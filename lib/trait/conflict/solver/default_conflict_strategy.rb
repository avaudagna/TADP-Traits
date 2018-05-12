
# Raises a ConflictingMethodError.
class DefaultConflictStrategy

  def solve(conflict)
    ConflictingMethodError.new
  end

end

class ConflictingMethodError < StandardError

end