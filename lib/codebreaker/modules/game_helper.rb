# frozen_string_literal: true


  module GameHelper
    def generate_secret
      (1..4).map { rand(1..6) }.join
    end

    def encrypt_secret(secret, guess)
      remaining = secret.chars
      encrypted = []
      secret.length.times do |i|
        if guess[i] == secret[i]
          encrypted.last == '+' ? encrypted << '+' : encrypted.unshift('+')
          remaining.delete_at(i)
        elsif remaining.include?(guess[i])
          encrypted << '-'
        else
          encrypted << ''
        end
      end
      encrypted.join
    end
  end
