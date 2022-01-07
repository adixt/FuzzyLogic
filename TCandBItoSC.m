clc;
clear;
close all;

%a type-2 Sugeno Fuzzy Inference System (FIS)
priceDemandFIS = sugfis('Name', "TC and BI - SC");

% Add input variable -Transportation Cost (TC)- to fuzzy inference system
priceDemandFIS = addInput(priceDemandFIS, [30 60], 'Name', "TC");
% Add input variable -Bullwhip Indicator (BI)- to fuzzy inference system
priceDemandFIS = addInput(priceDemandFIS, [1 2], 'Name', "BI");
%Add output variable -System Condition (SC)- to fuzzy inference system
priceDemandFIS = addOutput(priceDemandFIS, [-1 1], 'Name', "SC");

%Add Z-shaped membership function to 1st input fuzzy variable -TC-
priceDemandFIS = addMF(priceDemandFIS, "TC", 'zmf', [30 40], 'Name', "cheap");
%Add Triangular membership function to 1st input fuzzy variable -TC-
priceDemandFIS = addMF(priceDemandFIS, "TC", 'trimf', [36 43 50], 'Name', "averageCost");
%Add S-shaped membership function to 1st input fuzzy variable -TC-
priceDemandFIS = addMF(priceDemandFIS, "TC", 'smf', [45 60], 'Name', "expensive");

%Add Z-shaped membership function to 2nd input fuzzy variable -BI-
priceDemandFIS = addMF(priceDemandFIS, "BI", 'zmf', [1 1.3], 'Name', "low");
%Add Triangular membership function to 2nd input fuzzy variable -BI-
priceDemandFIS = addMF(priceDemandFIS, "BI", 'trimf', [1.2 1.35 1.5], 'Name', "medium");
%Add S-shaped membership function to 2nd input fuzzy variable -BI-
priceDemandFIS = addMF(priceDemandFIS, "BI", 'smf', [1.4 2.0], 'Name', "high");

%Add constant membership functions to output fuzzy variable -SC-
priceDemandFIS = addMF(priceDemandFIS, "SC", 'constant', -1, 'Name', "optimal");
priceDemandFIS = addMF(priceDemandFIS, "SC", 'constant', -0.5, 'Name', "nearOptimal");
priceDemandFIS = addMF(priceDemandFIS, "SC", 'constant', 0, 'Name', "regular");
priceDemandFIS = addMF(priceDemandFIS, "SC", 'constant', 0.5, 'Name', "nonoptimal");
priceDemandFIS = addMF(priceDemandFIS, "SC", 'constant', 1, 'Name', "disturbed");

Fuzzy_rules = [ ...
                "TC==cheap & BI==low => SC=optimal"; ...
                "TC==averageCost & BI==low => SC=nearOptimal"; ...
                "TC==expensive & BI==low => SC=regular"; ...
                "TC==cheap & BI==medium => SC=nearOptimal"; ...
                "TC==averageCost & BI==medium => SC=regular"; ...
                "TC==expensive & BI==medium => SC=nonoptimal"; ...
                "TC==cheap & BI==high => SC=regular"; ...
                "TC==averageCost & BI==high => SC=nonoptimal"; ...
                "TC==expensive & BI==high => SC=disturbed" ...
            ];

%Add rules to fuzzy inference system
priceDemandFIS = addRule(priceDemandFIS, Fuzzy_rules);
%The FIS Editor displays high-level information about a Fuzzy Inference System.
fuzzy(priceDemandFIS);
%Display fuzzy inference system
plotfis(priceDemandFIS);
%Display fuzzy inference system rules
showrule(priceDemandFIS);
%Open Rule Viewer
ruleview(priceDemandFIS);
