# frozen_string_literal: true

require 'shared_examples'
require 'validator_examples'

RSpec.describe Codebreaker::GameHelper do
  include_examples 'codebreaker'

  describe '#register_game' do
    context 'when game is registered' do
      it "has a secret that has #{Codebreaker::Game::SECRET_LENGTH} digits" do
        stub_const('SECRET_LENGTH', Codebreaker::Game::SECRET_LENGTH)
        expect(registered_game.instance_variable_get(:@secret)).to match(/[1-6]{#{SECRET_LENGTH}}$/)
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
      it_behaves_like 'cypher', { secret: '1234', guess: '1234', cypher: '++++' }
      it_behaves_like 'cypher', { secret: '', guess: '1234', cypher: '' }
      it_behaves_like 'cypher', { secret: '6543', guess: '5643', cypher: '++--' }
      it_behaves_like 'cypher', { secret: '6543', guess: '6411', cypher: '+-' }
      it_behaves_like 'cypher', { secret: '6543', guess: '6544', cypher: '+++' }
      it_behaves_like 'cypher', { secret: '6543', guess: '3456', cypher: '----' }
      it_behaves_like 'cypher', { secret: '6543', guess: '6666', cypher: '+' }
      it_behaves_like 'cypher', { secret: '6543', guess: '2666', cypher: '-' }
      it_behaves_like 'cypher', { secret: '6543', guess: '2222', cypher: '' }
    end
  end
end
