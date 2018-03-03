clear
clc

load('Seen.mat');
Seen = {'AHR2'};
Seen = strcat('df_',Seen);% add prefix df_ to every parameters for db
%%
conn = connMongoDB();

if isopen(conn) == 1
    
    % compare the list of collections with the "Seen parameters list"
    % work out if there is any missing parameter on the db
    % if found, add them as new collections
    newCollection = [];
    newCollection = Seen(~ismember( Seen, conn.CollectionNames' ));
    addedCollection = 0;
    if ~isempty(newCollection)
        for n = 1:length(newCollection)
            try
                createCollection(conn,string(newCollection{n}));
                addedCollection = addedCollection + 1;
            catch
                error('Error adding collection: %s. \n',string(newCollection{n}));
            end
        end
    end
%     
    
    fprintf('%i Collections. %i Added. \n',length(conn.CollectionNames), addedCollection)
    close(conn);
    
end