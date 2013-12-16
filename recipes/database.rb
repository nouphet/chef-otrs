include_recipe 'database::mysql'

mysql_connection_info = {:host => "localhost",
                         :username => 'root',
                         :password => node['mysql']['server_root_password']}

mysql_database "otrs" do
    connection mysql_connection_info
    action :create
end

mysql_database_user "otrs" do
    connection mysql_connection_info
    password "otrs"
    database_name "otrs"
    privileges [:all]
    action [:create, :grant]
end




