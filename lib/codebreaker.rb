#!/usr/lib/env ruby
# frozen_string_literal: true

require_relative 'codebreaker/version'
require_relative './codebreaker/entities/game'
require_relative './codebreaker/entities/menu'

module Codebreaker
  class Error < StandardError; end
end
