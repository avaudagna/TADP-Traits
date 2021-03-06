class Conflict

  attr_accessor :name, :implementations

  def initialize(name, implementations)
    @name = name
    @implementations = implementations
  end

  def add_implementations(new_implementations = [])
    @implementations.push(*new_implementations)
  end

end