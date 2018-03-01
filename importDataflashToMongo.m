clear
clc

FMT = load('42.BIN-1446536.mat');

Seen = sort(FMT.Seen);
Seen = {'AHR2'};
%
%%
conn = connMongoDB();
%%


flightNumber = 135;

for i = 1:length(Seen)
    collection = Seen{i};
    array = FMT.(collection);
    label = FMT.(sprintf('%s_label',collection));
    
    
    % add flight number to array and label
    array(:,1) = flightNumber;
    label{1} = 'flightNumber';
    
    
    T = array2table(array,'VariableNames',label);
    
    
    n = insert(conn,strcat('df_',collection),T);
    fprintf('%i documents added to %s.\n',n,collection)
end
%
%%
close(conn);









