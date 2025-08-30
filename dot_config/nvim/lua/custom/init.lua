-- Custom NvChad configuration
-- This file contains user-specific customizations

-- Set custom options
vim.opt.relativenumber = true
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

-- Custom key mappings
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Custom leader mappings
map("n", "<leader>e", ":NvimTreeToggle<CR>", opts)
map("n", "<leader>ff", ":Telescope find_files<CR>", opts)
map("n", "<leader>fg", ":Telescope live_grep<CR>", opts)
map("n", "<leader>fb", ":Telescope buffers<CR>", opts)
map("n", "<leader>fh", ":Telescope help_tags<CR>", opts)
map("n", "<leader>gg", ":LazyGit<CR>", opts)

-- LSP mappings
map("n", "gD", vim.lsp.buf.declaration, opts)
map("n", "gd", vim.lsp.buf.definition, opts)
map("n", "K", vim.lsp.buf.hover, opts)
map("n", "gi", vim.lsp.buf.implementation, opts)
map("n", "<C-k>", vim.lsp.buf.signature_help, opts)
map("n", "<leader>rn", vim.lsp.buf.rename, opts)
map("n", "<leader>ca", vim.lsp.buf.code_action, opts)
map("n", "gr", vim.lsp.buf.references, opts)
map("n", "<leader>f", function() vim.lsp.buf.format { async = true } end, opts)

-- Diagnostics
map("n", "<leader>dd", vim.diagnostic.open_float, opts)
map("n", "[d", vim.diagnostic.goto_prev, opts)
map("n", "]d", vim.diagnostic.goto_next, opts)
map("n", "<leader>dl", vim.diagnostic.setloclist, opts)

-- Custom commands
vim.api.nvim_create_user_command("Format", function()
  vim.lsp.buf.format { async = true }
end, {})

vim.api.nvim_create_user_command("LspInfo", function()
  vim.cmd("LspInfo")
end, {})

vim.api.nvim_create_user_command("Mason", function()
  vim.cmd("Mason")
end, {})

-- Custom autocommands
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.opt.tabstop = 4
    vim.opt.shiftwidth = 4
    vim.opt.expandtab = true
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  callback = function()
    vim.opt.tabstop = 4
    vim.opt.shiftwidth = 4
    vim.opt.expandtab = false
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "rust",
  callback = function()
    vim.opt.tabstop = 4
    vim.opt.shiftwidth = 4
    vim.opt.expandtab = true
  end,
})

-- Custom statusline
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.opt.statusline = "%f %m %r %= %l:%c %p%%"
  end,
})