# Build your new alian -- NEW

- updates on permutter made us to move to using conda for python stuff...

## first a workdir...

```
workdir=/global/cfs/cdirs/alice/$USER/myalian
# or you can create a TODAY directory for this version of code
# workdir=/global/cfs/cdirs/alice/$USER/myalian-$(date +%Y-%m-%d)
mkdir -p $workdir
```

## build heppyy and alian

```
cd $workdir
git clone https://github.com/matplo/yasp.git
./yasp/condaenv.sh
```

### within the condaenv (after calling condaenv.sh)
```
workdir=/global/cfs/cdirs/alice/$USER/myalian
cd $workdir

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

# Use the new code

```
workdir=/global/cfs/cdirs/alice/$USER/myalian
${workdir}/yasp/condaenv.sh 

module unload yasp

module use /global/cfs/cdirs/alice/software/yasp/software/modules
module load pcre2/default swig/4.1.1 bundle/hepbase

module use $workdir/yasp/software/modules
module load yasp
module load heppyy/current
module load alian/current

```

- run a test

```
workdir=/global/cfs/cdirs/alice/$USER/myalian
${workdir}/alian/alian/sandbox/jet_axis/pythia_jet_axis.py
```

# Useful tip

- you can edit `$workdir/yasp/conda_env_yasp_python_3.11/.venvstartup.sh` file and add the following to it such that the env starts with everything setup... - from OUTSIDE of condaenv...
```
# ... some existing stuff
# add what's below

workdir=/global/cfs/cdirs/alice/$USER/myalian

module unload yasp

module use /global/cfs/cdirs/alice/software/yasp/software/modules
module load pcre2/default swig/4.1.1 bundle/hepbase

module use $workdir/yasp/software/modules
module load yasp
module load heppyy/current
module load alian/current

```

- then you can directly run your python code using heppyy and alian in the env...

```
${workdir}/yasp/condaenv.sh ${workdir}/alian/alian/sandbox/jet_axis/pythia_jet_axis.py
```


# Build your new alian -- OBSOLETE

## first a workdir...

```
workdir=/global/cfs/cdirs/alice/$USER/myalian
# or you can create a TODAY directory for this version of code
# workdir=/global/cfs/cdirs/alice/$USER/myalian-$(date +%Y-%m-%d)
mkdir -p $workdir
```

## build heppyy and alian

```
cd $workdir
module load cmake pytorch/2.3.1
git clone https://github.com/matplo/yasp.git
./yasp/yaspenv.sh 
```

### within yaspenv (after calling yaspenv.sh)
```
cd $workdir

python -m pip install numpy tqdm pyyaml

# load modules for preinstalled packages

module use /global/cfs/cdirs/alice/ploskon/yasp/software/modules
module load swig/4.1.1 bundle/hepbase 
module unload yasp
module use ./yasp/software/modules
module load yasp

git clone https://github.com/matplo/heppyy.git
./heppyy/instal_with_yasp.sh
module load heppyy/current

git clone https://github.com/matplo/alian.git
./alian/install_with_yasp.sh
```

# Use the new code

```
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

- run a test

```
workdir=/global/cfs/cdirs/alice/$USER/myalian
${workdir}/alian/alian/sandbox/jet_axis/pythia_jet_axis.py
```
