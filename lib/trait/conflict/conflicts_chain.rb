require_relative 'conflict'
class ConflictsChain

  attr_accessor :conflicts

  def initialize
    @conflicts = []
  end

  def conflicts
    @conflicts
  end

  def size
    @conflicts.count
  end

  def add_conflict(conflict)
    merged_conflict = conflict
    matched_conflicts = @conflicts.find_all do |some_conflict|
      !some_conflict.nil? && some_conflict.name.eql?(conflict.name)
    end
    if matched_conflicts.any? then
      @conflicts -= matched_conflicts
      merged_conflict = conflict
      matched_conflicts.each do |some_conflict|
        merged_conflict.add_implementations(some_conflict.implementations)
      end
    end
    @conflicts << merged_conflict
  end

  def merge(conflict_chain)
    conflict_chain.conflicts.each do |some_conflict|
      add_conflict some_conflict
    end
  end

  def get_conflict(method_name)
    if exist_by_name? method_name
      @conflicts.find { |conflict| conflict.name == method_name }
    end
  end

  def remove(name_method)
    @implementations.delete_if{ |element| element.name == name_method }
  end

  def exist_by_name?(method_name)
    @conflicts.any? do |conflict|
      conflict.name.eql? method_name
    end
  end

  def exist?(some_conflict)
    conflicts.any? do |conflict|
      conflict.eql? some_conflict
    end
  end
  #solver_conflict(name_method,ConflictSolver)
end