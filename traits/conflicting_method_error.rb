class ConflictingMethodError < StandardError
  def initialize(msg = "Metodo conflictivo")
    super(msg)
  end
end

