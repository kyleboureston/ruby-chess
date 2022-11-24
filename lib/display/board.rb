# frozen_string_literal: true

# namespace for everthing displayed to user
module Display
  # mixin for displaying the board itself
  module Board
    def display
      @data.each.with_index do |row, row_index|
        row.each.with_index do |cell, cell_index|
          char = cell.char unless cell.nil?
          cell.nil? ? print_blank(row_index, cell_index) : print_char(row_index, cell_index, char)
        end
        puts
      end
    end

    private

    def print_char(row_index, cell_index, char)
      if row_index.odd?
        print cell_index.odd? ? " #{char} ".bg_black : " #{char} ".bg_white
      else
        print cell_index.even? ? " #{char} ".bg_black : " #{char} ".bg_white
      end
    end

    def print_blank(row_index, cell_index)
      if row_index.odd?
        print cell_index.odd? ? '   '.bg_black : '   '.bg_white
      else
        print cell_index.even? ? '   '.bg_black : '   '.bg_white
      end
    end
  end
end
