#
# Cookbook:: simplesamlphp
# Spec:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'simplesamlphp::default' do
  context 'When all attributes are default, on an Ubuntu 14.04' do
    let(:chef_run) do
      # for a complete list of available platforms and versions see:
      # https://github.com/customink/fauxhai/blob/master/PLATFORMS.md
      runner = ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '14.04') do |node, server|
        server.create_data_bag('simplesamlphp', {
          'sp' => {
            'id' => 'sp', 
            'cert' => 'byQ%SDN5fA5VnaNPr5g&aAt&FPcGS*GxzqMbZkpa7B#n4$eM6KFFDgrmQ6Tq',
            'idp-metadata' => '*nk2A3Pbuqxabgp%Kd!*YbRJaPWEMf*#MHK%wmeF*5S2gVXgRW^yZ@GHVqgW'
          },
          'sp-secrets' => {
            'key' => 'qbqj2f3ZX%g2M3DEA4N!G2qfZEy!b#zeQu!*a#F%JU*h2PsKhRpkHKvAs4&s',
            'adminpw' => 'gG7vsBmcWcgnSpWrHJES2CBxXhfW55bdBWE$tWMEcu*!$tUx9jWFWUvE8zTs'
          }
        })

        server.update_node(node)
      end
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
		
    it 'includes the simplesamlphp::service-provider recipe' do
      expect(chef_run).to include_recipe('simplesamlphp::service-provider')
    end
 		
    it 'includes the memcached recipe' do
      expect(chef_run).to include_recipe('memcached')
    end   
  end

  context 'When all attributes are default, but memcached search roles are provided on an Ubuntu 14.04' do
    let(:chef_run) do
      # for a complete list of available platforms and versions see:
      # https://github.com/customink/fauxhai/blob/master/PLATFORMS.md
      runner = ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '14.04') do |node, server|
      node.normal['simplesamlphp']['memcached']['search']['role'] = 'cache'
        server.create_data_bag('simplesamlphp', {
          'sp' => {
            'id' => 'sp',
              'cert' => 'byQ%SDN5fA5VnaNPr5g&aAt&FPcGS*GxzqMbZkpa7B#n4$eM6KFFDgrmQ6Tq',
              'idp-metadata' => '*nk2A3Pbuqxabgp%Kd!*YbRJaPWEMf*#MHK%wmeF*5S2gVXgRW^yZ@GHVqgW'
          },
          'sp-secrets' => {
            'key' => 'qbqj2f3ZX%g2M3DEA4N!G2qfZEy!b#zeQu!*a#F%JU*h2PsKhRpkHKvAs4&s',
            'adminpw' => 'gG7vsBmcWcgnSpWrHJES2CBxXhfW55bdBWE$tWMEcu*!$tUx9jWFWUvE8zTs'
          }
        })
        server.update_node(node)
      end
      Chef::Recipe.any_instance.stub(:search).with(:node, "chef_environment:_default AND role:cache").and_return([{name: "memcache", ipaddress: "10.0.0.1"}])
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'includes the simplesamlphp::service-provider recipe' do
      expect(chef_run).to include_recipe('simplesamlphp::service-provider')
    end

    it 'includes the memcached recipe' do
      expect(chef_run).to_not include_recipe('memcached')
    end
  end
end
