#!/usr/bin/ruby
# #popclip
# name: Run in Terminal
# icon: symbol:terminal

require 'shellwords'


def get_script(query)
  filepath = query
  # The \ in filepath has to be escaped third time so that it will actually work.
  # The first time \\\\\\\\ is in ruby string,
  # The second time \\\\ is in bash script,
  # The third time \\ is in apple script,
  # The fourth time \ is in Terminal app which will escape the special character(s).
  escaped_filepath = filepath.shellescape.gsub('\\', '\\\\\\\\')

  if File.directory?(filepath)
    "cd #{escaped_filepath}"
  else
    query.gsub(/^\s*\$\s*/, '')
  end
end

query = ARGV[0]
terminal = 'Terminal'


`osascript -e 'tell app "#{terminal}" to do script "#{get_script(query)}" activate'`
