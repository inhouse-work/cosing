# frozen_string_literal: true

module Cosing
  module Annex
    class II < Base
      class Rule < Rule
        attribute :inn, Types::String
      end

      def self.load
        new.tap do |annex|
          Annex.parse("data/annex.II.csv") do |row|
            ingredients = Cosing::Parser.transform_array!(
              row,
              key: :identified_ingredients,
              split: ";"
            )

            annex.add_rule(
              row.merge(
                identified_ingredients: ingredients.compact
              )
            )
          end
        end
      end
    end
  end
end
