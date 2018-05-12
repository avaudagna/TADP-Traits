
#Based on a condition, returns the first matching implementation.
class PredicateConflictStrategy

  attr_accessor :evaluator

  #evaluator has form: { |n| apply_condition(n) }
  def initialize(evaluator)
    evaluator = evaluator
  end

  def solve(conflcit)
    Proc.new {conflcit.implementations.detect do |implementation|
      evaluator.call(implementation)
    end}
  end
end