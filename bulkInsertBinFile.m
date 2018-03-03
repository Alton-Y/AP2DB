clear
clc


filelist = dir('BIN');

conn = connMySQL();
fprintf('%s\t Start SQL connection.\n\n',datestr(now));


%%
for n = 10:11
    
    filename = strcat('BIN/',filelist(n).name);
    
    str = strsplit(filelist(n).name,'.');
    
    load(filename,'Seen');
    Seen = sort(Seen);
    Seen = Seen(2:end);
%     Seen = {'AHR2'};
    
    Labels = load(filename,'*_label');
    [cursor] = createTableMySQL(conn,Seen,Labels);
    
    % only load variable names with numbers and digits
    DF = load(filename,'-regexp','^[a-zA-Z0-9_.-]*$');
    fprintf('%s\t Load %s.\n',datestr(now),filename);
    %
    flightNumber = str2num(str{1});
    fprintf('\t\t\t\t\t\t flightNumber = %i.\n',flightNumber);

    
    
    for k = 1:length(Seen)
        FMT = Seen{k};
        
        tablename = strcat('df_',FMT);
        
        array = DF.(FMT);
        fprintf('%s\t %s (%i/%i) %i rows.\n',datestr(now),FMT,k,length(Seen),size(array,1));
        
        label = DF.(sprintf('%s_label',FMT))';
        label(end+1) = {'flightNumber'};
        
        flightNumberArray = ones(size(array,1),1).*flightNumber;
        array = horzcat(array,flightNumberArray);
        
        %       insert data to mySQL
        
        tic;
        curs1 = exec(conn,'START TRANSACTION');
        fastinsert(conn,tablename,label,array);
        curs2 = exec(conn,'COMMIT');
        s = toc;
        
        fprintf('\t\t\t\t\t\t Elapsed time is %.3f seconds.\n',s);
        fprintf('\t\t\t\t\t\t %.2f rows/s \n',size(array,1)/s);
        %
        fprintf('');
        
    end
end


close(conn);

fprintf('%s\t Stop SQL connection.\n',datestr(now));

