# frozen_string_literal: true

require 'spec_helper'

describe 'phpversion', type: :fact do
  before { Facter.clear }

  after { Facter.clear }

  it 'is 8.2.7 according to output' do
    allow(Facter::Core::Execution).to receive(:which).with('php').and_return('/usr/bin/php')
    allow(Facter::Core::Execution).to receive(:execute).with('php -v').and_return(
      "PHP 8.2.7 (cli) (built: Jun  8 2023 20:03:25) (NTS)\n" \
      "Copyright (c) The PHP Group\n" \
      "Zend Engine v4.2.7, Copyright (c) Zend Technologies\n",
    )
    expect(Facter.fact(:phpversion).value).to eq('8.2.7')
  end

  it 'is not defined if php is not installed' do
    allow(Facter::Core::Execution).to receive(:which).with('php').and_return(nil)
    allow(Facter::Core::Execution).to receive(:execute)
    expect(Facter.fact(:phpversion).value).to be_nil
    expect(Facter::Core::Execution).not_to have_received(:execute)
  end

  it 'is not defined if php produces no output' do
    allow(Facter).to receive(:log_exception).and_call_original
    allow(Facter::Core::Execution).to receive(:which).with('php').and_return('/usr/bin/php')
    allow(Facter::Core::Execution).to receive(:execute).with('php -v').and_return('')
    expect(Facter.fact(:phpversion).value).to be_nil
    expect(Facter).not_to have_received(:log_exception)
  end

  it 'logs if php is installed but cannot be run' do
    allow(Facter).to receive(:log_exception).and_call_original
    allow(Facter::Core::Execution).to receive(:which).with('php').and_return('/usr/bin/php')
    allow(Facter::Core::Execution).to receive(:execute).with('php -v').and_raise(
      Facter::Core::Execution::ExecutionFailure, "Could not execute 'php -v': Permission denied"
    )
    expect(Facter.fact(:phpversion).value).to be_nil
    expect(Facter).to have_received(:log_exception)
  end
end
