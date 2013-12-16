name             'chef-otrs'
maintainer       'nouphet'
maintainer_email 'nouphet.ratanavong@gmail.com'
license          'All rights reserved'
description      'Installs/Configures chef-otrs'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends "selinux",     "~> 0.5.6"
depends "yum",         "~> 2.3.0"
depends "timezone-ii", "~> 0.2.0"
depends "database",    "~> 1.3.0"

