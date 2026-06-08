require 'roo'

class ExcelColumn
  include Enumerable

  attr_reader :column, :table, :col_index

  def initialize(column, table, col_index)
    @column = column
    @table = table
    @col_index = col_index
    build_row_lookup_cache
  end

  def each(&block)
    @column.each(&block)
  end

  def sum
    @column.compact.inject(0){ |sum, x| sum + x.to_f }
  end

  def avg
    return 0 if @column.empty?
    sum / @column.size.to_f
  end

  def to_s
    @column.to_s
  end

  def method_missing(m, *args, &block)
    normalized_method = normalize_string(m)
    if @row_lookup_cache.key?(normalized_method)
      @table.row(@row_lookup_cache[normalized_method])
    else
      super
    end
  end

  def respond_to_missing?(method_name, include_private = false)
    @row_lookup_cache.key?(normalize_string(method_name)) || super
  end

  private

  def build_row_lookup_cache
    @row_lookup_cache = {}
    @column.each_with_index do |cell_value, i|
      next if cell_value.nil?
      key = normalize_string(cell_value)
      @row_lookup_cache[key] ||= (i + 2)
    end
  end

  def normalize_string(value)
    value.to_s.downcase.gsub(/\s+/, '_')
  end
end