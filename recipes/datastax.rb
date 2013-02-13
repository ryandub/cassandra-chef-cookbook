#
# Cookbook Name:: cassandra
# Recipe:: datastax
#
# Copyright 2011-2012, Michael S Klishin & Travis CI Development Team
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

# This recipe relies on a PPA package and is Ubuntu/Debian specific. Please
# keep this in mind.

include_recipe "java"

apt_repository "datastax" do
  uri          "http://debian.datastax.com/community"
  distribution "stable"
  components   ["main"]
  key          "http://debian.datastax.com/debian/repo_key"
  action :add
end

# DataStax Server Community Edition package will not install w/o this
package "python-cql" do
  action :install
end

package "dsc12" do
  action :install
end

package "opscenter-free" do
  action :install
end

service "cassandra" do
  supports :restart => true, :status => true
  action [:enable, :start]
end

# The package starts the cassandra service before the cookbook sets the config
# file in place. A different cluster name will prevent cassandra from restarting.
# Since this is the first run, wipe the data.
path_to_prevent_file = File.join(node.cassandra.conf_dir, "prevent_data_deletion")
execute "clear-data-after-package-install" do
  command "rm -rf /var/lib/cassandra/*"
  notifies :create, "file[#{path_to_prevent_file}]", :immediately
  not_if {File.exists?(path_to_prevent_file)}
end

file "#{path_to_prevent_file}" do
  action :touch
end

template File.join(node.cassandra.conf_dir, "cassandra.yaml") do
  source "cassandra.yaml.erb"
  owner node.cassandra.user
  group node.cassandra.user
  mode  0644
  notifies :restart, "service[cassandra]"
end
