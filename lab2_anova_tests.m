function [p, tbl, stats] = lab2_anova_tests( values, groups, labels, prefix, output_folder)
% 
%% checking assumptions -- directly follows matlab_anova.m from iyr class

[g, ~] = findgroups( groups );
groupMeans = splitapply( @mean, values, g );
residuals = values - groupMeans( g );

figure( 'Color', 'w',  'Position', [100 100 1100 400] );
subplot( 1, 2, 1 );
histogram( residuals);

xlabel( 'Residual' ); ylabel( 'Count' ); title( 'Within-group residuals' );
subplot( 1, 2, 2 );
boxplot( residuals, g, 'Labels', labels );

xlabel( 'Group' ); ylabel( 'Residual' ); title( 'Compare residual spreads' );
if length( labels) > 6
    xtickangle( 65 );
end

exportgraphics( gcf, fullfile( output_folder,  [prefix '_assumptions.png']),  'Resolution', 200 );
variances= splitapply( @var, values, g );
variance_ratio = max( variances)/min( variances );
fprintf( '%s largest/smallest residual variance: %.4f\n', prefix, variance_ratio );


%% running anova -- the executable anova1 call from our Canvas class file
[p, tbl, stats] = anova1( values, groups, 'off' );
disp( prefix ); disp( tbl );
anova_result= table( tbl{2, 5},tbl{2, 3}, tbl{3,3},p, variance_ratio,  'VariableNames', {'F', 'df_between', 'df_within', 'p', 'VarianceRatio'} );
writetable( anova_result, fullfile( output_folder,[prefix '_anova.csv']) );

%% follow-up two-sample t-tests ( class t-test method)

combinations = nchoosek( 1:length( labels), 2 );
Group1 = cell( size(combinations, 1), 1 );
Group2 =Group1;
t =zeros( size( combinations, 1), 1 );
df = t;
p_unadjusted= t;

for j = 1:size( combinations, 1)
    a = combinations( j, 1 ); b = combinations( j, 2 );
    [~, p_unadjusted( j), ~, test_stats] = ttest2(  values( g==a), values( g==b),'Vartype','equal', 'Alpha' , 0.05 );
    Group1{j} = labels{a}; Group2{j} = labels{b};
    t( j) = test_stats.tstat; df( j) = test_stats.df;
end

results = table( Group1, Group2, t, df,p_unadjusted );
disp( results);
writetable( results, fullfile( output_folder, [prefix '_ttests.csv']) );
% % fprintf( 'Unadjusted\n' );

end
