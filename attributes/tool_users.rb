#
# Author:: Seigo Uchida (<spesnova@gmail.com>)
# Cookbook Name:: rundeck
# Attributes:: tool_users
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

# About Configuring Rundeck users
default["rundeck"]["tool_users"]["use_data_bag"]  = false
default["rundeck"]["tool_users"]["data_bag_name"] = "users"
default["rundeck"]["tool_users"]["users"] = [
  { "id"       => "admin",
    "encrypt"  => nil,
    "password" => "admin",
    "roles"    => ["admin"]
  },
  { "id"       => "jsmith",
    "encrypt"  => "MD5",
    "password" => "a029d0df84eb5549c641e04a9ef389e5",
    "roles"    => ["admin"]
  }
]
