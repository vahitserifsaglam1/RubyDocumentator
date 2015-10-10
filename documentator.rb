class Documentator

  attr_accessor :path, :extensions, :theme
  attr_reader :finded_files

  # create a new instance and register path
  # find documantation files and register it
  def initialize (path, extensions = nil, theme = 'default')
    @path = prepare_path path
    @extensions = extensions.nil? ? ['.md'] : self.prepare_extensions(extensions)
    @finded_files = self.find_files
    @theme = theme
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

