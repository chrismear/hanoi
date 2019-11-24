# frozen_string_literal: true

require_relative '../../lib/hanoi/spindle'

module Hanoi
  RSpec.describe Spindle do
    describe '#take!' do
      it 'removes the top disc' do
        spindle = Spindle.new(1, 3, 5)
        spindle.take!
        expect(spindle.sizes).to eq([3, 5])
      end

      it 'returns the removed disc' do
        spindle = Spindle.new(2, 3, 4)
        disc = spindle.take!
        expect(disc.size).to eq(2)
      end

      context 'when the spindle is empty' do
        let(:spindle) { Spindle.new }

        it 'raises an error' do
          expect do
            spindle.take!
          end.to raise_error(Hanoi::IllegalTakeFromEmptySpindle)
        end
      end
    end

    describe '#place!' do
      it 'adds the given disc' do
        spindle = Spindle.new(2, 3)
        disc = Disc.new(1)
        spindle.place!(disc)
        expect(spindle.sizes).to eq([1, 2, 3])
      end

      context 'when the move is illegal' do
        let(:spindle) { Spindle.new(4, 5) }
        let(:disc) { Disc.new(7) }

        it 'raises an error' do
          expect do
            spindle.place!(disc)
          end.to raise_error(Hanoi::IllegalPlace)
        end
      end
    end
  end
end
