local opt = vim.opt

-- ==========================================
-- 1. General Settings
-- ==========================================
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.softtabstop = 2
opt.background = "dark"
opt.termguicolors = true
opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"
opt.splitbelow = true
opt.splitright = true
opt.swapfile = false
opt.undofile = true
opt.clipboard:append "unnamedplus"

-- Typewriter Scrolling (Keep cursor in middle)
opt.scrolloff = 999
opt.sidescrolloff = 15

-- Set Leader Key (Must be before plugins load)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Load Mappings
require "mappings"

-- ==========================================
-- 2. Bootstrap Lazy.nvim
-- ==========================================
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  }
end
opt.rtp:prepend(lazypath)

-- ==========================================
-- 3. Plugins
-- ==========================================
require("lazy").setup({
  { import = "packages" },
}, {
  change_detection = { enable = true, notify = false },
})
