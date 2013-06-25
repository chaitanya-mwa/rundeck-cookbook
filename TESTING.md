This cookbook includes support for running tests via Test Kitchen (1.0). This has some requirements.

1. You must be using the Git repository, rather than the downloaded cookbook from the Chef Community Site.
2. You must have Vagrant 1.1 installed.
3. You must have a "sane" Ruby 1.9.3 environment.

Once the above requirements are met, install the additional requirements:

Install the berkshelf plugin for vagrant, 
```
vagrant plugin install vagrant-berkshelf
gem install berkshelf
```
Install the following packages

* berkshelf (cookbook dependency management tool)
* Test Kitchen (Chef testing integration framework)
* kitchen-vagrant (berkshelf plugin for vagrant)
* busser (test runner for test-kitchen)
* serverspec (test suites)

```
$ bundle install
```

Once the above are installed, you should be able to run Test Kitchen:
```
$ kitchen list
$ kitchen test
```
