
require_relative '../lib/trait/trait'
require_relative '../lib/trait/trait_builder'
require 'rspec'

include RSpec

def define_trait
  Trait.define do
    name :TraitA
    method :method1 do
      puts 'Hello'
    end
    method :method2 do |some_number|
      some_number * 0 + 42
    end
  end
end

describe Trait, '.define' do

  it 'Se crea un trait por medio de un bloque , el mismo debe contener el metodo "method2"' do
    define_trait
    expect(TraitA.respond_to?(:method2)).to be true
  end

  it 'Se crea un trait por medio de un bloque , el mismo debe contener el metodo "method1"' do
    define_trait
    expect(TraitA.respond_to?(:method1)).to be true
  end

  it 'Se crea un trait por medio de un bloque , el trait debe ser referenciado por la variable "TraitA"' do
    define_trait
    expect(TraitA).not_to be_nil
  end
end

