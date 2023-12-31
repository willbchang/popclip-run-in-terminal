set home to POSIX path of (path to home folder)
set folderPath to home & "Library/Application Support/PopClip/Extensions/RunInTerminal.popclipext"

tell application "Terminal"
	activate
	-- If there are no open windows, open one.
	if (count of windows) is less than 1 then
		do script ""
	else
		-- Get the last process from current tab.
		set terminalWindow to window 1
		set tabInfo to properties of tab 1 of terminalWindow
		set processList to processes of tabInfo
		set lastProcess to (last item of processList)

		-- Get the last process from the next tty if using figterm
		if (lastProcess ends with "(figterm)") then
			set ttyDevice to tty of tabInfo
			set rubyScriptPath to folderPath & "/shell_process.rb"
			do shell script "ruby " & quoted form of rubyScriptPath & " " & quoted form of ttyDevice
			set lastProcess to the result
		end if

		-- Create a new tab if current tab has active process.
		set defaultShell to do shell script "dscl . -read /Users/$(whoami) UserShell | sed 's/UserShell: \\/.*\\//-/'"
		if not (lastProcess ends with defaultShell or lastProcess ends with "login") then
			tell application "System Events" to keystroke "t" using command down
		end if
	end if


	-- Create temp file for writing the text
	set tempFilePath to POSIX path of (do shell script "mktemp")
	set fileHandle to open for access tempFilePath with write permission
	write "{popclip text}" to fileHandle
	close access fileHandle

	-- Format the command from the file content
	-- This way can avoid escaping special characters
	set rubyScriptPath to folderPath & "/format_command.rb"
	do shell script "ruby " & quoted form of rubyScriptPath & " " & quoted form of tempFilePath

	-- Select current tab and run shell script
	set theTab to selected tab in first window
	set fileContents to read POSIX file tempFilePath
	do script fileContents in theTab
	do shell script "rm " & quoted form of tempFilePath
end tell
