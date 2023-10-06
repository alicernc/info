# How to setup heppy+pyjetty @ perlmutter

Note: for all practical purposes you will only need the first subsection (in general, you should not need to recompile the other packages)

## compile your heppy+pyjetty using some preinstalled packages

- execute this sequence

```bash
workdir=/global/cfs/cdirs/alice/$USER/mypyjetty
mkdir -p $workdir
cd $workdir
## module load python/3.11 - not needed we will use systems python3 - change 5-Oct-2023
python3 -m venv pyjettyenv
source pyjettyenv/bin/activate
python -m pip install --upgrade pip
python -m pip install numpy tqdm pyyaml

# load some preinstalled packages
## module use /global/cfs/cdirs/alice/heppy_soft/yasp/software/modules - gsl not present - change 5-Oct-2023
module use /global/cfs/cdirs/alice/heppy_soft/05-11-2023/yasp/software/modules
module load cmake gsl root/6.28.00 HepMC2/2.06.11 LHAPDF6/6.5.3 pcre2/default swig/4.1.1 HepMC3/3.2.5

git clone https://github.com/matplo/heppy.git
./heppy/external/fastjet/build.sh
./heppy/external/pythia8/build.sh
./heppy/external/roounfold/build.sh --ezra
./heppy/cpptools/build.sh

# note: use --clean when recompiling...
# like that: ./heppy/external/fastjet/build.sh --clean
# ...
```

- now compile your pyjetty

```bash
workdir=/global/cfs/cdirs/alice/$USER/mypyjetty
cd ${workdir}
module use ${workdir}/heppy/modules
module load heppy
# two lines below if new shell/terminal
module use /global/cfs/cdirs/alice/heppy_soft/05-11-2023/yasp/software/modules
module load cmake gsl root/6.28.00 HepMC2/2.06.11 LHAPDF6/6.5.3 pcre2/default swig/4.1.1 HepMC3/3.2.5
git clone git@github.com:matplo/pyjetty.git
./pyjetty/cpptools/build.sh --tglaubermc --tenngen
```

- test using an example - a standalone script below (deactivate the python env after compilation of heppy+pyjetty done)

```bash
workdir=/global/cfs/cdirs/alice/$USER/mypyjetty
cd $workdir
## module load python/3.11 - not needed we will use systems python3 - change 5-Oct-2023
source pyjettyenv/bin/activate
## module use /global/cfs/cdirs/alice/heppy_soft/yasp/software/modules - gsl not present - change 5-Oct-2023
module use /global/cfs/cdirs/alice/heppy_soft/05-11-2023/yasp/software/modules
module load cmake gsl root/6.28.00 HepMC2/2.06.11 LHAPDF6/6.5.3 pcre2/default swig/4.1.1 HepMC3/3.2.5
module use $workdir/pyjetty/modules
module load pyjetty
$PYJETTY_DIR/pyjetty/examples/pythia_gen_fastjet_lund_test.py
```
## build *all* needed packages and install heppy

1. we will use nersc python `module load python/3.11`
1. we will use yasp (something made by mp) `git clone https://github.com/matplo/yasp.git` beacause it is easier to control the building process...
1. we will compile most of the needed things with yasp OR we can reuse precompiled things - see below
1. we will compile "the rest" with heppy

```bash
cd /global/cfs/cdirs/alice/
mkdir $USER
cd /global/cfs/cdirs/alice/$USER
module load python/3.11
git clone https://github.com/matplo/yasp.git
cd yasp
./yaspenv.sh
```

- and now we start compiling (some version numbers are overwritten - that's for a reason and ok)

```bash
module load cmake gsl
python -m pip install numpy
yasp -mi root --define version=6.28.06
module load root/6.28.00
yasp -mi HepMC2/2.06.11
module load HepMC2/2.06.11
yasp -mi LHAPDF6/6.5.3 --define version=6.5.4
module load LHAPDF6/6.5.3
yasp -mi pcre2/default
module load pcre2/default
yasp -mi swig/4.1.1
module load swig/4.1.1
yasp -mi HepMC3/3.2.5 --define version=3.2.6
module load HepMC3/3.2.5
```

- you can install some optional packages (below) too - these are optional because we will recompile those within heppy (not compatible with heppy usage)
- note: they are compatible with cppyy use - see <https://github.com/matplo/heppyy>

```bash
yasp -mi fastjet/3.4.0
module load fastjet/3.4.0
yasp -i fjcontrib/1.051
yasp -mi pythia8/8308
module load pythia8/8308
yasp -mi sherpa/2.2.15
module load sherpa/2.2.15
```

- now we will try to compile heppy - note we need to compile only some packages (fastjet, pythia, roounfold, cpptools)

```bash
# if working with a new shell...
module load python cmake
conda activate <your conda env> # could be the one above made with yaspconda.sh
cd /global/cfs/cdirs/alice/$USER
git clone https://github.com/matplo/heppy.git
# make sure this is done
module use /global/cfs/cdirs/alice/heppy_soft/yasp/software/modules
module load gsl root/6.28.00 HepMC2/2.06.11 LHAPDF6/6.5.3 pcre2/default swig/4.1.1 HepMC3/3.2.5
./external/fastjet/build.sh
./external/pythia8/build.sh
./external/roounfold/build.sh --ezra
./cpptools/build.sh
```

- test by running

```bash
module load python cmake
conda activate <your conda env>
module use /global/cfs/cdirs/alice/heppy_soft/yasp/software/modules
module load gsl root/6.28.00 HepMC2/2.06.11 LHAPDF6/6.5.3 pcre2/default swig/4.1.1 HepMC3/3.2.5
module use /global/cfs/cdirs/alice/$USER/heppy/modules
module load heppy/1.0
./heppy/examples/pythia_gen_fastjet_lund_test.py
```
