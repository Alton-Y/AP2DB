clear
clc


filelist = dir('BIN');

conn = connMySQL();
fprintf('%s\t Start SQL connection.\n\n',datestr(now));

tablename = 'df_AHR2';

for n = 3:length(filelist)
    
    filename = strcat('BIN/',filelist(n).name);
    
    str = strsplit(filelist(n).name,'.');
    
    
    load(filename,'AHR2','AHR2_label');
    fprintf('%s\t Load %s.\n',datestr(now),filename);
    %
    flightNumber = str2num(str{1});
    fprintf('\t\t\t\t\t\t flightNumber = %i.\n',flightNumber);
    
    
    label = AHR2_label';
    label(end+1) = {'flightNumber'};
    
    flightNumberArray = ones(size(AHR2,1),1).*flightNumber;
    array = horzcat(AHR2,flightNumberArray);
    
    %       insert data to mySQL
    tic;
    fastinsert(conn,tablename,label,array);
    s = toc;
    
    fprintf('%s\t Elapsed time is %.3f seconds.\n',datestr(now),s);
    fprintf('\t\t\t\t\t\t %i rows. %.2f rows/s \n',size(AHR2,1),size(AHR2,1)/s);
    %
    fprintf('\n');
end
close(conn);

fprintf('%s\t Stop SQL connection.\n',datestr(now));

