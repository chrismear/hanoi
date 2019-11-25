# frozen_string_literal: true

require_relative '../../lib/hanoi/board'
require_relative '../../lib/hanoi/printer'

module Hanoi
  RSpec.describe Printer do
    it 'prints the board' do
      board = Board.new(6)
      board.left = Spindle.new(2, 4, 6)
      board.middle = Spindle.new(3)
      board.right = Spindle.new(1, 5)

      expected = <<~OUTPUT
          |      |      |
          |      |      |
          |      |      |
          ##     |      |
         ####    |      #
        ######  ###   #####
        --------------------
      OUTPUT
      expect(Printer.new(board).print).to eq(expected.rstrip)
    end
  end
end
