# libssl package is generally v1.0. opscenterd needs the older version
package "libssl0.9.8" do
  action :install
end

package "opscenter-free" do
  action :install
end

service "opscenterd" do
  supports :restart => true, :status => true
  action [:enable, :start]
end

template "/etc/opscenter/opscenterd.conf" do
  source "opscenterd.conf.erb"
  owner node.cassandra.user
  group node.cassandra.user
  mode  0644
  notifies :restart, "service[opscenterd]"
end
