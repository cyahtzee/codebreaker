# frozen_string_literal: true

module Codebreaker
  module Validator
    def valid_name?(name)
      valid_string?(name) && valid_length?(name)
    end

    def valid_guess?(guess)
      valid_integers?(guess) && guess.length == Codebreaker::Game::SECRET_LENGTH
    end

    def valid_string?(string)
      !string.empty? && !string.nil?
    end

    def valid_length?(string, range = Codebreaker::Game::NAME_LENGTH_RANGE)
      range.include?(string.length)
    end

    def valid_integers?(combination, range = Codebreaker::Game::SECRET_DIGITS)
      combination.chars.all? do |char|
        integer?(char) && range.include?(char.to_i)
      end
    end

    def integer?(char)
      Integer(char).is_a?(Integer)
    rescue ArgumentError
      false
    end
  end
end
