
#Initialized with a function, applies in folding style to
# list of conflict's implementations.
class FoldConflictStrategy

  attr_accessor :folding_function

  def initialize(folding_function)
    @folding_function = folding_function
  end

  def solve(conflict)
    conflict.implementations
        .inject(conflict.implementations[0].call) do |accumulated, implementation|
      accumulated.folding_function(implementation.call)
    end
  end
end