require 'json'
require_relative 'parser'

# class Documentator
# create your own documantation files.
# you should change config.json file
class Documentator

  attr_accessor :path, :extensions, :theme, :output_path, :aliases
  attr_reader :finded_files, :page_options


  # create a new instance and register path
  # find documantation files and register it
  def initialize ()

    contents = File.read("config.json")
    parsed = JSON.parse(contents)

    prepare_class_for_build parsed

  end


  # prepare your instance variables for building your documantation
  # @param [Array] parsed
  def prepare_class_for_build parsed

    @path = prepare_path parsed.include?('input_path') ? parsed['input_path'] : '.'
    @extensions = parsed.include?('extensions') ? self.prepare_extensions(parsed['extensions']) : ['.md']
    @finded_files = self.find_files
    @theme = parsed.include?('theme') ? parsed['theme'] : 'default'
    output = parsed.include?('output_path') ? parsed['output_path'] : 'docs'
    @output_path = self.prepare_output_path (output)
    @aliases = parsed.include?('aliases') ? parsed['aliases'] : []
    @page_options = parsed.include?('page_options') ? parsed['page_options'] : []

  end

  # if output directory is not exists create it.
  def prepare_output_path output_path
    unless File.exists?(output_path)
      Dir.mkdir(output_path)
    end
    output_path
  end

  # make your path useable
  # @param [String] path
  def prepare_path path
    if path.end_with?('/')
      path = path[0, path.length-1]
    end
    return path
  end

  # each extension must be starts with dot(.), if it is'nt find it and replace.
  # @param [Array] extension the types of files
  # @return Array
  def prepare_extensions extensions

    exts = []

    extensions.each_with_index do |extension, index|
      if !extension.start_with?('.')
        add = '.'+extension
        exts[index] = add
      else
        exts[index] = extension
      end
    end
    return exts
  end

  # find files with registered extension and path and return response
  def find_files
    paths = []
    files = []
    @extensions.each_with_index do |extension, index|
      paths[index] = "#{@path}/*#{extension}"
    end
    paths.each_with_index do |path, index|
      finded = Dir[path]
      if finded.length > 0
        files[index] = finded
      end
    end
    return files
  end

  # start to parse files
  def start_parsing
    raise Exception, 'You must have a file to parse' if @finded_files.length < 1

    parsed = []

    @finded_files.each do |file, index|
      name_without_extension = File.basename(file, '.*')
      name_with_extension = File.basename file
      parser = Parser.new(name_without_extension, @page_options, file)
      parsed[index] = parser.parse
    end

  end
end

documantator = Documentator.new

