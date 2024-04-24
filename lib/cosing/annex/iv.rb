# frozen_string_literal: true

module Cosing
  module Annex
    class IV < Base
      class Rule < Rule
        attribute :colour, Types::String
        attribute :colour_index_number, Types::String
        attribute :maximum_concentration, Types::String
        attribute :other_restrictions, Types::String
        attribute :product_type, Types::String
        attribute :wording_of_conditions, Types::String
      end

      def self.load
        new.tap do |annex|
          Annex.parse("data/annex.IV.csv") do |row|
            ingredients = Cosing::Parser.transform_array!(
              row,
              key: :identified_ingredients,
              split: ";"
            )

            annex.add_rule(
              row.merge(
                identified_ingredients: ingredients.compact,
                other_restrictions: row[:other]
              )
            )
          end
        end
      end
    end
  end
end
