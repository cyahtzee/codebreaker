# frozen_string_literal: true

require 'validator_examples'

RSpec.describe Codebreaker::GameHelper do
  describe '#register_game' do
    context 'when game is registered' do
      it_behaves_like 'registered game', { name: 'Game',
                                           difficulty: 'easy',
                                           name_length: Codebreaker::Game::NAME_LENGTH_RANGE.last,
                                           secret_digits: Codebreaker::Game::SECRET_DIGITS,
                                           secret_length: Codebreaker::Game::SECRET_LENGTH,
                                           hints: Codebreaker::Game::DIFFICULTY[:easy][:hints],
                                           attempts: Codebreaker::Game::DIFFICULTY[:easy][:attempts] }
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
