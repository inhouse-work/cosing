# frozen_string_literal: true

module Cosing
  class Database
    attr_reader :annexes, :ingredients

    ANNOTATION_PATTERN = %r{([IVX]+)/([IVX]*/)?([\dabcd,]+)}
    CAS_NUMBER_PATTERN = /(?<cas_number>\d{2,7}-\d{2}-\d)/
    EINECS_NUMBER_PATTERN = /(?<einecs_number>\d{3}-\d{3}-\d)/

    def initialize(annexes)
      @annexes = annexes
      @ingredients = {}
    end

    def add_ingredient(params)
      restrictions = Parser
        .transform_array!(params, key: :restriction, split: "\n")
      regulations = extract_regulations(restrictions).compact
      cas_numbers = extract_cas_numbers(params).compact
      einecs_numbers = extract_einecs_numbers(params).compact
      functions = Parser
        .transform_array!(params, key: :functions, split: ",")
        .compact

      @ingredients[params[:reference_number]] = Ingredient.new(
        functions:,
        restrictions:,
        regulations:,
        cas_numbers:,
        einecs_numbers:,
        **params
      )
    end

    def save(filepath, pretty: false)
      output = if pretty
        JSON.pretty_generate(@ingredients.to_h)
      else
        JSON.dump(@ingredients.to_h)
      end

      File.write(filepath, output)
    end

    private

    def extract_cas_numbers(params)
      Parser.transform_array!(
        params,
        key: :cas_number,
        split: "/"
      ).map do |cas_number|
        match = cas_number.match(CAS_NUMBER_PATTERN)
        match[:cas_number] if match
      end
    end

    def extract_einecs_numbers(params)
      Parser.transform_array!(
        params,
        key: :einecs_number,
        split: "/"
      ).map do |einecs_number|
        match = einecs_number.match(EINECS_NUMBER_PATTERN)
        match[:einecs_number] if match
      end
    end

    def extract_regulations(restrictions)
      restrictions
        .flat_map do |restriction|
          matches = restriction.scan(ANNOTATION_PATTERN)
          next if matches.none?

          extract_hits(matches).compact
        end
    end

    def extract_hits(matches)
      matches.flat_map do |match|
        numeral, _, reference_number = match

        reference_number.split(",").flat_map do |number|
          # debugger if number == "41" && numeral == "VI"
          @annexes[numeral.downcase.to_sym].lookup(number)
        end
      end
    end
  end
end
