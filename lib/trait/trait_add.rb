module TraitAdd
  def +(other)
    final_trait = Trait.new
    final_trait.merge_conflict_chain other.conflicts_chain
    final_trait.merge_conflict_chain conflicts_chain
    final_trait.add_all_conflicting_methods(self, other)
    final_trait.add_all_non_conflicting_methods_left_join(self, other)
    final_trait.add_all_non_conflicting_methods_left_join(other, self)
    final_trait
  end

  def add_all_conflicting_methods(one_trait, other_trait)
    conflicting_methods = other_trait.methods(false) & one_trait.methods(false)
    conflicting_methods.each do |method_name|
      conflicts_chain.add_conflict(Conflict.new(method_name,
                  [one_trait.method(method_name).to_proc, other_trait.method(method_name).to_proc]))
    end
  end

  def add_all_non_conflicting_methods_left_join(one_trait, other_trait)
    other_trait_methods_only = other_trait.methods(false) - one_trait.methods(false)
    other_trait_methods_only.each do |method_name|
      send(:define_singleton_method, method_name,
           other_trait.singleton_method(method_name).to_proc)
    end
  end
end