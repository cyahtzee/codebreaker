# frozen_string_literal: true

require_relative './modules/validator'

module Codebreaker
  class Base
    include Validator

    def initialize
      raise NotImplementedError
    end

    def validate
      raise NotImplementedError
    end
  end
end
