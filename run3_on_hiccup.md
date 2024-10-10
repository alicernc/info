# setup software

- note we will work within directory `/software/users/$USER/run3/`
- build the software (save below as a shell script or copy `/software/users/alice/run3/build_heppyy_alian.sh`
- the script does a few things
  - creates directories for yasp, heppyy and alian (the actual analysis tool)
    - note: you perhaps want to clone the `alian` repository (modify the line below then)
  - loads modules of common (already pre-installed) software (root, HEPMC, fastjet, pythia etc)
  - builds your version of heppyy and alian

```
#!/bin/bash

savedir=${PWD}

workdir=/software/users/$USER/run3/

mkdir -p ${workdir}
cd ${workdir}
git clone git@github.com:matplo/yasp.git
git clone git@github.com:matplo/heppyy.git
git clone git@github.com:matplo/alian.git

# load some preinstalled packages
module use /software/users/alice/yasp/software/modules
module load bundle/hepbase
module list

yaspenv_cmnd=${workdir}/yasp/yaspenv.sh
# yaspenv_cmnd=yaspenv

echo "using ${yaspenv_cmnd}"

${yaspenv_cmnd} python -m pip install numpy tqdm uproot pandas

${yaspenv_cmnd} ${workdir}/heppyy/install_with_yasp.sh
module use ${workdir}/yasp/software/modules
module load heppyy/current

${yaspenv_cmnd} ${workdir}/alian/install_with_yasp.sh

cd ${savedir}

```

# setup the environment 

- do this in every new terminal...
- environment setup - execute this (to modify copy `/software/users/alice/run3/setenv.sh` and adopt to your own needs)

```
#!/bin/bash

savedir=${PWD}

workdir=/software/users/$USER/run3/

# load some preinstalled packages
module use /software/users/alice/yasp/software/modules
module load bundle/hepbase

yaspenv_cmnd=${workdir}/yasp/yaspenv.sh
echo "using ${yaspenv_cmnd}"

module use ${workdir}/yasp/software/modules
module load heppyy/current
module load alian/current

alias yaspenv=${yaspenv_cmnd}

cd ${savedir}
```

# run a test...

```
/software/users/alice/run3/setenv.sh
cd $ALIAN_SRC/alian/sandbox/
# gernerate a yaml description of the data tree
./generate_analysis_yaml_config.py /rstorage/fjonas/output_PbPb_LHC23zzm_544767_FullRun/eventTree_0.root
# run a jet analysis on 100 events (to disable reading some branches just comment out in the .yaml file
./analysis.py -e 1000 tree_structure.yaml /rstorage/fjonas/output_PbPb_LHC23zzm_544767_FullRun/eventTree_1.root
```
- make your own analysis... 
- note: we are developing - the analysis loop may change...
- sandbox/analysis link https://github.com/matplo/alian/blob/main/alian/sandbox/analysis.py
- sandbox/generate_analysis_yaml_config.py - https://github.com/matplo/alian/blob/main/alian/sandbox/generate_analysis_yaml_config.py

