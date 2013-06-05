#
# Cookbook Name:: chef-span
# Attribute:: default
#
# Copyright 2013, Edmunds.com
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

default['chef_span']['scripts_dir']  = "/usr/local/bin"

default['chef_span']['cron_minute']  = "5"
default['chef_span']['cron_hour']    = "*"
default['chef_span']['cron_day']     = "*"
default['chef_span']['cron_month']   = "*"
default['chef_span']['cron_weekday'] = "*"
default['chef_span']['cron_mailto']  = "/dev/null"

default['chef_span']['input_file']   = ""
default['chef_span']['output_dir']   = "/opt/chef-span"
default['chef_span']['output_dir_owner']   = "root"
default['chef_span']['output_dir_group']   = "root"
default['chef_span']['output_dir_mode']    = "0755"
default['chef_span']['output_file']  = "logical-network-connections.gdf"

default['chef_span']['apis']         = []
