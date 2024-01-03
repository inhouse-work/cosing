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
    end
  end
end
