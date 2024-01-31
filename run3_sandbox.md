# Synopsis

Collection of information on Run 3 analyses. Drop here whatever you find relevant. Let's try to have things organized.

# Relevant ALICE meetings

- PWG JE meeting - September 2023 - <https://indico.cern.ch/event/1326439/>
- PWG HF - <https://indico.cern.ch/event/1326524/>
- O2 Analysis Tutorial - November 2023 - <https://indico.cern.ch/event/1326201/>

# Software development / snippets / etc

# Runs for Run 3 analysis testing
Links I found useful to figure out run status
1. Figure out what period a run belongs to <https://alimonitor.cern.ch/hyperloop/runlists>
2. Spreadsheet(!!) for QA status in Pb-Pb <https://docs.google.com/spreadsheets/d/1vsl-pkLdUoNXZm6muPyMENWdDSKM7UDtQLcXc2B9QhE/edit#gid=492527515>
3. Spreadsheet(!!) for QA status in pp <https://docs.google.com/spreadsheets/d/14vXFYVx3oVE8wgJKmIBhjvAt6NpGp7D6H4AmBM9E0Cw/edit#gid=1454168024>

## Potentially interesting runs Pb-Pb:
- LHC23zzh_cpass1 - Run 544116 - TPC GOOD - ITS GOOD , but EMC not participating. Also run only 7 min long
- LHC23zzh_cpass1 - Run 544126 - same as above but EMCal also not participating
- **FJ suggestion:** LHC23zzk_cpass0      - Run 544451, roughly 30min run. Looking at QA it looks like TPC, ITS and EMCal have status good! Roughly 29khz interaction rate and 45mio inelastic events

## Status of EMCal in Run3 (readiness for analysis)
- on-the-fly bad channel correction → works (in the past this had to be done manually in Run2!)
- on-the-fly time calibration → works
- energy calib on-the-fly works but with PDG pi0 energy, wrong E/p → now corrected for energy loss using MC, even better than in Run2, very differential → calibration available for new apass that is starting now. Starting with pp 2023, then Pb-Pb, then pp 2022
- hardware triggers are working in 2023 data. With hardware triggers almost 100% lifetime (full lumi)
    - for MB not full lumi, lifetime about 5% (in pp) , in Pb-Pb 100% lifetime
- framework side analysis
    - m02 etc all there
    - MC labels are there on cell level, not yet on cluster level. PR pending
    - track matching in principle working, apart from tracking problems that impact track propagation (we have to see with new reconstruction passes)





