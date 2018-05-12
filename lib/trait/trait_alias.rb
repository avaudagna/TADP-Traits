module TraitAlias

  def <<(symbol_to_rename)
    singleton_class.send :alias_method, symbol_to_rename.final_symbol, symbol_to_rename.original_symbol
  end
end