# frozen_string_literal: true

require_relative './base'

module Codebreaker
  class Guess < Base
    attr_reader :combination

    def initialize(input)
      @combination = input
    end

    def validate(combination)
      length = Game::SECRET_PARAMS[:length]
      digits = Game::SECRET_PARAMS[:digits]
      error = "Guess should be a #{range.last} digit number between #{digits}"
      errors = []
      errors << error unless valid_guess?(combination, digits, length)
      errors
    end
  end
end
