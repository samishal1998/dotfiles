-- Core key mappings
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Leader key mappings
map("n", "<leader>w", ":w<CR>", opts)
map("n", "<leader>q", ":q<CR>", opts)
map("n", "<leader>Q", ":qa!<CR>", opts)
map("n", "<leader>h", ":nohlsearch<CR>", opts)

-- Window navigation
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

-- Window management
map("n", "<leader>v", ":vsplit<CR>", opts)
map("n", "<leader>s", ":split<CR>", opts)
map("n", "<leader>=", "<C-w>=", opts)
map("n", "<leader>x", ":close<CR>", opts)

-- Buffer navigation
map("n", "<S-l>", ":bnext<CR>", opts)
map("n", "<S-h>", ":bprevious<CR>", opts)
map("n", "<leader>bd", ":bdelete<CR>", opts)
map("n", "<leader>ba", ":bufdo bd<CR>", opts)

-- Better indenting
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)

-- Move text up and down
map("v", "<A-j>", ":m .+1<CR>==", opts)
map("v", "<A-k>", ":m .-2<CR>==", opts)
map("v", "p", '"_dP', opts)

-- Stay in indent mode
map("v", "<S-Tab>", "<gv", opts)
map("v", "<Tab>", ">gv", opts)

-- Quick fix
map("n", "<leader>qf", ":copen<CR>", opts)

-- Terminal
map("n", "<leader>tt", ":ToggleTerm<CR>", opts)
map("t", "<Esc>", "<C-\\><C-n>", opts)
map("t", "<C-h>", "<C-\\><C-n><C-w>h", opts)
map("t", "<C-j>", "<C-\\><C-n><C-w>j", opts)
map("t", "<C-k>", "<C-\\><C-n><C-w>k", opts)
map("t", "<C-l>", "<C-\\><C-n><C-w>l", opts)

-- File operations
map("n", "<leader>fs", ":w<CR>", opts)
map("n", "<leader>fa", ":wa<CR>", opts)
map("n", "<leader>fq", ":q<CR>", opts)
map("n", "<leader>fQ", ":qa!<CR>", opts)

-- Search and replace
map("n", "<leader>sr", ":%s/", opts)
map("v", "<leader>sr", ":s/", opts)

-- Quick navigation
map("n", "J", "5j", opts)
map("n", "K", "5k", opts)
map("v", "J", "5j", opts)
map("v", "K", "5k", opts)

-- Better search
map("n", "n", "nzzzv", opts)
map("n", "N", "Nzzzv", opts)

-- Better yank
map("n", "Y", "y$", opts)

-- Better paste
map("n", "<leader>p", '"0p', opts)
map("n", "<leader>P", '"0P', opts)

-- Better undo
map("n", "U", "<C-r>", opts)

-- Better join
map("n", "<leader>j", "J", opts)

-- Better macro
map("n", "Q", "@", opts)

-- Better command mode
map("n", ";", ":", opts)
map("v", ";", ":", opts)

-- Better visual mode
map("n", "vv", "V", opts)
map("n", "V", "v$", opts)

-- Better search and replace
map("n", "<leader>ss", ":s/", opts)
map("v", "<leader>ss", ":s/", opts)
map("n", "<leader>sg", ":%s/", opts)

-- Better grep
map("n", "<leader>gg", ":grep ", opts)
map("n", "<leader>gw", ":grep <cword><CR>", opts)

-- Better help
map("n", "<leader>hh", ":help ", opts)
map("n", "<leader>hk", ":help keys<CR>", opts)
map("n", "<leader>hc", ":help commands<CR>", opts)