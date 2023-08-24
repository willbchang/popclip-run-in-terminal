-- Get the title of the Terminal window
-- Please enable the Active process name
-- Settings → Profiles → Window → Active process name 
tell application "Terminal"
	activate
	set frontWindow to front window
	set windowTitle to name of frontWindow

	-- Check if the window title does not end with "-zsh" or "▸ zsh"(figterm)
	if not (windowTitle ends with "-zsh" or windowTitle ends with "▸ zsh") then
	 
	end if

end tell
