module Hanoi
  class IllegalPlace < RuntimeError; end
  class IllegalTakeFromEmptySpindle < RuntimeError; end
  class InvalidSpindleKeyword < RuntimeError; end
end
