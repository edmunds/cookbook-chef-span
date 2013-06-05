name		 "chef-span"
maintainer       "Edmunds.com"
maintainer_email "jmiller@edmunds.com"
license          "Apache 2.0"
description      "Installs a script for querying connectivity information out of chef server instances"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.1"

recipe "chef-span::default", "Installs a script for querying connectivity information out of chef server instances, and configures a cron job for driving it"

supports 'redhat', ">= 5.0"
