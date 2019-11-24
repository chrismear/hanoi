# frozen_string_literal: true

module Hanoi
  # A single disc of a particular size.
  class Disc
    attr_reader :size

    def initialize(size)
      @size = size
    end
  end
end
