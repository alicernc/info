# Building `alian` at Perlmutter

## Using `conda`

Author: Mateusz

### Install the software

```bash
workdir=/global/cfs/cdirs/alice/$USER/myalian
# or you can create a TODAY directory for this version of code
# workdir=/global/cfs/cdirs/alice/$USER/myalian-$(date +%Y-%m-%d)
mkdir -p $workdir
```

You can also set a custom `workdir`. If you do, remember to use that `workdir` in the following instructions. Now we load the dependencies. Note that, even though we defined `workdir` already outside of the conda environment, we need to define it again inside the environment since `conda` will remove it once you enter.

```bash
cd $workdir
git clone https://github.com/matplo/yasp.git
./yasp/condaenv.sh

# redefine workdir inside condaenv
workdir=/global/cfs/cdirs/alice/$USER/myalian

module unload yasp

module use /global/cfs/cdirs/alice/software/yasp/software/modules
module load pcre2/default swig/4.1.1 bundle/hepbase

module use $workdir/yasp/software/modules
module load yasp

git clone https://github.com/matplo/heppyy.git
./heppyy/install_with_yasp.sh 
module load heppyy/current

git clone https://github.com/matplo/alian.git
./alian/install_with_yasp.sh 
module load alian/current
```

### Run a test

```bash
workdir=/global/cfs/cdirs/alice/$USER/myalian
${workdir}/yasp/condaenv.sh 

workdir=/global/cfs/cdirs/alice/$USER/myalian
module unload yasp

module use /global/cfs/cdirs/alice/software/yasp/software/modules
module load pcre2/default swig/4.1.1 bundle/hepbase

module use $workdir/yasp/software/modules
module load yasp heppyy/current alian/current

${workdir}/alian/alian/sandbox/jet_axis/pythia_jet_axis.py
```

### Use the new code

```bash
workdir=/global/cfs/cdirs/alice/$USER/myalian
${workdir}/yasp/condaenv.sh 

workdir=/global/cfs/cdirs/alice/$USER/myalian
module unload yasp

module use /global/cfs/cdirs/alice/software/yasp/software/modules
module load pcre2/default swig/4.1.1 bundle/hepbase

module use $workdir/yasp/software/modules
module load yasp heppyy/current alian/current
```

You can now run your code within the environment.

> [!TIP]
> You can edit the `$workdir/yasp/conda_env_yasp_python_3.11/.venvstartup.sh` file and add the following to it such that the env starts with everything set up. Add these lines to the END of the file, from OUTSIDE the conda environment:
>
> ```bash
> # ... already existing stuff goes here
> workdir=/global/cfs/cdirs/alice/$USER/myalian
> 
> module unload yasp
> 
> module use /global/cfs/cdirs/alice/software/yasp/software/modules
> module load pcre2/default swig/4.1.1 bundle/hepbase
> 
> module use $workdir/yasp/software/modules
> module load yasp heppyy/current alian/current
> ```
>
> Then you can directly run some code directly within the environment:
>
> ```bash
> ${workdir}/yasp/condaenv.sh ${workdir}/alian/alian/sandbox/jet_axis/pythia_jet_axis.py
> ```
>
> Note that once it finishes, you'll be back in your regular shell, not the conda environment.

## Using preinstalled dependencies

Author: Tucker

### Install the software

We use a Shifter container ([Dockerfile](https://github.com/tch285/anchor/blob/main/alian-base/Dockerfile), [installed packages](https://github.com/tch285/anchor/blob/main/alian-base/packages)) that has all of the package dependencies to install `heppyy`, its dependencies, and `alian`. Note that this image derives from Ubuntu 22.04, not the NERSC SLES. Because these instructions will install the individual `yasp` packages, this installation may take longer, but allows for customization. If you don't anticipate needing any specific customization of the `yasp` packages, use the instructions above on [installing with conda](#using-conda).

```bash
workdir=/global/cfs/cdirs/alice/$USER/myalian
# or set a custom workdir
mkdir -p $workdir
cd $workdir
shifter --entrypoint --image=tch285/alian-base
git clone https://github.com/matplo/yasp.git

./yasp/yaspenv.sh
python3 -m pip install numpy tqdm pyyaml # add more packages here if desired
yasp -mi bundle/hepbase --opt rootspec=ubuntu22.04 n_cores=5

module load bundle/hepbase
git clone https://github.com/matplo/heppyy.git
./heppyy/install_with_yasp.sh

module load heppyy
git clone https://github.com/matplo/alian.git
# or replace with e.g. your fork: git clone --branch <your-branch> git@github.com:<username>/alian.git
./alian/install_with_yasp.sh
```

### Run a test

From a clean shell, run

```bash
workdir=<your/workdir> # use your workdir here
cd ${workdir}
shifter --entrypoint --image=tch285/alian-base yasp/yaspenv.sh "module load bundle/hepbase heppyy alian && ./alian/alian/sandbox/jet_axis/pythia_jet_axis.py"
```

### Use the new code

From a clean shell, run

```bash
workdir=<your/workdir> # use your workdir here
cd ${workdir}
shifter --entrypoint --image=tch285/alian-base yasp/yaspenv.sh -i "module load bundle/hepbase heppyy alian"
```

This will place you in an interactive `yaspenv` with all modules loaded.

## Using preinstalled packages (outdated)

Author: Mateusz

> [!CAUTION]
> The `pytorch/2.3.1` module has been removed, so these instructions are outdated.

### Install the software

We use an installed version of the `heppyy` dependencies to install `heppyy` and `alian`. In this case we stay with the native NERSC SLES.

```bash
workdir=/global/cfs/cdirs/alice/$USER/myalian
# or you can create a TODAY directory for this version of code
# workdir=/global/cfs/cdirs/alice/$USER/myalian-$(date +%Y-%m-%d)
mkdir -p $workdir
```

We build `heppyy` and `alian`:

```bash
cd $workdir
module load cmake pytorch/2.3.1
git clone https://github.com/matplo/yasp.git
./yasp/yaspenv.sh
```

Now within the `yaspenv` (after calling `yaspenv.sh`):

```bash
cd $workdir
python -m pip install numpy tqdm pyyaml

# load modules for preinstalled dependencies
module use /global/cfs/cdirs/alice/ploskon/yasp/software/modules
module load swig/4.1.1 bundle/hepbase 
module unload yasp
module use ./yasp/software/modules
module load yasp

git clone https://github.com/matplo/heppyy.git
./heppyy/install_with_yasp.sh
module load heppyy/current

git clone https://github.com/matplo/alian.git
./alian/install_with_yasp.sh
```

### Run a test

```bash
workdir=/global/cfs/cdirs/alice/$USER/myalian # or replace with your custom workdir
${workdir}/alian/alian/sandbox/jet_axis/pythia_jet_axis.py
```

### Use the new code

From a clean shell, run

```bash
workdir=/global/cfs/cdirs/alice/$USER/myalian # or replace with your custom workdir
module load cmake pytorch/2.3.1
${workdir}/yasp/yaspenv.sh 
module use /global/cfs/cdirs/alice/ploskon/yasp/software/modules
module load swig/4.1.1 bundle/hepbase 
module unload yasp
module use ./yasp/software/modules
module load yasp
module load heppyy/current
module load alian/current
```
