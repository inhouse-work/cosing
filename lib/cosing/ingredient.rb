# frozen_string_literal: true

module Cosing
  class Ingredient < Dry::Struct
    attribute :reference_number, Types::String
    attribute :inci_name, Types::String
    attribute :inn, Types::String
    attribute :ph_eur_name, Types::String
    attribute :cas_numbers, Types::Array.of(Types::CasNumber)
    attribute :einecs_numbers, Types::Array.of(Types::EinecsNumber)
    attribute :description, Types::String
    attribute :restrictions, Types::Array.of(Types::String)
    attribute :functions, Types::Array.of(Types::String)
    attribute :regulations, Types::Array

    def inspect
      to_h
    end

    def to_json(...)
      to_h.to_json(...)
    end
  end
end
