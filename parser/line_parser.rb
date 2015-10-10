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
         if finded = self.find_and_replace_charecter(charecter)
            created_content = finded
         elsif regex_findex = self.check_regex(charecter)
           created_content = regex_findex
         end
      end
    end

    # if content contains this charecter we will find and replace it
    def find_and_replace_charecter charecter

    end
  end
end
