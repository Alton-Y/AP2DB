function [conn] = connMySQL()


datasource = 'createv';
username = 'createv';
password = '';
driver = 'com.mysql.jdbc.Driver';
url = 'jdbc:mysql://:3306/';
conn = database(datasource,username,password,driver,url);


