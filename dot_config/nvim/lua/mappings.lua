require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

local hop = require('hop')
local directions = require('hop.hint').HintDirection
vim.keymap.set('', '<leader>hf', function()
  hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
end, {remap=true,  desc= "hop: forwards current_line_only"})

vim.keymap.set('', '<leader>hF', function()
  hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
end, {remap=true,desc= "hop: backwards current_line_only"})

vim.keymap.set('', '<leader>ht', function()
  hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
end, {remap=true})
vim.keymap.set('', '<leader>hT', function()
  hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
end, {remap=true})


vim.keymap.set('', '<leader>ha', function()
  hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = false, hint_offset = 1 })
end, {remap=true})


vim.keymap.set('', '<leader>hb', function()
  hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = false, hint_offset = 1 })
end, {remap=true})

map('n', '<Leader>rrnf', ':lua require("replacer").run({ rename_files = false })<cr>', { silent = true, desc= "replacer: refactor/rename (no files)" })
map('n', '<Leader>rrf', ':lua require("replacer").run()<cr>', { silent = true, desc= "replacer: refactor/rename" })


-- Keyboard users
vim.keymap.set("n", "<C-t>", function()
  require("menu").open("default")
end, {})

-- mouse users + nvimtree users!
vim.keymap.set("n", "<RightMouse>", function()
  vim.cmd.exec '"normal! \\<RightMouse>"'

  local options = vim.bo.ft == "NvimTree" and "nvimtree" or "default"
  require("menu").open(options, { mouse = true })
end, {})

vim.keymap.set('n', '<leader>i', function()
    -- If we find a floating window, close it.
    local found_float = false
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        if vim.api.nvim_win_get_config(win).relative ~= '' then
            vim.api.nvim_win_close(win, true)
            found_float = true
        end
    end

    if found_float then
        return
    end

    vim.diagnostic.open_float(nil, { focus = true, scope = 'cursor' })
end, { desc = 'Toggle Diagnostics' })

vim.api.nvim_set_keymap("n", "<leader>trm", ":terminal<CR>",{desc = "new terminal"})
vim.api.nvim_set_keymap("n", "<leader>tbc", ":tabnew<CR>",{desc = "Tab create"})
vim.api.nvim_set_keymap("n", "<leader>tttrm", ":tabnew<CR>:terminal<CR>:terminal<CR>",{desc = "New Tab with two terminals"})
vim.api.nvim_set_keymap("n", "<leader>tbn", ":tabnext<CR>",{desc = "Tab next"})
vim.api.nvim_set_keymap("n", "<leader>tbp", ":tabprevious<CR>",{desc = "Tab previous"})

-- local dap = require('dap')

-- map("n", "<leader>dtb", (function () dap.toggle_breakpoint() end),{desc = "Debugger Toggle Breakpoint"})
-- map("n", "<leader>dc", (function () dap.continue() end),{desc = "Debugger Continue"})
-- map("n", "<leader>dsi", (function () dap.step_into() end),{desc = "Debugger Step Into"})
-- map("n", "<leader>dso", (function () dap.step_over() end),{desc = "Debugger Step Over"})
-- map("n", "<leader>dro", (function () dap.repl.open() end),{desc = "Debugger Open Repl"})

-- override buffer close from nvchad
-- vim.api.nvim_set_keymap("n", "<leader>x", ":bdelete!<CR>",{desc = "Close buffer"})

-- map("n", "<leader>x", function()
--   local current_buf = vim.api.nvim_get_current_buf()
--   local buffers = vim.api.nvim_list_bufs()
--   local current_buf_index = nil
--
--   -- Find the index of the current buffer
--   for i, buf in ipairs(buffers) do
--     if buf == current_buf then
--       current_buf_index = i
--       break
--     end
--   end
--
--   -- If there's only one buffer, just delete it
--   if #buffers == 1 then
--     vim.schedule(function()
--       vim.api.nvim_buf_delete(current_buf, { force = true })
--     end)
--     return
--   end
--
--   -- Determine the next buffer to switch to
--   local next_buf
--   if current_buf_index == 1 then
--     -- If the current buffer is the first, go to the next buffer
--     next_buf = buffers[current_buf_index + 1]
--   else
--     -- Otherwise, go to the previous buffer
--     next_buf = buffers[current_buf_index - 1]
--   end
--
--   -- Switch to the determined buffer
--   vim.api.nvim_set_current_buf(next_buf)
--   -- Schedule the buffer deletion
--   vim.schedule(function()
--     vim.api.nvim_buf_delete(current_buf, { force = true })
--   end)
-- end, { desc = "buffer close" })

-- map("n", "<Tab>", function()
--   local current_buf = vim.api.nvim_get_current_buf()
--   -- local buffers = vim.api.nvim_list_bufs()
--   local current_buf_index = nil
--
--   local bufnrs_in_current_tab = vim.fn.
--   local buffers = bufnrs_in_current_tab
--   local buf_count = #buffers
-- for _, bufnr in ipairs(bufnrs_in_current_tab) do
--     local bufname = vim.fn.bufname(bufnr)
--     vim.print(buffers)
--     -- vim.print("Buffer number: " .. bufnr .. ", Name: " .. bufname)
-- end
--   -- Find the index of the current buffer
--   for i, buf in ipairs(buffers) do
--     if buf == current_buf then
--       current_buf_index = i
--       break
--     end
--   end
--
--   -- If there's only one buffer, just delete it
--   if buf_count == 1 or current_buf_index == buf_count then
--     return
--   end
--   -- Otherwise, go to the next buffer
--   local next_buf = buffers[current_buf_index + 1]
--
--   vim.api.nvim_set_current_buf(next_buf)
--
-- end, { desc = "buffer close" })
