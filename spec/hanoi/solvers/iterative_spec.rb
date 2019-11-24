# frozen_string_literal: true

require_relative '../../../lib/hanoi/solvers/iterative'
require_relative '../../../lib/hanoi/board'

module Hanoi
  module Solvers
    RSpec.describe Iterative do
      it 'solves the puzzle for an even number of discs' do
        solver = Iterative.new(Board.new(6))
        solver.run!
        expect(solver.board).to be_finished
      end

      it 'solves the puzzle for an odd number of discs' do
        solver = Iterative.new(Board.new(5))
        solver.run!
        expect(solver.board).to be_finished
      end

      describe '#step' do
        it 'does one step of the solution' do
          solver = Iterative.new(Board.new(6))
          solver.step
          expect(solver.board.left.sizes).to eq([2, 3, 4, 5, 6])
          expect(solver.board.middle.sizes).to eq([1])
        end
      end
    end
  end
end
