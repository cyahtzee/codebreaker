# frozen_string_literal: true

require 'shared_examples'

RSpec.describe Codebreaker::GameHelper do
  include_examples 'codebreaker'

  describe '#register_game' do
    context 'when game is registered' do
      it "has a secret that has #{Codebreaker::Game::SECRET_LENGTH} digits" do
        length = Codebreaker::Game::SECRET_LENGTH
        expect(registered_game.instance_variable_get(:@secret)).to match(/[1-6]{#{length}}$/)
      end

      it 'has a name' do
        expect(registered_game.name).to eq(name)
      end

      it 'has a difficulty' do
        expect(registered_game.difficulty).to eq(difficulty)
      end

      it 'has a valid difficulty' do
        expect(Codebreaker::Game::DIFFICULTY.keys).to include(difficulty.to_sym)
      end

      it 'has a number of attempts' do
        expect(registered_game.attempts).to eq(Codebreaker::Game::DIFFICULTY[:easy][:attempts])
      end

      it 'has a number of hints' do
        expect(registered_game.hints).to eq(Codebreaker::Game::DIFFICULTY[:easy][:hints])
      end
    end
  end

  describe '#encrypt_secret' do
    context 'when called with valid string' do
      it 'returns empty string if secret is empty' do
        expect(registered_game.encrypt_secret('', '1234')).to eq ''
      end

      it 'returns ++-- when secret code: 6543 and guess: 5643' do
        expect(registered_game.encrypt_secret('6543', '5643')).to eq '++--'
      end

      it 'returns +- when secret code: 6543 and guess: 6411' do
        expect(registered_game.encrypt_secret('6543', '6411')).to eq '+-'
      end

      it 'returns +++ when secret code: 6543 and guess: 6544' do
        expect(registered_game.encrypt_secret('6543', '6544')).to eq '+++'
      end

      it 'returns ---- when secret code: 6543 and guess: 3456' do
        expect(registered_game.encrypt_secret('6543', '3456')).to eq '----'
      end

      it 'returns + when secret code: 6543 and guess: 6666' do
        expect(registered_game.encrypt_secret('6543', '6666')).to eq '+'
      end

      it 'returns - when secret code: 6543 and guess: 2666' do
        expect(registered_game.encrypt_secret('6543', '2666')).to eq '-'
      end

      it 'returns \'\' when secret code: 6543 and guess: 2222' do
        expect(registered_game.encrypt_secret('6543', '2222')).to eq ''
      end
    end
  end
end
