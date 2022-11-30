# frozen_string_literal: true

# Helper mixin for converting array_notation to chess_notation and vice-versa
module Conversions
  # Chess notation (A1) does not come in the same as array notation ([0, 0]). There are 2 changes:
  #   [1] In arrays, row comes first. In chess, row comes second.
  #       TO FIX: I swap the two.
  #   [2] Chess notation uses a letter for the column. Arrays do not
  #   [3] Arrays use 0-based indexing. Chess does not.
  #       TO FIX: subtract 1 from the chess notation
  #   [4] In arrays print in order. So [0, 0] will print first. In chess, a8 prints first.
  #       TO FIX: convert this
  def array_notation(chess_notation)
    # [1] Swap col and row
    col, row = chess_notation.split('')
    # [2] Convert col to number (already zero-base indexed)
    col = 'abcdefgh'.index(col.downcase)
    # [3] Convert row to zero-based indexing
    # AND
    # [4] Convert the row to print in array notation order
    row = row.to_i
    row -= 8
    row = row.abs
    # Return the chess position converted to the corresponding array position
    [row, col]
  end

  def chess_notation(array_notation)
    # [1] Pull out the row and column
    row, col = array_notation
    # [2] Convert col to a letter
    col = 'abcdefgh'[col]
    # [3] Convert row out of zero-based indexing
    # AND
    # [4] Convert the row to print in array notation order
    row = row.to_i
    row -= 8
    row = row.abs
    # Return the array position converted to the corresponding chess position
    "#{col}#{row}"
  end
end
