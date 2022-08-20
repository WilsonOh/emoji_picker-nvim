local M = {}

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
  emoji_list = require("emoji_picker-nvim.emojis"),
}

local get_char_at_cursor = function()
  return vim.fn.strcharpart(vim.fn.strpart(vim.fn.getline("."), vim.fn.col(".") - 1), 0, 1)
end

local close_win = function(winnr, bufnr, set_insert)
  vim.api.nvim_win_close(winnr, false)
  vim.api.nvim_buf_delete(bufnr, {})
  if set_insert then
    vim.cmd("startinsert")
  end
end

local set_close_keys = function(keys, winnr, bufnr)
  for _, key in ipairs(keys) do
    vim.keymap.set("n", key, function()
      close_win(winnr, bufnr)
    end, { buffer = bufnr })
  end
end

local set_win_opts = function(winnr, bufnr)
  vim.api.nvim_buf_set_option(bufnr, "modifiable", false)
  local set_insert = vim.api.nvim_get_mode().mode == "i"

  vim.cmd("stopinsert")

  vim.keymap.set("n", "<cr>", function()
    local char = get_char_at_cursor()
    close_win(winnr, bufnr, set_insert)
    vim.api.nvim_put({ char }, "c", true, true)
  end, { buffer = bufnr })

  vim.keymap.set("n", "<Tab>", "l", { buffer = bufnr })
  vim.keymap.set("n", "<S-Tab>", "h", { buffer = bufnr })

  set_close_keys({ "q", "<esc>" }, winnr, bufnr)
end

M.open_win = function()
  local bufnr = vim.api.nvim_create_buf(false, true)
  local winnr = vim.api.nvim_open_win(bufnr, true, config.window)
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, config.emoji_list)
  set_win_opts(winnr, bufnr)
end

M.setup = function(user_config)
  if user_config then
    vim.tbl_deep_extend("force", config, user_config)
  end
  vim.api.nvim_create_user_command("EmojiPicker", M.open_win, {})
  vim.keymap.set("i", "<M-e>", "<cmd>EmojiPicker<cr>")
end

return M
