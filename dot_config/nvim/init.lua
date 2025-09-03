vim.g.base46_cache = vim.fn.stdpath "data" .. "/nvchad/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "nvchad.autocmds"

vim.schedule(function()
  require "mappings"
end)

vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldenable = false



vim.opt.termguicolors = true

function isModuleAvailable(name)
  if package.loaded[name] then
    return true
  else
    for _, searcher in ipairs(package.searchers or package.loaders) do
      local loader = searcher(name)
      if type(loader) == 'function' then
        package.preload[name] = loader
        return true
      end
    end
    return false
  end
end

if isModuleAvailable('bufferline') then
  setup_bufferline()
end

function setup_bufferline()

  local bufferline = require "bufferline"
local groups = require('bufferline.groups')

bufferline.setup {
  options = {

    mode = "buffers", -- set to "tabs" to only show tabpages instead
    style_preset = bufferline.style_preset.default, -- or bufferline.style_preset.minimal,
    themable = false, -- allows highlight groups to be overriden i.e. sets highlights as default
    numbers = "ordinal",
    close_command = "bdelete! %d", -- can be a string | function, | false see "Mouse actions"
    right_mouse_command = "bdelete! %d", -- can be a string | function | false, see "Mouse actions"
    left_mouse_command = "buffer %d", -- can be a string | function, | false see "Mouse actions"
    middle_mouse_command = 'bdelete! %d', -- can be a string | function, | false see "Mouse actions"
    indicator = {
      icon = "▎", -- this should be omitted if indicator style is not 'icon'
      style = "underline",
    },
    buffer_close_icon = "󰅖",
    modified_icon = "● ",
    close_icon = " ",
    left_trunc_marker = " ",
    right_trunc_marker = " ",
    --- name_formatter can be used to change the buffer's label in the bufferline.
    --- Please note some names can/will break the
    --- bufferline so use this at your discretion knowing that it has
    --- some limitations that will *NOT* be fixed.
    -- name_formatter = function(buf)  -- buf contains:
    --       -- name                | str        | the basename of the active file
    --       -- path                | str        | the full path of the active file
    --       -- bufnr               | int        | the number of the active buffer
    --       -- buffers (tabs only) | table(int) | the numbers of the buffers in the tab
    --       -- tabnr (tabs only)   | int        | the "handle" of the tab, can be converted to its ordinal number using: `vim.api.nvim_tabpage_get_number(buf.tabnr)`
    -- end,
    max_name_length = 12,
    max_prefix_length = 8, -- prefix used when a buffer is de-duplicated
    truncate_names = true, -- whether or not tab names should be truncated
    tab_size = 15,
    diagnostics = "nvim_lsp",
    diagnostics_update_in_insert = false, -- only applies to coc
    diagnostics_update_on_event = true, -- use nvim's diagnostic handler
    -- The diagnostics indicator can be set to nil to keep the buffer name highlight but delete the highlighting
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      return "(" .. count .. ")"
    end,
    offsets = {
      {
        filetype = "NvimTree",
        text = "File Explorer",
        text_align = "left",
        separator = true,
      },
    },
    color_icons = true, -- whether or not to add the filetype icon highlights
    get_element_icon = function(element)
      -- element consists of {filetype: string, path: string, extension: string, directory: string}
      -- This can be used to change how bufferline fetches the icon
      -- for an element e.g. a buffer or a tab.
      -- e.g.
      local icon, hl = require("nvim-web-devicons").get_icon_by_filetype(element.filetype, { default = false })
      return icon, hl
      -- -- or
      -- local custom_map = {my_thing_ft: {icon = "my_thing_icon", hl}}
      -- return custom_map[element.filetype]
    end,
    show_buffer_icons = true, -- disable filetype icons for buffers
    show_buffer_close_icons = true,
    show_close_icon = true,
    show_tab_indicators = true,
    show_duplicate_prefix = true, -- whether to show duplicate buffer prefix
    duplicates_across_groups = true, -- whether to consider duplicate paths in different groups as duplicates
    persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
    move_wraps_at_ends = false, -- whether or not the move command "wraps" at the first or last position
    -- can also be a table containing 2 custom separators
    -- [focused and unfocused]. eg: { '|', '|' }
    separator_style = "slant",
    enforce_regular_tabs = false,
    always_show_bufferline = true,
    auto_toggle_bufferline = true,
    hover = {
      enabled = true,
      delay = 200,
      reveal = { "close" },
    },
    sort_by = function(buffer_a, buffer_b)
      -- add custom logic
      local modified_a = vim.fn.getftime(buffer_a.path)
      local modified_b = vim.fn.getftime(buffer_b.path)
      return modified_a > modified_b
    end,
    pick = {
      alphabet = "abcdefghijklmopqrstuvwxyzABCDEFGHIJKLMOPQRSTUVWXYZ1234567890",
    },
    groups = {
            items = {
                require('bufferline.groups').builtin.pinned:with({ icon = "󰐃 " }),
            },
            groups.builtin.ungrouped,
        }
    -- groups = {
    --   options = {
    --     toggle_hidden_on_enter = true, -- when you re-enter a hidden group this options re-opens that group so the buffer is visible
    --   },
    --   items = {
    --     {
    --       auto_close = true,
    --       name = "Tests", -- Mandatory
    --       highlight = { underline = "", sp = "blue" }, -- Optional
    --       priority = 2, -- determines where it will appear relative to other groups (Optional)
    --       icon = " ", -- Optional
    --       matcher = function(buf) -- Mandatory
    --         return buf.filename:match "%_test" or buf.filename:match "%_spec"
    --       end,
    --     },
    --     {
    --       name = "Docs",
    --       highlight = { undercurl = "", sp = "green" },
    --       auto_close = false, -- whether or not close this group if it doesn't contain the current buffer
    --       matcher = function(buf)
    --         return buf.filename:match "%.md" or buf.filename:match "%.txt"
    --       end,
    --       separator = { -- Optional
    --         style = require("bufferline.groups").separator.tab,
    --       },
    --     },
    --   },
    -- },

    --
  },
}
  
end

