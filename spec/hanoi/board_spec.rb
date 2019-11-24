# frozen_string_literal: true

require_relative '../../lib/hanoi/board'
require_relative '../../lib/hanoi/disc'
require_relative '../../lib/hanoi/spindle'

module Hanoi
  RSpec.describe Board do
    it 'sets up the board' do
      board = Board.new(6)
      expect(board.left.sizes).to eq([1, 2, 3, 4, 5, 6])
      expect(board.middle.sizes).to be_empty
      expect(board.right.sizes).to be_empty
    end

    it 'accepts a move' do
      disc_one = instance_double(Disc)
      left = instance_double(Spindle, take!: disc_one, place!: nil)
      right = instance_double(Spindle, place!: nil)
      allow(Spindle).to receive(:new).and_return(left, nil, right)
      board = Board.new(6)
      board.move!(:left, :right)
      expect(left).to have_received(:take!)
      expect(right).to have_received(:place!).with(disc_one)
    end

    it 'raises an error when an illegal spindle keyword is passed' do
      board = Board.new(6)
      expect do
        board.move!(:left, :gorilla)
      end.to raise_error(Hanoi::InvalidSpindleKeyword)
    end

    describe '#finished?' do
      it 'returns true for the finished state' do
        board = Board.new(6)
        board.left = Spindle.new
        board.middle = Spindle.new
        board.right = Spindle.new(1, 2, 3, 4, 5, 6)
        expect(board.finished?).to be true
      end

      it 'returns false for an unfinished state' do
        board = Board.new(6)
        expect(board.finished?).to be false
      end
    end
  end
end
