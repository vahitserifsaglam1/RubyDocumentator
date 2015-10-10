class Parser

  attr_accessor :name_without_extension, :page_options, :path


  # create a new parser instance and register instance variables
  def initialize name_without_extension, page_options, path
    @name_without_extension = name_without_extension
    @page_options = page_options
    @path = path
  end

  #parse your content
  def parse

  end
end