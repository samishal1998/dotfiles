-- Custom key mappings
-- This file contains additional user-defined key mappings

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Custom navigation
map("n", "<leader>1", ":BufferLineGoToBuffer 1<CR>", opts)
map("n", "<leader>2", ":BufferLineGoToBuffer 2<CR>", opts)
map("n", "<leader>3", ":BufferLineGoToBuffer 3<CR>", opts)
map("n", "<leader>4", ":BufferLineGoToBuffer 4<CR>", opts)
map("n", "<leader>5", ":BufferLineGoToBuffer 5<CR>", opts)
map("n", "<leader>6", ":BufferLineGoToBuffer 6<CR>", opts)
map("n", "<leader>7", ":BufferLineGoToBuffer 7<CR>", opts)
map("n", "<leader>8", ":BufferLineGoToBuffer 8<CR>", opts)
map("n", "<leader>9", ":BufferLineGoToBuffer 9<CR>", opts)

-- Custom file operations
map("n", "<leader>fn", ":enew<CR>", opts)
map("n", "<leader>fo", ":Telescope oldfiles<CR>", opts)
map("n", "<leader>fr", ":Telescope registers<CR>", opts)
map("n", "<leader>fm", ":Telescope marks<CR>", opts)

-- Custom search
map("n", "<leader>sw", ":Telescope grep_string<CR>", opts)
map("n", "<leader>sc", ":Telescope commands<CR>", opts)
map("n", "<leader>sk", ":Telescope keymaps<CR>", opts)
map("n", "<leader>st", ":Telescope treesitter<CR>", opts)

-- Custom git operations
map("n", "<leader>gb", ":Telescope git_branches<CR>", opts)
map("n", "<leader>gc", ":Telescope git_commits<CR>", opts)
map("n", "<leader>gs", ":Telescope git_status<CR>", opts)
map("n", "<leader>gh", ":Telescope git_stash<CR>", opts)

-- Custom LSP operations
map("n", "<leader>la", ":lua vim.lsp.buf.code_action()<CR>", opts)
map("n", "<leader>ld", ":lua vim.lsp.buf.definition()<CR>", opts)
map("n", "<leader>lD", ":lua vim.lsp.buf.declaration()<CR>", opts)
map("n", "<leader>lr", ":lua vim.lsp.buf.references()<CR>", opts)
map("n", "<leader>li", ":lua vim.lsp.buf.implementation()<CR>", opts)
map("n", "<leader>lt", ":lua vim.lsp.buf.type_definition()<CR>", opts)
map("n", "<leader>lh", ":lua vim.lsp.buf.hover()<CR>", opts)
map("n", "<leader>ls", ":lua vim.lsp.buf.signature_help()<CR>", opts)
map("n", "<leader>ln", ":lua vim.lsp.buf.rename()<CR>", opts)
map("n", "<leader>lf", ":lua vim.lsp.buf.format()<CR>", opts)

-- Custom terminal operations
map("n", "<leader>tf", ":ToggleTerm direction=float<CR>", opts)
map("n", "<leader>th", ":ToggleTerm direction=horizontal<CR>", opts)
map("n", "<leader>tv", ":ToggleTerm direction=vertical<CR>", opts)
map("n", "<leader>tg", ":lua _lazygit_toggle()<CR>", opts)

-- Custom window operations
map("n", "<leader>wo", "<C-w>o", opts)
map("n", "<leader>wh", "<C-w>h", opts)
map("n", "<leader>wj", "<C-w>j", opts)
map("n", "<leader>wk", "<C-w>k", opts)
map("n", "<leader>wl", "<C-w>l", opts)
map("n", "<leader>wv", ":vsplit<CR>", opts)
map("n", "<leader>ws", ":split<CR>", opts)
map("n", "<leader>wr", "<C-w>r", opts)
map("n", "<leader>wx", ":close<CR>", opts)

-- Custom buffer operations
map("n", "<leader>bp", ":BufferLinePick<CR>", opts)
map("n", "<leader>bc", ":BufferLinePickClose<CR>", opts)
map("n", "<leader>bl", ":BufferLineCloseLeft<CR>", opts)
map("n", "<leader>br", ":BufferLineCloseRight<CR>", opts)
map("n", "<leader>bo", ":BufferLineCloseOthers<CR>", opts)

-- Custom quickfix operations
map("n", "<leader>co", ":copen<CR>", opts)
map("n", "<leader>cc", ":cclose<CR>", opts)
map("n", "<leader>cn", ":cnext<CR>", opts)
map("n", "<leader>cp", ":cprev<CR>", opts)

-- Custom location list operations
map("n", "<leader>lo", ":lopen<CR>", opts)
map("n", "<leader>lc", ":lclose<CR>", opts)
map("n", "<leader>ln", ":lnext<CR>", opts)
map("n", "<leader>lp", ":lprev<CR>", opts)

-- Custom fold operations
map("n", "<leader>za", "za", opts)
map("n", "<leader>zA", "zA", opts)
map("n", "<leader>zo", "zo", opts)
map("n", "<leader>zO", "zO", opts)
map("n", "<leader>zc", "zc", opts)
map("n", "<leader>zC", "zC", opts)
map("n", "<leader>zr", "zr", opts)
map("n", "<leader>zR", "zR", opts)
map("n", "<leader>zm", "zm", opts)
map("n", "<leader>zM", "zM", opts)

-- Custom spell check
map("n", "<leader>ss", ":setlocal spell!<CR>", opts)
map("n", "<leader>sn", "]s", opts)
map("n", "<leader>sp", "[s", opts)
map("n", "<leader>sa", "zg", opts)
map("n", "<leader>s?", "z=", opts)

-- Custom paste mode
map("n", "<leader>pp", ":set paste!<CR>", opts)

-- Custom line numbers
map("n", "<leader>nn", ":set number!<CR>", opts)
map("n", "<leader>nr", ":set relativenumber!<CR>", opts)

-- Custom wrap
map("n", "<leader>ww", ":set wrap!<CR>", opts)

-- Custom cursor line
map("n", "<leader>cl", ":set cursorline!<CR>", opts)

-- Custom list chars
map("n", "<leader>ll", ":set list!<CR>", opts)

-- Custom color column
map("n", "<leader>cc", ":set colorcolumn=80<CR>", opts)
map("n", "<leader>cC", ":set colorcolumn=<CR>", opts)

-- Custom tab settings
map("n", "<leader>tt", ":set expandtab tabstop=4 shiftwidth=4 softtabstop=4<CR>", opts)
map("n", "<leader>ts", ":set expandtab tabstop=2 shiftwidth=2 softtabstop=2<CR>", opts)
map("n", "<leader>th", ":set noexpandtab tabstop=4 shiftwidth=4 softtabstop=4<CR>", opts)

-- Custom file operations
map("n", "<leader>fd", ":e %:h<CR>", opts)
map("n", "<leader>fe", ":e!<CR>", opts)
map("n", "<leader>fs", ":w<CR>", opts)
map("n", "<leader>fS", ":wa<CR>", opts)
map("n", "<leader>fq", ":q<CR>", opts)
map("n", "<leader>fQ", ":qa!<CR>", opts)

-- Custom help
map("n", "<leader>hh", ":help ", opts)
map("n", "<leader>hk", ":help keys<CR>", opts)
map("n", "<leader>hc", ":help commands<CR>", opts)
map("n", "<leader>ho", ":help options<CR>", opts)
map("n", "<leader>hm", ":help map<CR>", opts)