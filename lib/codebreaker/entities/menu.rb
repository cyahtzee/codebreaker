require_relative '../../codebreaker'

module Codebreaker
  class Menu
    ACTIONS = ['start', 'rules', 'stats', 'exit']

    attr_reader :game

    def initialize
      @game = Game.new
    end

    def route_actions
      show_menu
      while @game.running?
        choice = gets.chomp.to_s
        case choice
          when ACTIONS[0] then @game.start
          when ACTIONS[1] then @game.rules
          when ACTIONS[2] then @game.stats
          when ACTIONS[3] then @game.exit
          else
            puts "Unknown action"
            show_menu
        end
      end
      puts "__________thank you for playing__________"
    end

    def show_menu
      puts %(----------Welcome to Codebreaker----------\n
      [#{ACTIONS[0]}] Start game\n
      [#{ACTIONS[1]}] Rules\n
      [#{ACTIONS[2]}] Stats\n
      [#{ACTIONS[3]}] Exit\n)
    end
  end
end
