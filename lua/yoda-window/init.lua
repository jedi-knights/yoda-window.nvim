local M = {}

local layout_manager = require("yoda-window.layout_manager")
local protection = require("yoda-window.protection")

local default_config = {
  enable_layout_management = true,
  enable_window_protection = true,
}

local config = {}
local is_setup = false

function M.setup(opts)
  if is_setup then
    vim.notify("yoda-window.nvim: setup() called multiple times", vim.log.levels.WARN)
    return
  end

  config = vim.tbl_deep_extend("force", default_config, opts or {})

  layout_manager.setup(config)
  protection.setup(config)

  if config.enable_window_protection then
    local protection_group = vim.api.nvim_create_augroup("YodaWindowProtection", { clear = true })

    vim.api.nvim_create_autocmd("BufWinEnter", {
      group = protection_group,
      desc = "Protect special windows from buffer overwrites",
      callback = function(args)
        protection.handle_buf_win_enter(args.buf)
      end,
    })

    vim.api.nvim_create_autocmd("WinClosed", {
      group = protection_group,
      desc = "Clean up window protection cache",
      callback = function(args)
        local win = tonumber(args.match)
        if win then
          protection.unprotect_window(win)
        end
      end,
    })
  end

  if config.enable_layout_management then
    local layout_group = vim.api.nvim_create_augroup("YodaWindowLayout", { clear = true })

    vim.api.nvim_create_autocmd("BufWinEnter", {
      group = layout_group,
      desc = "Ensure proper window placement with Snacks explorer and OpenCode",
      callback = function(args)
        layout_manager.handle_buf_win_enter(args.buf)
      end,
    })
  end

  is_setup = true
end

function M.get_config()
  return vim.deepcopy(config)
end

M.layout_manager = layout_manager
M.protection = protection

return M
