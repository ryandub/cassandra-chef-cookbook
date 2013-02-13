# Cluster and network configuration
default[:cassandra][:cluster_name] = "Test Cluster"
default[:cassandra][:seeds] = "127.0.0.1"
default[:cassandra][:listen_address] = "localhost"
default[:cassandra][:rpc_address] = "localhost"

# Misc attributes that apply to tarball and package installation
default[:cassandra][:user] = "cassandra"
default[:cassandra][:jvm][:xms] = 32
default[:cassandra][:jvm][:xmx] = 512
default[:cassandra][:limits][:memlock] = "unlimited"
default[:cassandra][:limits][:nofile] = 48000
default[:cassandra][:conf_dir] = "/etc/cassandra"

# Opscenterd attributes
default[:cassandra][:opscenterd][:listen] = '127.0.0.1'

# Attributes that only apply to the tarball recipe
default[:cassandra][:tarball][:version] = "1.2.1"
default[:cassandra][:tarball][:url] = "http://www.eu.apache.org/dist/cassandra/#{node[:cassandra][:tarball][:url]}/apache-cassandra-#{node[:cassandra][:tarball][:version]}-bin.tar.gz"
default[:cassandra][:tarball][:md5] = "bca870d48906172eb69ad60913934aee"
default[:cassandra][:tarball][:installation_dir] = "/usr/local/cassandra"
default[:cassandra][:tarball][:bin_dir] = "/usr/local/cassandra/bin"
default[:cassandra][:tarball][:lib_dir] = "/usr/local/cassandra/lib"
default[:cassandra][:tarball][:data_root_dir] = "/var/lib/cassandra/"
default[:cassandra][:tarball][:log_dir] = "/var/log/cassandra/"
