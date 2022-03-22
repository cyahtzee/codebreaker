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

    SECRET_PARAMS = { digits: (1..6), length: (1..4) }.freeze

    NAME_PARAMS = { length: (3..20) }.freeze

    def initialize
      @stats = Stats.new
      @secret = generate_secret
      @available_hints = @secret.dup.chars
    end

    def register_game(name, difficulty)
      errors = validate(name, difficulty)
      raise Codebreaker::ValidationError, errors.join('\n') if errors.any?

      register_game_with_params(name, difficulty)
    end

    def make_guess(input)
      new_guess = Guess.new(input)
      errors = new_guess.validate(input)
      raise Codebreaker::ValidationError, errors.join('\n') if errors.any?

      result = encrypt_secret(@secret, input)
      @stats.attempts << new_guess
      result
    end

    def check_win?(input)
      input == @secret && @stats.attempts.size <= @attempts
    end

    def any_hints_left?
      @stats.hints.size < @hints
    end

    def give_hint
      raise ValidationError, I18n.t(:hint) unless any_hints_left?

      hint = generate_hint
      @stats.hints << hint
      hint
    end

    private

    def validate(name, difficulty)
      length = NAME_PARAMS[:length]
      errors = []
      errors << I18n.t(:invalid_name, min: length.first, max: length.last) unless valid_name?(name)
      errors << I18n.t(:invalid_difficulty, difficulty: DIFFICULTY.keys) unless DIFFICULTY.key?(difficulty.to_sym)
      errors
    end

    def generate_hint
      index = rand(0..@available_hints.size - 1)
      @available_hints.delete_at(index)
    end
  end
end
