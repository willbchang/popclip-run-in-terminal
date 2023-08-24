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
    # Remove the single dollar sign in the beginning of each line.

    query.gsub(/^\s*\$\s+/, '')
  end
end

query = ARGV[0]
terminal = 'Terminal'


`
osascript <<EOF
-- Get the title of the Terminal window
-- Please enable the Active process name
-- Settings → Profiles → Window → Active process name
tell application "#{terminal}"
	activate
	set frontWindow to front window
	set windowTitle to name of frontWindow

	-- Check if the window title does not end with "-zsh" or "▸ zsh"(figterm)
	if not (windowTitle ends with "-zsh" or windowTitle ends with "▸ zsh") then
		-- Create a new tab
		tell application "System Events" to keystroke "t" using command down
	end if

	-- Select current tab and run shell script
	set theTab to selected tab in first window
	do script "#{get_script(query)}" in theTab
end tell
EOF
`

