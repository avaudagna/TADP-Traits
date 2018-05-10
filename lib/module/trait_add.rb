module TraitAdd

  def +(other)
    final_trait = Trait.new
    #Suplanta a : trait_son.conflict_methods = merge_y_flatent(self.conflicts_chain, other_trait.conflicts_chain)
    final_trait.merge other.conflicts_chain
    final_trait.merge conflicts_chain
    #FIXME Revisar quien deberia ser argumento y quien objeto que manda mensaje
    final_trait.add_all_methods_non_conflicting(self, other)

   #defineConflicting(trait_son, self, other_trait)
  end

  #TODO Reveer objetivo de método
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

  def add_all_methods_non_conflicting(some_trait, other_trait)
    add_methods_non_conflicting_left_join(some_trait, other_trait)
    add_methods_non_conflicting_left_join(other_trait, some_trait)
  end

  private

  def add_methods_non_conflicting_left_join(some_trait, other_trait)
    method_some_trait_only = some_trait.methods - other_trait.methods
    method_some_trait_only.each do |method_name|
      send(:define_singleton_method, method_name,
           some_trait.singleton_method(method_name).to_proc)
    end
  end



end