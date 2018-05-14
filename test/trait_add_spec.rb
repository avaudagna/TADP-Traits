
require_relative '../lib/trait/conflict/conflict'
require_relative '../lib/trait/trait_add'
require 'rspec'

include RSpec

describe TraitAdd, '#add_implementations' do

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
    expect(TraitC.methods(false)).to be 3
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
    TraitC = TraitA + TraitB
    expect(TraitC.methods(false)).to be 2
    expect(TraitC.respond_to?(:metodo1)).to be false
    expect(TraitC.conflicts_chain.size).to be 1
    expect(TraitC.conflicts_chain.conflicts[0].implementations.size).to be 2
    expect(TraitC.respond_to?(:metodo2)).to be true
    expect(TraitC.respond_to?(:metodo3)).to be true
  end

  it 'Un Trait viene con cadena de conflictos, el otro no y entre ellos no hay conflictos' do
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
    TraitA3 = TraitA + TraitA2
    Trait.define do
      name :TraitB
      method :metodo4 do |un_numero|
        un_numero * 0 + 50
      end
    end
    TraitC = TraitA3 + TraitB
    expect(TraitC.methods(false)).to be 3
    expect(TraitC.respond_to?(:metodo1)).to be false
    expect(TraitC.conflicts_chain.size).to be 1
    expect(TraitC.conflicts_chain.conflicts[0].implementations.size).to be 2
    expect(TraitC.respond_to?(:metodo2)).to be true
    expect(TraitC.respond_to?(:metodo3)).to be true
    expect(TraitC.respond_to?(:metodo4)).to be true
  end

  it 'Ambos vienen con cadena de conflictos y no tienen conflictos entre si' do
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
    TraitA3 = TraitA + TraitA2
    Trait.define do
      name :TraitB
      method :metodo4 do |un_numero|
        un_numero * 0 + 50
      end
    end
    Trait.define do
      name :TraitB2
      method :metodo4 do |un_numero|
        un_numero * 0 + 33
      end
    end
    TraitB3 = TraitB + TraitB2
    TraitC = TraitA3 + TraitB3
    expect(TraitC.methods(false)).to be 2
    expect(TraitC.respond_to?(:metodo1)).to be false
    expect(TraitC.respond_to?(:metodo4)).to be false
    expect(TraitC.conflicts_chain.size).to be 2
    expect(TraitC.conflicts_chain.conflicts[0].implementations.size).to be 2
    expect(TraitC.conflicts_chain.conflicts[1].implementations.size).to be 2
    expect(TraitC.respond_to?(:metodo2)).to be true
    expect(TraitC.respond_to?(:metodo3)).to be true
  end

  it 'Ambos vienen con cadena de conflictos y tienen conflictos entre si' do
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
    TraitA3 = TraitA + TraitA2
    Trait.define do
      name :TraitB
      method :metodo1 do |un_numero|
        un_numero * 0 + 100
      end
      method :metodo4 do |un_numero|
        un_numero * 0 + 50
      end
    end
    Trait.define do
      name :TraitB2
      method :metodo4 do |un_numero|
        un_numero * 0 + 33
      end
    end
    TraitB3 = TraitB + TraitB2
    TraitC = TraitA3 + TraitB3
    expect(TraitC.methods(false)).to be 2
    expect(TraitC.respond_to?(:metodo1)).to be false
    expect(TraitC.respond_to?(:metodo4)).to be false
    expect(TraitC.conflicts_chain.size).to be 2
    expect(TraitC.conflicts_chain.conflicts[0].implementations.size).to be 3
    expect(TraitC.conflicts_chain.conflicts[0].implementations[0]).to be TraitB.metodo1.to_proc
    expect(TraitC.conflicts_chain.conflicts[0].implementations[1]).to be TraitA.metodo1.to_proc
    expect(TraitC.conflicts_chain.conflicts[0].implementations[2]).to be TraitA2.metodo1.to_proc
    expect(TraitC.conflicts_chain.conflicts[1].implementations.size).to be 2
    expect(TraitC.respond_to?(:metodo2)).to be true
    expect(TraitC.respond_to?(:metodo3)).to be true
  end
end

