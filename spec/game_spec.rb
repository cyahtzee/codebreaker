# frozen_string_literal: true

module Codebreaker
  RSpec.describe Game do
    describe Game do
      it "has a secret" do
        game = Game.new
        expect(game.generate_secret).not_to be nil
      end

      it "has a secret with 4 digits" do
        game = Game.new
        expect(game.generate_secret.length).to eq 4
      end

      it "has a secret with numbers from 1 to 6" do
        game = Game.new
        expect(game.generate_secret).to match(/[1-6]/)
      end
    end
  end
end
