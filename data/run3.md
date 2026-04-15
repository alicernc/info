# Run 3 data record

Information on the Run 3 data and MC stored on Perlmutter and Hiccup.

## Table of contents

- [Table of contents](#table-of-contents)
- [Contact](#contact)
- [Data](#data)
- [MC (central)](#mc-central)
- [MC (fast simulation)](#mc-fast-simulation)

## Contact

Author: Tucker Hwang  
Date: 19 October 2025  
Contact: [tucker_hwang@berkeley.edu](mailto:tucker_hwang@berkeley.edu) or Slack

## Data

Raw data converted to BerkeleyTree format.

1. To find the path on Perlmutter, prepend the path found in the Path column with: `/global/cfs/cdirs/alice/alicepro/hiccup/rstorage/alice/run3/data`. On Hiccup, prepend the path with: `/rstorage/alice/run3/data`. A file list of the BerkeleyTrees for each dataset can be found in `tree_list.txt` in the corresponding directory.
2. All datasets that have an entry in the Path column are available on NERSC. Only datasets that are checked in the Hiccup column have been transferred there. Datasets with no Path entry have not been converted. Contact Tucker if you need a dataset converted, and/or if you need a dataset copied to Hiccup.
   - In principle, any JE derived dataset that has been produced can be converted. A full list of JE derived data can be found on [this spreadsheet](https://docs.google.com/spreadsheets/d/1zsD_StvPqN2-7dOlfN9W03TB4Opj9EwdrBQHOQi3ViU/edit?usp=sharing) (first sheet).
3. You will need your grid certificate installed in your browser to access the Hyperloop links. Check this [O2Physics documentation page](https://aliceo2group.github.io/analysis-framework/docs/gettingstarted/certificate.html) for more information.
4. All pp datasets are at 13.6 TeV, with the exception of the 2024 pp reference, which is at 5.36 TeV. All Pb-Pb and OO data is at 5.36 TeV.
5. All datasets are minimum-bias, with the exception of the 2024 skimmed, which has the software triggers applied and only JE triggers saved. However, each dataset has a further level of data reduction (via OTS skimming or manually-applied filters), so check the description of the linked JE derived dataset to make sure it is suitable for your analysis.
6. All datasets contain event and track information. Those that also have cluster information are marked in the Cluster column.

> [!CAUTION]
> The JE derived data format is still in flux, so the selection and trigger bits for tracks and events that you see in O2Physics **may not match the data you have.** Go to the dataset's train page on Hyperloop, find the Package tag, and look at the corresponding tag on the [O2Physics GitHub repository](https://github.com/AliceO2Group/O2Physics) to find exactly which bits were used during the derived data production.[^1]

| Dataset    | Pass  | System   | JE dataset                                                                                                   | ALICE dataset                                                                                                | Train                                                                       | Clusters | Path                          | Hiccup?                           | Notes      |
|------------|-------|----------|--------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------|----------|-------------------------------|-----------------------------------|------------|
| 22o        | 7     | pp       | [JE_LHC22o_pass7_minBias_CJ8_FJ8_CL5_TTSig15_TTRef5](https://alimonitor.cern.ch/hyperloop/view-dataset/3012) | [LHC22o_pass7_minBias](https://alimonitor.cern.ch/hyperloop/view-dataset/1071?timestamp=1772544939563)       | [626927](https://alimonitor.cern.ch/hyperloop/train-run/626927/general)     |          | `LHC22o/BerkeleyTrees`        |                                   | 1/pb       |
| 23_thin    | 4     | pp       | [JE_LHC23_pass4_Thin_CJ8_FJ8_CL5_TTSig15_TTRef5](https://alimonitor.cern.ch/hyperloop/view-dataset/3015)     | [LHC23_pass4_Thin](https://alimonitor.cern.ch/hyperloop/view-dataset/995?timestamp=1772541698877)            | [626870](https://alimonitor.cern.ch/hyperloop/train-run/626870/general)     |          |                               |                                   | 5/pb       |
| 24_ppref   | 1     | pp       | [JE_LHC24_ppref_pass1_CJ8_FJ8_CL5_TTSig15_TTRef5](https://alimonitor.cern.ch/hyperloop/view-dataset/3011)    | [LHC24_ppref_pass1](https://alimonitor.cern.ch/hyperloop/view-dataset/1728?timestamp=1772541683834)          | [626869](https://alimonitor.cern.ch/hyperloop/train-run/626869/general)     |          | `LHC24_ppref/BerkeleyTrees`   | &check;                           | 5/pb       |
| 24_skimmed | 1     | pp       | [JE_LHC24_pass1_skimmed](https://alimonitor.cern.ch/hyperloop/view-dataset/3010)                             | [LHC24_pass1_skimmed](https://alimonitor.cern.ch/hyperloop/view-dataset/1661?timestamp=1772618397685)        | [627650](https://alimonitor.cern.ch/hyperloop/train-run/627650/general)     | &check;  | `LHC24_skimmed/BerkeleyTrees` |                                   | 53/pb      |
| 24ar       | 3     | PbPb     | [JE_LHC24ar_pass3_CJEWS19_TTSig15_TTRef5](https://alimonitor.cern.ch/hyperloop/view-dataset/3014)            | [LHC24ar_pass3](https://alimonitor.cern.ch/hyperloop/view-dataset/2471?timestamp=1772541722890)              | [626871](https://alimonitor.cern.ch/hyperloop/train-run/626871/general)     |          | `LHC24ar/BerkeleyTrees`       | &check;                           |            |
| 25ae       | 2     | OO       | [JE_LHC25ae_pass2_CEWSJ10_FJ12_CL8_TTSig15_TTRef5](https://alimonitor.cern.ch/hyperloop/view-dataset/3009)   | [LHC25ae_pass2](https://alimonitor.cern.ch/hyperloop/view-dataset/2319?timestamp=1773072135385)              | [631181](https://alimonitor.cern.ch/hyperloop/train-run/631181/general)     |          | `LHC25ae/BerkeleyTrees`       | &check;                           |            |
| ~~22o~~    | ~~7~~ | ~~pp~~   | ~~[JE_LHC22o_pass7_CJ_R6_5_FJ_R6_5_CL_5_TT_5](https://alimonitor.cern.ch/hyperloop/view-dataset/1745)~~      | ~~[LHC22o_pass7_minBias](https://alimonitor.cern.ch/hyperloop/view-dataset/1071?timestamp=1739209991732)~~   | ~~[346364](https://alimonitor.cern.ch/hyperloop/train-run/346364/general)~~ |          |                               | ~~`/rstorage/alice/data/LHC22o`~~ | DEPRECATED |
| ~~23zzm~~  | ~~4~~ | ~~PbPb~~ | ~~[23zzm_pass4_Cl_8](https://alimonitor.cern.ch/hyperloop/view-dataset/1301)~~                               | ~~[LHC23zzm_pass4_EMCgood](https://alimonitor.cern.ch/hyperloop/view-dataset/1286?timestamp=1733308129865)~~ | ~~[304817](https://alimonitor.cern.ch/hyperloop/train-run/304817/general)~~ | &check;  | ~~`LHC23zzm/BerkeleyTrees`~~  |                                   | DEPRECATED |

## MC (central)

A list of central MC productions from ALICE that have been converted to the BerkeleyTree format. As of yet, no productions have been converted.

1. All simulations use Pythia 8 pp. For Pb-Pb, this pp MC should be embedded in Pb-Pb data. All simulations have continuous weighting with oversampling power 4 and reference 10 GeV.
2. A full list of PWG-JE productions can be found on [this spreadsheet](https://docs.google.com/spreadsheets/d/1zsD_StvPqN2-7dOlfN9W03TB4Opj9EwdrBQHOQi3ViU/edit?gid=1990835816#gid=1990835816).
3. The MB gap number refers to the *total* number of signal and MB events within the gap loop. For example, a MB gap 2 simulation goes signal-MB-signal-MB-...

| Name  | Anchor   | Pass | System | Gap | JIRA                                               | Clusters | Path | Hiccup | Notes     |
|-------|----------|------|--------|-----|----------------------------------------------------|----------|------|--------|-----------|
| 25a2b | 22o      | 7    | pp     | 5   | [O2-5654](https://its.cern.ch/jira/browse/O2-5654) |          |      |        |           |
| 26a6  | 24_ppref | 1    | pp     |     | [O2-6632](https://its.cern.ch/jira/browse/O2-6632) |          |      |        |           |
| 26a7  | 24 PbPb  | 3    | PbPb   | 2   | [O2-6633](https://its.cern.ch/jira/browse/O2-6633) |          |      |        | MB gap 2  |
|       | 24 pp    | 1    | pp     |     |                                                    |          |      |        | Gamma-jet |

## MC (fast simulation)

Fast simulation events saved to disk. These events contain generated events and a parametrized version of the Run 3 detector response to approximate a corresponding reconstructed event.

There are currently no Run 3-based fast simulations available.
