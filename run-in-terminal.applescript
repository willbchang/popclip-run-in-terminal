-- Get the title of the Terminal window
-- Please enable the Active process name
-- Settings → Profiles → Window → Active process name 
tell application "Terminal"
	activate
	set frontWindow to front window
	set windowTitle to name of frontWindow
end tell
