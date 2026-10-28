%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ITEMS 1 AND 4 
% -- pulls a lot from M2 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[script_folder, data_folder, output_folder] = lab2_setup();
filenames = {'time_to_failure_data-1.csv', 'clock_cycle_data-1.csv'};
output_names = {'ttf_summary.csv', 'clock_summary.csv'};

for dataset = 1:2
    data = readtable(fullfile(data_folder, filenames{dataset}));
    suppliers = unique(data{:,1});
    n = length(suppliers); % -- line 27 in M2_MATLAB_AN.m %
    N = zeros(n,1);
    Mean = zeros(n,1);
    Median = zeros(n,1);
    SampleSD = zeros(n,1);


    for j = 1:n
        values = data{data{:,1} == suppliers(j),2};
        N(j) = length(values);
        Mean(j) = mean(values);
        Median(j) = median(values);
        SampleSD(j) = std(values);
    end
    summary = table(suppliers,N,Mean,Median,SampleSD, ...
        'VariableNames',{'Supplier','N','Mean','Median','SampleSD'});
    disp(filenames{dataset});
    disp(summary);
    writetable(summary,fullfile(output_folder,output_names{dataset}));
    
end
%pause;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Below are items 1 and 4 from Milestone 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% % ttf_data = readtable( fullfile( script_folder, 'time_to_failure_data-1.csv') );
% clock_data = readtable( fullfile( script_folder, 'clock_cycle_data-1.csv') );
% % supplier ID in column 1 + measurements in column 2
% suppliers = unique( ttf_data{:,1 } );
% n = length( suppliers );
% 
% %pause;
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % ITEM 1: TIME-TO-FAILURE SUMMARY ( HOURS)
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% 
% % -- from large_system_reliability_ica.m %
% % total_ttf_weib = zeros( [N 1] ); % preallocation
% sample_size_ttf= zeros( n,1 );    % preallocation
% mean_ttf= zeros( n,1 );
% median_ttf = zeros( n,1 );
% sd_ttf = zeros( n,1 );
% 
% for j = 1:n
%     values= ttf_data{ttf_data{:,1 } ==suppliers( j), 2  };
%     sample_size_ttf(j)= length( values );
%     mean_ttf( j ) = mean( values );
%     median_ttf( j )= median( values );
%     sd_ttf(j) =std( values );     % -- sample SD: denominator is sample size - 1
% end
% 
% ttf_summary = table( suppliers, sample_size_ttf, mean_ttf, median_ttf, sd_ttf, 'VariableNames', {'Supplier','SampleSize','Mean_hours','Median_hours','SampleSD_hours'  } );
% 
% disp( 'ITEM 1: TIME TO FAILURE (in HRS)' );
% disp( ttf_summary );
% 
% writetable( ttf_summary, fullfile( output_folder, 'ttf_summary.csv') );

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ITEM 4: CLOCK-CYCLE SUMMARY ( mS :)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% sample_size_clocker = zeros( n,1 );
% mean_clock = zeros( n,1 );
% 
% median_clock = zeros( n,1 );
% 
% sd_clock = zeros( n,1 );
% 
% for j = 1:n
%     values = clock_data{ clock_data{:,1 } == suppliers( j), 2 };
%     sample_size_clocker( j) = length( values );
% 
%     mean_clock( j) = mean( values );
% 
%     median_clock( j) = median( values );
%     sd_clock( j) = std( values );
% end
% 
% clock_summary = table( suppliers, sample_size_clocker, mean_clock, median_clock, sd_clock, 'VariableNames', {'Supplier','SampleSize', 'Mean_ms','Median_ms','SampleSD_ms' } );
% disp( 'ITEM 4: CLOCK CYCLES ( MILLISECONDS )' );
% disp( 'Smaller clock-cycle times indicate faster processing' );
% disp( clock_summary );
% 
% writetable( clock_summary, fullfile( output_folder, 'clock_summary.csv') );
% % -- Save me LaTeX save me!!
% % fprintf( 'Results saved to: %s\n', output_folder );
