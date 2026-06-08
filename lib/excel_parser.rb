require 'roo'
require 'roo-xls'
require_relative 'excel_column'

class ExcelParser
  include Enumerable

  attr_reader :table

  def initialize(path)
    @table = Roo::Spreadsheet.open(path, expand_merged_ranges: true)
    @columns = {}
    build_column_index_cache
  end

  def +(other_parser)
    return unless headers_match?(other_parser)
    @table.parse + other_parser.table.parse
  end

  def -(other_parser)
    return unless headers_match?(other_parser)
    @table.parse - other_parser.table.parse
  end

  def [](key)
    normalized_key = normalize_string(key)
    col_idx = @columns[normalized_key]
    return nil unless col_idx
    @table.column(col_idx).drop(1)
  end

  def method_missing(header_name)
    normalized_key = normalize_string(header_name)
    col_idx = @columns[normalized_key]

    if col_idx
      # Fixed the 'Col.new' bug to use 'ExcelColumn'
      ExcelColumn.new(@table.column(col_idx).drop(1), @table, col_idx)
    else
      super
    end
  end

  def row(num)
    @table.row(num)
  end

  def each(&block)
    @table.parse.drop(1).each(&block)
  end

  def to_s
    @table.parse.to_s
  end

  private

  def headers_match?(other_parser)
    @table.row(1) == other_parser.table.row(1)
  end

  def build_column_index_cache
    @table.row(1).each_with_index do |header, i|
      next if header.nil?
      @columns[normalize_string(header)] = i + 1
    end
  end

  def normalize_string(val)
    val.to_s.downcase.strip.gsub(/\s+/, '_')
  end
end