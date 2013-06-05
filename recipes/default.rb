#
# Cookbook Name:: chef-span
# Recipe:: default
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

cron_job_command_args = ""
output_file_path = File.join(node['chef_span']['output_dir'],node['chef_span']['output_file'])

# Check preconditions

# Do we have an API to query?
if node['chef_span']['apis'].empty? then
  Chef::Log.warn("node['chef_span']['apis'] is empty.  This is bad.  See chef-span cookbook README.")
else
  # Do the pems with which we'll be authenticating actually exist?
  # While we're checking, build the list of apis to be set in the cron job command
  cron_job_command_args += " -a "
  node['chef_span']['apis'].each do |api|
    pem = api.split(",").last
    if ( File.exists? pem ) then
      cron_job_command_args += api + ","
    else
      Chef::Log.warn("Client API key \"#{pem}\" per node['chef_span']['apis'] - No such file.  This is bad.  See chef-span cookbook README.")
    end
  end
end

# Is there a static input file specified, and does it actually exist?
if ! node['chef_span']['input_file'].empty? then
  if File.exists? node['chef_span']['input_file'] then
    cron_job_command_args += " -i #{node['chef_span']['input_file']} " 
  else
    Chef::Log.warn("Input file \"#{node['chef_span']['input_file']}\" - No such file.  Ignoring input file.")
  end
end

cron_job_command_args += " -o #{output_file_path} "

directory node['chef_span']['scripts_dir'] do
  recursive true
  owner "root"
  group "root"
  mode 0755
  action :create
end

directory node['chef_span']['output_dir'] do
  recursive true
  owner node['chef_span']['output_dir_owner']
  group node['chef_span']['output_dir_group']
  mode node['chef_span']['output_dir_mode']
  action :create
end

chef_span_script = "#{node['chef_span']['scripts_dir']}/chef-span.rb"

template "#{chef_span_script}" do
  source 'chef-span.rb.erb'
  owner 'root'
  group 'root'
  mode 0755
end

# Build the cron job command based on the node attributes
chef_span_cron_command = "#{chef_span_script} #{cron_job_command_args}"

cron "chef-span cron" do
  minute node['chef_span']['cron_minute']
  hour node['chef_span']['cron_hour']
  day node['chef_span']['cron_day']
  month node['chef_span']['cron_month']
  weekday node['chef_span']['cron_weekday']
  mailto node['chef_span']['cron_mailto']
  command "#{chef_span_cron_command}"
end
