# How to herwig @ perlmutter

Herwig compilation needed a newer python version (note we may want to migrate to it at some point also for heppy/pyjetty)

## first time setup

- execute this sequence the first time

```bash
workdir=/global/cfs/cdirs/alice/$USER/myherwigdir
mkdir -p $workdir
cd $workdir

## here is the new python load
module use /global/cfs/cdirs/alice/heppy_soft/05-11-2023/yasp/software/modules/python3
module load 3.10.13-saul

python3 -m venv pyjettyenv
source pyjettyenv/bin/activate
python -m pip install --upgrade pip
python -m pip install numpy tqdm pyyaml

module use /global/cfs/cdirs/alice/heppy_soft/18-01-2024/yasp/software/modules
module load herwig_with_deps
```

- now `Herwig` command should be available...

# subsequent logins

```bash
workdir=/global/cfs/cdirs/alice/$USER/myherwigdir
cd $workdir

source pyjettyenv/bin/activate

module use /global/cfs/cdirs/alice/heppy_soft/18-01-2024/yasp/software/modules
module load herwig_with_deps
```

- now `Herwig` command should be available...
