# frozen_string_literal: true

require "csv"
require "json"
require "pathname"
require "dry/types"
require "dry/struct"
require_relative "cosing/version"
require_relative "cosing/types"
require_relative "cosing/ingredient"
require_relative "cosing/annex"
require_relative "cosing/database"

module Cosing
  module_function

  GEM_ROOT = File.expand_path("..", __dir__)

  class Error < StandardError; end
  # Your code goes here...

  def load
    Database.new(Annex.load).tap do |database|
      path = gem_path("data/ingredients.csv")
      ingredient_file = File.read(path).delete("\r")

      CSV.parse(
        ingredient_file,
        headers: true,
        liberal_parsing: true,
        header_converters: :symbol
      ) do |row|
        row
          .to_h
          .transform_values! { |value| value.to_s.strip }
          .then { |row| database.add_ingredient(row) }
      end
    end
  end

  def gem_path(path)
    Pathname.new(GEM_ROOT).join(path)
  end
end
