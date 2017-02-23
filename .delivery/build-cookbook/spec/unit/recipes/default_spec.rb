#
# Cookbook:: build-cookbook
# Spec:: default
#
# Copyright:: 2015-2017 Chef Software, Inc.

require 'spec_helper'

describe 'build-cookbook::default' do

  context 'When all attributes are default, on an unspecified platform' do

    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      chef_run # This should not raise an error
    end

  end
end
