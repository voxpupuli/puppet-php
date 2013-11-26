require 'spec_helper'

describe 'php', :type => :class do
  it { should contain_class 'php' }
  it { should include_class 'php::params' }
end
