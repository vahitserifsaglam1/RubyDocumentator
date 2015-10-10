require 'json'
class Documentator

  attr_accessor :path, :extensions, :theme, :output_path
  attr_reader :finded_files


  # create a new instance and register path
  # find documantation files and register it
  def initialize ()

    contents = File.read("config.json")
    parsed = JSON.parse(contents)

    prepare_class_for_build(parsed)

  end

  def prepare_class_for_build parsed
    @path = prepare_path parsed.include?('input_path') ? parsed['input_path'] : '.'
    @extensions = extensions.include?('extensions') ? self.prepare_extensions(parsed['extensions']) : ['.md']
    @finded_files = self.find_files
    @theme = parsed.include?('theme') ? parsed['theme'] : 'default'
    output = parsed.include?('output_path') ? parsed['output_path'] : 'docs'
    @output_path = self.prepare_output_path (output)

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

end

documantator = Documentator.new

p documantator