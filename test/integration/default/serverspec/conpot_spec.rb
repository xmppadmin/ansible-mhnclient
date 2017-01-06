require 'serverspec'

# Required by serverspec
set :backend, :exec

describe file('/var/log/supervisor/conpot.log') do
  its(:content) { should match /Starting Conpot using template/ }
  its(:content) { should_not match /Error/ }
end

describe command('mongo hpfeeds -eval "db.auth_key.find({identifier: \'mnemosyne\'}).pretty();"') do
  its(:stdout) { should match /conpot.events/ }
  its(:exit_status) { should eq 0 }
end
describe command('mongo hpfeeds -eval "db.auth_key.find({identifier: \'geoloc\'}).pretty();"') do
  its(:stdout) { should match /conpot.events/ }
  its(:exit_status) { should eq 0 }
end