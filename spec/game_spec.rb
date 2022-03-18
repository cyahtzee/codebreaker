# frozen_string_literal: true

module Codebreaker
  RSpec.describe Game do
    before(:each) do
      @game = Game.new
    end

    describe '#register_game' do
      it 'has a secret' do
        expect(@game.generate_secret).not_to be nil
      end

      it 'has a secret with 4 digits' do
        expect(@game.generate_secret.length).to eq 4
      end

      it 'has a secret with numbers from 1 to 6' do
        expect(@game.generate_secret).to match(/[1-6]/)
      end

      it 'has a instance variable @secret' do
        expect(@game.instance_variable_get(:@secret)).not_to be nil
      end

      it 'has instance variable @secret taht is not visible to outside' do
        expect { @game.secret }.to raise_error(NoMethodError)
      end

      it 'sets instance variable hints and attempts' do
        expect(@game.instance_variable_get(:@hints)).not_to be nil
        expect(@game.instance_variable_get(:@attempts)).not_to be nil
      end
    end
  end
end
