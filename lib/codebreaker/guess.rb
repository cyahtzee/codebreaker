# frozen_string_literal: true

require_relative './base'

module Codebreaker
  class Guess < Base
    attr_reader :combination

    def initialize(input)
      @combination = input
    end

    def validate(combination)
      error = I18n.t(:invalid_guess,
                     digit_count: Game::SECRET_LENGTH,
                     range: Game::SECRET_DIGITS)
      errors = []
      errors << error unless valid_guess?(combination)
      errors
    end
  end
end
