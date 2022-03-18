# frozen_string_literal: true

require_relative './modules/game_helper'
require_relative './base'

module Codebreaker
  class Game < Base
    include GameHelper

    attr_reader :attempts, :hints, :name

    DIFFICULTY = { easy: { attempts: 15, hints: 2 },
                   medium: { attempts: 10, hints: 1 },
                   hell: { attempts: 5, hints: 1 } }.freeze

    def initialize(params = {})
      @stats = Stats.new
      @secret = generate_secret
      @name = params[:name]
      @attempts = params[:attempts]
      @hints = params[:hints]
    end

    def register_game(name, difficulty)
      errors = validate(name, difficulty)
      raise errors.join('\n') unless errors.empty?
    rescue RuntimeError => e
      puts e.message

      register_game_with_params(name, difficulty)
    end

    def make_guess(guess)
      new_guess = Guess.new(guess)
      errors = new_guess.validate(guess)
      if errors.any?
        puts errors.join('\n')
      else
        result = encrypt_secret(@secret, guess)
        @stats.attempts += 1
        @stats.guesses << new_guess
        result
      end
    end

    private

    def validate(name, difficulty)
      errors = []
      errors << 'Invalid name' unless valid_name?(name)
      errors << 'Invalid difficulty' unless DIFFICULTY.key?(difficulty.to_sym)
      errors
    end
  end
end
