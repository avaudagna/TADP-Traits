class Class

  def uses(trait)
    class_methods = methods
    trait_methods = trait.singleton_methods(false)
    for m in trait_methods
      if class_methods.include?(m)
        puts m.to_s + " no fue agregado"
      else
        inject(m, trait)
      end
    end
  end

  def inject(method_name, trait)
    define_method(method_name, trait.singleton_method(method_name).to_proc)
  end
end