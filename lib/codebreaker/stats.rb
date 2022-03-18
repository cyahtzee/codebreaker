# frozen_string_literal: true

module Codebreaker
  class Stats
    attr_accessor :attempts, :hints, :guesses

    def initialize
      @attempts = []
      @hints = []
    end
  end
end
