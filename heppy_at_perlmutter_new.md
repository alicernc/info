# Build your new heppy + pyjetty

## heppy

```
# the line sets a TODAY directory
# workdir=/global/cfs/cdirs/alice/$USER/mypyjetty-$(date +%Y-%m-%d)
workdir=/global/cfs/cdirs/alice/$USER/mypyjetty
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

# pyjetty

```
# the line sets a TODAY directory
# workdir=/global/cfs/cdirs/alice/$USER/mypyjetty-$(date +%Y-%m-%d)
workdir=/global/cfs/cdirs/alice/$USER/mypyjetty
cd ${workdir}
module load python/3.11
source pyjettyenv/bin/activate
module use ${workdir}/heppy/modules
module load heppy

module use /global/cfs/cdirs/alice/heppy_soft/15-09-2024/yasp/software/modules
module load cmake gsl root/default HepMC2/2.06.11 LHAPDF6/6.5.4 pcre2/default swig/4.1.1 HepMC3/3.2.5

git clone git@github.com:matplo/pyjetty.git
./pyjetty/cpptools/build.sh --tglaubermc --tenngen
```

# Use the new pyjetty

```
# the line sets a TODAY directory
# workdir=/global/cfs/cdirs/alice/$USER/mypyjetty-$(date +%Y-%m-%d)
workdir=/global/cfs/cdirs/alice/$USER/mypyjetty
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
