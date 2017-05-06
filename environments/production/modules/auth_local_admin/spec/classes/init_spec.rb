require 'spec_helper'
describe 'auth_local_admin' do

  context 'with defaults for all parameters' do
    it { should contain_class('auth_local_admin') }
  end
end
