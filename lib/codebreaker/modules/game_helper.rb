# frozen_string_literal: true

module Codebreaker
  module GameHelper
    def generate_secret
      Game::SECRET_LENGTH.times.map { rand(Game::SECRET_DIGITS) }.join
    end

    def encrypt_secret(secret, guess)
      remaining = secret.chars
      encrypted = []
      secret.length.times do |i|
        current = remaining.index(guess[i])
        if guess[i] == secret[i]
          encrypted.unshift('+')
          remaining.delete_at(current)
        elsif remaining.include?(guess[i])
          encrypted << '-'
          remaining.delete_at(current)
        else
          encrypted << ''
        end
      end
      encrypted.join
    end

    def register_game_with_params(name, difficulty)
      self.name = name
      self.difficulty = difficulty
      self.attempts = Game::DIFFICULTY[difficulty.to_sym][:attempts]
      self.hints = Game::DIFFICULTY[difficulty.to_sym][:hints]
      self
    end
  end
end
