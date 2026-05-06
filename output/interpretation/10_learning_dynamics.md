# US-007 Learning Dynamics by Proficiency Group

## Spec
For each proficiency group separately:
y ~ Treat × {wb5,wb4,wb3,wb2, w1,w2,w3,w4,w5} | rider + station-date | cluster rider
(wb1 = reference week)

## Coefficients
         term              group    estimate        se      p_value week_index      ci_low     ci_high
       <char>             <char>       <num>     <num>        <num>      <num>       <num>       <num>
 1: Treat:wb5   High-proficiency -0.04469529 0.1724255 0.7959450933         -5 -0.38264917  0.29325860
 2: Treat:wb4   High-proficiency -0.11499640 0.1486377 0.4407564465         -4 -0.40632631  0.17633351
 3: Treat:wb3   High-proficiency  0.02948554 0.1258248 0.8151503972         -3 -0.21713107  0.27610215
 4: Treat:wb2   High-proficiency  0.14049914 0.1174543 0.2341439075         -2 -0.08971138  0.37070967
 5:  Treat:w1   High-proficiency  0.14031820 0.1349047 0.3005204468          1 -0.12409501  0.40473141
 6:  Treat:w2   High-proficiency -0.13513281 0.1528809 0.3786389250          2 -0.43477946  0.16451384
 7:  Treat:w3   High-proficiency  0.05216601 0.1407934 0.7116988835          3 -0.22378902  0.32812104
 8:  Treat:w4   High-proficiency  0.24437832 0.1348009 0.0725281797          4 -0.01983142  0.50858807
 9:  Treat:w5   High-proficiency  0.20754958 0.1865613 0.2683050637          5 -0.15811055  0.57320971
10: Treat:wb5    Low-proficiency  0.01559397 0.1701739 0.9271558121         -5 -0.31794682  0.34913477
11: Treat:wb4    Low-proficiency -0.31261696 0.1356730 0.0231072178         -4 -0.57853601 -0.04669792
12: Treat:wb3    Low-proficiency -0.07275720 0.1350592 0.5911883256         -3 -0.33747330  0.19195890
13: Treat:wb2    Low-proficiency -0.12242393 0.1438084 0.3964697808         -2 -0.40428842  0.15944057
14:  Treat:w1    Low-proficiency  0.01855503 0.1079507 0.8638471720          1 -0.19302825  0.23013830
15:  Treat:w2    Low-proficiency -0.16717312 0.1383486 0.2295289059          2 -0.43833646  0.10399021
16:  Treat:w3    Low-proficiency -0.06044959 0.1181354 0.6098977467          3 -0.29199493  0.17109575
17:  Treat:w4    Low-proficiency  0.01479443 0.1802655 0.9347413681          4 -0.33852590  0.36811476
18:  Treat:w5    Low-proficiency  0.07441299 0.1711987 0.6646694676          5 -0.26113640  0.40996238
19: Treat:wb5 Medium-proficiency  0.03124125 0.1570582 0.8426897449         -5 -0.27659275  0.33907526
20: Treat:wb4 Medium-proficiency  0.07564213 0.1657983 0.6491080641         -4 -0.24932244  0.40060671
21: Treat:wb3 Medium-proficiency  0.18955768 0.1629117 0.2470748281         -3 -0.12974921  0.50886457
22: Treat:wb2 Medium-proficiency -0.01152396 0.1224854 0.9252102579         -2 -0.25159532  0.22854740
23:  Treat:w1 Medium-proficiency  0.11099868 0.1516198 0.4656454602          1 -0.18617612  0.40817348
24:  Treat:w2 Medium-proficiency  0.40037634 0.1347704 0.0036352394          2  0.13622631  0.66452638
25:  Treat:w3 Medium-proficiency  0.12131803 0.1599445 0.4497445397          3 -0.19217326  0.43480932
26:  Treat:w4 Medium-proficiency  0.46023797 0.1666845 0.0067327806          4  0.13353640  0.78693954
27:  Treat:w5 Medium-proficiency  0.43993690 0.1300756 0.0009913224          5  0.18498869  0.69488510
         term              group    estimate        se      p_value week_index      ci_low     ci_high
       <char>             <char>       <num>     <num>        <num>      <num>       <num>       <num>

## Reviewer address
- R2-9: empirical evidence on the learning curve. The per-week treatment effect series shows whether benefits emerge gradually (consistent with learning) or appear immediately. By proficiency group, this also speaks to differential adaptation patterns.

## Limitation
Observation window is 5 weeks post-rollout (1 month + buffer). Long-term adaptation cannot be inferred. The Dec-Feb extension (US-010) helps address this.
