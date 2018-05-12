# Raises a ConflictingMethodError.
class DefaultConflictStrategy

  def solve(conflict)
    Proc.new {raise ConflictingMethodError}
  end

end

class ConflictingMethodError < StandardError

end