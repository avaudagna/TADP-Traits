class Trait

  include TraitAdd

  def initialize()
    @conflicting_methods = Hash.new
  end
  
  def conflicting_methods
    @conflicting_methods
  end

  def self.define(&schema)
    TraitBuilder.new.build(&schema)
  end

end