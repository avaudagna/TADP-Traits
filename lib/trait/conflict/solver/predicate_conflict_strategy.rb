
#Based on a condition, returns the first matching implementation.
class PredicateConflictStrategy

  attr_accessor :evaluator

  #evaluator has form: { |n| apply_condition(n) }
  def initialize(evaluator)
    evaluator = evaluator
  end

  def solve(conflcit)
    conflcit.implementations.detect do |implementation|
      evaluator.call(implementation)
    end
  end
end