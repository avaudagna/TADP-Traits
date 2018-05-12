
require_relative '../lib/trait/conflict/conflict'
require 'rspec'

include RSpec

describe Conflict, '#add_implementations' do

  it 'debe agregar un nueva implementacion,
       incrementar en 1 y tener dos instancias de implementacion' do

    list_implementations = [->(x) { puts x }]
    conflict = Conflict.new(:method1, list_implementations)
    conflict.add_implementations list_implementations
    expect(conflict.implementations.size).to be 2
    expect(conflict.implementations).to eq(list_implementations.push(*list_implementations))


  end



end

