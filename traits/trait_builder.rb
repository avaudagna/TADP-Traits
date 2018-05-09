class TraitBuilder

  attr_accessor :trait

  def name (nombre)
    Object.const_set(nombre,@trait)
  end

  def method(nombre,&estrategia)
    @trait.singleton_class.send(:define_method,
                                nombre, &estrategia)
  end

  def build(&schema)
    @trait = Trait.new
    instance_eval(&schema)
  end
end
