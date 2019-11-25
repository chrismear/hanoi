# frozen_string_literal: true

require_relative '../printer'

module Hanoi
  module Solvers
    # A recursive solver for the puzzle.
    class Recursive
      SPINDLE_NAMES = %i[left middle right].freeze

      attr_accessor :board, :focus_disc_size, :target

      def initialize(board, target = :right)
        @board = board
        @target = target
        @focus_disc_size = max
        @pending_moves = []
      end

      def run!
        step until finished?
      end

      def next_move
        return next_pending_move if @pending_moves.any?

        if focus_disc_is_available? && target_is_available?
          return [focus_disc_location, target]
        end

        if focus_disc_solved?
          prepare_moves_to_solve_next_disc
        else
          prepare_moves_to_shift_tower
        end
        next_pending_move
      end

      def step
        cached_move = next_move
        board.move!(*cached_move)
        cached_move
      end

      def move_list
        list = []
        list << step until finished?
        list
      end

      private

      def focus_disc_solved?
        board.send(target).sizes.include?(focus_disc_size)
      end

      def next_pending_move
        @pending_moves.shift
      end

      def focus_disc_is_available?
        board.send(focus_disc_location).sizes[0] == focus_disc_size
      end

      def target_is_available?
        board.send(target).sizes.reject { |s| s > focus_disc_size }.empty?
      end

      def prepare_moves_to_shift_tower
        free_spindle = (SPINDLE_NAMES - [focus_disc_location, target])[0]
        @pending_moves =
          Recursive.new(reduced_board, free_spindle).move_list
      end

      def prepare_moves_to_solve_next_disc
        @pending_moves = Recursive.new(reduced_board, target).move_list
        @focus_disc_size -= 1
      end

      def max
        (board.left.sizes + board.middle.sizes + board.right.sizes).max
      end

      def finished?
        board.send(target).sizes == 1.upto(max).to_a
      end

      def reduced_board
        new_board = Board.new(0)
        SPINDLE_NAMES.each do |spindle_name|
          new_board.send(
            "#{spindle_name}=",
            Spindle.new(
              *board.send(spindle_name).sizes.reject { |s|
                s >= focus_disc_size
              }
            )
          )
        end
        new_board
      end

      def focus_disc_location
        SPINDLE_NAMES.each do |spindle_name|
          if board.send(spindle_name).sizes.include?(focus_disc_size)
            return spindle_name
          end
        end
      end
    end
  end
end
