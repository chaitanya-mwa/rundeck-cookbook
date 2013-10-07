name             "rundeck"
maintainer       "Seigo Uchida"
maintainer_email "spesnova@gmail.com"
license          "Apache 2.0"
description      "Installs/Configures rundeck"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.2.8"

%W{ centos }.each do |os|
  supports os
end

%W{ apt yum java git users logrotate }.each do |cb|
  depends cb
end

