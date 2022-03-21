# frozen_string_literal: true

require_relative './modules/game_helper'
require_relative './base'

module Codebreaker
  class Game < Base
    include GameHelper

    attr_accessor :attempts, :hints, :name, :stats, :difficulty

    DIFFICULTY = { easy: { attempts: 15, hints: 2 },
                   medium: { attempts: 10, hints: 1 },
                   hell: { attempts: 5, hints: 1 } }.freeze

    def initialize
      @stats = Stats.new
      @secret = generate_secret
      @available_hints = @secret.dup.chars
    end

    def register_game(name, difficulty)
      errors = validate(name, difficulty)
      raise errors.join('\n') unless errors.empty?
    rescue RuntimeError => e
      e.message
    else
      register_game_with_params(name, difficulty)
    end

    def make_guess(input)
      new_guess = Guess.new(input)
      errors = new_guess.validate(input)
      if errors.any?
        puts errors.join('\n')
      else
        result = encrypt_secret(@secret, input)
        @stats.attempts << new_guess
        result
      end
    end

    def check_win?(input)
      input == @secret && @stats.attempts.size <= @attempts
    end

    def any_hints_left?
      @stats.hints.size < @hints
    end

    def give_hint
      raise 'No hints left' unless any_hints_left?
    rescue RuntimeError => e
      e.message
    else
      hint = generate_hint
      @stats.hints << hint
      hint
    end

    private

    def validate(name, difficulty)
      errors = []
      errors << 'Invalid name' unless valid_name?(name)
      errors << 'Invalid difficulty' unless DIFFICULTY.key?(difficulty.to_sym)
      errors
    end

    def generate_hint
      index = rand(0..@available_hints.size - 1)
      hint = @available_hints.delete_at(index)
      p "Hint: #{hint}"
      hint
    end
  end
end
