# frozen_string_literal: true

require_relative './base'

module Codebreaker
  class Guess < Base
    attr_reader :guess

    def initialize(guess)
      @guess = guess
    end

    def validate(guess)
      errors = []
      errors << 'Invalid guess' unless valid_guess?(guess)
      errors
    end
  end
end
