local api = vim.api
local g = vim.g
local opt = vim.opt

-- Remap leader and local leader to <Space>
api.nvim_set_keymap("", "<Space>", "<Nop>", { noremap = true, silent = true })
g.mapleader = " "
g.maplocalleader = " "
g.neovide_refresh_rate = 60

opt.termguicolors = true -- Enable colors in terminal
opt.hlsearch = true --Set highlight on search
opt.number = true --Make line numbers default
opt.mouse = "a" --Enable mouse mode
opt.breakindent = true --Enable break indent
opt.undofile = true --Save undo history
opt.ignorecase = true --Case insensitive searching unless /C or capital in search
opt.smartcase = true -- Smart case
opt.updatetime = 250 --Decrease update time
opt.signcolumn = "yes" -- Always show sign column
opt.clipboard = "unnamedplus" -- Access system clipboard
opt.cursorline = true -- Highlight the current line under the cursor
opt.timeoutlen = 300 -- Time in millisecs to wait for a mapped sequence to complete
opt.pastetoggle= "<F3>"

-- Special Casing for Gui Font handling under Mac OS X
if jit.os == "OSX" then
	opt.guifont = "FiraCode Nerd Font Mono:h13"
else
	opt.guifont = "FiraCode Nerd Font Mono:h8"
end

-- Highlight on yank
vim.cmd [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]]

-- Set the desired color scheme
vim.cmd [[colorscheme kanagawa]]

-- Initialize LuaSnip
require("config.luasnip").setup()

-- Initialize CMP
require("config.cmp").setup()

-- Initialize LSP
require("config.lsp").setup()
