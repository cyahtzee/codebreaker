# frozen_string_literal: true

module Codebreaker
  module GameHelper
    def generate_secret
      (1..4).map { rand(1..6) }.join
    end

    def encrypt_secret(secret, guess)
      remaining = secret.chars
      encrypted = []
      secret.length.times do |i|
        current = remaining.index(guess[i])
        if guess[i] == secret[i]
          encrypted.last == '+' ? encrypted << '+' : encrypted.unshift('+')
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
      params = { name: name, difficulty: difficulty }
      params[:attempts] = Game::DIFFICULTY[difficulty.to_sym][:attempts]
      params[:hints] = Game::DIFFICULTY[difficulty.to_sym][:hints]
      Game.new(**params)
    end
  end
end
