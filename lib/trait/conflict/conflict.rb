class Conflict

  attr_accessor :name, :implementations

  def initialize(name, implementations)
    @name = name
    @implementations = implementations
  end

  def add_implementations(new_implementations = [])
    @implementations += new_implementations
  end

  def implementations
    @implementations
  end

  def name
    @name
  end

end