#
# Cookbook:: simplesamlphp
# Recipe:: service-provider
#
# Copyright:: 2017, The Authors, All Rights Reserved.

::Chef::Resource.send(:include, Simplesamlphp::Helper)

install_path = node['simplesamlphp']['installation']['path']
version = node['simplesamlphp']['version']
src_filepath = "#{Chef::Config[:file_cache_path]}/simplesamlphp-#{version}.tar.gz"

remote_file 'simplesamlphp-source' do
  source node['simplesamlphp']['source']['url']
  checksum node['simplesamlphp']['source']['checksum']
  path src_filepath
  retries 4
  not_if { simplesamlphp_updated?(install_path, version) }
end

directory install_path do
  owner 'root'
  group 'www-data'
  mode  '0755'
end

bash 'extract simplesamlphp' do
  user 'root'
  group 'www-data'
  cwd Chef::Config[:file_cache_path]
  code <<-EOH
    tar xzf simplesamlphp-#{version}.tar.gz -C #{install_path} --strip-components=1
  EOH
  not_if { simplesamlphp_updated?(install_path, version) }
end

directory "#{install_path}/cert" do
  owner 'root'
  group 'www-data'
  mode '0750'
end

sp_data_bag = data_bag_item('simplesamlphp', 'sp')
sp_secrets_data_bag = data_bag_item('simplesamlphp', 'sp-secrets')

# Populate array of memcache servers
if node['simplesamlphp']['memcached']['search']['role'] == 'none'
  @memcache_servers = ['localhost']
elsif Chef::Config[:solo]
  Chef::Log.warn('This recipe uses search. Chef Solo does not support search.')
else
  memcache_search = search(:node, "chef_environment:#{node.chef_environment} AND role:#{node['simplesamlphp']['memcached']['search']['role']}")
  memcache_search.each do |cache|
    next if cache['ipaddress'].nil?
    @memcache_servers << cache['ipaddress']
  end
end

file node['simplesamlphp']['sp']['privatekey']['path'] do
  content sp_secrets_data_bag['key']
  owner 'root'
  group 'www-data'
  mode  '0440'
end

file node['simplesamlphp']['sp']['certificate']['path'] do
  content sp_data_bag['cert']
  owner 'root'
  group 'www-data'
  mode  '0440'
end

template "#{install_path}/config/authsources.php" do
  source 'authsources.php.erb'
  cookbook node['simplesamlphp']['templates']
  owner 'root'
  group 'www-data'
  mode  '0644'
end

template "#{install_path}/config/config.php" do
  source 'config.php.erb'
  cookbook node['simplesamlphp']['templates']
  owner  'root'
  group  'www-data'
  mode   '0640'
  variables(adminpw: sp_secrets_data_bag['adminpw'])
end

template "#{install_path}/attributemap/custom.php" do
  source 'custom.php.erb'
  cookbook node['simplesamlphp']['templates']
  owner 'root'
  group 'www-data'
  mode  '0644'
  action :create
  only_if { node['simplesamlphp']['sp']['attribute']['map']['custom'] }
end

file node['simplesamlphp']['sp']['idp-metadata']['path'] do
  content sp_data_bag['idp-metadata']
  owner 'root'
  group 'www-data'
  mode  '0640'
end
