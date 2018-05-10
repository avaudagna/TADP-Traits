require_relative 'trait'
require_relative 'trait_builder'
require_relative 'class'

def init
  Trait.define do
    name :TraitA
    method :method1 do
      puts 'Hello'
    end
    method :method2 do |some_number|
      some_number * 0 + 42
    end
  end
  Trait.define do
    name :TraitB
    method :method1 do
      puts 'Bye'
    end
    method :method3 do |some_number|
      some_number * 0 + 50
    end
  end


end