%% Lab 2 Part 3
clear;
clc;

%% read data
data = readtable('data/time_to_failure_data-1.csv');

supplier = data{:,1};
time_to_failure = data{:,2};
suppliers = [1; 2; 3; 4; 5; 6];

%% compare all pairs

SupplierA = zeros(15,1);
SupplierB = zeros(15,1);
PairMean = zeros(15,1);
PairMedian = zeros(15,1);

j = 0;

for i = 1:5

    for k = i+1:6

        j = j + 1;

        valuesA = time_to_failure(supplier == suppliers(i));
        valuesB = time_to_failure(supplier == suppliers(k));

        pair_lifetime = max(valuesA, valuesB');

        PairMean(j) = mean(pair_lifetime(:));
        PairMedian(j) = median(pair_lifetime(:));

        SupplierA(j) = suppliers(i);
        SupplierB(j) = suppliers(k);

    end

end

%% ranked pairs by MeanLifetime

Results = table(SupplierA, SupplierB, PairMean, PairMedian, ...
    'VariableNames', {'SupplierA', 'SupplierB', ...
    'MeanLifetime', 'MedianLifetime'});

Results = sortrows(Results, 'MeanLifetime', 'descend');

disp(Results);