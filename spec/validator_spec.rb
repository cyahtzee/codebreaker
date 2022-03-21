# frozen_string_literal: true

module Codebreaker
  RSpec.describe Validator do
    let(:validator) { Game.new }

    it 'valid_name? returns true if name is ex: John' do
      expect(validator.valid_name?('John')).to be true
    end

    it 'valid_name? returns false if name is empty' do
      expect(validator.valid_name?('')).to be false
    end

    it 'valid_name? returns false if name is less than 3 chars' do
      expect(validator.valid_name?('sd')).to be false
    end

    it 'valid_name? returns false if name is longer than 20 chars' do
      expect(validator.valid_name?('NameIsLongerThan20Charackters')).to be false
    end

    it 'valid_guess? returns true if guess has 4 digits' do
      expect(validator.valid_guess?('1234')).to be true
    end

    it 'valid_guess? returns false if guess is too short' do
      expect(validator.valid_guess?('98')).to be false
    end
  end
end
