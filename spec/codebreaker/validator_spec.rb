# frozen_string_literal: true

RSpec.describe Codebreaker::Validator do
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
  end

  describe '#valid_guess?' do
    it "returns true if guess is between #{Codebreaker::Game::SECRET_PARAMS[:digits]}" do
      expect(validator.valid_guess?(combination)).to be true
    end

    it "returns true if guess has #{Codebreaker::Game::SECRET_PARAMS[:length]} digits" do
      expected_length = Codebreaker::Game::SECRET_PARAMS[:length].last
      expect(combination.length).to eq expected_length
    end

    it 'returns false if guess is empty' do
      expect(validator.valid_guess?('')).to be false
    end

    it 'returns false if guess is not a number' do
      expect(validator.valid_guess?('a')).to be false
    end

    it 'returns false if guess is a special character' do
      expect(validator.valid_guess?('#')).to be false
    end

    it 'returns false if guess is a math symbol' do
      expect(validator.valid_guess?('+')).to be false
    end
  end
end
