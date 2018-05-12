
# Raises a ConflictingMethodError.
class DefaultConflictStrategy

  def solve(conflict)
    Porc.new { ConflictingMethodError.new }
  end

end

class ConflictingMethodError < StandardError

end