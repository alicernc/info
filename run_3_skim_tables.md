## Proposed skim tables design

\* = optional, only included as appropriate, ideally (need to confirm how to do this in O2 in a reasonable way). We should be able to turn all of the top level tables off through hyperloop to fit our needs  

## Event level

- Event table:
    - run number
    - some sort of trigger (eg. bool) or full trigger bit?
    - centrality*
    - event plane?*

### Tracks

- Track table for data:
    - pt (sign of pt of can be used to encode charge)
    - eta
    - phi
- Track table for MC:
    - Same as above, plus:
    - ParticleID (when available)*
    - Label (ie. identifier between particle and true level)*
    - Optional encoded information field, where we can bit pack whatever else where want*

### Clusters

- Clusters table for data:
    - E
    - eta
    - phi
    - …?
- Clusters table for MC:
    - Same as approach as track table, minus PID?

### Photons?

- Photons:
    - Can we include candidates instead?
