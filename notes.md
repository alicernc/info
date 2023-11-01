# 1st of November 2023

## data structure / skimming

- to do (followed from last week):
  - skim a smaple of the data - see data size
    - open pull request from Raymond - https://github.com/AliceO2Group/O2Physics/pull/3590
    - R test on run numbers - see what those 544116 to 544126 are?
    - these numbers are from TPC presentaion at the recent Tech Board [link](https://indico.cern.ch/event/1202842/contributions/5625704/attachments/2736979/4760271/ASchmah_TPC_TB_19102023_V4.pdf)
    - let's use a longer run? - this however, also depends on the int. rate.
  - calculate the statistcal gain of Run 3 vs. Run 2 (in particular in the central sample)
    - 1.5/nb in PbPb (0.12/nb 10% central in Run 2)
    - 9/pb pp - this is probably only the high-energy?
  - follow up on the trigger bit - only single available?
    - second one available for another jet pT threshold - pull request - Raymond will add a link and some text [link in mattermost](https://mattermost.web.cern.ch/alice/pl/t47gpm8szt8ombm5ao38yzznao)
      > 1) We actually managed to get one extra bit for the trigger! So now we will have 2 thresholds with their own bit each.  [AliceO2Group/O2Physics#3666](https://github.com/AliceO2Group/O2Physics/pull/3666)
      > 2) The full CTFs for 2022 are not deleted yet but it is unclear if they will survive the PbPb processing (depends on disk space). so its not certain they will be reconstructed and triggered on again but it might happen. This is the latest  info i got but I do not know exactly where they are stored.
      > 3) a new pass of the reconstruction of the 2023 data will start next week and the triggering on it will start  mid November. So we have about 2 weeks to decide on thresholds and downscales
    
# 25th of October 2023

- O2 JE meeting - https://indico.cern.ch/event/1339333/
  - follow up: why only single bit availble for the jet trigger
  - do we really plan to have two thresholds (low threshold downscaled at ~20; higher at 40 - no downscaling)
- skim data - https://github.com/alicernc/info/blob/main/run_3_skim_tables.md
- query: scan over the PbPb data looking for a "nice" jetty event in EMCal - who can help
  - we need event ID's / run ID's etc
- MP still working on the trigger curves (secondary for the moment)

- search for emails
  - Alexander Kalweit
    - "[Phys. Coord. Update] Test productions to investigate TPC performance with improved calibration"
    - [Phys. Coord. Update] QC volunteers from PWGs and "The November of Reconstruction"

- to do:
  - skim a smaple of the data - see data size
  - calculate the statistcal gain of Run 3 vs. Run 2 (in particular in the central sample)
  - follow up on the trigger bit - only single available?

# 11th of October 2023

- finalization on the R=0.6 trigger strategy - incomplete - still on MP

- links to QA tasks from JE group - https://github.com/AliceO2Group/O2Physics/blob/master/PWGJE/Tasks/jetfinderQA.cxx 

- find out how to extract the collected luminosity for Run 3? - on MP

- slack channel is ON

- skimming:
  - Raymond modified the code and created a pull request
    - check this also: https://github.com/alicernc/info/blob/main/run_3_skim_tables.md
    - note JIRA ticket - https://alice.its.cern.ch/jira/browse/PWGJE-24
  - dependencies: O2 physics installation (need it on hiccup and saul.nersc.gov)
  - example code how to submit a job to Hyperloop with the skimming code?
    - link to documentation needed - everyone/anyone please add here
  - target data sets:
    - reference run or min bias from from 13 TeV
    - any good run from 2023 PbPb - highest interaction rate (recent CPass - fill 9237?) and low interaction rate (from early in the run)

- install alisoft on perlmutter - MP

- find out the in-bunch interaction rates for high-lumi pp runs (see ? [AliceDPG](https://twiki.cern.ch/twiki/bin/viewauth/ALICE/AliceDPG))

- find out from Irakli how much *really* we have space on saul.nersc to store our ntuples/tables?

- news from the PWG-JE O2 analysis meetings
  - Florian takes minutes - see https://github.com/alicernc/info/blob/main/pwg-je-o2-analysis-minutes.md
  - highlight: tracks associated to multiple events - code to process/collect information about these tracks linked in F's notes [trackToCollisionAssociator](https://github.com/nzardosh/O2Physics/blob/master/Common/TableProducer/trackToCollisionAssociator.cxx); Minjung: HF group looking into it as well
  - Raymond: remind the conveners about importance of the minutes
 
# 4th of October 2023

## action items
- work on the data size etc assessmenr ongoing; skimming code being developed - Raymond;
  - [diff link here](https://github.com/AliceO2Group/O2Physics/compare/master...raymondEhlers:O2Physics:lbl-skim)
  - code for filtering - Raymond + everyone - ongoing
  - [Table design document](run_3_skim_tables.md)
- finalization on the R=0.6 trigger strategy - incomplete - still on MP
- put together links to QA tasks from JE group
  - Nima working on the code - committed? - not running within automatic QA trains? - follow up on Florian (?)
- follow up on the photon and HF skimming
  - Raymond/Preeti: HF should be straightforward - 2- 3-prompt decays to store in table
  - Florian will look into photon code
- find out how to extract the collected luminosity for Run 3?
- Created slack channel for more informal discussion. RJE tried to add everyone at the meeting, but probably forgot some folks. [Join here](https://berkeley-heavy-ions.slack.com/archives/C060EQS4X24)

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
- Comparisons of different events for different trigger flags. Weird observations of no changes in nEvents but changes in number of jets and tracks
- Even with no selections significantly different number of tracks and jets (less in O2 than AliPhysics)
- Comment by Vit: maybe not counting selected events the right way? What is also strange is that you get more tracks in O2 with sel7 than with no selection
- Vit: this is not observed for HF validation. Maybe play with AliEventCuts?
- Florian might check to find old slides about validation of emcal correction framework to help Archita
- Florian: could this be related to the fact that ESDs are converted to AO2D instead of AOD? Probably not since HF also starts validation with ESDs and they don’t see it
- Archita will double-check for bugs in the code

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

