require 'rspec'
require '../lib/conflicts_chain.rb'
require '../lib/conflict.rb'


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
    conflict = Conflict.new(:method1,->(x){ puts x } )
    chain_of_conflict.conflicts = [conflict]
    expect(chain_of_conflict.exist?(conflict)).to be true
  end

  it 'debe agregar un nuevo conflicto a la bolsa de conflictos,
      exite por lo menos un conflicto con el nombre del method1' do
    chain_of_conflict = ConflictsChain.new
    conflict = Conflict.new(:method1,->(x){ puts x } )
    chain_of_conflict.add_conflict(conflict)
    expect(chain_of_conflict.exist?(conflict)).to be true
  end



end

