# SheetQuery

An elegant, object-oriented Ruby wrapper built on top of the `roo` gem. It simplifies spreadsheet manipulation by converting Excel columns and rows into dynamic, queryable Ruby objects, abstracting away clunky matrix arrays into native, intuitive Ruby code.

## Key Features

* **Dynamic Lookup Engine:** Leverages Ruby's `method_missing` metaprogramming to query rows instantly using cell data values as method names.
* **Table Mathematics:** Overloads `+` and `-` operators to perform set-like addition (merging data) and subtraction (finding differences) across spreadsheets.
* **Lightning-Fast Lookups:** Indexes data structures into an internal hash cache on initialization, dropping lookup times from $O(n)$ to $O(1)$.
* **Idiomatic Ruby Design:** Fully implements the `Enumerable` mixin, allowing you to use standard methods like `.map`, `.select`, and `.find` right on your spreadsheet data.

---

## Usage Examples

Below is a complete guide on how to integrate and use the `ExcelParser` and `ExcelColumn` engines.

### 1. Initializing Tables

```ruby
require './excel_parser'

# Initialize tables (automatically maps headers to index pointers)
table1 = ExcelParser.new("./ruby_test.xlsx")
table2 = ExcelParser.new("./test2.xlsx")

```

### 2. Column Access & Calculations

You can pull an array of raw column data using string/bracket notation, or invoke standard statistical calculations:

```ruby
# Get raw column contents (safely skips the header row)
p table1["third_col"]
# => ["Value1", "Value2", "Value3"]

# Grab a specific element by index inside that column
p table1["third_col"][2]

# Calculate the safe mathematical sum of a column (handles nil/empty values gracefully)
p table1.first_col.sum

```

### 3. Metaprogramming & Ghost Methods (Dynamic Querying)

Instead of searching through rows manually, call the cell value directly as a method on the column. It will instantly return the spreadsheet row it belongs to.

```ruby
# Finds the cell containing "bla" in 'second_col' and returns its full row matrix
p table1.second_col.bla
# => ["Data1", "bla", 42, "Status"]

```

### 4. Table Math Operations

Merge sheets or find discrepancies natively using math operators. Operations require the spreadsheets to share identical header schemes.

```ruby
# Table Addition: Merges rows together
puts "Result of Addition:"
p table2 + table1

# Table Subtraction: Finds missing or changed rows
puts "Result of Subtraction:"
p table2 - table1

```
