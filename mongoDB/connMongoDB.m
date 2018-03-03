function [conn] = connMongoDB()
%CONNMONGODB Summary of this function goes here
%   Detailed explanation goes here

ipAddress = '';
dbName = 'createv';
userName = 'createv';
password = '';

conn = mongo(ipAddress,27017,dbName,'UserName',userName,'Password',password);
end

