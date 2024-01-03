# frozen_string_literal: true

module Cosing
  module Annex
    class Base
      def initialize
        @rules = {}
      end

      def keys
        @rules.keys
      end

      def add_rule(params)
        return unless params[:reference_number]

        @rules[params[:reference_number]] = self.class::Rule.new(
          **params.merge(annex: self.class.name.gsub("::", " "))
        )
      end

      def lookup(reference_number)
        @rules.fetch(
          reference_number.to_s,
          fuzzy_find(reference_number.to_s)
        )
      rescue KeyError => e
        # Known missing data from original source
        return nil if reference_number == "19" && instance_of?(Annex::VI)
        return nil if reference_number == "41" && instance_of?(Annex::VI)
        return nil if reference_number == "31" && instance_of?(Annex::VI)
        return nil if reference_number == "44" && instance_of?(Annex::VI)
        return nil if reference_number == "268" && instance_of?(Annex::III)

        raise e
      end

      private

      def fuzzy_find(reference_number)
        return @rules[reference_number] if @rules.key?(reference_number)

        candidates = @rules.keys.grep(/#{reference_number}[abcd]/)
        candidates
          .map { |candidate| @rules[candidate] }
          .tap do |candidates|
            if candidates.empty?
              raise KeyError,
                    "Could not find #{reference_number} in #{self.class}, " \
                    "valid keys are #{keys}"
            end
          end
      end
    end
  end
end
