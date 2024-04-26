# info on hiccup

## storage, directories etc

- please use `/software/users` for your software installations 
    - we have 2TB so please remove unused / old stuff
- let's try to keep `/home` relatively tidy (although the space was increased to 4TB)
- please use `/rstorage` for your data, analysis output, large footpring things, etc
    - please remove things you do not need anymore
- use `df -h <some_directory>` to know how much space you are using

## slurm

- we have 3 partitions (queues)
    - use quick if something is quick (<few hours)...
    - std is a one day job
    - long is for very long jobs

```
> sinfo
PARTITION AVAIL  TIMELIMIT  NODES  STATE NODELIST
quick        up    4:00:00      1  down* hiccup6
quick        up    4:00:00      6   idle hiccup1n,hiccup2n,hiccup3n,hiccup4n,hiccup5n,hiccup8n
std          up 1-00:00:00      1  down* hiccup6
std          up 1-00:00:00      6   idle hiccup1n,hiccup2n,hiccup3n,hiccup4n,hiccup5n,hiccup8n
long*        up   infinite      1  down* hiccup6
long*        up   infinite      6   idle hiccup1n,hiccup2n,hiccup3n,hiccup4n,hiccup5n,hiccup8n
```

## running jobs - use local `/scratch`

- here is an example of a slurm script that uses local scratch for a lot of I/O - saving resources on disk server (a lot of I/O to DS makes things inefficient for your jobs and others.. ;-)

```
# ... setup things...

# modify as needed but keep /scratch/u/$USER in front
TEMP_OUTPUT_DIRECTORY="/scratch/u/$USER/${SLURM_ARRAY_JOB_ID}"
# modify as needed
RSTORAGE_OUTPUT_DIRECTORY="/rstorage/$USER/${SLURM_ARRAY_JOB_ID}"

# from now on operate on the node's local /scratch ...
mkdir -p ${TEMP_OUTPUT_DIRECTORY}
my_script.py --output ${TEMP_OUTPUT_DIRECTORY}
# ... do something else on an ouput directory

# now copy files/results to /rstorage
mkdir -p ${RSTORAGE_OUTPUT_DIRECTORY}
cp -r ${TEMP_OUTPUT_DIRECTORY}/* ${RSTORAGE_OUTPUT_DIRECTORY}/

# in general we'd want to delete the temp dir after job is done
# make sure the copy was succesful...

if [ $? -eq 0 ]; then
    echo "copy done - removing the temp output dir."
    rm -rf ${TEMP_OUTPUT_DIRECTORY}
else
    echo "The copy command failed - not deleting the temp output dir."
fi

```

## installing heppy with a few precompiled packages

- note: the listed below steps to install heppy/pyjetty with preinstalled packages are put together in a script
    - https://github.com/alicernc/info/blob/main/scripts/build_pyjetty_heppy_preinst_hic.sh
    - get it with (wget for example):
    ```
        wget https://raw.githubusercontent.com/alicernc/info/main/scripts/build_pyjetty_heppy_preinst_hic.sh
    ```
    - modify as needed (workdir...) and `chmod +x build_pyjetty_heppy_preinst_hic.sh` and run `./build_pyjetty_heppy_preinst_hic.sh`
    - see the `.bashrc` function below for the next time around...

### compile your heppy
- note we will use `$workdir` a lot...

```
workdir=/software/users/$USER/mypyjetty
```

```
workdir=/software/users/$USER/mypyjetty
mkdir -p $workdir
cd $workdir
python3 -m virtualenv pyjettyenv
source pyjettyenv/bin/activate
python -m pip install --upgrade pip
python -m pip install numpy tqdm pyyaml

# load some preinstalled packages
module use /software/users/alice/yasp/software/modules
module load root HepMC2 LHAPDF6 HepMC3

git clone https://github.com/matplo/heppy.git
./heppy/external/fastjet/build.sh
./heppy/external/pythia8/build.sh
./heppy/external/roounfold/build.sh --heppy
./heppy/cpptools/build.sh

# note: use --clean when recompiling...
# like that: ./heppy/external/fastjet/build.sh --clean
# ...
```

### now compile your pyjetty

```
cd ${workdir}
module use ${workdir}/heppy/modules
module load heppy
# two lines below if new shell/terminal
/software/users/alice/yasp/software/modules
module load root HepMC2 LHAPDF6 HepMC3
git clone git@github.com:matplo/pyjetty.git
./pyjetty/cpptools/build.sh --tglaubermc --tenngen
```

### test using an example - a standalone script below (deactivate the python env after compilation of heppy+pyjetty done)

- recommended: use a new shell/terminal

```
cd $workdir
source pyjettyenv/bin/activate
module use /software/users/ploskon/yasp/software/modules
module load root HepMC2 LHAPDF6 HepMC3
module use $workdir/pyjetty/modules
module load pyjetty
$PYJETTY_DIR/pyjetty/examples/pythia_gen_fastjet_lund_test.py
```

## setup for next login...

- consider setting up your `$HOME/.bashrc` with a function that loads all whats needed - add the following to your `$HOME/.bashrc` and execute `pyjetty_load` whenever you need to use your pyjetty at your next login (note, the contents of the function is also good for your slurm scripts)...

```
function pyjetty_load()
{
    workdir=/software/users/$USER/mypyjetty
    source $workdir/pyjettyenv/bin/activate
    module use /software/users/ploskon/yasp/software/modules
    module load root HepMC2 LHAPDF6 HepMC3
    module use $workdir/pyjetty/modules
    module load pyjetty
}
export -f pyjetty_load
```

- alternatively use a script `/software/users/alice/activate_pyjetty.sh` - like this:

```
source /software/users/alice/activate_pyjetty.sh
```

    - copy to your own dir and adjust if needed

## intstalling heppy with yasp - all packages

```
git clone https://github.com/matplo/yasp.git
cd yasp
./yaspenv.sh
```

```
python -m pip install numpy
yasp -mi root/default --define version=6.28.06
module load root/default
yasp -mi HepMC2/2.06.11
module load HepMC2/2.06.11
yasp -mi LHAPDF6/6.5.3 --define version=6.5.4
module load LHAPDF6/6.5.3
yasp -mi HepMC3/3.2.5 --define version=3.2.6
module load HepMC3/3.2.5
```

### optional (they will be also within heppy)

```
yasp -mi fastjet/3.4.0
module load fastjet/3.4.0
yasp -i fjcontrib/1.051
yasp -mi pythia8/8308
module load pythia8/8308
```


### sherpa 2.2.15

- we need to disable python extension (sherpa 2.x uses an interface from older python versions)

```
 yasp -mi sherpa/2.2.15 --define extra_opt=--disable-pyext
```
