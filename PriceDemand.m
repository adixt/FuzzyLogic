clc
clear
close all

%a type-1 Mamdani Fuzzy Inference System (FIS)
priceDemandFIS = mamfis('Name', "10^3 Price (USD)- BTC Demand");

% Add input variable -price- to fuzzy inference system
priceDemandFIS = addInput(priceDemandFIS, [40 60], 'Name', "price");
%Add output variable -demand- to fuzzy inference system
priceDemandFIS = addOutput(priceDemandFIS, [0 100], 'Name', "demand");

%Add Z-shaped membership function to input fuzzy variable -price-
priceDemandFIS = addMF(priceDemandFIS, "price", 'zmf', [40 50], 'Name', "cheap");
%Add Triangular membership function to input fuzzy variable -price-
priceDemandFIS = addMF(priceDemandFIS, "price", 'trimf', [47 50 58], 'Name', "medium");
%Add S-shaped membership function to input fuzzy variable -price-
priceDemandFIS = addMF(priceDemandFIS, "price", 'smf', [50 60], 'Name', "expensive");

%Add Gaussian membership functions to output fuzzy variable -demand-
priceDemandFIS = addMF(priceDemandFIS, "demand", 'gaussmf', [5 25], 'Name', "low");
priceDemandFIS = addMF(priceDemandFIS, "demand", 'gaussmf', [10 40], 'Name', "mid");
priceDemandFIS = addMF(priceDemandFIS, "demand", 'gaussmf', [20 60], 'Name', "high");

Fuzzy_rules = [
            1 3 1 1 %If (price is cheap(1)) then (demand is high(3)) with 100 % condifence (1) AND(1)'
            3 1 1 1 %If (price is expensive(3)) then (demand is low(1)) with 100 % condifence (1) AND(1)'
            2 2 1 1]; % If (price is medium(2)) then (demand is mid(2)) with 100 % condifence (1) AND(1)'

%Add rule to fuzzy inference system
priceDemandFIS = addRule(priceDemandFIS, Fuzzy_rules);
%The FIS Editor displays high-level information about a Fuzzy Inference System.
fuzzy(priceDemandFIS)
%Display fuzzy inference system
plotfis(priceDemandFIS)
%Display fuzzy inference system rules
showrule(priceDemandFIS)
%Open Rule Viewer
ruleview(priceDemandFIS)
