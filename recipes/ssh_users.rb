#
# Author:: Seigo Uchida (<spesnova@gmail.com>)
# Cookbook Name:: rundeck
# Recipe:: ssh_users
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

users_manage node["rundeck"]["ssh_users"]["group"] do
  data_bag node["rundeck"]["ssh_users"]["data_bag_name"]
  group_id node["rundeck"]["ssh_users"]["gid"]
  action :create
end