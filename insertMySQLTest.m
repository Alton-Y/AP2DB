clear
clc




load('43.BIN-454388.mat','AHR2','AHR2_label');
flightNumber = 43;
% load('AHR2.mat');
tablename = 'df_AHR2';
label = AHR2_label';
array = AHR2;
label(end+1) = {'flightNumber'};


flightNumberArray = ones(size(array,1),1).*flightNumber;
% id = (1:size(array,1))';

array = horzcat(array,flightNumberArray);
%% connect and insert data to mySQL
conn = connMySQL();
tic
fastinsert(conn,tablename,label,array);
toc
close(conn);







