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
        return unless reference = params[:reference_number]

        annex = self.class.name.gsub("::", " ")
        @rules[reference] = self.class::Rule.new(**params.merge(annex:))
      end

      def lookup(reference_number)
        @rules.fetch(
          reference_number.to_s,
          fuzzy_find(reference_number.to_s)
        )
      rescue KeyError
        nil
      end

      private

      def fuzzy_find(reference_number)
        return @rules[reference_number] if @rules.key?(reference_number)

        @rules.keys.grep(/#{reference_number}[abcd]/)
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
