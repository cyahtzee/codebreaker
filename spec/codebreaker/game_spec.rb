# frozen_string_literal: true

RSpec.describe Codebreaker::Game do
  let(:new_game) { described_class.new }
  let(:registered_game) { described_class.new.register_game('Game', 'easy') }

  describe '#make_guess' do
    context 'when game is registered' do
      it 'returns an encrypted string with correspodning number of - and +' do
        allow(registered_game).to receive(:make_guess).with('1234').and_return('++++')
        expect(registered_game.make_guess('1234')).to eq('++++')
      end

      it "returns a ValidationError when string is less than #{Codebreaker::Game::SECRET_PARAMS[:length].last} chars" do
        allow(registered_game).to receive(:make_guess).with('12').and_return(Codebreaker::ValidationError)
        expect { new_game.make_guess('12') }.to raise_error(Codebreaker::ValidationError)
      end
    end

    context 'when game is not registered' do
      it 'returns a ValidationError when making guess' do
        allow(new_game).to receive(:make_guess).with('1234').and_raise(Codebreaker::ValidationError)
        expect { new_game.make_guess('1234') }.to raise_error(Codebreaker::ValidationError)
      end

      it 'returns a ValidationError when making guess with empty string' do
        allow(new_game).to receive(:make_guess).with('').and_raise(Codebreaker::ValidationError)
        expect { new_game.make_guess('') }.to raise_error(Codebreaker::ValidationError)
      end
    end
  end

  describe '#give_hint' do
    context 'when there are hints left' do
      it 'returns a hint' do
        stats = object_double('stats', hints: [])

        allow(stats).to receive(:hints).and_return(['1'])
        allow(registered_game).to receive(:stats).and_return(stats)
        allow(registered_game).to receive(:give_hint).and_return('1')
        expect(stats.hints).to include('1')
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
        allow(registered_game).to receive(:give_hint).and_raise(Codebreaker::ValidationError)
        expect { registered_game.give_hint }.to raise_error(Codebreaker::ValidationError)
      end
    end
  end
end
