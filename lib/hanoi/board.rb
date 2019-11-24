# frozen_string_literal: true

require_relative 'exceptions'
require_relative 'spindle'

module Hanoi
  # Represents the game board. Is responsible for setting up the game, enforcing
  # legality of moves, and checking for the win state.
  class Board
    attr_accessor :left, :middle, :right

    def initialize(number_of_discs)
      @left = Spindle.new
      @middle = Spindle.new
      @right = Spindle.new

      number_of_discs.downto(1).each do |size|
        @left.place!(Disc.new(size))
      end
    end

    def move!(from, to)
      from_spindle = spindle_from_keyword(from)
      to_spindle = spindle_from_keyword(to)
      disc = from_spindle.take!
      to_spindle.place!(disc)
    end

    def finished?
      return false unless left.empty?
      return false unless middle.empty?
      true
    end

    private

    def spindle_from_keyword(keyword)
      case keyword
      when :left
        left
      when :middle
        middle
      when :right
        right
      else
        raise Hanoi::InvalidSpindleKeyword
      end
    end
  end
end
