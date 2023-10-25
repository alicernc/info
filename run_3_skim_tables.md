## Proposed skim tables design

\* = optional, only included as appropriate, ideally (need to confirm how to do this in O2 in a reasonable way). We should be able to turn all of the top level tables off through hyperloop to fit our needs  

## Event level

- Event table:
    - run number
    - some sort of trigger (eg. bool) or full trigger bit? - in favor of trigger bit word (full mask)
    - centrality* - yes
    - event plane?* - yes
    - vertex-Z position (pre-cut at 10cm)
    - information from FIT - T0, V0
    - any other quality cuts
      - flag for ambigous tracks - is this is also a per-track quantity?
      - number of HF, photon, J/psi candidates? (overlap with trigger information)

### Tracks

- Track table for data:
    - pt (sign of pt of can be used to encode charge - yes)
    - eta
    - phi
- Track table for MC:
    - Same as above, plus:
    - ParticleID (when available)*
    - Label (ie. identifier between particle and true level)*
    - Optional encoded information field, where we can bit pack whatever else where want*
      - including track quality flag?

### Clusters
- seperate table?
- Clusters table for data:
    - E
    - eta
    - phi
    - …?
- Clusters table for MC:
    - Same as approach as track table, minus PID?

### Photons?
- note this goes to a separate table

### HF
- separate table

- Photons:
    - Can we include candidates instead?
