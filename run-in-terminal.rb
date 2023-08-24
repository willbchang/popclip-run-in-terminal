#!/usr/bin/ruby
# #popclip
# name: Run in Terminal
# icon: symbol:terminal

require 'shellwords'

def get_filepath(query)
  space_tilde_slash = /^\s*~\//
  if query.start_with?(space_tilde_slash)
    username = `whoami`.strip
    subpath = query.sub(space_tilde_slash, '')
    "/Users/#{username}/#{subpath}"
  else
    query.gsub(/^\s*/, '')
  end
end

def get_script(query)
  filepath = get_filepath(query)
  if File.directory?(filepath)
    "cd \\\"#{filepath}\\\""
  else
    # Remove the single dollar sign in the beginning of each line.
    # Escape the " $ \ in the string.
    query.gsub(/^\s*\$\s+/, '').gsub(/(["$\\])/, '\\\\\1')
  end
end

# ARGV[0] is for testing in the Terminal
query = ARGV[0] || ENV['POPCLIP_TEXT']
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

