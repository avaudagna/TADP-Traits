class Trait
  class << self
    def define(&schema)
      #Quiero que me cree una inst de Trait
      #instance = Trait.new.singleton_class
      Trait.new.instance_eval &schema
    end

    def name (nombre)
      Object.const_set(nombre,self)
    end

    def method(nombre, &estrategia)
      self.send(:define_singleton_method,
                nombre, &estrategia)
    end
  end
end