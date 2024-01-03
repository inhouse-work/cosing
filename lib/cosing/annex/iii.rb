# frozen_string_literal: true

module Cosing
  module Annex
    class III < Base
      class Rule < Rule
        attribute :common_ingredients, Types::Array.of(Types::String)
        attribute :inn, Types::String
        attribute :maximum_concentration, Types::String
        attribute :other_restrictions, Types::String
        attribute :product_type, Types::String
      end
    end
  end
end
