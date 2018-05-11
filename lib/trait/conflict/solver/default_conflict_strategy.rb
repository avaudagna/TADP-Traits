module DefaultConflictStrategy

  def solve(method_name, implementations)
    conflictingMethodException
  end

  def conflictingMethodException
    raise ConflictingMethodError.new
  end
end