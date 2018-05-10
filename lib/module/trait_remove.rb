module TraitRemove

  def -(deleted_method_name)
    final_trait = Trait.new
    clean_methods = methods(false)
    clean_methods.delete(deleted_method_name)
    clean_methods.each do |method_name|
      final_trait.send(:define_singleton_method, method_name, singleton_method(method_name).to_proc)
    end
  end

end