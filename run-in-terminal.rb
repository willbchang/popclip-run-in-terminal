#!/usr/bin/ruby
# #popclip
# name: Run in Terminal
# icon: symbol:terminal

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

# https://stackoverflow.com/a/41553295/5520270
def get_default_shell
  `dscl . -read /Users/$(whoami) UserShell | sed 's/UserShell: \\\/.*\\\//-/'`.chomp
end


`osascript <<EOF
tell application "Terminal"
	activate
	-- If there are no open windows, open one.
	if (count of windows) is less than 1 then
		do script ""
	else
		-- Create a new tab if it has active process.
		set terminalWindow to window 1
		set tabInfo to properties of tab 1 of terminalWindow
		set processList to processes of tabInfo
		set lastProcess to (last item of processList)
		if not (lastProcess ends with "#{get_default_shell}" or lastProcess ends with "login") then
			tell application "System Events" to keystroke "t" using command down
		end if
	end if

	-- Select current tab and run shell script
	set theTab to selected tab in first window
	do script "#{get_script(ARGV[0] || ENV['POPCLIP_TEXT'])}" in theTab
end tell
EOF
`

