#
# Cookbook Name:: chef-otrs
# Recipe:: default
#
# Copyright (C) 2013 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

node.set[:timezone][:use_symlink] = false
node.set[:tz] = 'Asia/Tokyo'

include_recipe 'timezone-ii'
include_recipe "yum"
include_recipe 'yum::epel'
include_recipe 'database::mysql'
#include_recipe "iptables"

#iptables_rule "ssh"
#iptables_rule "http"

%w{vim tcpdump wget gcc-c++ libffi-devel libyaml-devel make git}.each do |pkg|
  package pkg do
    action :install
  end
end

%w{cronie
    gd
    gd-devel
    httpd
    mod_perl
    mysql-server
    perl
    perl-core
    perl-Crypt-Eksblowfish
    perl-Crypt-SSLeay
    perl-Encode-HanExtra
    perl-GD
    perl-GDGraph
    perl-GDTextUtil
    perl-JSON-XS
    perl-LDAP
    perl-Mail-IMAPClient
    perl-DBD-MySQL
    perl-IO-Socket-SSL
    perl-LDAP
    perl-libwww-perl
    perl-Net-DNS
    perl-PDF-API2
    perl-Text-CSV_XS
    perl-TimeDate
    perl-XML-Parser
    perl-YAML-LibYAML
    procmail
  }.each do |pkg|
  package pkg do
    action :install
  end
end

service "httpd" do
      supports :status => true, :restart => true, :reload => true
      action [ :enable, :restart ]
end

service "mysqld" do
      supports :status => true, :restart => true, :reload => true
      action [ :enable, :restart ]
end

# Setting up MySQL Database
mysql_connection_info = {:host => "localhost",
                         :username => 'root',
                         :password => node['mysql']['server_root_password']
}

mysql_database "otrs" do
    connection mysql_connection_info
    action :create
end

mysql_database_user "otrs" do
    connection mysql_connection_info
    password "somepass"
    database_name "otrs"
    privileges [:all]
    action [:create, :grant]
end

# Install OTRS Package
remote_file "/usr/local/src/otrs-3.3.3-01.noarch.rpm" do
  source "http://ftp.otrs.org/pub/otrs/RPMS/rhel/6/otrs-3.3.3-01.noarch.rpm"
  #not_if "test -f /usr/local/src/otrs-3.3.3-01.noarch.rpm"
end

package "OTRS-Package" do
  action :install
  provider Chef::Provider::Package::Rpm
  source "/usr/local/src/otrs-3.3.3-01.noarch.rpm"
end

#service "otrs" do
#      supports :status => true, :restart => true, :reload => true
#      action [ :enable, :restart ]
#end

log "########################################"
log "# Finished.                            #"
log "########################################"

log "Next steps:

[httpd services]
 Restart httpd 'service httpd restart'

 [install the OTRS database]
  Make sure your database server is running.
   Use a web browser and open this link:
    http://your.domain/otrs/installer.pl

    [OTRS services]
     Start OTRS 'service otrs start' (service otrs {start|stop|status|restart).

     ((enjoy))

      Your OTRS Team"

