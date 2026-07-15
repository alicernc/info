# MC info

## LHC26c5

MC anchored to LHC24ap/aq (2024 pp reference data set) is stored on hiccup (will be copied to perlmutter at some point):
`/rstorage/lbergmann/mc_conversion/LHC24ppRef/`

pre-selections:
- only mc-collisions with 1 reconstructed collision (i.e. split reconstructions are excluded)
- |vtx<sub>z</sub>| < 10cm
- particles: physical primaries, charged, |eta|<0.9
- tracks: global tracks, migrated tracks from other JJ events are removed

notes: A separate outlier rejection of $$p_{T,jet}/\hat{p}_{T} > cutoff$$ has to be applied on analysis level (cutoff=4 for pp ref. is recommended)

## JEWEL

JEWEL (2.4.0) simulations at different inital temperatures are also stored on hiccup in:

- sqrt(s) = 5.02 TeV
- vacuum (~2mio events) and medium (~2mio events each)

initial temperatures:
- 300 MeV
- 590 MeV
- 900 MeV (in process)

non-default medium parameters are:
- $$\tau_{i} = 0.4$$
- $$T_c = 156 MeV$$
