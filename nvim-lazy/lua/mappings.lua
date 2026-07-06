local map = vim.keymap.set

-- =============================================================
-- 1. NAVIGATION (Typewriter / Centered)
-- =============================================================

-- Center cursor when scrolling half-pages
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll Down & Center" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll Up & Center" })

-- Center cursor when searching
map("n", "n", "nzzzv", { desc = "Next Result & Center" })
map("n", "N", "Nzzzv", { desc = "Prev Result & Center" })

-- Center screen after pressing Enter in Insert Mode
-- (Fixes "bottom of file" scrolling issue)
map("i", "<CR>", "<CR><C-o>zz", { silent = true })

-- Better Up/Down (Handles wrapped lines)
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- =============================================================
-- 2. WINDOW & BUFFER MANAGEMENT
-- =============================================================

-- Move focus between windows
map("n", "<C-h>", "<C-w>h", { desc = "Left Window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Right Window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Down Window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Up Window", remap = true })

-- Resize windows with arrows
map("n", "<C-Up>", "<cmd>resize +2<CR>", { desc = "Increase Height" })
map("n", "<C-Down>", "<cmd>resize -2<CR>", { desc = "Decrease Height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "Decrease Width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Increase Width" })

-- Buffer Navigation (Tabs)
map("n", "<Tab>", "<cmd>bnext<CR>", { desc = "Next Buffer" })
map("n", "<S-Tab>", "<cmd>bprev<CR>", { desc = "Prev Buffer" })
map("n", "<leader>x", "<cmd>bdelete<CR>", { desc = "Close Buffer" })

-- =============================================================
-- 3. SYSTEM
-- =============================================================

-- Quick Save & Quit
map({ "n", "i", "v" }, "<C-s>", "<CMD>write<CR>", { desc = "Save" })
map({ "n", "i", "v" }, "<A-s>", "<CMD>wq<CR>", { desc = "Save & Quit" })

map("n", "<leader>q", "<CMD>q<CR>", { desc = "Exit Neovim" })

-- Clear search highlights with Esc
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear Highlights" })
