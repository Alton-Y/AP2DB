function [cursor] = createTableMySQL(conn,Seen,Labels)


cursor = [];
SeenTables = lower(sort(strcat('df_',Seen)));
Seen = sort(Seen);
try
    sqlTables = lower(tables(conn,'createv'))';
    sqlTables = sqlTables(1,:)';
catch
    sqlTables = {};
end

newTables = sort(Seen(~ismember( SeenTables, sqlTables )));


addedTable = 0;
for j = 1:length(newTables)
    
    try
        name = newTables{j};
        
        
        labels = Labels.(sprintf('%s_label',name));
        
        cursor = singleTableMySQL(conn,name,labels);
        addedTable = addedTable + 1;
    end
end
%
fprintf('%i Collections. %i Added. \n',length(tables(conn,'createv')), addedTable);

end
