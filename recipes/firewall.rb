include_recipe 'firewall'

### Get the interface for the IP address Cassandra is set to listen on ###
interface = node[:network][:interfaces].select {|i| 
  i if node['network']['interfaces'][i[0]]['addresses'].has_key?("#{node['cassandra']['listen_address']}")}
node.set_unless[:cassandra][:listen_interface] = 
  (node[:cassandra][:listen_address] == "localhost" ? "lo" : interface.flatten[0])

firewall_rule "cassandra-communication" do
  port 7000 
  protocol :tcp
  interface node['cassandra']['listen_interface'] 
  action :allow
end

firewall_rule "cassandra-jmx-monitoring" do
  port 7199 
  protocol :tcp
  interface node['cassandra']['listen_interface'] 
  action :allow
end
