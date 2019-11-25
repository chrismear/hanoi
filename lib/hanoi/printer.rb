# frozen_string_literal: true

module Hanoi
  # Makes an ASCII-art interpretation of the board state.
  class Printer
    SPINDLE_COUNT = 3
    BORDER_LENGTH = 1

    def initialize(board)
      @board = board
    end

    def print
      lines = []
      0.upto(max - 1).each do |level|
        lines << generate_line(level)
      end
      lines << '-' * line_length
      lines.map(&:rstrip).join("\n")
    end

    private

    def max
      @max ||=
        (@board.left.sizes + @board.middle.sizes + @board.right.sizes).max
    end

    def line_length
      max * SPINDLE_COUNT + (SPINDLE_COUNT - 1) * BORDER_LENGTH
    end

    def generate_line(level)
      [@board.left, @board.middle, @board.right].map { |spindle|
        generate_spindle_line(spindle, level)
      }.join(' ')
    end

    def generate_spindle_line(spindle, level)
      if spindle.discs.length >= (max - level)
        disc = spindle.discs[level - (max - spindle.discs.length)]
        glyph = '#' * disc.size
      else
        glyph = '|'
      end
      glyph_with_padding(glyph)
    end

    def glyph_with_padding(glyph)
      padding = max - glyph.length
      padding_left = padding / 2
      padding_right = padding - padding_left
      line = ' ' * padding_left
      line << glyph
      line << ' ' * padding_right
    end
  end
end
