# frozen_string_literal: true

RSpec.describe Codebreaker::Validator do
  let(:validator) { Codebreaker::Game.new }
  let(:name) do
    stub_const('NAME_LENGTH_RANGE', Codebreaker::Game::NAME_LENGTH_RANGE)
    FFaker::Name.unique.name[0...NAME_LENGTH_RANGE.last]
  end
  let(:combination) do
    stub_const('SECRET_DIGITS', Codebreaker::Game::SECRET_DIGITS)
    stub_const('SECRET_LENGTH', Codebreaker::Game::SECRET_LENGTH)
    SECRET_LENGTH.times.map { FFaker::Random.rand(SECRET_DIGITS) }.join
  end

  describe '#valid_name?' do
    it "returns true if name is in range #{Codebreaker::Game::NAME_LENGTH_RANGE}" do
      expect(validator.valid_name?(name)).to be true
    end

    it 'returns false if name is empty' do
      expect(validator.valid_name?('')).to be false
    end

    it "returns false if name is longer than #{Codebreaker::Game::NAME_LENGTH_RANGE.last}" do
      expect(validator.valid_name?('a' * name.length.next)).to be false
    end
  end

  describe '#valid_guess?' do
    it "returns true if guess is exactly #{Codebreaker::Game::SECRET_LENGTH}" do
      expect(validator.valid_guess?(combination)).to be true
    end

    it 'returns false if guess is empty' do
      expect(validator.valid_guess?('')).to be false
    end

    it 'returns false if guess is not a number' do
      expect(validator.valid_guess?('a')).to be false
    end

    it 'returns false if guess has a special character' do
      expect(validator.valid_guess?('#')).to be false
    end

    it 'returns false if guess has a math symbol' do
      expect(validator.valid_guess?('+')).to be false
    end

    it 'returns false if guess has a white space charachter' do
      expect(validator.valid_guess?('\t')).to be false
    end
  end
end
