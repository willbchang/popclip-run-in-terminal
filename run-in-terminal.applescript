-- Get the title of the Terminal window
-- Please enable the Active process name
-- Settings → Profiles → Window → Active process name 
tell application "Terminal"
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
	do script "echo 123" in theTab
end tell
