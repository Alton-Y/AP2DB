setdbprefs('DataReturnFormat','table')

conn = connMySQL();

tic
query = 'SELECT * FROM createv.df_ARSP';
curs = exec(conn,query);
curs = fetch(curs);
data = curs.Data;
toc
close(conn);

%%
% scatter(data.TimeUS,data.Alt-183,[],data.flightNumber,'.')
scatter(data.TimeUS,data.Airspeed,[],data.flightNumber,'.')

grid minor
% axis equal