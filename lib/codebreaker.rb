# frozen_string_literal: true

# !/usr/lib/env ruby

require 'codebreaker/version'
require 'codebreaker/game'
require 'codebreaker/guess'
require 'codebreaker/base'
require 'codebreaker/stats'

module Codebreaker
  class ValidationError < StandardError; end
end
