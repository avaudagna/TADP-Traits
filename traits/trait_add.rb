module TraitAdd
  def +(other_trait)
    trait_son = Trait.new
    trait_son.conflict_methods = merge_y_flatent(self.conflict_methods, other_trait.conflict_methods)
    addAllNonConflicting(trait_son, self, other_trait)
    defineConflicting(trait_son, self, other_trait)
  end

  def defineConflicting(trait_son, traitA, traitB)
    conficting_methods = traitA & traitB
    for method_name in conficting_methods
      trait_son.send(:define_singleton_method, method_name,
                     traitB.singleton_method(conflictingMethodException).to_proc)
    end
  end

  def conflictingMethodException
    raise ConflictingMethodError.new
  end

  def addAllNonConflicting(trait_son, traitA, traitB)
    trait_b_only =  traitB.methods - traitA.methods
    trait_a_only =  traitA.methods - traitB.methods

    for method_name in trait_a_only
      trait_son.send(:define_singleton_method, method_name,
                     traitA.singleton_method(nombre_metodo).to_proc)
    end

    for method_name in trait_b_only
      trait_son.send(:define_singleton_method, method_name,
                     traitB.singleton_method(nombre_metodo).to_proc)
    end
  end

  def merge_and_flaten(map1, map2)
    map1.merge(map2) { |_k, v1, v2| [v1, v2] }
    map1.each do |key, values|
      map1[key] = values.flatten
    end
  end

end
