Description
===========

Installs a script (chef-span.rb) for querying connectivity information out of chef server instances, and a cron job to drive said script.

The output of the chef-span.rb script is a collection of vertices and edges which can be used with graphing software to visualize your network.

Attributes
==========

`node['chef_span']['scripts_dir']` - filesystem location for chef-span.rb script

`node['chef_span']['cron_minute']` - cron minute schedule for running chef-span.rb

`node['chef_span']['cron_hour']` - cron hour schedule for running chef-span.rb

`node['chef_span']['cron_day']` - cron day schedule for running chef-span.rb

`node['chef_span']['cron_month']` - cron month schedule for running chef-span.rb

`node['chef_span']['cron_weekday']` - cron weekday schedule for running chef-span.rb

`node['chef_span']['input_file']` - Optional file name for the input file for chef-span.rb

`node['chef_span']['output_dir']` - filesystem location for the output file for chef-span.rb

`node['chef_span']['output_file']` - file name for the output file for chef-span.rb

`node['chef_span']['apis']` - array for chef server API target and credentials.
	Should be in the form 'https://chef.server.url:port,chef_client_name,/home/user/.chef/key.pem[,...]'  
	This needs to be set to function - it is empty by default.  See Usage below.

Usage
=====

To use this cookbook, do the following:

First: Use a role or wrapper cookbook to set node['chef_span']['apis'] with the chef server API url, the chef client name, and pem ( with optional multiple chef servers ).  
	Examples:
	To query a single chef server:
	node['chef_span']['apis'] = ["https://chef.server.url:port,chef_client_name,/home/user/.chef/key.pem"]
	To query multiple chef servers:
	node['chef_span']['apis'] = [ "https://chef.server.url:port,chef_client_name,/home/user/.chef/key.pem", \
				      "https://chef.server.url2:port,chef_client_name2,/home/user/.chef/key.pem2" ]

Second: Make sure the pem(s) you populated in the first step exist on the system.  If the pem doesn't exist, the recipe will error when chef-client is run.

Third: at the time of this writing, chef-span will attempt to query nfs filesystems and "connections" out of the node data for every node in the chef server.  NFS filesystems are available by default with ohai, but "connections" are not.  "Connection" data is gathered via an ohai plugin, and is a rolling summary of recent TCP network connections.  The connection data GREATLY increases the value of the graph that is output by chef-span.  See https://github.com/edmunds/cookbook-connections for additional details.   

Fourth, if there are manual nodes and edges you want to include in the graph, you can optionally create an input file, and then set node['chef_span']['input_file']using a role or wrapper cookbook.  I advise against this ; manual entries are future problems.  For those who proceed nonetheless, the syntax of the input file can be found in SAMPLE_INPUT.txt.

Changes
=======

## v0.0.1

- first cut

License and Author
==================

Author:: Joshua Miller (<jmiller@edmunds.com>)

Copyright:: 2013, Edmunds.com

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
