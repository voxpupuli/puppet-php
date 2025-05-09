# frozen_string_literal: true

require 'spec_helper'

describe 'php::ensure_prefix' do
  let(:prefix) { 'p.' }

  context 'when first parameter is a hash' do
    let(:input) { { 'a' => 1, 'b' => 2, 'p.c' => 3 } }
    let(:expected) do
      {
        'p.a' => 1,
        'p.b' => 2,
        'p.c' => 3,
      }
    end

    it { is_expected.to run.with_params(input, prefix).and_return(expected) }

    context 'when prefix is `undef`' do
      let(:prefix) { nil }

      it { is_expected.to run.with_params(input, prefix).and_return(input) }
    end

    context 'when prefix is empty string' do
      let(:prefix) { '' }

      it { is_expected.to run.with_params(input, prefix).and_return(input) }
    end
  end

  context 'when first parameter is an array' do
    let(:input) { ['a', 'p.b', 'c'] }
    let(:expected) do
      ['p.a', 'p.b', 'p.c']
    end

    it { is_expected.to run.with_params(input, prefix).and_return(expected) }

    context 'when prefix is `undef`' do
      let(:prefix) { nil }

      it { is_expected.to run.with_params(input, prefix).and_return(input) }
    end

    context 'when prefix is empty string' do
      let(:prefix) { '' }

      it { is_expected.to run.with_params(input, prefix).and_return(input) }
    end
  end
end
