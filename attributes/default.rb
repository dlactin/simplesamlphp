default['simplesamlphp']['memcached']['enabled'] = true
default['simplesamlphp']['memcached']['search']['role'] = 'none'

default['simplesamlphp']['installation']['path'] = '/var/simplesamlphp'
default['simplesamlphp']['templates'] = 'simplesamlphp' # Cookbook that contains templates

default['simplesamlphp']['version'] = '1.14.14'
default['simplesamlphp']['source']['url'] = "https://github.com/simplesamlphp/simplesamlphp/releases/download/v#{node['simplesamlphp']['version']}/simplesamlphp-#{node['simplesamlphp']['version']}.tar.gz"
default['simplesamlphp']['source']['checksum'] = '2ff76d8b379141cdd3340dbd8e8bab1605e7a862d4a31657cc37265817463f48'

default['simplesamlphp']['saml20']['enabled'] = true

# Identity provider attributes
default['simplesamlphp']['idp']['metadata']['url'] = 'https://idp.example.com'

# Service provider attributes
default['simplesamlphp']['sp']['enabled'] = true
default['simplesamlphp']['sp']['entityid'] = 'localhost/sp'
default['simplesamlphp']['sp']['contact'] = 'noreply@localhost.ca'
default['simplesamlphp']['sp']['salt'] = '2ff76d8b379141cdd3340dbd8e8bab1605e7a862d4a31657cc37265817463f48'

default['simplesamlphp']['sp']['privatekey']['data_bag'] = 'simplesamlphp'
default['simplesamlphp']['sp']['privatekey']['path'] = "#{node['simplesamlphp']['installation']['path']}/cert/saml.pem"

default['simplesamlphp']['sp']['certificate']['data_bag'] = 'simplesamlphp'
default['simplesamlphp']['sp']['certificate']['path'] = "#{node['simplesamlphp']['installation']['path']}/cert/saml.crt"

default['simplesamlphp']['sp']['attribute']['map']['custom'] = false

default['simplesamlphp']['sp']['idp-metadata']['path'] = "#{node['simplesamlphp']['installation']['path']}/metadata/saml20-idp-remote.php"

# Cookie config
default['simplesamlphp']['cookie']['name']['auth'] = 'SimpleSAMLAuthToken'
default['simplesamlphp']['cookie']['name']['session'] = 'SimpleSAMLSessionID'
default['simplesamlphp']['cookie']['name']['php']['session'] = 'SimpleSAMLPHPSessionID'
default['simplesamlphp']['cookie']['lifetime']['session'] = 0
