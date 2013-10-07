#
# Author:: Seigo Uchida (<spesnova@gmail.com>)
# Cookbook Name:: rundeck
# Recipe:: chef_integrate
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

# TODO Install Ruby

include_recipe "git"

# Create .chef directory and knife.rb for chef-rundeck
directory "/var/lib/rundeck/chef" do
  owner node["rundeck"]["user"]
  group node["rundeck"]["group"]
  mode "0755"
  action :create
end

template "/var/lib/rundeck/chef/config.rb" do
  source "config.rb.erb"
  owner node["rundeck"]["user"]
  group node["rundeck"]["group"]
  mode "0644"
  variables({
    :log_level => node["rundeck"]["chef_integrate"]["log_level"],
    :chef_server_url => Chef::Config["chef_server_url"],
    :validation_client_name => Chef::Config["validation_client_name"],
    :node_name => Chef::Config["node_name"]
  })
end

# Install chef-rundeck gem package
#   1. Clone chef-rundeck git repo.
#   2. Build gem package from .gemsprc in the git repo.
#   3. Install chef-rundeck from .gem file.
# TODO Use remote gems instead of build gems,
#      when the gem is updated and has -P option.
gem_package "chef-rundeck" do
  source "/var/lib/rundeck/chef/chef-rundeck_git-repo/chef-rundeck-0.1.0.gem"
  action :nothing
end

execute "build chef-rundeck gem package" do
  command <<-CMD
    gem build chef-rundeck.gemspec
  CMD
  user node["rundeck"]["user"]
  cwd "/var/lib/rundeck/chef/chef-rundeck_git-repo"
  action :nothing
  notifies :install, "gem_package[chef-rundeck]", :immediately
end

git "/var/lib/rundeck/chef/chef-rundeck_git-repo" do
  repo "https://github.com/oswaldlabs/chef-rundeck.git"
  user node["rundeck"]["user"]
  action :sync
  notifies :run, "execute[build chef-rundeck gem package]", :immediately
end

# Start chef-rundeck process
execute "start chef-rundeck" do
  command <<-CMD
    /opt/chef/embedded/bin/chef-rundeck \
    -c /var/lib/rundeck/chef/config.rb \
    -u #{node["rundeck"]["chef_integrate"]["ssh_user"]} \
    -a #{Chef::Config["chef_server_url"]} \
    -p #{node["rundeck"]["chef_integrate"]["port"]} \
    -P /var/run/chef-rundeck
  CMD
  user "root"
  not_if "kill -0 `cat /var/run/chef-rundeck-#{node['rundeck']['chef_integrate']['port']}`"
  # FIXME use :run, but need to change to daemon process
  #       otherwise chef-client doesn't finish...
  action :nothing
end

# TODO Remove this after chef-rundeck process is changed to daemon process.
message = String.new
message << "sudo -b"
message << " /opt/chef/embedded/bin/chef-rundeck"
message << " -c /var/lib/rundeck/chef/config.rb"
message << " -u #{node['rundeck']['chef_integrate']['ssh_user']}"
message << " -a #{Chef::Config['chef_server_url']}"
message << " -p #{node['rundeck']['chef_integrate']['port']}"
log "Run this command to start chef-rundeck server"
log message
