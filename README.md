# emoji_picker-nvim

## Demo
https://user-images.githubusercontent.com/87934749/185742547-6f7c73d9-1998-47a2-ac83-64233ec252c4.mp4

## *But why??*
There are already many other emoji/icon picker plugins such as [telescope-emoji.nvim](https://github.com/xiyaowong/telescope-emoji.nvim), [icon-picker.nvim](https://github.com/ziontee113/icon-picker.nvim) or even [cmp-emoji](https://github.com/hrsh7th/cmp-emoji) which offers way more features like fuzzy searching.
However, I just wanted a quick and dirty way to have the emojis displayed in a grid and select one, similar to phone keyboards.

## Installation
### Using [packer](https://github.com/wbthomason/packer.nvim)
```lua
use({
  "WilsonOh/emoji_picker-nvim",
  config = function()
    require("emoji_picker").setup()
  end,
})
```

## Usage
### Invocation
This plugin does not set any keymaps. The plugin can be called using the `EmojiPicker` ex-command or `require("emoji_picker").open_win()` in lua.
### Navigation and selecting
Within the emoji picker window, press `q` or `esc` to close out of the window. Use the usual navigation keys to move around in the window (`Tab` and `Shift-Tab` are set to move right and left in the window) and press `Enter` to select an emoji.

## Configuration
### Default configuration
```lua
local config = {
  window = {
    relative = "cursor",
    row = 1,
    col = 1,
    width = 20,
    height = 6,
    anchor = "SW",
    style = "minimal",
    border = "rounded",
  },
  emoji_list = require("emoji_picker.emojis"),
}
```
The default list of emojis is very limited as I didn't want to add too many, but a custom list of emojis can be passed into the setup function. All the arguments required for `vim.api.open_win` can also be modified through the `window` key in the setup function.
e.g.
```lua
require("emoji_picker").setup({
  window = {
    width = 25,
    height = 10,
  },
  emoji_list = {
    "*my custom*",
    "*lines of emojis*",
  },
})
```
