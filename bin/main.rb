require 'roo'
require 'roo-xls'
require_relative '../lib/excel_parser'

# 1. Initialize the parser objects with your Excel files
test_table1  = ExcelParser.new("../test_files/ruby_test.xlsx")
test_table2 = ExcelParser.new("../test_files/test2.xlsx")

# 2. Print the entire spreadsheet matrix (as an array of arrays)
puts "--- Full Table Data ---"
p test_table1.to_s

# 3. Print the header row (Row 1)
puts "\n--- Header Row ---"
puts test_table1.row(1)

# 4. Access a column using bracket syntax
puts "\n--- Accessing 'treca_kolona' via brackets ---"
p test_table1["treca_kolona"]

# 5. Access a specific element (index 2) inside that column array
puts "\n--- Element at index 2 of 'treca_kolona' ---"
p test_table1["treca_kolona"][2]

# 6. Access a column dynamically using a method name
puts "\n--- Accessing 'prva_kolona' via dynamic method ---"
p test_table1.prva_kolona.to_s

# 7. Calculate the sum of a column dynamically
puts "\n--- Sum of 'prva_kolona' ---"
p test_table1.prva_kolona.sum

# 8. Dynamic row lookup from a column cell value
# (This looks for a cell matching "bla" in 'druga_kolona' and returns its whole row)
puts "\n--- Finding the row containing 'bla' in 'druga_kolona' ---"
p test_table1.druga_kolona.bla

# 9. Table Addition (Merges rows if headers match)
puts "\n--- Result of Addition (Table 2 + Table 1) ---"
p test_table2 + test_table1

# 10. Table Subtraction (Finds difference in rows if headers match)
puts "\n--- Result of Subtraction (Table 2 - Table 1) ---"
p test_table2 - test_table1