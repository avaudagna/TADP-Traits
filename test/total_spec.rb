require_relative '../lib/trait/trait'
require_relative '../lib/trait/trait_builder'

require 'rspec'

include RSpec

describe Trait, '#+' do
  it 'Traits sin conflictos, resultante con todos los metodos de ambos' do
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
      method :metodo3 do |un_numero|
        un_numero * 0 + 50
      end
    end
    TraitC = TraitA + TraitB
    expect(TraitC.methods(false).size).to be 3
    expect(TraitC.respond_to?(:metodo1)).to be true
    expect(TraitC.respond_to?(:metodo2)).to be true
    expect(TraitC.respond_to?(:metodo3)).to be true
  end
  it 'Traits con conflicto en 1 solo metodo' do
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
    TraitC = TraitA + TraitA2
    expect(TraitC.methods(false).size).to be 2
    expect(TraitC.respond_to?(:metodo1)).to be false
    expect(TraitC.conflicts_chain.size).to be 1
    expect(TraitC.conflicts_chain.conflicts[0].implementations.size).to be 2
    expect(TraitC.respond_to?(:metodo2)).to be true
    expect(TraitC.respond_to?(:metodo3)).to be true
  end

  it 'Un Trait viene con cadena de conflictos, el otro no y entre ellos no hay conflictos' do
    Trait.define do
      name :TraitZ
      method :metodo1 do
        "Hola"
      end
      method :metodo2 do |un_numero|
        un_numero * 0 + 42
      end
    end
    Trait.define do
      name :TraitZ2
      method :metodo1 do
        "Chau"
      end
      method :metodo3 do |un_numero|
        un_numero * 0 + 50
      end
    end
    TraitZ3 = TraitZ + TraitZ2
    Trait.define do
      name :TraitX
      method :metodo4 do |un_numero|
        un_numero * 0 + 50
      end
    end
    TraitY = TraitZ3 + TraitX
    expect(TraitY.methods(false).size).to be 3
    expect(TraitY.respond_to?(:metodo1)).to be false
    expect(TraitY.conflicts_chain.size).to be 1
    expect(TraitY.conflicts_chain.conflicts[0].implementations.size).to be 2
    expect(TraitY.respond_to?(:metodo2)).to be true
    expect(TraitY.respond_to?(:metodo3)).to be true
    expect(TraitY.respond_to?(:metodo4)).to be true
  end

  it 'Ambos vienen con cadena de conflictos y no tienen conflictos entre si' do
    Trait.define do
      name :TraitJ
      method :metodo1 do
        "Hola"
      end
      method :metodo2 do |un_numero|
        un_numero * 0 + 42
      end
    end
    Trait.define do
      name :TraitJ2
      method :metodo1 do
        "Chau"
      end
      method :metodo3 do |un_numero|
        un_numero * 0 + 50
      end
    end
    TraitJ3 = TraitJ + TraitJ2
    Trait.define do
      name :TraitK
      method :metodo4 do |un_numero|
        un_numero * 0 + 50
      end
    end
    Trait.define do
      name :TraitK2
      method :metodo4 do |un_numero|
        un_numero * 0 + 33
      end
    end
    TraitK3 = TraitK + TraitK2
    TraitL = TraitJ3 + TraitK3
    expect(TraitL.methods(false).size).to be 2
    expect(TraitL.respond_to?(:metodo1)).to be false
    expect(TraitL.respond_to?(:metodo4)).to be false
    expect(TraitL.conflicts_chain.size).to be 2
    expect(TraitL.conflicts_chain.conflicts[0].implementations.size).to be 2
    expect(TraitL.conflicts_chain.conflicts[1].implementations.size).to be 2
    expect(TraitL.respond_to?(:metodo2)).to be true
    expect(TraitL.respond_to?(:metodo3)).to be true
  end

  it 'Ambos vienen con cadena de conflictos y tienen conflictos entre si' do
    Trait.define do
      name :TraitO
      method :metodo1 do
        "Hola"
      end
      method :metodo2 do |un_numero|
        un_numero * 0 + 42
      end
    end
    Trait.define do
      name :TraitO2
      method :metodo1 do
        "Chau"
      end
      method :metodo3 do |un_numero|
        un_numero * 0 + 50
      end
    end
    TraitO3 = TraitO + TraitO2
    Trait.define do
      name :TraitP
      method :metodo1 do |un_numero|
        un_numero * 0 + 100
      end
      method :metodo4 do |un_numero|
        un_numero * 0 + 50
      end
    end
    Trait.define do
      name :TraitP2
      method :metodo4 do |un_numero|
        un_numero * 0 + 33
      end
    end
    TraitP3 = TraitP + TraitP2
    TraitQ = TraitO3 + TraitP3
    expect(TraitQ.methods(false).size).to be 2
    expect(TraitQ.respond_to?(:metodo1)).to be false
    expect(TraitQ.respond_to?(:metodo4)).to be false
    expect(TraitQ.conflicts_chain.size).to be 2
    expect(TraitQ.conflicts_chain.conflicts[0].implementations.size).to be 3
    expect(TraitQ.conflicts_chain.conflicts[0].implementations[0]).to be TraitP.metodo1.to_proc
    expect(TraitQ.conflicts_chain.conflicts[0].implementations[1]).to be TraitO.metodo1.to_proc
    expect(TraitQ.conflicts_chain.conflicts[0].implementations[2]).to be TraitO2.metodo1.to_proc
    expect(TraitQ.conflicts_chain.conflicts[1].implementations.size).to be 2
    expect(TraitQ.respond_to?(:metodo2)).to be true
    expect(TraitQ.respond_to?(:metodo3)).to be true
  end
end

