# Minutes PWG-JE O2 analysis meeting 11.10.23
present: 13 people .. I will not write them individually

## General:
- Hadi is implementing background subtraction for PbPb
- news on HF tagging
- small bug, if you request to run multiple R at the same time, it will default to eta acceptance matching only one radius -> now fixed

## Presentation on Track QA by Alice Caluisi (student of Marta)
- QA dataset LHC22p_pass4_small
- study of track uncertainty as function of pt shows unexpectedly two distinct distributions instead of one -> origin is investigated and appears to be due to an issue with ITS-TPC matching
- high pt tracks show low number of crossed TPC rows etc. (see slide 9/10)
  - Comment Nima: How did you come to this conclusion? Isn’t this statistical? Only 30 counts in the box? -> Marta thinks it is significant at very high pt, she thinks it is fake tracks.
  - Marta: our plan is to focus on very hig pt first (pt>100GeV), understand what is goin on and then go lower
- Slide 12: the “weird” tracks however have low chi2 … I asked about it and Marta commented that also fake track can have low chi2
- slide 15 gaps appear in eta phi and change as function of pt. Origin is certain ITS staves that are off (according to Marta). See also backup slide 20
  - Comment Johanna: the very low pt <1GeV  gaps are there because matching ITS-TPC is very bad 
- Personal comment: slide 17 mentions a track skim. Maybe useful for us to check out the code and compare to our skim, i.e. what information is stored etc
- Comment Nima: in general ITS-TPC matching efficiency lower than in Run2. Marta has some suggestions to start discussions with tracking group
- Comment Nima: check if tracks are correctly associated to collision! There is a task “TrackToCollisionAssociator” in common. One can run that and itallows you to check if a track may belong to multiple collisions. This is outside of the JE framework. https://github.com/nzardosh/O2Physics/blob/master/Common/TableProducer/trackToCollisionAssociator.cxx we should look into this

## Presentation by Johanna on Jet framework validation
- comment by Florian: please consider also checking the number of accepted events and comparing AliPhysics and O2
- since the shape is very well reproduced, it may speak to a difference in the number of accepted events
- Johanna talked about overwritten files, but Vit commented that if something is overwritten it is not configured correctly
- Question Nima: Did you manage to turn off entirely the event selection in O2 Physics? -> No, right now she is running event selection in jet finder
- Maybe problem in event selection of jet finder?
- Archita and Johannah will communicate and debug together

## Presentation by Nima on first look at jets in PbPb collisions in Run3 (see slides)
- slide 2: I asked if it is possible to get ML based background subtraction interface included. In principle yes
- Gijs has questions about ghosts: Markus implemented a more efficient way for the jet finder. Is this fix included in the background estimation? Markus: No this can not be used here, because he removed the ghosts only for the trigger. The CPU intensiveness of ghost generation might be show show-stopper in PbPb. Maybe one needs to get in touch with Fastjet authors. Also, contact ATLAS and CMS? Maybe one also needs to adjust ghost area depending what is possible from CPU hours
- slide 5: comment Marta. She thinks what is labeled power law is actually the tail of the resolution Gaussian
- slide 6: Johanna: skewness that is visible in eta distribution seems to be interaction rate dependent when looking at tracks
- slide 7: how can it be jets of 0.6 increase with high eta, but tracks inside jets fall with increasing eta?
- slide 13: names for people responsible for Jet QC listed on slide 13
- Markus suggests to combine QA for full and charged jets using one templated structure etc

had to leave after 1.5h due to other conflicts
