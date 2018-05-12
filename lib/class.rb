
require_relative 'trait/conflict/solver/default_conflict_strategy'

class Class

  attr_accessor :strategy_by_conflict

  def initialize
    #uso la instancia singleton para que no haya mil de estos.
    strategy_by_conflict = DefaultConflictStrategy.class
  end

  def uses(trait)
    class_methods_name = methods
    trait_methods = trait.methods(false)

    trait_methods.each do |trait_method_name|
      #new to the class
      if !class_methods_name.include?(trait_method_name)
        inject(trait_method_name, trait)
      end
    end
  end

  def inject(method_name, trait)
    if trait.is_conflicting? method_name
      define_method(method_name,
                    strategy_by_conflict.solve(trait.conflict(trait_method_name)))
    else
      define_method(method_name, trait.singleton_method(method_name).to_proc)
    end
  end
end