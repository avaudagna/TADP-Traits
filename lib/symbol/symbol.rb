class Symbol
  def >> (other_symbol)
    SymbolToRename.new(self, other_symbol)
  end
end

