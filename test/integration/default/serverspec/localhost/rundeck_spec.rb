require 'spec_helper'

if ::File.exists?("/etc/redhat-release")
  describe yumrepo("epel") do
    it { should exist }
    it { should be_enabled }
  end
end

describe command("java") do
  it { should return_exit_status 0}
end

describe package("rundeck") do
  it { should be_installed }
end

describe service("rundeckd") do
  it { should be_running }
end
