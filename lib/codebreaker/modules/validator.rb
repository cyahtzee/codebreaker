# frozen_string_literal: true

module Codebreaker
  module Validator
    def valid_name?(name)
      valid_string?(name) && valid_length?(name, 3, 20)
    end

    def valid_guess?(guess)
      valid_integers?(guess) && valid_length?(guess, 4, 4)
    end

    def valid_string?(string)
      !string.empty? && !string.nil?
    end

    def valid_length?(name, min, max)
      name.length.between?(min, max)
    end

    def valid_integers?(string, min = 0, max = 9)
      string.chars.all? do |char|
        is_integer?(char) && char.to_i.between?(min, max)
      end
    end

    def is_integer?(char)
      Integer(char).is_a?(Integer)
    rescue ArgumentError
      false
    end
  end
end
