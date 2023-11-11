#!/bin/bash

save_dir=${PWD}

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

# build heppy
git clone https://github.com/matplo/heppy.git
./heppy/external/fastjet/build.sh
./heppy/external/pythia8/build.sh
./heppy/external/roounfold/build.sh --ezra
./heppy/cpptools/build.sh

# note: use --clean when recompiling...
# like that: ./heppy/external/fastjet/build.sh --clean
# ...

# build pyjetty
cd ${workdir}
module use ${workdir}/heppy/modules
module load heppy
git clone git@github.com:matplo/pyjetty.git
./pyjetty/cpptools/build.sh --tglaubermc --tenngen

# load pyjetty module
module use ${workdir}/pyjetty/modules
module load pyjetty

# test
$PYJETTY_DIR/pyjetty/examples/pythia_gen_fastjet_lund_test.py

cd ${save_dir}