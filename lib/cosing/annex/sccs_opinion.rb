module Cosing
  module Annex
    class SccsOpinion < Dry::Struct
      attribute :code, Types::String
      attribute :description, Types::String

      def inspect
        to_h
      end
    end
  end
end
