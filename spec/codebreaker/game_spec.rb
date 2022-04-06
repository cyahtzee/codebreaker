# frozen_string_literal: true

require 'shared_examples'

RSpec.describe Codebreaker::Game do
  before { registered_game.instance_variable_set(:@secret, '1234') }

  let(:long_word) { 'a' * Codebreaker::Game::SECRET_LENGTH.next }
  let(:registered_game) { described_class.new.register_game('Game', 'easy') }
  let(:guess) { '1234' }

  describe '#make_guess' do
    it_behaves_like 'cypher', { secret: '1234', guess: '1234', cypher: '++++' }

    it 'adds attempts to the game' do
      expect { registered_game.make_guess(guess) }.to change { registered_game.stats.attempts.size }.by(1)
    end

    it "returns a ValidationError when string is less than #{Codebreaker::Game::SECRET_LENGTH} chars" do
      expect { registered_game.make_guess('12') }.to raise_error(Codebreaker::ValidationError)
    end

    it "returns a ValidationError when string is more than #{Codebreaker::Game::SECRET_LENGTH} chars" do
      expect { registered_game.make_guess(long_word) }.to raise_error(Codebreaker::ValidationError)
    end

    context 'when no attempts left' do
      it 'raise a ActionNotAvailable when no attempt left' do
        registered_game.attempts.times { registered_game.make_guess(guess) }
        expect { registered_game.make_guess(guess) }.to raise_error(Codebreaker::ActionNotAvailable)
      end
    end
  end

  context 'when game is not registered' do
    let(:invalid_game) { described_class.new }

    it_behaves_like 'not registered game', 'make_guess' do
      let(:expected) { invalid_game.make_guess(guess) }
    end

    it_behaves_like 'not registered game', "make_guess(' ')" do
      let(:expected) { invalid_game.make_guess('') }
    end

    it_behaves_like 'not registered game', 'any_hints_left?' do
      let(:expected) { invalid_game.any_hints_left? }
    end

    it_behaves_like 'not registered game', 'check_win?' do
      let(:expected) { invalid_game.check_win?(guess) }
    end

    it_behaves_like 'not registered game', 'give_hint' do
      let(:expected) { invalid_game.give_hint }
    end
  end

  describe '#give_hint' do
    let(:current_hint) { registered_game.give_hint }

    context 'when there are hints left' do
      it "returns a hint within #{Codebreaker::Game::SECRET_DIGITS}" do
        expect(Codebreaker::Game::SECRET_DIGITS.to_a).to include(current_hint.to_i)
      end

      it 'increase the number of hints in stats' do
        expect { registered_game.give_hint }.to change { registered_game.stats.hints.size }.by(1)
      end

      it 'returns a digit from secret and adds to the hints array' do
        expect(registered_game.stats.hints).to include(current_hint)
      end
    end

    context 'when there are no hints left' do
      before { 2.times { registered_game.give_hint } }

      it 'raises a ActionNotAvailable error' do
        expect { registered_game.give_hint }.to raise_error(Codebreaker::ActionNotAvailable)
      end
    end
  end

  describe '#check_win?' do
    it 'returns true when secret is equal to guess' do
      expect(registered_game.check_win?(guess)).to be true
    end
  end
end
