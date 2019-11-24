# frozen_string_literal: true

module Hanoi
  module Solvers
    # An iterative solver for the puzzle.
    class Iterative
      attr_accessor :board

      def initialize(board)
        @board = board

        @pattern = decide_pattern!
        @pattern_step = 0
      end

      def run!
        step until board.finished?
      end

      def step
        board.move!(*legal_move_for_current_pattern_step)
        increment_pattern_step!
      end

      private

      def decide_pattern!
        number_of_discs = board.left.discs.length
        @pattern =
          if number_of_discs.odd?
            [%i[left right], %i[left middle], %i[middle right]]
          else
            [%i[left middle], %i[left right], %i[middle right]]
          end
      end

      def legal_move_for_current_pattern_step
        pair = @pattern[@pattern_step]
        if board.legal_move?(*pair)
          pair
        else
          pair.reverse
        end
      end

      def increment_pattern_step!
        @pattern_step += 1
        @pattern_step = 0 if @pattern_step == 3
      end
    end
  end
end
