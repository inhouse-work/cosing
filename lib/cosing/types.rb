# frozen_string_literal: true

module Cosing
  module Types
    include Dry.Types()

    CasNumber = Types::String.constrained(format: /\A\d{2,7}-\d{2}-\d\z/)
    EinecsNumber = Types::String.constrained(format: /\A\d{3}-\d{3}-\d\z/)
  end
end
