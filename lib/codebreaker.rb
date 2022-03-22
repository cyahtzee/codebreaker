# frozen_string_literal: true

# !/usr/lib/env ruby

require 'i18n'
require 'codebreaker/version'
require 'codebreaker/game'
require 'codebreaker/guess'
require 'codebreaker/base'
require 'codebreaker/stats'
require_relative 'codebreaker/config/i18n'

module Codebreaker
  class ValidationError < StandardError; end
end
