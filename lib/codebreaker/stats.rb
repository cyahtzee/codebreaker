module Codebreaker
  class Stats
    attr_accessor :attempts, :hints, :guesses

    def initialize
      @attempts = 0
      @hints = 0
      @guesses = []
    end
  end
end
