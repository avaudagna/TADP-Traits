class SymbolToRename
#Value Obj :(
  attr_accessor :original_symbol
  attr_accessor :final_symbol

  def initialize(original_symbol, final_symbol)
    @original_symbol = original_symbol
    @final_symbol = final_symbol
  end
end