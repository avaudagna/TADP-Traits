
#Executes each of the conflicting methods in insertion order.
class EagerFifoConflictStrategy
  def solve(conflict)
    Proc.new {conflict.implementations.each do |block|
      block.call
    end}
  end
end