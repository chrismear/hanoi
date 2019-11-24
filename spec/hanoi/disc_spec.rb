# frozen_string_literal: true

require_relative '../../lib/hanoi/disc'

module Hanoi
  RSpec.describe Disc do
    it 'is initialised with a size' do
      disc = Disc.new(6)
      expect(disc.size).to eq(6)
    end
  end
end
