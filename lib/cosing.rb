# frozen_string_literal: true

require "csv"
require "json"
require "dry/types"
require "dry/struct"
require_relative "cosing/version"
require_relative "cosing/types"
require_relative "cosing/ingredient"
require_relative "cosing/annex"
require_relative "cosing/database"

module Cosing
  module_function

  class Error < StandardError; end
  # Your code goes here...

  def load
    Database.new(Annex.load).tap do |database|
      ingredient_file = File.read("data/ingredients.csv").delete("\r")

      CSV.parse(
        ingredient_file,
        headers: true,
        liberal_parsing: true,
        header_converters: :symbol
      ) do |row|
        row =
          row
            .to_h
            .transform_values(&:to_s)
            .transform_values(&:strip)

        database.add_ingredient(row)
      end
    end
  end
end
