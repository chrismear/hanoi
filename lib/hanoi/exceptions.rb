module Hanoi
  class IllegalMove < RuntimeError; end
  class IllegalPlace < IllegalMove; end
  class IllegalTakeFromEmptySpindle < IllegalMove; end
  class InvalidSpindleKeyword < RuntimeError; end
end
