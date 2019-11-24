# frozen_string_literal: true

require_relative '../../lib/hanoi/board'
require_relative '../../lib/hanoi/game'

module Hanoi
  RSpec.describe Game do
    it 'can be started' do
      expect do
        Game.new(6)
      end.not_to raise_error
    end

    it 'passes moves to the board' do
      board = instance_double(Board, move!: nil)
      allow(Board).to receive(:new).and_return(board)
      game = Game.new(6)
      game.move(:left, :middle)
      expect(board).to have_received(:move!).with(:left, :middle)
    end

    it 'passes #finished? to the board' do
      board = instance_double(Board, finished?: true)
      allow(Board).to receive(:new).and_return(board)
      game = Game.new(6)
      expect(game).to be_finished
      expect(board).to have_received(:finished?)
    end
  end
end
