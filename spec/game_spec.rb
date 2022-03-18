# frozen_string_literal: true

module Codebreaker
  RSpec.describe Game do
    let(:game) { Game.new }
    let(:register_game) { Game.new.register_game('John', 'easy') }

    describe 'Game properties' do
      it 'has a secret' do
        expect(game.generate_secret).not_to be nil
      end
      it 'has a secret with 4 digits' do
        expect(game.generate_secret.length).to eq 4
      end
      it 'has a secret with numbers from 1 to 6' do
        expect(game.generate_secret).to match(/[1-6]{4}/)
      end
      it 'has a instance variable @secret' do
        expect(game.instance_variable_get(:@secret)).not_to be nil
      end
      it 'has instance variable @secret that is not visible to outside' do
        expect { game.secret }.to raise_error(NoMethodError)
      end
    end

    describe '#register_game' do
      it 'returns a new instance of Game' do
        expect(register_game).to be_instance_of(Game)
      end
      it 'returns a new instance of Game with name' do
        expect(register_game.name).to eq 'John'
      end
      it 'returns a new instance of Game with difficulty' do
        expect(register_game.difficulty).to eq 'easy'
      end
      it 'returns a new instance of Game with attempts' do
        expect(register_game.attempts).to eq Game::DIFFICULTY[:easy][:attempts]
      end
      it 'returns a new instance of Game with hints' do
        expect(register_game.hints).to eq Game::DIFFICULTY[:easy][:hints]
      end
    end

    describe '#make_guess' do
      it 'returns an encrypted string according to the secret' do
        secret = register_game.instance_variable_get(:@secret)
        result = game.encrypt_secret(secret, '1234')
        expect(register_game.make_guess('1234')).to eq result
      end
    end
  end
end
