require_relative '../lib/trait/conflict/conflict'
require_relative '../lib/trait/conflict/solver/default_conflict_strategy'
require_relative '../lib/trait/conflict/solver/eager_fifo_conflict_strategy'
require 'rspec'

include RSpec

describe DefaultConflictStrategy, '#solve' do

  it 'debe agregar un nueva implementacion,
       incrementar en 1 y tener dos instancias de implementacion' do


    #DefaultConflictStrategy.new.solve(conflict)
    #expect(raise ConflictingMethodError).to raise_error
  end
end

describe EagerFifoConflictStrategy, '#solve' do

  let(:spy_instance) {Conflict.new(:hola,nil)}
  it 'Se prueba que se ejecuten las dos implementaciones de un metodo' do
    spy_instance.name


    expect(spy_instance).not_to receive(:name)
  end
end


