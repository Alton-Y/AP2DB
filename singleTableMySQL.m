function [cursor] = singleTableMySQL(conn,name,labels)
%SINGLETABLEMYSQL Summary of this function goes here
%   Detailed explanation goes here

    cursor = [];

    % assign all datatype as double
    labels(:,2) = {'DOUBLE'};
    
    % assign datatype BIGINT to TimeUS
    idxTimeUS = find(contains(labels(:,1),'TimeUS'));
    labels(idxTimeUS,2) = {'BIGINT'};
    
    % assign datatype INT to LineNo
    idxLineNo = find(contains(labels(:,1),'LineNo'));
    labels(idxLineNo,2) = {'INT'};
    
    
    % SQL query
    % add prefix df_ to form table name
    tableName = strcat('df_',name);
    % CREATE TABLE
    query = sprintf('CREATE TABLE %s (',tableName);
    % Unique ID, auto_increment
    query = sprintf('%s id MEDIUMINT NOT NULL AUTO_INCREMENT,',query);
    % flightNumber
    query = sprintf('%s flightNumber SMALLINT NOT NULL,',query);
    % loop lables
    for n = 1:size(labels,1)
        query = sprintf('%s %s %s NOT NULL,',query,labels{n,1},labels{n,2});
    end
    % Primary key
    query = sprintf('%s PRIMARY KEY (id),',query);
    % Index flightNumber
    query = sprintf('%s INDEX (flightNumber)',query);
    % close query
    query = sprintf('%s );',query);
    
    
    
    % Exec Query to mySQL
    try
        cursor = exec(conn,query);
        
    catch
        error('Error adding collection: %s. \n',name);
    end








end

