-- settings
vim.wo.number = true
vim.wo.relativenumber = true

vim.api.nvim_set_keymap('n', '<C-s>', ':w<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-s>', '<Esc>:w<CR>a', { noremap = true, silent = true })

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = "//"

-- Setup azy.nvim
require("lazy").setup("plugins")

-- fuzzy findinig
local builtin = require("telescope.builtin")
vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})

-- neotree
vim.keymap.set('n', '<C-b>', ':Neotree<CR>', {})
vim.keymap.set('n', '<C-h>', ':Neotree close<CR>', {})

-- treesitter config
local config = require("nvim-treesitter.configs")
config.setup({
  auto_install = { enable = true },
  highlight    = { enable = true },
  indent       = { enable = true }
})

require("catppuccin").setup({ transparent_background = true })
vim.cmd.colorscheme "catppuccin"

