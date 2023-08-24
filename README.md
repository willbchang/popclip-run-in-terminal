# PopClip Run in Terminal
An improved PopClip extension to run selected text in Terminal.
This project is derived from [willbchang/alfred-run-in-terminal](https://github.com/willbchang/alfred-run-in-terminal)

TODO: Add Video intro.

## Features
1. Auto detect whether current selected text is a filepath and run `cd` if it is.
   - `~` will be auto expanded to `/Users/$(whoami)` for checking the filepath.
   - Spaces before filepath will be removed in order to use `cd`.
   ```bash
   ~/Library/Application Support/
   ```
2. Auto remove the solo `$` in the beginning of lines.
   - Some bash code snippets always prefix with `$`, it's annoying when copy and running them.
   ```bash
   $ temp=$(mktemp)
   $ echo "$temp"
   $ rm "$temp"
   $(whoami)
   ```
3. Auto detect whether current Terminal tab is running command, it will open a new tab if current tab has active process.
   - **`Terminal → Settings → Profiles → Window → Active process name` should be enabled.**
   - Tested with `zsh`, `bash` and `fish`.

iTerm.app is not supported, the AppleScript that Terminal.app uses is not compatible with iTerm.app, pull requests are welcome for iTerm.app or other terminal emulators.

## Installation
1. Go to [run-in-terminal.rb](./run-in-terminal.rb)
2. Select all the code.
3. Use the PopClip's keyboard shortcut to call it if you selected via <kbd>Command</kbd> + <kbd>A</kbd> 
4. Click `Install Extension "Run in Terminal"`

## LICENSE
AGPL-3.0