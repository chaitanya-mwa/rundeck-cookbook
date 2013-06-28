require 'spec_helper'

describe file("/etc/rundeck/realm.properties") do
  it { should be_file }
  it { should contain "admin: admin,admin,users" }
  it { should contain "jsmith: MD5:a029d0df84eb5549c641e04a9ef389e5,admin" }
  it { should contain "steve: OBF:1xfd1zt11uha1ugg1zsp1xfp,admin" }
  it { should contain "bill: CRYPT:stnPHOuwRN8Is,admin" }
end