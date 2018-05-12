require_relative '../lib/trait/trait_remove'
require_relative 'trait_spec'
require 'rspec'

include RSpec

describe TraitRemove, '#-' do

  it 'debe generar una copia del trait el cual no contiene el metodo cuyo nombre es enviado por parametro,
       el mismo existe en el trait base' do
    define_trait
    TraitA - :method1
    expect(TraitA.respond_to?(:method1)).to be true
  end
  it 'debe generar una copia del trait el cual no contiene el metodo cuyo nombre es enviado por parametro,
       el mismo NO existe en el trait base' do
    define_trait
    TraitA - :method4
    expect(TraitA.respond_to?(:method4)).to be false
  end

end

