# frozen_string_literal: true

module Cosing
  module Annex
    class VI < Base
      class Rule < Rule
        attribute :common_ingredients, Types::Array.of(Types::String)
        attribute :inn, Types::String
        attribute :maximum_concentration, Types::String
        attribute :other_restrictions, Types::String
        attribute :product_type, Types::String
        attribute :wording_of_conditions, Types::String
      end
    end
  end
end
