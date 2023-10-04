# 4th of October 2023

## notes from PWG-O2 meeting

```
Begin forwarded message:
```

From: Florian Jonas <fjonas@lbl.gov>
Subject: PWG-JE O2 analysis meeting minutes 04.10.23
Date: October 4, 2023 at 7:30:59 AM PDT
To: Mateusz Ploskon <mploskon@lbl.gov>
Cc: Barbara Jacak <bvjacak@lbl.gov>, Minjung Kim <minjung.kim@lbl.gov>, Preeti Dhankher <pdhankher@lbl.gov>, Raymond Ehlers <rehlers@lbl.gov>, Wenqing Fan <wenqing@lbl.gov>, James Mulligan <jmulligan@lbl.gov>

Hey everyone,

I wrote some private minutes for the PWG-O2 meeting. I think also Laura by now writes official minutes, but it can’t hurt. You missed nothing much, only an update on the validation of the JE framework with puzzling mismatches in the number of events, jets and tracks for O2 vs. AliPhysics … most likely a bug of some form or user error.

Minutes PWG-JE O2 analysis meeting 04.10.2023
Present:  Florian Debjani, Filip, Jaehyeok,  Joonsuk, Sidharth, Sweta, Vit, Archita, Abhi, Yubiao, Vertesi, Laura, 

Presentation by Archita on validation of Jet framework (debugging) using official validation framework
Comparisons of different events for different trigger flags. Weird observations of no changes in nEvents but changes in number of jets and tracks
Even with no selections significantly different number of tracks and jets (less in O2 than AliPhysics)
Comment by Vit: maybe not counting selected events the right way? What is also strange is that you get more tracks in O2 with sel7 than with no selection
Vit: this is not observed for HF validation. Maybe play with AliEventCuts?
Florian might check to find old slides about validation of emcal correction framework to help Archita
Florian: could this be related to the fact that ESDs are converted to AO2D instead of AOD? Probably not since HF also starts validation with ESDs and they don’t see it
Archita will double-check for bugs in the code

12:25 - End of meeting

# 27 Septemeber 2023

New JE o2 dev meeting [indico here](https://indico.cern.ch/category/16173/) . Meeting time is bad for us.

Action items:
- re-engage in organization of the meetings within JE - better timing for us - potentially 7AM Wednesdays
    - understand what is OUR best time/day - we should make sure at least one of us connects
    - potential for two meetings? - not ideal
    - share your best times with the group / MP
- check the service task assignement for QA
    - validation of JE framework - comparison to Run 2
    - underlying event subtraction in AA
    - QA/QC - two volounteers - real-time based on nightly hyperloop tasks (JE not yet in the daily) - during the run(!) - possibly intensive when data being collected (issue: timing of the reporting - 6:30AM? - daily [indico](https://indico.cern.ch/event/1330828/) )
    - check the penalty of triggering at low-pT R=0.6 jets for high-pT jets - MP
- Raymond asked for minutes of the JE o2 meeting - listed up.

## Re trigger threshold for the software trigger
- response from Filip - look into the slides in detail
- bias studies for R=0.6



# Various notes - 20 September 2023

## Action items:
- contact Filip about the thresholds setup for the software trigger - why not R=0.2 - Florian - email to Fillip / CC to others
- skimming data formats (output of the software trigger) - understand the structure, footprint and location of the files, copy some to hiccup - Raymond
  - [Docs on skimming](https://aliceo2group.github.io/analysis-framework/docs/basics-usage/SavingTablesToFile.html?highlight=skim) . We can pick out fields immediately, although if we want to aclculate more (which we usually will), we need explicit tasks
- further skimming to track tables - Raymond - Florian - add photon events - HF? checkin with Preeti?
    - HF meeting yesterday - find in INDICO - looking for people for HF-jets / service task; HF-jet framework within JE-framework
- scaling of analysis using python within O2; further skimming - Raymond

## General goals:
- primary target for pp is to find out if we can do 2023 pp locally - all of it ?
- which software triggers RNC group wants/requests?
  - find out if the JE strategy is OK
  - photon software triggers
  - HF software triggers - higher a thresholds data sets?

