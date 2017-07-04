# encoding: utf-8

# Inspec test for recipe simplesamlphp::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe directory('/var/simplesamlphp') do
  it { should exist }
end

describe directory('/var/simplesamlphp/cert') do
  it { should exist }
end

describe file('/var/simplesamlphp/cert/saml.pem') do
  it { should exist }
end

describe file('/var/simplesamlphp/cert/saml.crt') do
  it { should exist }
end

describe file('/var/simplesamlphp/config/authsources.php') do
  it { should exist }
end

describe file('/var/simplesamlphp/config/config.php') do
  it { should exist }
end

describe file('/var/simplesamlphp/metadata/saml20-idp-remote.php') do
  it { should exist }
end
