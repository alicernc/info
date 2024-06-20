# starlight installed as a part of bundle software

-- first (once) do this:
```
workdir=/software/users/$USER/mypyjetty
mkdir -p $workdir
cd $workdir
python3 -m virtualenv pyjettyenv
source pyjettyenv/bin/activate
python -m pip install --upgrade pip
python -m pip install numpy tqdm pyyaml

# load some preinstalled packages
module use /software/users/ploskon/yasp/software/modules
module load bundle/hepbase
```

-- at the next login/shell (no need to create the python env)

```
workdir=/software/users/$USER/mypyjetty
source $workdir/pyjettyenv/bin/activate
module use /software/users/ploskon/yasp/software/modules
module load bundle/hepbase

# starlight command should be available now
```