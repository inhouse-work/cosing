# frozen_string_literal: true

module Cosing
  class Database
    attr_reader :annexes, :ingredients

    def initialize(annexes)
      @annexes = annexes
      @ingredients = {}
    end

    def add_ingredient(params)
      restrictions = Parser.transform_array!(
        params,
        key: :restriction,
        split: "\n"
      )

      annotation_pattern = %r{([IVX]+)/([IVX]*/)?([\dabcd,]+)}

      regulations = restrictions
        .flat_map do |restriction|
          matches = restriction.scan(annotation_pattern)
          next if matches.none?

          hits = matches.flat_map do |match|
            numeral, _, reference_number = match

            reference_number.split(",").flat_map do |number|
              # debugger if number == "41" && numeral == "VI"
              @annexes[numeral.downcase.to_sym].lookup(number)
            end
          end

          hits.compact
        end

      cas_numbers = Parser.transform_array!(
        params,
        key: :cas_number,
        split: "/"
      ).map do |cas_number|
        match = cas_number.match(/(?<cas_number>\d{2,7}-\d{2}-\d)/)
        match[:cas_number] if match
      end

      functions = Parser.transform_array!(params, key: :functions, split: ",")

      einecs_numbers = Parser.transform_array!(
        params,
        key: :einecs_number,
        split: "/"
      ).map do |einecs_number|
        match = einecs_number.match(/(?<einecs_number>\d{3}-\d{3}-\d)/)
        match[:einecs_number] if match
      end

      @ingredients[params[:reference_number]] = Ingredient.new(
        functions:,
        restrictions: restrictions.compact,
        regulations: regulations.compact,
        cas_numbers: cas_numbers.compact,
        einecs_numbers: einecs_numbers.compact,
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
  end
end
