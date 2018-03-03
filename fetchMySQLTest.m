setdbprefs('DataReturnFormat','table')

conn = connMySQL();

tic
query = 'SELECT * FROM createv.df_baro WHERE flightNumber = 42';
curs = exec(conn,query);
curs = fetch(curs);
data = curs.Data;

query = 'SELECT * FROM createv.df_gps WHERE flightNumber = 42';
curs = exec(conn,query);
curs = fetch(curs);
data2 = curs.Data;

query = 'SELECT * FROM createv.df_NKF1 WHERE flightNumber = 42';
curs = exec(conn,query);
curs = fetch(curs);
data3 = curs.Data;

query = 'SELECT * FROM createv.df_pos WHERE flightNumber = 42';
curs = exec(conn,query);
curs = fetch(curs);
data4 = curs.Data;
%
query = 'SELECT * FROM createv.df_ahr2 WHERE flightNumber = 42';
curs = exec(conn,query);
curs = fetch(curs);
data5 = curs.Data;

query = 'SELECT * FROM createv.df_tecs WHERE flightNumber = 42';
curs = exec(conn,query);
curs = fetch(curs);
data6 = curs.Data;

toc
close(conn);

%%
figure(1)
clf(1)
% scatter(data.TimeUS,data.Alt-183,[],data.flightNumber,'.')
hold on
scatter(data.TimeUS,data.Alt,[],'.')

scatter(data2.TimeUS,data2.Alt,[],'.')

% scatter(data5.TimeUS,data5.Alt-data5.Alt(1),[],'.')

scatter(data4.TimeUS,data4.Alt- data4.Alt(1),[],'.')

scatter(data3.TimeUS,-data3.PD,[],'.')

scatter(data6.TimeUS,data6.h,[],'.')

legend('Baro','GPS','POS','NKFPD','TECS')
grid minor
axis tight
% axis equal