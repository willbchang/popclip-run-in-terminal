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
		set defaultShell to do shell script "dscl . -read /Users/$(whoami) UserShell | sed 's/UserShell: \\/.*\\//-/'"
		if not (lastProcess ends with defaultShell or lastProcess ends with "login") then
			tell application "System Events" to keystroke "t" using command down
		end if
	end if

	-- Select current tab and run shell script
	set theTab to selected tab in first window
	do script "echo 123" in theTab
end tell
