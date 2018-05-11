
require_relative '../lib/trait/trait'
require_relative '../lib/trait/trait_builder'
require 'rspec'

include RSpec

describe Trait, '.define' do

  it 'debe retornar un solo trait con nombre TraitA y con dos metodos
        :metodo1 y :metodo2' do
    Trait.define do
      name :TraitA
      method :method1 do
        puts 'Hello'
      end
      method :method2 do |some_number|
        some_number * 0 + 42
      end
    end
    expect(TraitA.respond_to?(:method1)).to be true
  end
end

