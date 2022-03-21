# frozen_string_literal: true

require_relative './base'

module Codebreaker
  class Guess < Base
    attr_reader :combination

    def initialize(input)
      @combination = input
    end

    def validate(combination)
      errors = []
      errors << 'Invalid guess' unless valid_guess?(combination)
      errors
    end
  end
end
