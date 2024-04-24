# frozen_string_literal: true

module Cosing
  module Annex
    class Rule < Dry::Struct
      attribute :annex, Types::String
      attribute :cas_numbers, Types::Array.of(Types::String)
      attribute :chemical_name, Types::String
      attribute :cmr, Types::String
      attribute :ec_numbers, Types::Array.of(Types::String)
      attribute :identified_ingredients, Types::Array.of(Types::String)
      attribute :other_regulations, Types::String
      attribute :reference_number, Types::String
      attribute :regulated_by, Types::String
      attribute :regulation, Types::String
      attribute :sccs_opinions, Types::Array.of(SccsOpinion)
    end
  end
end
