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
  `dscl . -read /Users/$(whoami) UserShell | sed 's/UserShell: \\\/.*\\\///'`.chomp
end

def increase_tyy_number(tty)
  old_tty_number = tty[/\d+$/]
  # Convert to an integer, increment, and format as a string with leading zeros
  incremented_tyy_number = (old_tty_number.to_i + 1).to_s.rjust(old_tty_number.length, '0')
  tty.sub(old_tty_number, incremented_tyy_number)
end

def get_current_process
  applescript_result = `osascript <<EOF
tell application "Terminal"
	set terminalWindow to window 1
	set tabInfo to properties of tab 1 of terminalWindow
	set processList to processes of tabInfo
	set lastProcess to (last item of processList)
	set ttyDevice to tty of tabInfo as string
  return {lastProcess, ttyDevice}
end tell
EOF`
  process, tty = applescript_result.chomp.split(', ')

  if process.end_with?('(figterm)')
    tty = increase_tyy_number(tty)
    `ps -t #{tty} -o command= | tail -n 1 `.chomp
  else
    process
  end
end

def is_active_process
  process = get_current_process
  shell = get_default_shell
  !(process.end_with?(shell) || process.end_with?('login'))
end

`
osascript <<EOF
-- Get the title of the Terminal window
-- Please enable the Active process name
-- Settings → Profiles → Window → Active process name
tell application "Terminal"
	activate
	set frontWindow to front window
	set windowTitle to name of frontWindow

 	-- Create a new tab if the window title does not end with shell name or login, which means it has active process.
	if #{is_active_process} then
		tell application "System Events" to keystroke "t" using command down
	end if

	-- Select current tab and run shell script
	set theTab to selected tab in first window
	do script "#{get_script(ENV['POPCLIP_TEXT'])}" in theTab
end tell
EOF
`

