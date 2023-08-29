# PopClip Run in Terminal
An improved PopClip extension to run selected text in Terminal.
This project is derived from [willbchang/alfred-run-in-terminal](https://github.com/willbchang/alfred-run-in-terminal)

## Installation
1. Go to [release page](https://github.com/willbchang/popclip-run-in-terminal/releases/latest)
2. Download and unzip `RunInTerminal.zip`.
3. Double click `RunInTerminal.popclipextz` to install.

## Features
1. Auto-detect whether current selected text is a filepath and run `cd` if it is.
   - `~` will be auto expanded to `/Users/USER_NAME` for checking the filepath.
   - Spaces before filepath will be removed in order to use `cd`.
   
   Input:
   ```bash
   ~/Library/Application Support/
   ```
   Output:
   ```bash
   cd "/Users/USER_NAME/Library/Application Support/" 
   ```
2. Auto remove the solo `$` in the beginning of lines.
   - Some bash code snippets always prefix with `$`, it's annoying when copy and running them.
   - It won't affect the bash argument, only the `$` with space will be removed, regex: `/^\s*\$\s+/`
   
   Input:
   ```bash
   $ temp=$(mktemp)
     $ echo "$temp"
   $ rm "$temp"
   $(whoami)
   ```
   Output:
   ```bash
   temp=$(mktemp)
   echo "$temp"
   rm "$temp"
   $(whoami) 
   ```
3. Auto-detect whether current Terminal tab is running command, it will open a new tab if current tab has active process.
   - Tested with `zsh`, `bash` and `fish`.
   - Support [figterm](https://fig.io).
4. It won't mess up with escaping characters even though this extension uses `ruby`, `applescript` and `shell script` together.

   Input:
   ```bash
   variable="This is a \$10 \"quote\""
   echo $variable
   ```
   Output:
   ```bash
   variable="This is a \$10 \"quote\""
   echo $variable
   ```

Only **Terminal.app** is supported, the AppleScript that Terminal.app uses is not compatible with iTerm.app, pull requests are welcome for iTerm.app or other terminal emulators.



## LICENSE
AGPL-3.0
