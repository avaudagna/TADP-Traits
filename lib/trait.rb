require '../lib/module/trait_add'
require '../lib/module/trait_remove'
require '../lib/conflicts_chain'

class Trait

  include TraitAdd
  include TraitRemove

  attr_accessor :conflicts_chain

  def initialize
    @conflicts_chain = ConflictsChain.new
  end

  def add_conflicting_method(conflict)
    @conflicts_chain.add_conflict conflict
  end

  def self.define(&schema)
    TraitBuilder.new.build(&schema)
  end

end