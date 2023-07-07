# example for flavor dependent EEC's with Pythia using pyjetty

- code: <https://github.com/matplo/pyjetty/blob/master/pyjetty/sandbox/qorg/eec_flavor_dep_example.py>
- example run: <https://github.com/matplo/pyjetty/blob/master/pyjetty/sandbox/qorg/run_eec_flavor.sh>
- result: eec distributions <https://www.dropbox.com/s/z1us1xmo7z1lrlx/eec_flavor.draw_Fig_0.png?dl=0>
    - jet pt distributions <https://www.dropbox.com/s/z1us1xmo7z1lrlx/eec_flavor.draw_Fig_1.png?dl=0>
    - IMPORTANT NOTE: the tagging could be still refined (one can tune what parton's are ghosted for example)

# some more info

- the strucure follows:
  - initialize pythia
  - loop until a given number of jets is collected
  - within the loop turn partons into ghosts and merge with the hadron level particles
  - run the jet finder
  - for each jet use the tagger to know the leading flavor
  - run the EEC code and fill histograms (using a class that opens a root file and creates histograms dynamically for each flavor found)

- the code uses <https://github.com/matplo/pyjetty/blob/master/pyjetty/sandbox/qorg/flavor_tagger.py> to tag jets with the leading parton but the partons are first merged with the hadron level information as ghosts (then jet finder is run on the whole event and individual jets satisfying some kinematic cuts tagged)

- in the `run_eec_flavor.sh` we ask pythia to generate either gluon, uds quarks, charm, or beauty dominated jets in the final state - to spead up the generation; we also ask for minimum pThat and specify cuts on jet pT's; this of course can be extended as needed
