# Run 2 data record

Information on the Run 2 data and MC stored on Perlmutter and Hiccup.

## Table of contents

- [Table of contents](#table-of-contents)
- [Contact](#contact)
- [Data](#data)
- [MC (central)](#mc-central)
  - [Production list](#production-list)
  - [JJ simulation types](#jj-simulation-types)
  - [Cross-section paths](#cross-section-paths)
- [MC (fast simulation)](#mc-fast-simulation)

## Contact

Author: Tucker Hwang  
Date: 26 June 2025  
Contact: [tucker_hwang@berkeley.edu](mailto:tucker_hwang@berkeley.edu) or Slack for issues, questions, or suggestions

## Data

Raw data converted to BerkeleyTree format.

1. For runlists, check the [DPG Twiki](https://twiki.cern.ch/twiki/bin/view/ALICE/AliDPGReconstructedDataTakingPeriodsSummary) and navigate to the corresponding run periods, or check the analysis notes of the example analyses.
2. All Perlmutter paths should be prepended with: `/global/cfs/cdirs/alice/alicepro/hiccup/rstorage/alice/data`

| Period | Pass | System | Trigger cluster | Anchored MC | Runlist                     | Perlmutter          | Example analyses |
|--------|------|--------|-----------------|-------------|-----------------------------|---------------------|------------------|
| 17pq   | 2    | pp     | FAST+CENT_woSDD | 23a3b+23a3c | CBT runlist for 17p and 17q | `LHC17pq_pass2/807` | pp EEC           |
| 16qt   | 2    | pPb    | FAST+CENT_woSDD | 24c1        | CBT runlist for 16q and 16t | `LHC16qt/776`       | pPb EECs         |
| 18qr   | 3    | PbPb   |                 | 20g4        | CBT runlist for 18q and 18r | `LHC18qr/147-148`   | PbPb EECs        |

## MC (central)

A list of central MC productions from ALICE that have been converted to the BerkeleyTree format.

1. All Perlmutter paths should be prepended with: `/global/cfs/cdirs/alice/alicepro/hiccup/rstorage/alice/data`
2. The JJ column denotes whether this is a jet-jet simulation. MB denotes a minimum-bias simulation. For types like 1a, the number indicates the bin edges and the letter differentiates the different scaling factors required, both of which are listed below the table.

### Production list

| Period      | Pass | Anchored data | System | Generator | Trigger cluster | Type | JIRA         | Notes                             | Perlmutter           | Example analyses  |
|-------------|------|---------------|--------|-----------|-----------------|------|--------------|-----------------------------------|----------------------|-------------------|
| 18b8        | 1    | 17pq          | pp     | Pythia    | FAST+CENT_woSDD | 1a   | ALIROOT-7689 |                                   | `LHC18b8_charge/804` | pp EECs           |
| 23a3b+23a3c | 2    | 17pq          | pp     | Pythia    | FAST+CENT_woSDD | 1a   | ALIROOT-8829 |                                   | `LHC23a3/806`        | pp charged EECs   |
| 18f3        | 1    | 16qt          | pPb    | DPMJET    | FAST+CENT_woSDD | MB   | ALIROOT-7792 |                                   | `LHC18f3/803`        | p-Pb EECs         |
| 24c1        | 2    | 16qt          | pPb    | Pythia    | FAST+CENT_woSDD | 2    | ALIROOT-8867 |                                   | `LHC24c1/808_809`    | p-Pb charged EECs |
| 20g4        | 3    | 18qr          | PbPb   | Pythia    |                 | 1b   | ALIROOT-8505 | pp sim for embedding into MB data | `LHC20g4_mcid/805`   | PbPb EECs         |

### JJ simulation types

1. 20 bins with edges 5, 7, 9, 12, 16, 21, 28, 36, 45, 57, 70, 85, 99, 115, 132, 150, 169, 190, 212, 235, 235+ GeV
2. 6 bins with edges 5, 11, 21, 36, 57, 84, 84+ GeV

### Cross-section paths

- 1a: `/global/cfs/cdirs/alice/alicepro/hiccup/rstorage/alice/data/LHC18b8_charge/scaleFactors.yaml`
- 1b: `/global/cfs/cdirs/alice/alicepro/hiccup/rstorage/alice/data/LHC20g4_mcid/scaleFactors.yaml`
- 2: `/global/cfs/cdirs/alice/alicepro/hiccup/rstorage/alice/data/LHC24c1/scaleFactors_temp.yaml`

## MC (fast simulation)

Fast simulation events saved to disk. These events contain generated events and a parametrized version of the Run 2 reconstruction conditions to approximate a corresponding reconstructed event.

1. File formats may vary, so make sure to run a test to make sure it works with your code.
2. All Perlmutter paths must be prepended with: `/global/cfs/cdirs/alice/alicepro/hiccup/rstorage/generators`

| System | Generator | Energy (TeV) | Type   | Perlmutter                                        |
|--------|-----------|--------------|--------|---------------------------------------------------|
| pp     | Herwig 7  | 5.02         | Dijets | `herwig_alice/tree_fastsim/1120002/265216/260023` |
| pp     | Herwig 7  | 5.02         | Dijets | `herwig_alice/tree_fastsim/1122902/265216/260023` |
| pp     | Pythia 8  | 5.02         | Dijets | `pythia_alice/tree_fastsim/1143757/1132588`       |
