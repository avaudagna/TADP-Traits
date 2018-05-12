module TraitAdd

  def +(other)
    final_trait = Trait.new
    final_trait.merge_conflict_chain other.conflicts_chain
    final_trait.merge_conflict_chain conflicts_chain
    final_trait.add_all_methods_non_conflicting(self)
    final_trait.add_all_methods_non_conflicting(other)
    final_trait
  end

  def add_all_methods_non_conflicting(other_trait)
    add_methods_non_conflicting_left_join(other_trait)
  end

  def add_methods_non_conflicting_left_join(other_trait)
    other_trait_methods_only = other_trait.methods - self.methods
    other_trait_methods_only.each do |method_name|
      send(:define_singleton_method, method_name,
           other_trait.singleton_method(method_name).to_proc)
    end
  end
end