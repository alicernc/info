---
Title: Standalone simulations
Author: Tucker Hwang
Date: 20 June 2025
Contact: tucker_hwang@berkeley.edu or Slack
---

# Standalone simulations

Information on the standalone Monte Carlo simulations stored on disk.

1. All Perlmutter paths should be prepended with: `/global/cfs/cdirs/alice/alicepro/hiccup/rstorage`
2. Details on usage vary widely depending on the generator. The directory for each simulation contains a README that explains how the simulation is organized and how they should be used.
3. These simulations are typically done with generators for which an on-the-fly analysis for a specific observable is somewhat annoying. On-the-fly Pythia can be easily done via `alian` or `pyjetty`.
4. The generator-level events from fast simulations can also work as standalone simulations as well; check the fast simulation sections of the [Run 2](/data/run2.md#mc-fast-simulation) and [Run 3](/data/run3.md#mc-fast-simulation) data records.

| System | Generator  | Energy (TeV) | Type   | Perlmutter       |
|--------|------------|--------------|--------|------------------|
| pp     | HERWIG 7.3 | 5.02         | Dijets | `herwig73_alice` |
| pp     | SHERPA     | 5.02         | Dijets | `sherpa_alice`   |
