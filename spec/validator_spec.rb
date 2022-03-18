# frozen_string_literal: true

module Codebreaker
  RSpec.describe Validator do
    before do
      @validator = Game.new
    end

    it 'valid_name? returns true if name is valid' do
      expect(@validator.valid_name?('John')).to be true
    end

    it 'valid_name? returns false if name is invalid' do
      expect(@validator.valid_name?('')).to be false
    end

    it 'valid_name? returns false if name is invalid' do
      expect(@validator.valid_name?('sd')).to be false
    end

    it 'valid_name? returns false if name is invalid' do
      expect(@validator.valid_name?('NameIsLongerThan20Charackters')).to be false
    end

    it 'valid_guess? returns true if guess is valid' do
      expect(@validator.valid_guess?('1234')).to be true
    end

    it 'valid_guess? returns false if guess is invalid' do
      expect(@validator.valid_guess?('98')).to be false
    end
  end
end
