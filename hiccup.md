# info on hiccup

## installing heppy with a few precompiled packages

- compile your heppy

```
workdir=/software/$USER/mypyjetty
mkdir -p $workdir
cd $workdir
python3 -m virtualenv pyjettyenv
source pyjettyenv/bin/activate
python -m pip install --upgrade pip
python -m pip install numpy tqdm pyyaml

# load some preinstalled packages
module use /software/users/ploskon/yasp/software/modules
module load root HepMC2 LHAPDF6 HepMC3

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

```
cd ${workdir}
module use ${workdir}/heppy/modules
module load heppy
# two lines below if new shell/terminal
module use /software/users/ploskon/yasp/software/modules
module load root HepMC2 LHAPDF6 HepMC3
git clone git@github.com:matplo/pyjetty.git
./pyjetty/cpptools/build.sh --tglaubermc --tenngen
```

- test using an example - a standalone script below (deactivate the python env after compilation of heppy+pyjetty done)

```
cd $workdir
## module load python/3.11 - not needed we will use systems python3 - change 5-Oct-2023
source pyjettyenv/bin/activate
module use /software/users/ploskon/yasp/software/modules
module load root HepMC2 LHAPDF6 HepMC3
module use $workdir/pyjetty/modules
module load pyjetty
$PYJETTY_DIR/pyjetty/examples/pythia_gen_fastjet_lund_test.py
```

## intstalling heppy with yasp - all packages

```
module load cmake gsl
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

### optional (within heppy)

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

sqlite3