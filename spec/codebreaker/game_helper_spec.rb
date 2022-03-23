# frozen_string_literal: true

module Codebreaker
  RSpec.describe Codebreaker::GameHelper do
    let(:new_game) { Codebreaker::Game.new }
    let(:registered_game) { new_game.register_game('Game', 'easy') }

    describe '#register_game' do
      context 'when game is registered' do
        it 'returns a the same instance with additional params' do
          expect(registered_game).to eq(new_game)
        end

        it "has a secret that has #{Codebreaker::Game::SECRET_PARAMS[:length].last} digits" do
          length = Codebreaker::Game::SECRET_PARAMS[:length].last
          expect(registered_game.instance_variable_get(:@secret).length).to eq(length)
        end

        it 'has a name' do
          expect(registered_game.name).to eq('Game')
        end

        it 'has a difficulty' do
          expect(registered_game.difficulty).to eq('easy')
        end

        it 'has a number of attempts' do
          expect(registered_game.attempts).to eq(Game::DIFFICULTY[:easy][:attempts])
        end

        it 'has a number of hints' do
          expect(registered_game.hints).to eq(Game::DIFFICULTY[:easy][:hints])
        end
      end
    end

    describe '#encrypt_secret' do
      context 'when called with valid string' do
        it 'returns empty string if secret is empty' do
          expect(new_game.encrypt_secret('', '1234')).to eq ''
        end

        it 'returns ++-- when secret code: 6543 and guess: 5643' do
          expect(new_game.encrypt_secret('6543', '5643')).to eq '++--'
        end

        it 'returns +- when secret code: 6543 and guess: 6411' do
          expect(new_game.encrypt_secret('6543', '6411')).to eq '+-'
        end

        it 'returns +++ when secret code: 6543 and guess: 6544' do
          expect(new_game.encrypt_secret('6543', '6544')).to eq '+++'
        end

        it 'returns ---- when secret code: 6543 and guess: 3456' do
          expect(new_game.encrypt_secret('6543', '3456')).to eq '----'
        end

        it 'returns + when secret code: 6543 and guess: 6666' do
          expect(new_game.encrypt_secret('6543', '6666')).to eq '+'
        end

        it 'returns - when secret code: 6543 and guess: 2666' do
          expect(new_game.encrypt_secret('6543', '2666')).to eq '-'
        end

        it 'returns \'\' when secret code: 6543 and guess: 2222' do
          expect(new_game.encrypt_secret('6543', '2222')).to eq ''
        end
      end
    end
  end
end
