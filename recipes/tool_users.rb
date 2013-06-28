#
# Author:: Seigo Uchida (<spesnova@gmail.com>)
# Cookbook Name:: rundeck
# Recipe:: tool_users
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

user_definition_lines = Array.new

# Public: Create a Rundeck user definition line
#
# id       - String, The Rundeck tool user id
# encrypt  - String, password encryption method ("MD5", "CRYPT", "OBF")
# password - String, encrypted or plain password
# roles    - Array, the user having roles name
#
# Examples
#
#   user_definition_line(
#     "steve",
#     "MD5",
#     "a2cb028d8cfcc9fec8890234td",
#     ["admin", "users"]
#   )
#   # => 'steve: MD5:a2cb028d8cfcc9fec8890234td,admin,users'
#
# Returns a string
def user_definition_line(id, encrypt, password, roles)
  "#{id}: #{encrypt}#{':' if encrypt}#{password},#{roles.join(',')}"
end

if node["rundeck"]["tool_users"]["use_data_bag"]
  search(node["rundeck"]["tool_users"]["data_bag_name"], "rundeck_locked_user:false") do |u|
    user_definition_lines << user_definition_line(
      u["id"],
      u["rundeck"]["encrypt"],
      u["rundeck"]["password"],
      u["rundeck"]["roles"]
    )
  end
else
  node["rundeck"]["tool_users"]["users"].each do |u|
    user_definition_lines << user_definition_line(
      u["id"],
      u["encrypt"],
      u["password"],
      u["roles"]
    )
  end
end

template "/etc/rundeck/realm.properties" do
  source "realm.properties.erb"
  owner node["rundeck"]["user"]
  group node["rundeck"]["group"]
  mode "0600"
  variables({
    :user_definition_lines => user_definition_lines
  })
  backup false
  notifies :restart, "service[rundeckd]"
  action :create
end
