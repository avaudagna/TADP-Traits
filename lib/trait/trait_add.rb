module TraitAdd

  def +(other)
    final_trait = Trait.new
    final_trait.merge other.conflicts_chain
    final_trait.merge conflicts_chain
    final_trait.add_all_methods_non_conflicting(self, other)
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