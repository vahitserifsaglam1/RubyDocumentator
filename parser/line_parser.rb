class LineParser
  class << self
    attr_accessor :content
    @@charecters = %w{# >}
    @@regex = %w{}
    # parse the content and create html content
    # @param [String] content
    def parse_line content
      @content = content
      created_content = content

      @@charecters.each do |charecter|



      end
    end

    # if content contains this charecter we will find and replace it
    def find_and_replace_charecter charecter

    end

    # check regex parameter
    def regex_checker regex

    end
  end
end
