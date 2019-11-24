# frozen_string_literal: true

require_relative 'board'

module Hanoi
  # Allows easy interaction with one game of Tower of Hanoi.
  class Game
    attr_reader :board

    def initialize(number_of_discs)
      @board = Board.new(number_of_discs)
    end

    def move(from, to)
      board.move!(from, to)
    end

    def finished?
      board.finished?
    end
  end
end
