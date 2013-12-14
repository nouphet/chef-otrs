#
# Cookbook Name:: chef-otrs
# Recipe:: default
#
# Copyright (C) 2013 YOUR_NAME
# 
# All rights reserved - Do Not Redistribute
#

include_recipe "yum"                                                            

node.set[:timezone][:use_symlink] = false                                       
node.set[:tz] = 'Asia/Tokyo'                                                    
include_recipe 'timezone-ii'                                                    
include_recipe 'yum::epel'

%w{vim tcpdump wget gcc-c++ libffi-devel libyaml-devel make git}.each do |pkg|
  package pkg do                                                                
    action :install                                                             
  end                                                                           
end                                                                             

%w{perl-DBD-MySQL mysql-server perl perl-core perl-libwww-perl perl-Crypt-SSLeay perl-LDAP perl-Net-DNS perl-IO-Socket-SSL perl-XML-Parser perl-TimeDate httpd mod_perl gd gd-devel cronie procmail}.each do |pkg|
  package pkg do                                                                
    action :install                                                             
  end                                                                           
end                                                                             

#%w{vixie-cron}.each do |pkg|
#  package pkg do                                                                
#    action :install                                                             
#  end                                                                           
#end                                                                             

remote_file "/usr/local/src/otrs-3.3.3-01.noarch.rpm" do                          
  source "http://ftp.otrs.org/pub/otrs/RPMS/rhel/6/otrs-3.3.3-01.noarch.rpm"
  #not_if "test -f /usr/local/src/otrs-3.3.3-01.noarch.rpm"                 
end                                                                             

package "OTRS-Package" do
  action :install
  provider Chef::Provider::Package::Rpm
  source "/usr/local/src/otrs-3.3.3-01.noarch.rpm"
end

