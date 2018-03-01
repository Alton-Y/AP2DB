conn = connMySQL();

tic
query = 'SELECT TimeUS,flightNumber,Alt,Lat, Lng FROM createv.df_AHR2 WHERE Lat <> 0';
curs = exec(conn,query);
curs = fetch(curs);
data = curs.Data;
toc
close(conn);

%%
scatter(data.Lng,data.Lat,[],data.flightNumber,'.')
grid minor
axis equal