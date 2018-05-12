require_relative '../lib/trait/trait'
require_relative 'trait_spec'
require_relative '../lib/symbol/symbol'

require 'rspec'

include RSpec

describe TraitAlias, '#<<' do

  it 'debe copiar la implementación del metodo "method1" en otro metodo llamado "cachito"' do
    define_trait
    symbol_to_rename = SymbolToRename.new(:method1,:cachito)
    TraitA <<(symbol_to_rename)
    #Que es menos feo , 2 expect o dividirlo en dos test
    expect(TraitA.respond_to?(:cachito)).to be true
    expect(TraitA.respond_to?(:method1)).to be true
  end


  it 'debe copiar la implementación del metodo "method1" en otro metodo llamado "cachito",
      INTEGRACION con metodo >> de symbol' do
    define_trait
    TraitA <<(:method1 >> :cachito)
    #Que es menos feo , 2 expect o dividirlo en dos test
    expect(TraitA.respond_to?(:cachito)).to be true
    expect(TraitA.respond_to?(:method1)).to be true
  end
end
