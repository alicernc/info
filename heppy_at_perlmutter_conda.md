# How to setup heppy @ perlmutter

## using precompiled packages

- we will NOT need yasp
- we will still use conda

```dotnetcli
cd /global/cfs/cdirs/alice/
mkdir $USER
cd $USER
module load python
conda create -n mycondaheppy
conda activate mycondaheppy
conda install numpy tqdm pyyaml
```

## from scratch (with all the dependencies)

1. we will use conda - activate it with `module load python`
1. we will use yasp (something made by mp) `git clone https://github.com/matplo/yasp.git` beacause it is easier to control the building process...
1. we will compile most of the needed things with yasp OR we can reuse precompiled things - see below
1. we will compile "the rest" with heppy

```bash
cd /global/cfs/cdirs/alice/
mkdir $USER
cd /global/cfs/cdirs/alice/$USER
module load python cmake
git clone https://github.com/matplo/yasp.git
cd yasp
./yaspconda.sh
conda activate /global/cfs/cdirs/alice/$USER/yasp/condayasp
conda install numpy
```

- and now we start compiling (some version numbers are overwritten - that's for a reason and ok)

```bash
module load gsl
yasp -mi root --define version=6.28.04
module load root/6.28.00
yasp -mi HepMC2/2.06.11
module load HepMC2/2.06.11
yasp -mi LHAPDF6/6.5.3 --define --version=6.5.4
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
yacp -mi fastjet/3.4.0
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
module use /global/cfs/cdirs/alice/heppy_soft/yasp_conda/software/modules
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
module use /global/cfs/cdirs/alice/heppy_soft/yasp_conda/software/modules
module load gsl root/6.28.00 HepMC2/2.06.11 LHAPDF6/6.5.3 pcre2/default swig/4.1.1 HepMC3/3.2.5
module use /global/cfs/cdirs/alice/$USER/heppy/modules
module load heppy/1.0
./heppy/examples/pythia_gen_fastjet_lund_test.py
```
