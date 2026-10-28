%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ITEMS SIX SEVEN SIX SEVEN 
% base matlab no libraries needed
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[script_folder, data_folder, output_folder] =lab2_setup();
ttf =readtable( fullfile( data_folder,'time_to_failure_data-1.csv') );
clock= readtable(fullfile( data_folder ,'clock_cycle_data-1.csv') );
x = zeros( 6,1 ); y = zeros( 6, 1);
for j = 1:6
    x( j) = mean( clock{clock{:,1} == j,2} );
    y( j) = mean( ttf{ttf{:, 1} == j,2} );
end

figure( 'Color', 'w','Position',[100 100 1000 430] );
scatter( x,y, 80,[134 31 65]/255 , 'filled' );

for j = 1:6
    text( x( j)+0.005, y( j),num2str( j));
end

xlabel( 'mean clock cycle time (ms): smaller is faster' );
ylabel( 'individual mean lifetime ( hrs)' );
grid on;
exportgraphics( gcf, fullfile( output_folder, 'tradeoff.png'),'Resolution', 200 );
