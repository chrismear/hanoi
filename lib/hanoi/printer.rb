# frozen_string_literal: true

module Hanoi
  # Makes an ASCII-art interpretation of the board state.
  class Printer
    def initialize(board)
      @board = board
    end

    def print
      lines = []
      max = (@board.left.sizes + @board.middle.sizes + @board.right.sizes).max
      0.upto(max - 1).each do |level|
        line = String.new
        [@board.left, @board.middle, @board.right].each do |spindle|
          if spindle.discs.length >= (max - level)
            disc = spindle.discs[level - (max - spindle.discs.length)]
            padding = max - disc.size
            padding_left = padding / 2
            padding_right = padding - padding_left
            line << ' ' * padding_left
            line << '#' * disc.size
          else
            padding = max - 1
            padding_left = padding / 2
            padding_right = padding - padding_left
            line << ' ' * padding_left
            line << '|'
          end
          line << ' ' * padding_right
          line << ' '
        end
        lines << line
      end
      lines << '-' * (max * 3 + 2)
      lines.map(&:rstrip).join("\n")
    end
  end
end
