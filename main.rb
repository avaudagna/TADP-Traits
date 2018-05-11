require_relative 'trait'
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
    name :TraitB
    method :metodo1 do
      "Chau"
    end
    method :metodo3 do |un_numero|
      un_numero * 0 + 50
    end
  end
end