# simplesamlphp Cookbook
[![Chef cookbook](https://img.shields.io/cookbook/v/simplesamlphp.svg)](https://github.com/dlactin/simplesamlphp)
[![Travis](https://img.shields.io/travis/dlactin/simplesamlphp.svg)](https://travis-ci.org/dlactin/simplesamlphp)

Installs and configures a SimpleSAMLphp Service Provider. 

## Requirements

### Platforms

  - Debian / Ubuntu and derivatives

### Chef
 
  - Chef 12.5+

### Attributes 
These attributes need to be populated: 
  - `simplesamlphp['idp']['metadata']['url']` - url to your identity providers metadata
  - `simplesamlphp['sp']['entityid']` - entity id of the service provider
  - `simplesamlphp['sp']['contact']` - support contact email

These attributes should be changed: 
  - `simplesamlphp['sp']['salt']` - salt string used by SimpleSAMLphp to generate a secure hash of a value.

### Data Bags
This cookbook will look for the following data bag keys in the `sp` data bag item within the `simplesamlphp` data bag: 
  - `cert` - generated certificate for SimpleSAMLphp environment
  - `idp-metadata` - remote metadata for identity provider
This cookbook will look for the following data bag keys in the `sp-secrets` encrypted data bag item within the `simplesamlphp` data bag:
  - `key` - generated private key for SimpleSAMLphp environment
  - `adminpw` - password for the admin web interface

## Attributes
  - `simplesamlphp['memcached']['enabled']` - defaults to true, php sessions will be used if this is disabled
  - `simplesamlphp['memcached']['search']['role']` - defaults to none, used to populate a list of memcache servers by searching nodes with the populated role
 
  - `simplesamlphp['installation']['path']` - defaults to /var/simplesamlphp, location of simplesamlphp install
  - `simplesamlphp['templates']` - defaults to this cookbook, custom templates from another cookbook can be used
  
  - `simplesamlphp['version']` - defaults to 1.14.14, if changed the checksum will need to be updated
  - `simplesamlphp['source']['url']` - defaults to simplesamlphp github download url
  - `simplesamlphp['source']['checksum']` - defaults to checksum for 1.14.14
   
  - `simplesamlphp['saml20']['enabled']` - defaults to true, the only supported functionality right now
   
  - `simplesamlphp['idp']['metadata']['url']` - needs to be updated with your idp metadata url
   
  - `simplesamlphp['sp']['enabled']` - defaults to true, includes the service provider recipe
  - `simplesamlphp['sp']['entityid']` - needs to be updated with your service provider entityid
  - `simplesamlphp['sp']['contact']` - needs to be updated with your support contact email
  - `simplesamlphp['sp']['salt']` - should be updated with a unique salt string
   
  - `simplesamlphp['sp']['privatekey']['data_bag']` - defaults to `simplesamlphp`
  - `simplesamlphp['sp']['privatekey']['path']` - defaults to cert directory within the simplesamlphp directory
   
  - `simplesamlphp['sp']['certificate']['data_bag']` - defaults to `simplesamlphp`
  - `simplesamlphp['sp']['certificate']['path']` = defaults to cert directory within the simplesamlphp directory
  
  - `simplesamlphp['sp']['attribute']['map']['custom']` - defaults to false, can be enabled to use custom attribute maps
 
  - `simplesamlphp['sp']['idp-metadata']['path']` - defaults to metadata directory within the simplesamlphp directory
  
  - `simplesamlphp['cookie']['name']['auth']` - defaults to `SimpleSAMLAuthToken`
  - `simplesamlphp['cookie']['name']['session']` - defaults to `SimpleSAMLSessionID`
  - `simplesamlphp['cookie']['name']['php']['session']` - defaults to `SimpleSAMLPHPSessionID`
  - `simplesamlphp['cookie']['lifetime']['session']` - defaults to  0 which lets the cookie live until the browser is closed

## Usage
This cookbook can be used to setup a SimpleSAMLphp Service Provider. The session cache will default to a local memcache instance on the server if the `simplesamlphp['memcached']['search']['role']` attribute is 
left as the default value. 

### Generate certificate
This cookbook requires data bags that contain a self signed certificate and key. 
They can be generated the following command: 
`openssl req -newkey rsa:2048 -new -x509 -days 3652 -nodes -out saml.crt -keyout saml.pem`

## License and Authors

Author:: Dustin Lactin (<dustin.lactin@gmail.com>)

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License. 
