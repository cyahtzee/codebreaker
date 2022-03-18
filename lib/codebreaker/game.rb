# frozen_string_literal: true

require_relative './modules/game_helper'
require_relative './modules/validator'

module Codebreaker
  class Game
    include GameHelper
    include Validator
    attr_reader :running

    def initialize
      @secret = generate_secret
      @name ||= ''
      @guesses ||= []
      @hints ||= []
      @attempts ||= []
    end

    def generate_output(secret, guess)
      encrypt_secret(secret, guess)
    end

    def generate_hint(secret)
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
      validate(name)
    end
  end
end
