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

