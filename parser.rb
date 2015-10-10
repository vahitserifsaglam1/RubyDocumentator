class Parser

  attr_accessor :name_without_extension, :page_options, :path, :aliases

  # create a new parser instance and register instance variables
  # @param [String] name
  # @param [Array] page_options
  # @param [String] path
  def initialize name, page_options, path, aliases
    @name_without_extension = name
    @page_options = page_options
    @path = path
    @aliases = aliases
  end

  #parse the file content
  def parse

  end
end