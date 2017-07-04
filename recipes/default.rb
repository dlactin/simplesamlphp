#
# Cookbook:: simplesamlphp
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

raise "#{node['platform']} is not a supported platform in the simplesamlphp::default recipe" unless platform_family?('debian')

include_recipe 'memcached' if node['simplesamlphp']['memcached']['enabled'] && node['simplesamlphp']['memcached']['search']['role'] == 'none'
include_recipe 'simplesamlphp::service-provider' if node['simplesamlphp']['sp']['enabled']
