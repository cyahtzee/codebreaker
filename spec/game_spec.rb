# frozen_string_literal: true

module Codebreaker
  RSpec.describe Game do
    subject(:new_game) { described_class.new.register_game('John', 'easy') }

    describe 'Game properties' do
      it 'has a secret' do
        expect(new_game.generate_secret).not_to be_nil
      end

      it 'has a secret with 4 digits' do
        expect(new_game.generate_secret.length).to eq 4
      end

      it 'has a secret with numbers from 1 to 6' do
        expect(new_game.generate_secret).to match(/[1-6]{4}/)
      end

      it 'has a instance variable @secret' do
        expect(new_game.instance_variable_get(:@secret)).not_to be_nil
      end

      it 'has instance variable @secret that is not visible to outside' do
        expect { new_game.secret }.to raise_error(NoMethodError)
      end
    end

    describe '#register_game' do
      it 'returns a new instance of Game' do
        expect(new_game).to be_instance_of(described_class)
      end

      it 'returns a new instance of Game with name' do
        expect(new_game.name).to eq 'John'
      end

      it 'returns a new instance of Game with difficulty' do
        expect(new_game.difficulty).to eq 'easy'
      end

      it 'returns a new instance of Game with attempts' do
        expect(new_game.attempts).to eq Game::DIFFICULTY[:easy][:attempts]
      end

      it 'returns a new instance of Game with hints' do
        expect(new_game.hints).to eq Game::DIFFICULTY[:easy][:hints]
      end
    end

    describe '#make_guess' do
      it 'returns an encrypted string according to the secret' do
        secret = new_game.instance_variable_get(:@secret)
        result = new_game.encrypt_secret(secret, '1234')
        expect(new_game.make_guess('1234')).to eq result
      end
    end

    describe '#give_hint' do
      let(:with_hints) do
        2.times { new_game.give_hint }
        new_game
      end

      it 'returns a hint that is a single digit from the secret' do
        expect(new_game.give_hint).to match(/[1-6]{1}/)
      end

      it 'return a hint unless there are no more hints left' do
        expect(with_hints.give_hint).to eq('No hints left')
      end
    end
  end
end
