require("config.options")
require("config.keymaps")

-- Load the native package manager manifest
require("pack")

vim.cmd([[
  if &ft != '' | filetype detect | endif
]])
