# frozen_string_literal: true

require_relative "annex/sccs_opinion"
require_relative "annex/rule"
require_relative "annex/base"
require_relative "annex/ii"
require_relative "annex/iii"
require_relative "annex/iv"
require_relative "annex/v"
require_relative "annex/vi"

module Cosing
  module Annex
    module_function

    def parse(path)
      CSV.parse(
        File.read(Cosing.gem_path(path)),
        headers: true,
        liberal_parsing: true,
        header_converters: :symbol
      ) do |row|
        row = row
          .to_h
          .transform_values do |value|
            value.to_s.strip.then { |val| val == "-" ? "" : val }
          end

        cas_numbers = build_cas_numbers(row)
        ec_numbers = build_ec_numbers(row)
        sccs_opinions = build_sccs_opinions(row)

        yield row.merge(
          cas_numbers: cas_numbers.compact,
          ec_numbers: ec_numbers.compact,
          sccs_opinions: sccs_opinions.compact
        )
      end
    end

    def load
      ii, iii, iv, v, vi = [
        Annex::II,
        Annex::III,
        Annex::IV,
        Annex::V,
        Annex::VI
      ].map(&:load)

      { ii:, iii:, iv:, v:, vi: }
    end

    def transform_array!(params, key:, split:)
      params
        .delete(key)
        .split(split)
        .map(&:strip)
        .reject { |n| n == "-" }
    end

    def build_sccs_opinions(row)
      transform_array!(
        row,
        key: :sccs_opinions,
        split: ";"
      ).map do |opinion|
        code, *description = opinion.split("-")

        SccsOpinion.new(
          code:,
          description: description.join("-")
        )
      end
    end

    def build_cas_numbers(row)
      transform_array!(
        row,
        key: :cas_number,
        split: "/"
      ).map do |cas_number|
        match = cas_number.match(/(?<cas_number>\d{2,7}-\d{2}-\d)/)
        match[:cas_number] if match
      end
    end

    def build_ec_numbers(row)
      transform_array!(
        row,
        key: :ec_number,
        split: "/"
      ).map do |ec_number|
        match = ec_number.match(/(?<ec_number>\d{3}-\d{3}-\d)/)
        match[:ec_number] if match
      end
    end
  end
end
