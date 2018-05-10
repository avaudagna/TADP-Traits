class Class

  attr_accessor :strategy_by_conflict

  def uses(trait)
    class_methods_name = methods
    trait_methods = trait.methods(false)

    trait_methods.each do |trait_method_name|
      if class_methods_name.include?(trait_method_name)
        # Se encuentra un conflicto de un metodo con el trait reducido
        conflict = Conflict.new(trait_method_name, singleton_method(trait_method_name).to_proc)
        trait.add_conflicting_method(conflict)
      else
        inject(trait_method_name, trait)
      end
      # Resolver conflicto por metodo
      strategy_by_conflict.call(trait_method_name)
    end
  end

  def inject(method_name, trait)
    define_method(method_name, trait.singleton_method(method_name).to_proc)
  end
end