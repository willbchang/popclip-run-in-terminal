#!/usr/bin/ruby
# #popclip
# name: Run in Terminal
# icon: symbol:terminal
# options:
# - { identifier: terminal, label: Terminal, default value: Terminal, type: string, description: "Which Terminal app do you use?" }
# - { identifier: shell, label: Shell, default value: zsh, type: string, description: "Which shell do you use?" }

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

`
osascript <<EOF
-- Get the title of the Terminal window
-- Please enable the Active process name
-- Settings → Profiles → Window → Active process name
tell application "#{ENV['POPCLIP_OPTION_TERMINAL']}"
	activate
	set frontWindow to front window
	set windowTitle to name of frontWindow

 	-- Create a new tab if the window title does not end with shell name or login, which means it has active process.
	if not (windowTitle ends with "#{ENV['POPCLIP_OPTION_SHELL']}" or windowTitle ends with "login") then
		tell application "System Events" to keystroke "t" using command down
	end if

	-- Select current tab and run shell script
	set theTab to selected tab in first window
	do script "#{get_script(ENV['POPCLIP_TEXT'])}" in theTab
end tell
EOF
`

