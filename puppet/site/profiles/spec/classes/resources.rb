require 'spec_helper'

describe 'profiles::resources' do
  let( :params ) {
    {
      :users => {
        'test' => {
          'ensure' => 'present',
        },
      },
    }
  }

  context 'with ::kernel => Linux' do
    let( :facts )  { { :kernel => 'Linux' } }

    it { should compile.with_all_deps }

    it do
      should contain_user( 'test' ).with(
        'ensure' => 'present'
      )
    end
  end

  context 'with ::kernel => Windows' do
    let( :facts )  { { :kernel => 'Windows' } }

    it { should compile.with_all_deps }

    it do
      should contain_user( 'test' ).with(
        'ensure' => 'present'
      )
    end
  end
end
