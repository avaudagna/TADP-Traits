
class TraitBuilder

  attr_accessor :trait

  def name(name)
    Object.const_set(name, @trait)
  end

  def method(name_method, &strategy_method)
    @trait.singleton_class.send(:define_method,
                                name_method, &strategy_method)
  end

  def build(&schema)
    @trait = Trait.new
    instance_eval(&schema)
  end


end