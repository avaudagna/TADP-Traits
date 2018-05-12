require_relative 'trait/trait'
require_relative 'trait/trait_builder'

require_relative 'class'

def init()
  Trait.define do
    name :TraitA
    method :metodo1 do
      "Hola"
    end
    method :metodo2 do |un_numero|
      un_numero * 0 + 42
    end
  end
  Trait.define do
    name :TraitA2
    method :metodo1 do
      "Chau"
    end
    method :metodo3 do |un_numero|
      un_numero * 0 + 50
    end
  end
  Trait.define do
    name :TraitB
    method :metodo3 do |un_numero|
      un_numero * 0 + 50
    end
  end
end

def trait_adding()
  non_conflict_sum(TraitA, TraitB)
  simple_conflict_sum(TraitA, TraitA2)
end

def simple_conflict_sum(one_trait, other_trait)
  one_trait + other_trait
end

def non_conflict_sum(one_trait, other_trait)
  one_trait + other_trait
end

