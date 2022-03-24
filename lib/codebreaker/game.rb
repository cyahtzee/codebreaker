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

    SECRET_DIGITS = 1..6

    SECRET_LENGTH = 4

    NAME_LENGTH_RANGE = 3..10

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
      alert_unregistered_game
      new_guess = Guess.new(input)
      errors = new_guess.validate(input)
      raise Codebreaker::ActionNotAvailable, I18n.t(:no_attempts) if @stats.attempts.size > @attempts
      raise Codebreaker::ValidationError, errors.join('\n') if errors.any?

      result = encrypt_secret(@secret, input)
      @stats.attempts << new_guess
      result
    end

    def check_win?(input)
      alert_unregistered_game
      input == @secret && @stats.attempts.size <= @attempts
    end

    def any_hints_left?
      alert_unregistered_game
      @stats.hints.size < @hints
    end

    def give_hint
      alert_unregistered_game
      raise Codebreaker::ActionNotAvailable, I18n.t(:hint) unless any_hints_left?

      hint = generate_hint
      @stats.hints << hint
      hint
    end

    private

    def alert_unregistered_game
      raise Codebreaker::GameNotExistError, I18n.t(:unregistered_game) if difficulty.nil?
    end

    def validate(name, difficulty)
      errors = []
      unless valid_name?(name)
        errors << I18n.t(:invalid_name,
                         min: NAME_LENGTH_RANGE.first,
                         max: NAME_LENGTH_RANGE.last)
      end
      errors << I18n.t(:invalid_difficulty, difficulty: DIFFICULTY.keys) unless DIFFICULTY.key?(difficulty.to_sym)
      errors
    end

    def generate_hint
      index = rand(0..@available_hints.size - 1)
      @available_hints.delete_at(index)
    end
  end
end
