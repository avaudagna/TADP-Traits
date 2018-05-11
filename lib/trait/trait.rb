
require_relative 'trait_add'
require_relative 'trait_remove'
require_relative 'conflict/conflict'
require_relative 'conflict/conflicts_chain'

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

  def is_conflicting?(method_name)
    @conflicts_chain.exist_by_name?(method_name)
  end

  def conflict(method_name)
    @conflicts_chain.get_conflict(method_name)
  end
end