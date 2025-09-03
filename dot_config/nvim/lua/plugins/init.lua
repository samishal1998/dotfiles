return {
  "nvim-lua/plenary.nvim",

  {
    "nvchad/ui",
    config = function()
      require "nvchad"
    end,
  },

  {
    "nvchad/base46",
    lazy = true,
    build = function()
      require("base46").load_all_highlights()
    end,
  },
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    -- config = function()
    --   vim.wo.foldmethod = "expr"
    --   vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    --   vim.opt.foldenable = false
    -- end,
    opts = {
      sync_install = true,
      auto_install = true,
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "bash",
        "prisma",
        "graphql",
        "json",
        "typescript",
        "javascript",
        "tsx",
        "sql",
        "typespec",
        "regex",
      },
      tree_docs = {
        enable = true,
      },
    },
  },
  {
    "nvim-treesitter/nvim-tree-docs",
  },
  -- #region added plugins
  {
    "gabrielpoca/replacer.nvim",
    opts = { rename_files = false },
    keys = {
      {
        "<leader>h",
        function()
          require("replacer").run()
        end,
        desc = "run replacer.nvim",
      },
    },
  },
  {
    "gorbit99/codewindow.nvim",
    lazy = false,
    config = function()
      local codewindow = require "codewindow"
      codewindow.setup()
      codewindow.apply_default_keybinds()
    end,
  },
  {
    "smoka7/hop.nvim",
    lazy = false,
    version = "*",
    opts = {
      keys = "etovxqpdygfblzhckisuran",
    },
  },
  {
    "keaising/textobj-backtick.nvim",
    lazy = false,
    config = function()
      require("textobj-backtick").setup {
        -- no backticks, no white spaces
        inner_trim_key = "i`",

        -- no backtick, keep white spaces
        -- empty content will be ignore.
        inner_all_key = "",

        -- all content, include backticks
        around_key = "a`",
      }
    end,
  },
  {
    "mg979/vim-visual-multi",
    lazy = false,
  },
  -- {
  --   "brenton-leighton/multiple-cursors.nvim",
  --   lazy = "false",
  --   version = "*", -- Use the latest tagged version
  --   opts = {}, -- This causes the plugin setup function to be called
  --   keys = {
  --     { "<C-S-j>", "<Cmd>MultipleCursorsAddDown<CR>", mode = { "n", "x" }, desc = "Add cursor and move down" },
  --     { "<C-S-k>", "<Cmd>MultipleCursorsAddUp<CR>", mode = { "n", "x" }, desc = "Add cursor and move up" },
  --
  --     { "<C-S-Up>", "<Cmd>MultipleCursorsAddUp<CR>", mode = { "n", "i", "x" }, desc = "Add cursor and move up" },
  --     { "<C-S-Down>", "<Cmd>MultipleCursorsAddDown<CR>", mode = { "n", "i", "x" }, desc = "Add cursor and move down" },
  --
  --     { "<C-LeftMouse>", "<Cmd>MultipleCursorsMouseAddDelete<CR>", mode = { "n", "i" }, desc = "Add or remove cursor" },
  --
  --     { "<Leader>a", "<Cmd>MultipleCursorsAddMatches<CR>", mode = { "n", "x" }, desc = "Add cursors to cword" },
  --     {
  --       "<Leader>A",
  --       "<Cmd>MultipleCursorsAddMatchesV<CR>",
  --       mode = { "n", "x" },
  --       desc = "Add cursors to cword in previous area",
  --     },
  --
  --     {
  --       "<Leader>d",
  --       "<Cmd>MultipleCursorsAddJumpNextMatch<CR>",
  --       mode = { "n", "x" },
  --       desc = "Add cursor and jump to next cword",
  --     },
  --     { "<Leader>D", "<Cmd>MultipleCursorsJumpNextMatch<CR>", mode = { "n", "x" }, desc = "Jump to next cword" },
  --
  --     { "<Leader>l", "<Cmd>MultipleCursorsLock<CR>", mode = { "n", "x" }, desc = "Lock virtual cursors" },
  --   },
  -- },
  {
    "rmagatti/auto-session",
    lazy = false,

    ---enables autocomplete for opts
    ---@module "auto-session"
    ---@type AutoSession.Config
    opts = {
      suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },

      -- log_level = 'debug',
    },
  },
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {},
  },

  {
    "yioneko/nvim-vtsls",
    opts = {},
  },

  --#region lua completion
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  { -- optional cmp completion source for require statements and module annotations
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      table.insert(opts.sources, {
        name = "lazydev",
        group_index = 0, -- set group index to 0 to skip loading LuaLS completions
      })
    end,
  },
  { -- optional blink completion source for require statements and module annotations
    "saghen/blink.cmp",
    opts = {
      sources = {
        -- add lazydev to your completion providers
        completion = {
          enabled_providers = { "lsp", "path", "snippets", "buffer", "lazydev" },
        },
        providers = {
          -- dont show LuaLS require statements when lazydev has items
          lsp = { fallback_for = { "lazydev" } },
          lazydev = { name = "LazyDev", module = "lazydev.integrations.blink" },
        },
      },
    },
  },
  --#endregion
  --

  {
    "rest-nvim/rest.nvim",
    lazy = false,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      opts = function(_, opts)
        opts.ensure_installed = opts.ensure_installed or {}
        table.insert(opts.ensure_installed, "http")
      end,
    },
  },

  {
    "BlackLight/nvim-http",
    lazy = false,
  },
  { "mistweaverco/kulala.nvim", opts = {} },
  --#endregion added plugins
  -- {
  --   "akinsho/bufferline.nvim",
  --   lazy = false,
  --   version = "*",
  --   dependencies = "nvim-tree/nvim-web-devicons",
  -- },
  { "tiagovla/scope.nvim", config = true, lazy = false },
  {
    "mfussenegger/nvim-dap",
    dependencies = { "rcarriga/nvim-dap-ui", "nvim-neotest/nvim-nio", "mxsdev/nvim-dap-vscode-js" },
    lazy = false,
    config = function()
      local dap, dapui = require "dap", require "dapui"
      dapui.setup()
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end

      vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "", linehl = "", numhl = "" })
      --
      --
      -- vim.keymap.set("n", "<Leader>dbt", dap.toggle_breakpoint, { desc = "Breakpoint Toggle" })
      -- vim.keymap.set("n", "<Leader>dbc", dap.continue, { desc = "Breakpoint Continue" })
      -- vim.keymap.set("n", "<Leader>dbso", dap.step_out, { desc = "DAP Step Out" })
      -- vim.keymap.set("n", "<Leader>dbsi", dap.step_into, { desc = "DAP Step Into" })

      vim.keymap.set("n", "<F5>", function()
        require("dap").continue()
      end)
      vim.keymap.set("n", "<F10>", function()
        require("dap").step_over()
      end)
      vim.keymap.set("n", "<F11>", function()
        require("dap").step_into()
      end)
      vim.keymap.set("n", "<F12>", function()
        require("dap").step_out()
      end)
      vim.keymap.set("n", "<Leader>bt", function()
        require("dap").toggle_breakpoint()
      end)
      vim.keymap.set("n", "<Leader>B", function()
        require("dap").set_breakpoint()
      end)
      vim.keymap.set("n", "<Leader>lp", function()
        require("dap").set_breakpoint(nil, nil, vim.fn.input "Log point message: ")
      end)
      vim.keymap.set("n", "<Leader>dr", function()
        require("dap").repl.open()
      end)
      vim.keymap.set("n", "<Leader>dl", function()
        require("dap").run_last()
      end)
      vim.keymap.set({ "n", "v" }, "<Leader>dh", function()
        require("dap.ui.widgets").hover()
      end)
      vim.keymap.set({ "n", "v" }, "<Leader>dp", function()
        require("dap.ui.widgets").preview()
      end)
      vim.keymap.set("n", "<Leader>df", function()
        local widgets = require "dap.ui.widgets"
        widgets.centered_float(widgets.frames)
      end)
      vim.keymap.set("n", "<Leader>ds", function()
        local widgets = require "dap.ui.widgets"
        widgets.centered_float(widgets.scopes)
      end)

      -- require("dap").adapters["pwa-node"] = {
      --   type = "server",
      --   host = "localhost",
      --   port = "${port}",
      --   executable = {
      --     command = "node",
      --     -- 💀 Make sure to update this path to point to your installation
      --     args = { "/Users/samimishal/js-debug/src/dapDebugServer.js", "${port}" },
      --   },
      -- }
      --
      -- require("dap").configurations.typescript = {
      --   {
      --     type = "pwa-node",
      --     request = "launch",
      --     name = "Launch file",
      --     program = "${file}",
      --     cwd = "${workspaceFolder}",
      --   },
      -- }
      --
      -- require("dap").configurations.javascript = {
      --   {
      --     type = "pwa-node",
      --     request = "launch",
      --     name = "Launch file",
      --     program = "${file}",
      --     cwd = "${workspaceFolder}",
      --   },
      -- }

      -- setup adapters
      require("dap-vscode-js").setup {
        debugger_path = vim.fn.stdpath "data" .. "/mason/packages/js-debug-adapter",
        debugger_cmd = { "js-debug-adapter" },
        adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
      }

      -- custom adapter for running tasks before starting debug
      local custom_adapter = "pwa-node-custom"
      dap.adapters[custom_adapter] = function(cb, config)
        if config.preLaunchTask then
          local async = require "plenary.async"
          local notify = require("notify").async

          async.run(function()
            ---@diagnostic disable-next-line: missing-parameter
            notify("Running [" .. config.preLaunchTask .. "]").events.close()
          end, function()
            vim.fn.system(config.preLaunchTask)
            config.type = "pwa-node"
            dap.run(config)
          end)
        end
      end

      -- language config
      for _, language in ipairs { "typescript", "javascript" } do
        dap.configurations[language] = {
          {
            name = "Launch",
            type = "pwa-node",
            request = "launch",
            program = "${file}",
            rootPath = "${workspaceFolder}",
            cwd = "${workspaceFolder}",
            sourceMaps = true,
            skipFiles = { "<node_internals>/**" },
            protocol = "inspector",
            console = "integratedTerminal",
          },
          {
            name = "Attach to node process",
            type = "pwa-node",
            request = "attach",
            rootPath = "${workspaceFolder}",
            processId = require("dap.utils").pick_process,
          },
          {
            name = "Debug Main Process (Electron)",
            type = "pwa-node",
            request = "launch",
            program = "${workspaceFolder}/node_modules/.bin/electron",
            args = {
              "${workspaceFolder}/dist/index.js",
            },
            outFiles = {
              "${workspaceFolder}/dist/*.js",
            },
            resolveSourceMapLocations = {
              "${workspaceFolder}/dist/**/*.js",
              "${workspaceFolder}/dist/*.js",
            },
            rootPath = "${workspaceFolder}",
            cwd = "${workspaceFolder}",
            sourceMaps = true,
            skipFiles = { "<node_internals>/**" },
            protocol = "inspector",
            console = "integratedTerminal",
          },
          {
            name = "Compile & Debug Main Process (Electron)",
            type = custom_adapter,
            request = "launch",
            preLaunchTask = "npm run build-ts",
            program = "${workspaceFolder}/node_modules/.bin/electron",
            args = {
              "${workspaceFolder}/dist/index.js",
            },
            outFiles = {
              "${workspaceFolder}/dist/*.js",
            },
            resolveSourceMapLocations = {
              "${workspaceFolder}/dist/**/*.js",
              "${workspaceFolder}/dist/*.js",
            },
            rootPath = "${workspaceFolder}",
            cwd = "${workspaceFolder}",
            sourceMaps = true,
            skipFiles = { "<node_internals>/**" },
            protocol = "inspector",
            console = "integratedTerminal",
          },
        }
      end
    end,
  },
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
    opts = {
      --    -- add any opts here
      --    -- for example
      provider = "openai",
      openai = {
        endpoint = "https://api.openai.com/v1",
        model = "gpt-4o", -- your desired model (or use gpt-4o, etc.)
        timeout = 30000, -- timeout in milliseconds
        temperature = 0, -- adjust if needed
        max_tokens = 8192,
        -- reasoning_effort = "high", -- only supported for "o" models
      },
      auto_suggestions_provider = "openai",

      -- provider = "claude",
      -- auto_suggestions_provider = "claude",
      behaviour = {
        auto_suggestions = true, -- Experimental stage
        auto_set_highlight_group = true,
        auto_set_keymaps = true,
        auto_apply_diff_after_generation = false,
        support_paste_from_clipboard = false,
        minimize_diff = true, -- Whether to remove unchanged lines when applying a code block
        enable_token_counting = true, -- Whether to enable token counting. Default to true.
        enable_cursor_planning_mode = true, -- Whether to enable Cursor Planning Mode. Default to false.
      },
      mappings = {
        --- @class AvanteConflictMappings
        diff = {
          ours = "co",
          theirs = "ct",
          all_theirs = "ca",
          both = "cb",
          cursor = "cc",
          next = "]x",
          prev = "[x",
        },
        suggestion = {
          accept = "<leader><Tab>",
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-]>",
        },
        jump = {
          next = "]]",
          prev = "[[",
        },
        submit = {
          normal = "<CR>",
          insert = "<C-s>",
        },
        sidebar = {
          apply_all = "A",
          apply_cursor = "a",
          switch_windows = "<Tab>",
          reverse_switch_windows = "<S-Tab>",
        },
      },
      hints = { enabled = true },
      suggestion = {
        debounce = 200,
        throttle = 100,
      },
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "echasnovski/mini.pick", -- for file_selector provider mini.pick
      "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
      "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
      "ibhagwan/fzf-lua", -- for file_selector provider fzf
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua", -- for providers='copilot'
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  }, -- Avante End
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup {}
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    config = function()
      require("copilot_cmp").setup()
    end,
  },
}

-- {
--   "yetone/avante.nvim",
--   event = "VeryLazy",
--   lazy = false,
--   version = false, -- set this if you want to always pull the latest change
--   opts = {
--     -- add any opts here
--   },
--   -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
--   build = "make",
--   -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
--   dependencies = {
--     "nvim-treesitter/nvim-treesitter",
--     "stevearc/dressing.nvim",
--     "nvim-lua/plenary.nvim",
--     "MunifTanjim/nui.nvim",
--     --- The below dependencies are optional,
--     "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
--     "zbirenbaum/copilot.lua", -- for providers='copilot'
--     {
--       -- support for image pasting
--       "HakonHarnes/img-clip.nvim",
--       event = "VeryLazy",
--       opts = {
--         -- recommended settings
--         default = {
--           embed_image_as_base64 = false,
--           prompt_for_file_name = false,
--           drag_and_drop = {
--             insert_mode = true,
--           },
--           -- required for Windows users
--           use_absolute_path = true,
--         },
--       },
--     },
--     {
--       -- Make sure to set this up properly if you have lazy=true
--       "MeanderingProgrammer/render-markdown.nvim",
--       opts = {
--         file_types = { "markdown", "Avante" },
--       },
--       ft = { "markdown", "Avante" },
--     },
--   },
-- },
--
--
