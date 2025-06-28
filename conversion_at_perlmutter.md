# Run 3 data conversion on Perlmutter

A how-to guide on using the AO2D to BerkeleyTree converter at Perlmutter. Any comments/improvements welcome!

## Table of contents

- [Table of contents](#table-of-contents)
- [Contact](#contact)
- [Currently available datasets](#currently-available-datasets)
- [Shifter](#shifter)
- [Dependencies](#dependencies)
- [Installation](#installation)
- [Grid tokens](#grid-tokens)
- [Usage](#usage)

## Contact

Author: Tucker Hwang  
Date: 26 June 2025  
Contact: [tucker_hwang@berkeley.edu](mailto:tucker_hwang@berkeley.edu) or Slack for issues, questions, or suggestions

## Currently available datasets

First, before you even consider using the converter, check that none of the data we already have on disk is not suitable to what you need. You can see a full list of the datasets available on Hiccup and Perlmutter in the [Run 3 data record](data/run3.md). Keep in mind that our conversions are by choice very general, so as long as the data you actually want is on disk, most likely any cuts or selections that you want can be done on the analyis level, without relying on a new conversion. Conversions will typically be done on NERSC. If you need the data on hiccup, there is no need to reconvert; please contact Tucker via the contact info above if you need a dataset transferred.

## Shifter

To run the conversions, we will use [Shifter](https://docs.nersc.gov/development/containers/shifter/). We will be using the `tch285/o2alma:latest` image. Check the [O2 at Perlmutter documentation](o2_at_perlmutter.md) for more information on Shifter.

The converter itself works in two parts: (1) the download of a JE derived dataset, and (2) the conversion of several AO2Ds into the BerkeleyTree format. Here we only describe NERSC specifics and how to get started - for more details, please check its [usage documentation](https://github.com/KirillVNaumov/AO2DToBerkeleyTreeConverter/blob/master/scripts/README.md).

## Dependencies

The CVMFS builds of the ALICE software stack and our Shifter image provide all dependencies: the ALICE utilities, ROOT and an appropriate Python environment.

## Installation

To obtain the source code, simply clone the repository. You might want to use the project's Global Common directory:

```bash
# This workdir can be changed if necessary
workdir=/global/common/software/alice/$USER
mkdir -p $workdir
cd $workdir
git clone https://github.com/KirillVNaumov/AO2DToBerkeleyTreeConverter.git converter
cd converter
```

Compilation is generally not necessary, since the launcher will do this for you. If you do want to compile, run the following:

```bash
shifter --module=cvmfs --image=tch285/o2alma:latest /cvmfs/alice.cern.ch/bin/alienv setenv JAliEn-ROOT/0.7.14-43 -c make -C "$workdir/converter"
```

## Grid tokens

The downloader requires a properly converted certificate pair. Follow the instructions on [this page](https://aliceo2group.github.io/analysis-framework/docs/gettingstarted/certificate.html). You can ignore the sections on adding your certificate to your browser, but make sure to complete the steps on [registering](https://aliceo2group.github.io/analysis-framework/docs/gettingstarted/certificate.html#register-your-certificate-to-the-alice-grid) and [converting your certificate](https://aliceo2group.github.io/analysis-framework/docs/gettingstarted/certificate.html#convert-your-certificate-for-using-the-grid-tools). You will not be able to test your certificate, but the downloader will validate your token and prompt you if a valid token is not found.

## Usage

The two main scripts of the converter are the downloader (`scripts/download_hyperloop.py`) and the conversion scheduler (`scripts/schedule_conversion.sh`). Both of these are steered by the launcher (`scripts/launch_pipeline_nersc.sh`). The options for the launcher are

- `-d`, `--download`: Run the downloader
- `-c`, `--convert`: Run the conversion scheduler
- `-t`, `--test`: Run a test conversion: a conversion will run locally instead of being submitted as a batch job.
- `-v`, `--verbose`: Compile converter in verbose mode[^1]. The converter will always be recompiled on every run, but this does not take much time.

These options can be combined, e.g. `-ctv` will skip the download but will perform a test conversion in verbose mode. Running the script with no options will prompt for a full test run: download and test conversion.

The most relevant user parameters are listed in the dataset parameters section:

- `HYPERLOOP_FILELIST`: The path to a list of Hyperloop directories. You should get this from the Hyperloop page of the relevant train: click on the "Submitted jobs" tab and then the "Copy all output directories" button on the top right. The directories should be copied onto your clipboard. Paste these into a text file and save this text file somewhere, preferably the prepared directory `hylists`.
- `OUTPUT_DIR`: The path to where the downloaded AO2Ds and converted trees will be placed.  Testing before performing a full conversion is **highly recommended**. There is a prepared staging area for testing downloads and conversions, located at `/global/cfs/cdirs/alice/alicepro/hiccup/rstorage/alice/run3/data/staging`. A user-specific directory is recommended, i.e. set `OUTPUT_DIR=/global/cfs/cdirs/alice/alicepro/hiccup/rstorage/alice/run3/data/staging/$USER/<dataset_name>`. The output directory is created automatically if it does not already exist. Once your testing is complete, datasets should be downloaded and converted with `OUTPUT_DIR=/global/cfs/cdirs/alice/alicepro/hiccup/rstorage/alice/run3/data/<dataset_name>`.
- `EMAIL`: The email you wish to be notified at when the Slurm conversion job completes. Leave empty (`EMAIL=""` or `EMAIL=`) if you do not wish to be notified.
- `NAOD`: The number of AO2Ds to combine into one BerkeleyTree. Generally any number from 2 to 10 will yield reasonably sized BerkeleyTrees. We recommend running some test runs `launch_pipeline_nersc.sh -ct` with a few different values for `NAOD` to see what yields a reasonable size for the tree (aiming for around 2-3 GB per tree).

> [!CAUTION]
> Because the AO2D and tree directories are automatically cleared before downloading or converting, it is very easy to accidentally wipe your previous work, or worse, delete someone else's data! **Please use the your personalized staging area in** `/global/cfs/cdirs/alice/alicepro/hiccup/rstorage/alice/run3/data/staging/$USER/<dataset_name>` while testing to avoid affecting existing data or other people's staging areas, and only use the `run3/data` directory when you are fully ready and absolutely sure you're not about to unintentionally delete other data.

Some other parameters of relevance to the user but should probably be left alone:

- `NTHREADS`: the number of threads to download AO2Ds. Around 10-25 seems to work best.
- `CONFIG`: The configuration file for the conversion. Unless you have specific needs, you can just use the `tree-cuts.yaml` file that comes with the repo.
- `AOD_DIR`: The subdirectory where the downloaded AO2Ds are placed. The recommended structure is an `AO2D` directory inside `OUTPUT_DIR`.
- `TREE_DIR`: The subdirectory where the converted trees are placed. The recommended structure is a `BerkeleyTrees` directory inside `OUTPUT_DIR`.

[^1]: For the moment, the converter must be recompiled to swap between verbose and production mode. In the future this will be implemented as a command line option.
