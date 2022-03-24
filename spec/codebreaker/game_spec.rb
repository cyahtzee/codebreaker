# frozen_string_literal: true

require 'shared_examples'

RSpec.describe Codebreaker::Game do
  include_examples 'codebreaker'
  let(:long_word) { 'a' * Codebreaker::Game::SECRET_LENGTH.next }

  describe '#make_guess' do
    context 'when game is registered' do
      it 'returns ++++ when secret: 1234 and guess: 1234' do
        expect(registered_game.make_guess(guess)).to eq expected
      end

      it 'adds attempts to the game' do
        expect { registered_game.make_guess(guess) }.to change { registered_game.stats.attempts.size }.by(1)
      end

      it "returns a ValidationError when string is less than #{Codebreaker::Game::SECRET_LENGTH} chars" do
        expect { registered_game.make_guess('12') }.to raise_error(Codebreaker::ValidationError)
      end

      it "returns a ValidationError when string is more than #{Codebreaker::Game::SECRET_LENGTH} chars" do
        expect { registered_game.make_guess(long_word) }.to raise_error(Codebreaker::ValidationError)
      end
    end

    context 'when no attempts left' do
      it 'raise a ActionNotAvailable when no attempt left' do
        registered_game.attempts.next.times { registered_game.make_guess(guess) }
        expect { registered_game.make_guess(guess) }.to raise_error(Codebreaker::ActionNotAvailable)
      end
    end

    context 'when game is not registered' do
      it 'raises a GameNotExistError when make_guess' do
        expect { invalid_game.make_guess('1234') }.to raise_error(Codebreaker::GameNotExistError)
      end

      it 'raises a GameNotExistError when making guess with empty string' do
        expect { invalid_game.make_guess('') }.to raise_error(Codebreaker::GameNotExistError)
      end

      it 'raises a GameNotExistError when #any_hints_left?' do
        expect { invalid_game.any_hints_left? }.to raise_error(Codebreaker::GameNotExistError)
      end

      it 'raises a GameNotExistError when #check_win?' do
        expect { invalid_game.check_win?(guess) }.to raise_error(Codebreaker::GameNotExistError)
      end

      it 'raises a GameNotExistError when #give_hint' do
        expect { invalid_game.give_hint }.to raise_error(Codebreaker::GameNotExistError)
      end
    end
  end

  describe '#give_hint' do
    let(:current_hint) { registered_game.give_hint }

    context 'when there are hints left' do
      it "returns a hint within #{Codebreaker::Game::SECRET_DIGITS}" do
        expect(secret).to include(current_hint)
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

    describe '#check_win?' do
      it 'returns true when secret is equal to guess' do
        expect(registered_game.check_win?(secret)).to be true
      end
    end
  end
end
