require_relative '../lib/trait/conflict/conflicts_chain'
require_relative '../lib/trait/conflict/conflict'
require 'rspec'

include RSpec

describe ConflictsChain, '#add_conflict' do

  it 'debe agregar un nuevo conflicto a la bolsa de conflictos,
       incrementar en 1' do
    chain_of_conflict = ConflictsChain.new
    init_size = chain_of_conflict.size
    conflict = Conflict.new(:method1, [->(x) { puts x }])
    chain_of_conflict.add_conflict(conflict)
    expect(chain_of_conflict.size).to be (init_size + 1)
  end

  it 'compara sobre un chain_of_conflict si existe el conflicto inicial' do
    chain_of_conflict = ConflictsChain.new
    conflict = Conflict.new(:method1,[->(x){ puts x }] )
    chain_of_conflict.conflicts = [conflict]
    expect(chain_of_conflict.exist?(conflict)).to be true
  end

  it 'debe agregar un nuevo conflicto a la bolsa de conflictos,
      exite por lo menos un conflicto con el nombre del method1' do
    chain_of_conflict = ConflictsChain.new
    conflict = Conflict.new(:method1,[->(x){ puts x }] )
    chain_of_conflict.add_conflict(conflict)
    expect(chain_of_conflict.exist?(conflict)).to be true
  end

  it 'Se agrega una nueva implementacion al conflicto method1' do
    chain_of_conflict = ConflictsChain.new
    conflict = Conflict.new(:method1,[->(x){ puts x }] )
    conflict2 = Conflict.new(:method1,[->(x){ puts x }] )
    chain_of_conflict.add_conflict(conflict)
    chain_of_conflict.add_conflict(conflict2)
    expect(chain_of_conflict.size).to be 1
    expect(chain_of_conflict.get_conflict(:method1).implementations.size).to be 2
  end



end

