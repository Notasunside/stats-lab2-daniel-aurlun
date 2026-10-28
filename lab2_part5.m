%% Lab 2 Part 5
clear;
clc;

%% read data
script_folder = fileparts(mfilename('fullpath'));
data_folder = fullfile(script_folder, 'data');

data = readtable('data\clock_cycle_data-1.csv');

supplier = data{:,1};
clock_cycle = data{:,2};
suppliers = [1; 2; 3; 4; 5; 6];

%% residuals histogram and boxplot
residuals = zeros(length(clock_cycle),1);
variances = zeros(6,1);

for i = 1:6

    values = clock_cycle(supplier == i);
    residuals(supplier == i) = values - mean(values);
    variances(i) = var(values);

end

figure;

subplot(1,2,1);
histogram(residuals);
xlabel('Residual (ms)');
ylabel('Count');
title('Residuals');

subplot(1,2,2);
boxplot(residuals, supplier);
xlabel('Supplier');
ylabel('Residual (ms)');
title('Residuals by Supplier');

%% ANOVA
[p, tbl, stats] = anova1(clock_cycle, supplier, 'off');

disp('ANOVA table:');
disp(tbl);

fprintf('ANOVA p-value = %.6g\n', p);

%% two-sample t-tests

combinations = nchoosek(1:6, 2);

Group1 = cell(15,1);
Group2 = Group1;
t = zeros(15,1);
df = t;
p_unadjusted = t;
labels = {'Supplier 1', 'Supplier 2', 'Supplier 3', 'Supplier 4', 'Supplier 5', 'Supplier 6'};

for j = 1:15
    a = combinations(j,1);
    b = combinations(j,2);

    valuesA = clock_cycle(supplier == a);
    valuesB = clock_cycle(supplier == b);

    [~, p_unadjusted(j), ~, test_stats] = ttest2(valuesA, valuesB, 'Vartype','equal', 'Alpha',0.05);

    Group1{j} = labels{a};
    Group2{j} = labels{b};
    t(j) = test_stats.tstat;
    df(j) = test_stats.df;
end

results = table(Group1, Group2, t, df, p_unadjusted);

disp('t-test results:');
disp(results);
