require_relative '../../codebreaker'
module Codebreaker
    class Game
    attr_reader :running

    def initialize
      @running = true
    end

    def running?
      @running
    end

    def switch
      @running = !@running
    end

    def start
      puts "Game started"
    end

    def exit
      switch
    end
  end
end
