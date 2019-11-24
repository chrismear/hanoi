# frozen_string_literal: true

require_relative 'disc'
require_relative 'exceptions'

module Hanoi
  # Represents a spindle of the board, and taking/placing discs. Responsbile for
  # ensuring that there is always a legal arrangement of discs on the spindle.
  class Spindle
    attr_reader :discs

    def initialize(*sizes)
      @discs = []
      sizes.sort.uniq.each do |size|
        @discs.push(Disc.new(size))
      end
    end

    def sizes
      discs.map(&:size)
    end

    def take!
      discs.shift || (raise IllegalTakeFromEmptySpindle)
    end

    def place!(disc)
      trial_discs = discs.dup
      trial_discs.unshift(disc)
      if trial_discs.map(&:size).sort.uniq != trial_discs.map(&:size)
        raise IllegalPlace
      end

      @discs = trial_discs
    end

    def empty?
      discs.empty?
    end

    def copy
      Spindle.new(*sizes)
    end
  end
end
