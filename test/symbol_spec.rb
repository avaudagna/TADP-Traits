require_relative '../lib/symbol/symbol'
require 'rspec'

include RSpec


describe Symbol, '#>>' do

  it 'Se debe crear un objeto valor , el cual tenga como simbolo original :method1' do
    symbol_to_rename = :method1 >> :cachito
    expect(symbol_to_rename.original_symbol).to be :method1
  end
  it 'Se debe crear un objeto valor , el cual tenga como simbolo final :cachito' do
    symbol_to_rename = :method1 >> :cachito
    expect(symbol_to_rename.final_symbol).to be :cachito
  end
end

