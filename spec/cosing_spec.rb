# frozen_string_literal: true

RSpec.describe Cosing do
  it "has a version number" do
    expect(Cosing::VERSION).not_to be_nil
  end

  describe ".load" do
    it "returns a cosing database" do
      expect(described_class.load).to be_a(described_class::Database)
    end
  end
end
