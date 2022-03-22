# frozen_string_literal: true

RSpec.describe Codebreaker::Game do
  subject(:new_game) { described_class.new.register_game('John', 'easy') }

  describe '#make_guess' do
    it 'returns an encrypted string according to the secret' do
      secret = new_game.instance_variable_get(:@secret)
      result = new_game.encrypt_secret(secret, '1234')
      expect(new_game.make_guess('1234')).to eq result
    end
  end

  describe '#give_hint' do
    before { 2.times { new_game.give_hint } }

    context 'when there are hints left' do
      it 'returns a hint' do
        expect(:hint).to match(/[1-6]/)
      end
    end

    context 'when there are no hints left' do
      it 'raises a ValidationError' do
        expect { new_game.give_hint }.to raise_error(Codebreaker::ValidationError)
      end
    end
  end
end
