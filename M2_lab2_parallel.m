%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ITEM 2 -- ALL 63 PARALLEL COMBINATIONS
% cut exactly from M2_matlab_AN.m in M2 assignment 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[script_folder, data_folder, output_folder] = lab2_setup();
rng(1);
N = 100000;
ttf_data = readtable(fullfile(data_folder,'time_to_failure_data-1.csv'));
suppliers = unique(ttf_data{:,1});
n = length(suppliers);
mean_ttf = zeros(n,1);
for j = 1:n
    mean_ttf(j) = mean(ttf_data{ttf_data{:,1} == suppliers(j),2});
end
lambda = 1 ./ mean_ttf;         % exponential mean = 1/lambda
fail_times = zeros( N,n );        % rows = trials; columns = suppliers

% -- from large_syst_reliability_ica.m
% t_1 = (-log( unifrnd(0, 1, 1)) / lambda_base) ^ (1/k_base ); % ttf comp 1
% -- or exprnd(1/lambda)
% but -log( rand )/lambda shld gen the same exponential model in base MATLAB?

for i = 1:N
    for j = 1:n
        fail_times( i,j)= -log( max(rand,realmin)) / lambda( j );
    end
end

number_of_results = 2^n - 1;
number_parallel= zeros( number_of_results,1 );
combination_name = cell(number_of_results,1 );
parallel_mttf= zeros( number_of_results,1 );

result_row = 0;

for k= 1:n
    combinations= nchoosek( 1:n,k ); % dist group k 

    for c = 1:size( combinations,1)

        result_row = result_row + 1;
        selected = combinations( c,: );

        number_parallel( result_row) = k;
        labels= arrayfun( @num2str, suppliers( selected), 'UniformOutput', false );
        combination_name{result_row } = strjoin( labels, ' + ' );

        if k== 1
            % ind MTTF is its observed mean ( also the fitted mean).
            parallel_mttf( result_row) = mean_ttf( selected );
        else
            % -- one || system fails when its last component fails
            % -- is max( fail_times), as in the class example
            % -- 
            system_ttf = max( fail_times( :,selected), [], 2 );
            parallel_mttf( result_row) = mean( system_ttf );
        end
    end
end

parallel_results = table( number_parallel, combination_name, parallel_mttf, 'VariableNames', {'NumberParallel','Suppliers','MTTF_hours' } );
disp( 'ITEM 2: PARALLEL MTTF ( HOURS)' );
disp( 'exp model; independent lifetimes; unchanged failure rates.' );
disp( 'Single suppliers: observed means. Groups: Monte Carlo estimates.' );
disp( parallel_results );

writetable( parallel_results, fullfile( output_folder, 'parallel_mttf.csv') );

% each wombo (word + coombo)
figure( 'Color','w','Position',[100 100 950 600] );
hold on;
colors = lines( n );

for k =1:n
    rows = number_parallel== k;

    scatter( number_parallel( rows), parallel_mttf( rows), 55, colors( k,:), 'filled', 'HandleVisibility','off' );
end

xlim( [0.5 n+0.5] );
%xlim( [1 n+1] );
xticks( 1:n );
xlabel('Microcontrollers in parallel');
ylabel( 'Mean time to failure ( hours)' );
title('Independent exponential parallel model');
grid on;
set( gca, 'FontSize',12 );
hold off;
exportgraphics( gcf, fullfile( output_folder,'parallel_mttf.png' ), 'Resolution',200 );
savefig( gcf, fullfile( output_folder, 'parallel_mttf.fig') );


