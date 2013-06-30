# Description
Install and configure orchestration tool Rundeck.

Learn more about Rundeck [Here](http://rundeck.org/).

Currently supported:

* Install Rundeck
* Configure Rundeck tool users
* Install and configure chef-rundeck integrator

Roadmap:

* Managing firewall(iptables)
* Support Other platform
* Support log rotate
* Add a test case using data bag for tool_users recipe
* Add a test case for chef_integrate
* Add a resource to start chef-rundeck server.
* Option to use MySQL

# Requirements
## Platform

* CentOS

Tested on:

* CentOS 6.4

## Cookbook

* apt
* yum
* java

# Usage
## Installing Rundeck
Include the default recipe on your node or role that fits how you wish to install Rundeck on your system per the recipes section above. Modify the attributes as required in your role to change how various configuration is applied per the attributes section above. In general, override attributes in the role should be used when changing attributes.

## Managing Rundeck tool users
If you're going to manage Rundeck user by Chef, include the tool_users recipe under the default recipe.

    ...
    "recipe[rundeck]",
    "recipe[rundeck::tool_users]"  # Add here
    ...

And define user id / password in roles or data bag.

Example definition in roles

    "override_attributes": {
      "rundeck": {
        "tool_users": {
          "use_data_bag": true,
          "users": [
            {
              "id": "admin",
              "encrypt": nil,
              "password": "admin",
              "roles": ["admin"]
            },
            {
              "id": "jsmith",
              "encrypt": "MD5",
              "password": "a029d0df84eb5549c641e04a9ef389e5",
              "roles": ["admin"]
            }
          ]
        }
      }
    }

Example definition in data bags, see Data Bags Section.

## Integrating Rundeck with Chef
Include the chef_integrate recipe on your node or role.

For now, you need to start chef-rundeck server yourself...

# Attributes
See the `attributes/default.rb` for default values.

* `node["rundeck"]["version"]` - The rundeck package version to install. String
* `node["rundeck"]["rpm_url"]` - Yum repo package url. String
* `node["rundeck"]["user"]` - User that Rundeck will run as. String
* `node["rundeck"]["group"]` - Group for Rundeck. String
* `node["rundeck"]["tool_users"]["use_data_bag"]` - Whether or not use data bag to manage Rundeck tool users. Boolean
* `node["rundeck"]["tool_users"]["data_bag_name"]` - Data bag name managing Rundeck tool users data. String (default to `users`)
* `node["rundeck"]["tool_users"]["users"]` - Rundeck tool users definition. Hash
* `node["rundeck"]["chef_integrate"]["log_level"]` - Log level about chef-rundeck sinatra server run. String (`info` or `debug`)
* `node["rundeck"]["chef_integrate"]["ssh_user"]` - SSH user that Rundeck server use to connect nodes. String
* `node["rundeck"]["chef_integrate"]["port"]` - Port that chef-rundeck sinatra server listen on. Fixnum

# Recipes
## default
Install Rundeck

## tool_users
Create Rundeck tool users.

For more detail, this recipe create rundeck users definition file `realm.properties`
from node attributes or data bag

## chef_integrate
Install and configure chef-rundeck gem.

# Data Bags
This cookbook use data bag to manage Rundeck tool users.
(Or you can manage by node attributes.)

First, please see [opscode-cookbooks/users Usage section](https://github.com/opscode-cookbooks/users#usage).

Add Rundeck data to each users item.
```
{
  "id": "bofh",
  "password": "$1$d...HgH0",
  "ssh_keys": [
    "ssh-rsa AAA123...xyz== foo",
    "ssh-rsa AAA456...uvw== bar"
  ],
  "groups": [ "sysadmin", "dba", "devops" ],
  "uid": 2001,
  "shell": "\/bin\/bash",
  "comment": "BOFH",
  ...
  ...
  "rundeck": {
    "locked_user": false,
    "encrypt": "MD5",
    "password": "a029d0df84eb5549c641e04a9ef389e5",
    "roles": ["admin", "users"]
  },
  ...
  ...
}
```

* `locked_user` - Whether or not lock this user account.
* `encrypt` - Encryption method, `MD5` or `OBF` or `CRYPT` or `false`(plain)
* `password` - Encrypted or plain password
* `roles` - Roles this user have

Upload the json data to Chef Server.
```
$ knife data bag from file users data_bags/users/*.json
```

# License and Author

Author:: Seigo Uchida (<spesnova@gmail.com>)

Copyright:: 2013 Seigo Uchida (<spesnova@gmail.com>)

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

```
http://www.apache.org/licenses/LICENSE-2.0
```

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
