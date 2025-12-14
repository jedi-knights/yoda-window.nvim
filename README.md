# yoda-window.nvim

Window management utilities for Neovim. Provides window layout management and protection for special buffers (explorer, OpenCode, etc.).

## Features

- **Window Protection**: Prevents regular files from overwriting special windows (explorer, OpenCode, trouble, etc.)
- **Layout Management**: Ensures files open in appropriate editing windows, not in protected sidebars
- **Automatic Redirection**: Intelligently redirects buffers to the correct window based on buffer type

## Installation

### Using [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
{
  "jedi-knights/yoda-window.nvim",
  config = function()
    require("yoda-window").setup()
  end,
}
```

### Using [packer.nvim](https://github.com/wbthomason/packer.nvim)

```lua
use {
  "jedi-knights/yoda-window.nvim",
  config = function()
    require("yoda-window").setup()
  end,
}
```

## Configuration

Default configuration:

```lua
require("yoda-window").setup({
  enable_layout_management = true,
  enable_window_protection = true,
})
```

### Options

- `enable_layout_management` (boolean): Enable layout management for multi-pane setups. Default: `true`
- `enable_window_protection` (boolean): Enable protection for special windows. Default: `true`

## Usage

Once setup is called, the plugin automatically manages windows through autocommands.

### Manual API Access

```lua
local yoda_window = require("yoda-window")

-- Access layout manager functions
yoda_window.layout_manager.handle_buf_win_enter(buf)

-- Access protection functions
yoda_window.protection.protect_window(win, "explorer")
yoda_window.protection.unprotect_window(win)
yoda_window.protection.is_buffer_switch_allowed(win, buf)

-- Access window utilities
local utils = require("yoda-window.utils")
local win, buf = utils.find_snacks_explorer()
local win, buf = utils.find_opencode()
local win, buf = utils.find_by_filetype("lua")
```

## Protected Buffer Types

The following buffer types are automatically protected:

- `snacks-explorer` - Snacks file explorer
- `opencode` - OpenCode buffers
- `alpha` - Alpha dashboard
- `trouble` - Trouble diagnostics window
- `aerial` - Aerial code outline

## Development

### Running Tests

```bash
make test
```

### Linting

```bash
make lint
```

### Formatting

```bash
make format
```

## License

MIT
