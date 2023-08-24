# PopClip Run in Terminal
An improved PopClip extension to run selected text in Terminal.

## Features
1. Auto detected whether current selected text is a directory and run `cd` if it is.
   ```bash
   ~/Library/Application Support/
   ```
2. Auto remove the solo `$` in the beginning of lines. Some bash code snippets always prefix with `$`, it's annoying when copy and running them.
   ```bash
   $ temp=$(mktemp)
   $ echo "$temp"
   $ rm "$temp"
   $(whoami)
   ```
3. Auto detect whether current Terminal tab is running command, it will open a new tab if current tab has active process.
   **`Terminal → Settings → Profiles → Window → Active process name` should be enabled.**
## Installation
1. Go to [run-in-terminal.rb](./run-in-terminal.rb)
2. Select all the code.
3. Click `Install Extension "Run in Terminal"`

## LICENSE
AGPL-3.0