# Description
Install and configure orchestration tool Rundeck.

Learn more about Rundeck [Here](http://rundeck.org/).

Currently supported:

* Install Rundeck

Roadmap:

* Option to use MySQL
* Support Other platform
* Configure rundeck user definition
* Install and configure chef-rundeck integrator

# Requirements
## Platform

* CentOS

## Cookbook

* apt
* yum
* mysql

# Usage

# Attributes
See the `attributes/default.rb` for default values.

* `node["rundeck"]["version"]` - The rundeck package version to install
* `node["rundeck"]["rpm_url"]` - Yum repo package url

# Recipes
## default
Install and configure Rundeck

## user(yet)
Create rundeck users definition file `realm.properties` from users data bag.

## _mysql(yet)
Install and configure MySQL

# Data Bags

# License and Author

Author:: Seigo Uchida (<spesnova@gmail.com>)

Copyright:: 2013 Seigo Uchida (<spesnova@gmail.com>)

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

```
http://www.apache.org/licenses/LICENSE-2.0
```

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
