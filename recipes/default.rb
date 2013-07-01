#
# Author:: Seigo Uchida (<spesnova@gmail.com>)
# Cookbook Name:: rundeck
# Recipe:: default
#
# Copyright (C) 2013 Seigo Uchida (<spesnova@gmail.com>)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Configure package manager
case node["platform"]
when "ubuntu"
  # TODO
when "centos", "redhat"
  include_recipe "yum::epel"
end

# Install java
include_recipe "java::openjdk"

# Install, configure, start Rundeck
case node["platform"]
when "ubuntu"
  # TODO
when "centos", "redhat"
  remote_file "#{Chef::Config['file_cache_path']}/rundeck-latest.rpm" do
    action :create_if_missing
    source node['rundeck']['rpm_url']
  end

  rpm_package "rundeck" do
    action :install
    source "#{Chef::Config['file_cache_path']}/rundeck-latest.rpm"
  end

  yum_package "rundeck" do
    action :install
    version node["rundeck"]["version"]
  end
end

# Configure logrotate
include_recipe "logrotate"

logrotate_app "rundeck" do
  cookbook "logrotate"
  path "/var/log/rundeck/*.log"
  frequecy "daily"
  create "644 #{node['rundeck']['user']} #{node['rundeck']['group']}"
  rotate 7
  options ["compress", "delaycompress", "missingok", "notifempty"]
end

service "rundeckd" do
  supports :status => true, :restart => true
  action [:enable, :start]
end

# Configure Rundeck
# template "/etc/rundeck/rundeck-config.properties" do
#   source "rundeck-config.properties.erb"
#   owner node["rundeck"]["user"]
#   group node["rundeck"]["group"]
#   #variables
#   notifies :restart, "service[rundeckd]"
# end
