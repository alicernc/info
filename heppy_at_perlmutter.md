# How to setup heppy @ perlmutter

1. we will use conda - activate it with `module load python`
1. we will use yasp (something made by mp) `git clone https://github.com/matplo/yasp.git` beacause it is easier to control the building process...
1. we will compile most of the needed things with yasp OR we can reuse precompiled things - see below
1. we will compile "the rest" with heppy

```sh
cd /global/cfs/cdirs/alice/
mkdir $USER
cd /global/cfs/cdirs/alice/$USER
module load python
git clone https://github.com/matplo/yasp.git
cd yasp
./yaspconda.sh
conda activate /global/cfs/cdirs/alice/$USER/yasp/condayasp
conda install numpy
```

- and now we start compiling (some version numbers are overwritten - that's for a reason and ok)

```sh
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
# sherpa is optional...
yasp -mi sherpa/2.2.15
```

- now we will try to compile heppy - note we need to compile only some packages (fastjet, pythia, roounfold, cpptools)
```sh
cd /global/cfs/cdirs/alice/$USER
git clone https://github.com/matplo/heppy.git
```

## using precompiled root etc...

- we will NOT need yasp
- we will still use conda

```dotnetcli
cd /global/cfs/cdirs/alice/
mkdir $USER
cd $USER
module load python
conda -n condaheppy
conda activate condaheppy
conda install numpy
```