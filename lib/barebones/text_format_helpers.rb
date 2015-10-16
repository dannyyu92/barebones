module Barebones
  module TextFormatHelpers

    def spaces(num_spaces)
      "\s" * num_spaces
    end

    def replace_regex_in_file(file, regex, replacement)
      gsub_file file, regex do |match|
        replacement
      end
    end
    
  end
end