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
  end

  def choose_difficulty(difficulty)
    raise 'Wrong difficulty' unless DIFFICULTY.include?(difficulty)
  rescue RuntimeError => e
    puts e.message

    case difficulty
    when 'easy'
      self.attempts = 15
      self.hints = 2
    when 'medium'
      self.attempts = 10
      self.hints = 1
    when 'hell'
      self.attempts = 5
      self.hints = 1
    end
  end
end
