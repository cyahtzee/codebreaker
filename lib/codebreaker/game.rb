# frozen_string_literal: true

require_relative './modules/game_helper'
require_relative './modules/validator'

module Codebreaker
  class Game
    include GameHelper
    include Validator
    DIFFICULTY = %w[easy medium hell].freeze

    def initialize
      @secret = generate_secret
      @name ||= ''
      @guesses ||= []
      @hints ||= 0
      @attempts ||= 0
    end

    def generate_output
      encrypt_secret(secret, guess)
    end

    def generate_hint
      hint = secret.chars.sample
      while @guesses.include? hint
        hint = secret.chars.sample
      end
      @hints -= 1
      hint
    end

    def make_guess(guess)
      if valid_guess?(guess)
        @guess = guess
        @attempts << @guess
        @hints << generate_output(@secret, @guess)
      else
        raise Error, 'Wrong guess'
      end
    end

    def register_game
      game = Game.new
      game.generate_secret
      game.choose_difficulty(difficulty)
    end
  end
end
