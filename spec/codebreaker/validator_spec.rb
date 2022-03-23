# frozen_string_literal: true

RSpec.describe Codebreaker::Validator do
  let(:secret_length) { Codebreaker::Game::SECRET_PARAMS[:length] }
  let(:name_length) { Codebreaker::Game::NAME_PARAMS[:length] }
  let(:validator) { Codebreaker::Game.new }
  let(:name) do
    length = Codebreaker::Game::NAME_PARAMS[:length]
    FFaker::Name.unique.name[0...length.last]
  end
  let(:combination) do
    digits = Codebreaker::Game::SECRET_PARAMS[:digits]
    length = Codebreaker::Game::SECRET_PARAMS[:length]
    length.last.times.map { FFaker::Random.rand(digits) }.join
  end

  describe '#valid_name?' do
    it "returns true if name is in range #{Codebreaker::Game::NAME_PARAMS[:length]}" do
      expect(validator.valid_name?(name)).to be true
    end

    it 'returns false if name is empty' do
      expect(validator.valid_name?('')).to be false
    end

    it "returns false if name is longer than #{Codebreaker::Game::NAME_PARAMS[:length].last}" do
      expect(validator.valid_name?(name * secret_length.last)).to be false
    end
  end

  describe '#valid_guess?' do
    it "returns true if guess is between #{Codebreaker::Game::SECRET_PARAMS[:digits]}" do
      expect(validator.valid_guess?(combination)).to be true
    end

    it "returns true if guess has #{Codebreaker::Game::SECRET_PARAMS[:length]} digits" do
      expect(combination.length).to be_between(secret_length.first, secret_length.last)
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
