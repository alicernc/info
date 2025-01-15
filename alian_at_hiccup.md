# Build your new alian

# everything you need in short

- grab the `install_my_alian_hiccup.sh` [link](https://github.com/alicernc/info/blob/main/install_my_alian_hiccup.sh) in this repository and execute it
```
curl -o install_my_alian_hiccup.sh https://raw.githubusercontent.com/alicernc/info/main/install_my_alian_hiccup.sh
chmod +x <thefile>
./install_my_alian_hiccup.sh
```
- the steps below should do the same

## first a workdir...

```
workdir=/software/users/$USER/myalian
# or you can create a TODAY directory for this version of code
# workdir=/global/cfs/cdirs/alice/$USER/myalian-$(date +%Y-%m-%d)
mkdir -p $workdir
```

## build heppyy and alian

```
cd $workdir
git clone https://github.com/matplo/yasp.git
./yasp/yaspenv.sh 
```

### within yaspenv (after calling yaspenv.sh)
```
workdir=/software/users/$USER/myalian
cd $workdir

python -m pip install numpy tqdm pyyaml

# load modules for preinstalled packages

module use /software/users/ploskon/yasp/software/modules/bundle
module load hepbase 

workdir=/software/users/$USER/myalian
cd $workdir
git clone https://github.com/matplo/heppyy.git
./heppyy/install_with_yasp.sh
module use $workdir/yasp/software/modules
module load heppyy/current

cd $workdir
git clone https://github.com/matplo/alian.git
./alian/install_with_yasp.sh
```

# Use the new code

```
workdir=/software/users/$USER/myalian
${workdir}/yasp/yaspenv.sh 
```

- now within the yaspenv (virtual env)
```
workdir=/software/users/$USER/myalian
module use /software/users/ploskon/yasp/software/modules/bundle
module load hepbase 
module use ${workdir}/yasp/software/modules
module load yasp
module load heppyy/current
module load alian/current
```

- run a test (within the yaspenv...)

```
workdir=/software/users/$USER/myalian
${workdir}/alian/alian/sandbox/jet_axis/pythia_jet_axis.py
```

- install some additional python packages

```
python -m pip install -r $ALIAN_DEV/alian/sandbox/requirements.txt 
```
