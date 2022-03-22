# frozen_string_literal: true

module Codebreaker
  RSpec.describe Codebreaker::GameHelper do
    let(:game_helper) { Game.new }

    describe '#encrypt_secret' do
      it 'returns empty string if secret is empty' do
        expect(game_helper.encrypt_secret('', '1234')).to eq ''
      end

      it 'returns ++-- when secret code: 6543 and guess: 5643' do
        expect(game_helper.encrypt_secret('6543', '5643')).to eq '++--'
      end

      it 'returns +- when secret code: 6543 and guess: 6411' do
        expect(game_helper.encrypt_secret('6543', '6411')).to eq '+-'
      end

      it 'returns +++ when secret code: 6543 and guess: 6544' do
        expect(game_helper.encrypt_secret('6543', '6544')).to eq '+++'
      end

      it 'returns ---- when secret code: 6543 and guess: 3456' do
        expect(game_helper.encrypt_secret('6543', '3456')).to eq '----'
      end

      it 'returns + when secret code: 6543 and guess: 6666' do
        expect(game_helper.encrypt_secret('6543', '6666')).to eq '+'
      end

      it 'returns - when secret code: 6543 and guess: 2666' do
        expect(game_helper.encrypt_secret('6543', '2666')).to eq '-'
      end

      it 'returns \'\' when secret code: 6543 and guess: 2222' do
        expect(game_helper.encrypt_secret('6543', '2222')).to eq ''
      end
    end
  end
end
