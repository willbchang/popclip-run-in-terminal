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
   - `Terminal → Settings → Profiles → Window → Active process name` should enabled.
   - Currently only `zsh` with/without [`figterm`](https://fig.io) are supported. It shouldn't be hard to support other shells. You need to check [run-in-terminal.applescript](https://github.com/willbchang/popclip-run-in-terminal/blob/300710e172a646313a3c863854f18b4f2e6d396e/run-in-terminal.applescript#L10). PRs are welcome!

## Installation
1. Go to [run-in-terminal.rb](./run-in-terminal.rb)
2. Select all the code.
3. Click `Install Extension "Run in Terminal"`

## LICENSE
AGPL-3.0