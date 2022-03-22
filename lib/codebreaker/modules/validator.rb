# frozen_string_literal: true

module Codebreaker
  module Validator
    def valid_name?(name)
      valid_string?(name) && valid_length?(name)
    end

    def valid_guess?(guess)
      valid_integers?(guess) && valid_length?(guess)
    end

    def valid_string?(string)
      !string.empty? && !string.nil?
    end

    def valid_length?(string, range = Codebreaker::Game::NAME_PARAMS[:length])
      string.length.between?(range.first, range.last)
    end

    def valid_integers?(combination, range = Codebreaker::Game::SECRET_PARAMS[:digits])
      combination.chars.all? do |char|
        integer?(char) && char.to_i.between?(range.first, range.last)
      end
    end

    def integer?(char)
      Integer(char).is_a?(Integer)
    rescue ArgumentError
      false
    end
  end
end
