conn = connMongoDB();

tic
% documents1 = find(conn,'df_AHR2','Query','{"TimeUS":359798752}');
toc
% 
tic
documents2 = find(conn,'df_AHR2','Projection','{"Lat":1.0,"Lng":1.0}');




toc

close(conn);