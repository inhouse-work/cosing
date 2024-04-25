# frozen_string_literal: true

module Cosing
  module Parser
    module_function

    def transform_array!(params, key:, split:)
      params
        .delete(key)
        .split(split)
        .map!(&:strip)
        .reject { |n| n == "-" }
    end
  end
end
