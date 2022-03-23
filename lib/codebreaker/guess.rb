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
      error = I18n.t(:invalid_guess, digit_count: length.last, range: digits)
      errors = []
      errors << error unless valid_guess?(combination)
      errors
    end
  end
end
