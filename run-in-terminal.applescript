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


		if (lastProcess ends with "(figterm)") then
			set ttyDevice to tty of tabInfo
			-- Get the real tty of figterm by increase the tty number
			set rubyScript to "
            tty = '" & ttyDevice & "'
            old_tty_number = tty[/\\d+$/]
            incremented_tty_number = (old_tty_number.to_i + 1).to_s.rjust(old_tty_number.length, '0')
            printf tty.sub(old_tty_number, incremented_tty_number)
            "

			do shell script "ruby -e " & quoted form of rubyScript
			set ttyDevice to the result
			-- Get the real process
			do shell script "ps -t '" & ttyDevice & "' -o command= | tail -n 1"
			set lastProcess to the result
		end if

		set defaultShell to do shell script "dscl . -read /Users/$(whoami) UserShell | sed 's/UserShell: \\/.*\\//-/'"
		if not (lastProcess ends with defaultShell or lastProcess ends with "login") then
			tell application "System Events" to keystroke "t" using command down
		end if
	end if

	-- Select current tab and run shell script
	set theTab to selected tab in first window
	do script "echo 123" in theTab
end tell
