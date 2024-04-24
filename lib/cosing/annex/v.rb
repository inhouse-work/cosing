# frozen_string_literal: true

module Cosing
  module Annex
    class V < Base
      class Rule < Rule
        attribute :inn, Types::String
        attribute :maximum_concentration, Types::String
        attribute :other_restrictions, Types::String
        attribute :product_type, Types::String
        attribute :wording_of_conditions, Types::String
      end

      def self.load
        new.tap do |annex|
          Annex.parse("data/annex.V.csv") do |row|
            common_ingredients = Annex.transform_array!(
              row,
              key: :common_ingredients,
              split: ";"
            )
            identified_ingredients = Annex.transform_array!(
              row,
              key: :identified_ingredients,
              split: ";"
            )

            annex.add_rule(
              row.merge(
                common_ingredients: common_ingredients.compact,
                identified_ingredients: identified_ingredients.compact,
                other_restrictions: row[:other]
              )
            )
          end
        end
      end
    end
  end
end
