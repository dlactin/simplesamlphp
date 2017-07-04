#
# Cookbook Name:: simplesamlphp
# Spec:: default
#
# Copyright (c) 2017 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'simplesamlphp::service-provider' do
  shared_examples 'default simplesamlphp tests' do
    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'downloads the simplesamlphp-source file' do
      expect(chef_run).to create_remote_file("#{Chef::Config[:file_cache_path]}/simplesamlphp-1.14.14.tar.gz")
 		end
		
    it 'creates the default install path' do
      expect(chef_run).to create_directory("/var/simplesamlphp")
    end

    it 'extracts the simplesamlphp tar' do
      expect(chef_run).to run_bash('extract simplesamlphp')
    end
  
    it 'creates the default cert directory in the install path' do
      expect(chef_run).to create_directory("/var/simplesamlphp/cert")
    end

    it 'creates the private key in the default path from a supplied data bag' do
      expect(chef_run).to create_file("/var/simplesamlphp/cert/saml.pem")
    end

    it 'creates the certificate in the default path from a supplied data bag' do
      expect(chef_run).to create_file("/var/simplesamlphp/cert/saml.crt")
    end
		
    it 'creates the authsources.php file in the default install path' do
      expect(chef_run).to create_template("/var/simplesamlphp/config/authsources.php")
    end

    it 'creates the config.php file in the default install path' do
      expect(chef_run).to create_template("/var/simplesamlphp/config/config.php")
    end
		
    it 'creates saml20 idp metadata file in the default install path' do 
      expect(chef_run).to create_file("/var/simplesamlphp/metadata/saml20-idp-remote.php")
    end
  end

  context 'When all attributes are default, on a fresh debian family platform' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new(platform_family: 'debian') do |node, server|
      server.create_data_bag('simplesamlphp', {
          'sp' => {
            'id' => 'sp',
            'cert' => 'byQ%SDN5fA5VnaNPr5g&aAt&FPcGS*GxzqMbZkpa7B#n4$eM6KFFDgrmQ6Tq',
            'idp-metadata' => '*nk2A3Pbuqxabgp%Kd!*YbRJaPWEMf*#MHK%wmeF*5S2gVXgRW^yZ@GHVqgW',
           },
          'sp-secrets' => {
            'key' => 'qbqj2f3ZX%g2M3DEA4N!G2qfZEy!b#zeQu!*a#F%JU*h2PsKhRpkHKvAs4&s',
            'adminpw' => 'gG7vsBmcWcgnSpWrHJES2CBxXhfW55bdBWE$tWMEcu*!$tUx9jWFWUvE8zTs',
          },
      })
        server.update_node(node)
      end
      runner.converge(described_recipe)
    end

  it_behaves_like 'default simplesamlphp tests'
	end
end
