# frozen_string_literal: true

require_relative '../../../lib/hanoi/solvers/recursive'
require_relative '../../../lib/hanoi/board'

module Hanoi
  module Solvers
    RSpec.describe Recursive do
      it 'solves the puzzle for one disc' do
        solver = Recursive.new(Board.new(1))
        solver.run!
        expect(solver.board).to be_finished
      end

      it 'solves the puzzle for two discs' do
        solver = Recursive.new(Board.new(2))
        solver.run!
        expect(solver.board).to be_finished
      end

      it 'solves the puzzle for three discs' do
        solver = Recursive.new(Board.new(3))
        solver.run!
        expect(solver.board).to be_finished
      end

      it 'solves the puzzle for six discs' do
        solver = Recursive.new(Board.new(6))
        solver.run!
        expect(solver.board).to be_finished
      end

      xdescribe '#step' do
        it 'does one step of the solution' do
          solver = Recursive.new(Board.new(6))
          solver.step
          expect(solver.board.left.sizes).to eq([2, 3, 4, 5, 6])
          expect(solver.board.middle.sizes).to eq([1])
        end
      end
    end
  end
end
