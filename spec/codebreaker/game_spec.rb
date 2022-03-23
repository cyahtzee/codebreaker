# frozen_string_literal: true

RSpec.describe Codebreaker::Game do
  let(:new_game) { described_class.new }
  let(:registered_game) { new_game.register_game('Game', 'easy') }
  let(:guess)  do
    digits = Codebreaker::Game::SECRET_PARAMS[:digits]
    length = Codebreaker::Game::SECRET_PARAMS[:length]
    length.last.times.map { FFaker::Random.rand(digits) }.join
  end
  let(:secret) { registered_game.instance_variable_get(:@secret) }

  describe '#make_guess' do
    context 'when game is registered' do
      it 'returns an encrypted string with correspodning number of - and +' do
        result = registered_game.encrypt_secret(secret, guess)
        expect(registered_game.make_guess(guess)).to eq(result)
      end

      it "returns a ValidationError when string is less than #{Codebreaker::Game::SECRET_PARAMS[:length].last} chars" do
        expect { registered_game.make_guess('12') }.to raise_error(Codebreaker::ValidationError)
      end
    end

    context 'when game is not registered' do
      it 'returns a ValidationError when making guess' do
        expect { new_game.make_guess('1234') }.to raise_error(Codebreaker::ValidationError)
      end

      it 'returns a ValidationError when making guess with empty string' do
        expect { new_game.make_guess('') }.to raise_error(Codebreaker::ValidationError)
      end
    end
  end

  describe '#give_hint' do
    context 'when there are hints left' do
      it 'returns a hint' do
        expect(secret).to include(registered_game.give_hint).at_least(1)
      end

      it 'increase the number of hints in stats' do
        expect { registered_game.give_hint }.to change { registered_game.stats.hints.size }.by(1)
      end

      it 'returns a digit from secret and adds to the hints array' do
        current_hint = registered_game.give_hint
        expect(registered_game.stats.hints).to include(current_hint)
      end
    end

    context 'when there are no hints left' do
      before { 2.times { registered_game.give_hint } }

      it 'raises a ValidationError' do
        expect { registered_game.give_hint }.to raise_error(Codebreaker::ValidationError)
      end
    end
  end
end
