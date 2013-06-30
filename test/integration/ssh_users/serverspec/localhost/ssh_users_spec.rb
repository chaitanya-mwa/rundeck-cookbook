require 'spec_helper'

public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEApYF0Vh/bE6xRiuh6N6YzNTNjVc1EysP6y4xn9xWxeB0x3e+JwyjAqbnK+80IcUJkixWDlp+m5XEZH0bTVHitPOB/q/5pwF2zEhNXgoz0VGCZy4FdrheQW6FAE9HTpRmUAqKdAuA3/zp4BlwtPJrGOFUC6pa88oHYwhlc65NlSZ8y38/zjxWEQnBJPSsqd6hSZ55NE0qgpUCIbuvL3OYSlDJhpuFDFNe2CKWB74Mg+NsKbjJKmqyN3ouO5W9ZvuI1d1n3igK9VC07Iz6ieYtfxoniX8gpGU2wYl0zndnyqG5SFPyzqxQaDAjhS5npZBL561pdgFwSmOtgHHSAieF5Xw=="

describe user("rundeck") do
  it { should exist }
  it { should have_uid 50001 }
  it { should belong_to_group "rundeck" }
  it { should have_login_shell "/var/lib/rundeck" }
  it { should have_authorized_key public_key }
end
