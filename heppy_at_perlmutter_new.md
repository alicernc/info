# Build your new heppy + pyjetty

- note: lines using Today's date `$(date +%Y-%m-%d)` for the new workdir are commented out with `#` ... you can use those for compilation on a given day but of course you do not want to compile these every day... 

## heppy

```
workdir=/global/cfs/cdirs/alice/$USER/mypyjetty
# or you can create a TODAY directory for this version of code
# workdir=/global/cfs/cdirs/alice/$USER/mypyjetty-$(date +%Y-%m-%d)
mkdir -p $workdir
cd $workdir
module load python/3.11
python3 -m venv pyjettyenv
source pyjettyenv/bin/activate
python -m pip install --upgrade pip
python -m pip install numpy tqdm pyyaml

# load some preinstalled packages
module use /global/cfs/cdirs/alice/heppy_soft/15-09-2024/yasp/software/modules
module load cmake gsl root/default HepMC2/2.06.11 LHAPDF6/6.5.4 pcre2/default swig/4.1.1 HepMC3/3.2.5

git clone https://github.com/matplo/heppy.git
./heppy/external/fastjet/build.sh
./heppy/external/pythia8/build.sh
./heppy/external/roounfold/build.sh --ezra
./heppy/cpptools/build.sh
```

- note: you may reuse MP's heppy for your pyjetty installation/use...
  - it is at `/global/cfs/cdirs/alice/ploskon/mypyjetty-2024-09-16/heppy`
  - so, when compiling pyjetty below just create your own pyenv; load my heppy and compile pyjetty...
```
python3 -m venv pyjettyenv
workdir=/global/cfs/cdirs/alice/$USER/mypyjetty
# or you can create a TODAY directory for this version of code
# workdir=/global/cfs/cdirs/alice/$USER/mypyjetty-$(date +%Y-%m-%d)
mkdir -p $workdir
cd $workdir
module load python/3.11
python3 -m venv pyjettyenv
source pyjettyenv/bin/activate
module use /global/cfs/cdirs/alice/ploskon/mypyjetty-2024-09-16/heppy
module load heppy/1.0
# ...
```

## pyjetty

- here we stay with the your heppy install (as in the heppy built)... 
```
workdir=/global/cfs/cdirs/alice/$USER/mypyjetty
# or you can create a TODAY directory for this version of code
# workdir=/global/cfs/cdirs/alice/$USER/mypyjetty-$(date +%Y-%m-%d)
cd ${workdir}
module load python/3.11
source pyjettyenv/bin/activate
module use ${workdir}/heppy/modules
module load heppy/1.0

module use /global/cfs/cdirs/alice/heppy_soft/15-09-2024/yasp/software/modules
module load cmake gsl root/default HepMC2/2.06.11 LHAPDF6/6.5.4 pcre2/default swig/4.1.1 HepMC3/3.2.5

git clone git@github.com:matplo/pyjetty.git
./pyjetty/cpptools/build.sh --tglaubermc --tenngen
```

# Use the new pyjetty

```
workdir=/global/cfs/cdirs/alice/$USER/mypyjetty
# or you want to use the TODAY directory for this version of code 
# remember to change the code below to actual directory name if using... `$(date +%Y-%m-%d)` changes every day...
# workdir=/global/cfs/cdirs/alice/$USER/mypyjetty-$(date +%Y-%m-%d)
module load python/3.11
source ${workdir}/pyjettyenv/bin/activate
module use /global/cfs/cdirs/alice/heppy_soft/15-09-2024/yasp/software/modules
module load cmake gsl root/default HepMC2/2.06.11 LHAPDF6/6.5.4 pcre2/default swig/4.1.1 HepMC3/3.2.5
module use ${workdir}/pyjetty/modules
module load pyjetty/1.0
```

- run a test

```
${workdir}/pyjetty/pyjetty/examples/pythia_gen_fastjet_lund_test.py
```
