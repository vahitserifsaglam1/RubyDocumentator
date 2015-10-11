require_relative 'parser/line_parser'
class Parser

  attr_accessor :name_without_extension, :page_options, :path, :aliases, :headers
  attr_reader :parsed

  # create a new parser instance and register instance variables
  # @param [String] name
  # @param [Array] page_options
  # @param [String] path
  def initialize name, page_options, path, aliases
    @@headers = []
    @name_without_extension = name
    @page_options = page_options
    @path = path
    @aliases = aliases
    @parsed = []
  end

  #parse the file content
  def parse

    File.readlines(@path).each do |line|
      parsed_new = LineParser.parse_line(line)
      parsed.push(parsed_new)
    end
  end
end
