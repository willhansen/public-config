local function keymap(modes, keys, command, description)
  vim.keymap.set(modes, keys, command, {noremap = true, silent = true, desc = description})
end

local function nmap(comb, cmd, desc)
  keymap({'n'}, comb, cmd, desc)
end

local function nvmap(comb, cmd, desc)
  keymap({'n', 'v'}, comb, cmd, desc)
end

local function nivmap(comb, cmd, desc)
  keymap({'n', 'i', 'v'}, comb, cmd, desc)
end

local lazy = {}

function lazy.install(path)
  if not vim.loop.fs_stat(path) then
    print('Installing lazy.nvim....')
    vim.fn.system({
      'git',
      'clone',
      '--filter=blob:none',
      'https://github.com/folke/lazy.nvim.git',
      '--branch=stable', -- latest stable release
      path,
    })
  end
end

function lazy.setup(plugins)
  if vim.g.plugins_ready then
    return
  end

  -- You can "comment out" the line below after lazy.nvim is installed
  lazy.install(lazy.path)

  vim.opt.rtp:prepend(lazy.path)

  require('lazy').setup(plugins, lazy.opts)
  vim.g.plugins_ready = true
end

lazy.path = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
lazy.opts = {}

lazy.setup({
  -- the colorscheme should be available when starting Neovim
  {
    -- "Skalyaeve/a-nvim-theme", -- neon theme
    -- "folke/tokyonight.nvim",
    "tanvirtin/monokai.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins

    opts = {
      -- defaults here: https://github.com/tanvirtin/monokai.nvim/blob/master/lua/monokai.lua
      palette = {
        name = 'monokai',
        base0 = '#222426',
        base1 = '#211F22',
        -- base1 = '#272a30',
        base2 = '#26292C',
        base3 = '#2E323C',
        base4 = '#333842',
        base5 = '#4d5154',
        base6 = '#9ca0a4',
        base7 = '#b1b1b1',
        base8 = '#e3e3e1',
        border = '#a1b5b1',
        brown = '#504945',
        white = '#f8f8f0',
        grey = '#8F908A',
        black = '#000000',
        pink = '#f92672',
        green = '#a6e22e',
        aqua = '#66d9ef',
        yellow = '#e6db74',
        orange = '#fd971f',
        purple = '#ae81ff',
        red = '#e95678',
        diff_add = '#3d5213',
        diff_remove = '#4a0f23',
        diff_change = '#27406b',
        diff_text = '#23324d',
      },
    },
    
    init = function()
      vim.opt.termguicolors = true

      -- load the colorscheme here
      -- vim.cmd.colorscheme('monokai_pro')
      -- vim.cmd.colorscheme('monokai')
      -- vim.cmd.colorscheme('tokyonight')
      -- vim.cmd.colorscheme('neon')
    end,
  },
  {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    opts = {},
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    keys = { 
        { "<leader>F" , "<cmd>NvimTreeOpen<cr>", "Open file tree"}
    },
  },
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = {
      "nvim-tree/nvim-web-devicons", -- If you want devicons
    },
    opts = {
      options = {
        diagnostics = "nvim_lsp"
      }
    }
  },
	--{
  --"folke/flash.nvim",
  --event = "VeryLazy",
  -----@type Flash.Config
  --opts = {},
  ---- stylua: ignore
  --keys = {
    --{ "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    --{ "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    --{ "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    --{ "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    --{ "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  --},
 --},
  {"ggandor/leap.nvim",
    lazy = false,
    opts = {},
    init = function()
      -- TODO: 'S' might not work in some circumstances?
      -- Gives 's', 'S', and 'gs'
      -- vim.keymap.del("n", "S")
      -- vim.keymap.del("n", "s")
     
      -- has conflict with Lazy auto update window `S`
      -- require('leap').create_default_mappings()
      -- Should be equivalent
      vim.keymap.set({'n', 'x', 'o'}, 's',  '<Plug>(leap-forward)')
      vim.keymap.set({'n', 'x', 'o'}, 'S',  '<Plug>(leap-backward)')
      vim.keymap.set({'n', 'x', 'o'}, 'gs', '<Plug>(leap-from-window)')
    end,
  },
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.6',
    dependencies = { 
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    lazy = false, -- load on startup
    opts = {
      defaults = {
        -- layout_strategy = 'flex',
        layout_strategy = 'vertical',
        winblend = 5, -- out of 100
        scroll_strategy = "limit",
        path_display = {"smart"},
        dynamic_preview_title = true,
        layout_config = {
          horizontal = {
            prompt_position = 'top',
            width = 0.95,
            height = 0.95,
            preview_width = 0.5,
            preview_cutoff = 1,
          },
          vertical = {
            prompt_position = 'top',
            width = 0.95,
            height = 0.95,
            mirror = true,
            preview_cutoff = 1,
          },
        },
        mappings = {
          i = {
            ["<esc>"] = "close",
            ["<C-c>"] = false,
          },
        },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
  },
    },
    init = function()
      require('telescope').load_extension('fzf')
    end,
  },

  {
    "folke/which-key.nvim",
    lazy = false,
    priority = 900,
    -- event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      -- vim.o.timeoutlen = 0
    end,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function(_, opts)
      local gcc_path = io.popen("which -a gcc | grep -m1 nix"):read()
      require("nvim-treesitter.install").compilers = { gcc_path }
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "elixir", "heex", "javascript", "html", "rust", "python", "bash", "nix" },
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },  
      })
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    opts = {},
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    opts = {},
  },
  {
    "folke/trouble.nvim",
    lazy = false,
    opts = {},
    -- ft = [ "rust", "bash" ], -- load on filetype
    -- cmd = "Trouble", -- load on command
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      {
        "<leader>x",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc =  "Diagnostics (Trouble)",
      },
      {
        "<leader>X",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc =  "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>l",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>cq",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
    -- init = function()
    --   vim.diagnostic.config({virtual_text = false})
    -- end
  },
  

  {'tpope/vim-commentary',
    keys = {
      { "<leader>c", mode = "n", "<CMD>Commentary<CR>", desc = "toggle comment"},
      {"<C-c>", mode = "n", "<CMD>Commentary<CR>", desc = "toggle comment"},
      { "<leader>c", mode =  "x", ":'<,'>Commentary<CR>", desc = "toggle comment"},
      {"<C-c>", mode =  "x", ":'<,'>Commentary<CR>", desc = "toggle comment"},
    }
  },
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    opts = {},
    -- use opts = {} for passing setup options
    -- this is equalent to setup({}) function
  },
  { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'neovim/nvim-lspconfig',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-nvim-lsp-document-symbol',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      -- 'onsails/lspkind.nvim',
      -- 'hrsh7th/cmp-nvim-lsp-signature-help',
      -- 'lukas-reineke/cmp-under-comparator',
      -- 'doxnit/cmp-luasnip-choice',
    },
    config = function(_, opts)
      local cmp = require('cmp')
      cmp.setup({

        -- These two lines prevent <TAB> from skipping the first option
        preselect = cmp.PreselectMode.None,
        completion = { completeopt = "noselect" },

        -- Disabled because confusing when typing comments
        -- experimental = { ghost_text = true, },


        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          -- ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          -- ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<Tab>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Replace }),
          ['<S-Tab>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Replace }),
          -- ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        sources = cmp.config.sources({
          {name = 'nvim_lsp'},
          {name = 'buffer'},
          {name = 'path'},
          {name = 'cmdline'},
          {name = 'luasnip'},
        })
      })
      -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        },
        performance = {max_view_entries = 7},
      })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
            { name = 'cmdline' }
          }),
        matching = { disallow_symbol_nonprefix_matching = false }
      })
    end,
    event = 'InsertEnter',
  },
  {
    'neovim/nvim-lspconfig',
    enabled = false,
    config = function(_, opts)
      require('lspconfig').rust_analyzer.setup {
        settings = {
          ['rust-analyzer'] = {
            workspace = {
              symbol = {
                search = {
                  kind = "all_symbols",
                },
              },
            },
          }
        }
      }
    end

  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    opts = {
      mode = 'topline',
      multiline_threshold = 1, -- default is 20.  May want to increase
    },
    init = function()
      vim.keymap.set("n", "[c", function()
        require("treesitter-context").go_to_context(vim.v.count1)
      end, { silent = true , desc = "Jump to context"}) 
    end

  },
  {"andersevenrud/nvim_context_vt"},
  {"hiphish/rainbow-delimiters.nvim"},
  {
    "johmsalas/text-case.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    -- config = function(_, opts)
      -- require("textcase").setup({})
    init = function()
      require("telescope").load_extension("textcase")
    end,
    keys = {
      "ga", -- Default invocation prefix
      { "ga.", "<cmd>TextCaseOpenTelescope<CR>", mode = { "n", "x" }, desc = "Telescope" },
    },
    cmd = {
      -- NOTE: The Subs command name can be customized via the option "substitude_command_name"
      "Subs",
      "TextCaseOpenTelescope",
      "TextCaseOpenTelescopeQuickChange",
      "TextCaseOpenTelescopeLSPChange",
      "TextCaseStartReplacingCommand",
    },
    -- If you want to use the interactive feature of the `Subs` command right away, text-case.nvim
    -- has to be loaded on startup. Otherwise, the interactive feature of the `Subs` will only be
    -- available after the first executing of it or after a keymap of text-case.nvim has been used.
    lazy = false,
  },
  {"boltlessengineer/smart-tab.nvim",
    opts = {},
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = {},
  },
  {
    -- Show git diff colors in the left column
    "lewis6991/gitsigns.nvim",
    opts = {},
  },
  { 
    -- show lightbulb where there are lsp actions
    'kosayoda/nvim-lightbulb',
    opts = {
      autocmd = { 
        enabled = true, 
        updatetime = 100,
      } 
    }
  },
  {
    -- show colored backgrounds behind hex values
    "norcalli/nvim-colorizer.lua",
    opts = {},
  },
  {
    -- show lsp errors under lines
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    opts = {},
    enabled = false,
  },
  {
    -- highlight symbol under cursor
    "RRethy/vim-illuminate",
    lazy = false,
  },
  { "nvim-tree/nvim-web-devicons", lazy = true },
  {
    "mrcjkb/rustaceanvim",
    version = '^4', -- Recommended
    lazy = false, -- load on startup
    -- config = function(_, opts) 
    keys = { 
        { "<leader>e" , function() vim.cmd.RustLsp('expandMacro') end, "Expand macros"}
    },
    init = function()
      vim.g.rustaceanvim = {
        server = {
          default_settings = {
            ['rust-analyzer'] = {
              workspace = {
                symbol = {
                  search = {
                    kind = "all_symbols"
                  }
                }
              }
            }
          }
        }
      }
    end
  },
  -- end of plugins
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'sh',
  callback = function()
    vim.lsp.start({
      name = 'bash-language-server',
      cmd = { 'bash-language-server', 'start' },
    })
  end,
})





-- TODO: exclude non-edit windows, like the context lines
go_to_next_window = function()
  local current_window = vim.fn.winnr()
  local total_windows = vim.fn.winnr('$')
  local target_window = (current_window % total_windows) + 1
  vim.api.nvim_command(target_window .. "wincmd w")
end
go_to_prev_window = function()
  local current_window = vim.fn.winnr()
  local total_windows = vim.fn.winnr('$')
  local target_window = (current_window +(total_windows-2)) % total_windows + 1
  vim.api.nvim_command(target_window .. "wincmd w")
end

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.smartindent = true

vim.opt.splitbelow = true -- Put new windows below current
vim.opt.splitkeep = "screen"
vim.opt.splitright = true -- Put new windows right of current

-- scroll before cursor reaches edge of window
vim.opt.scrolloff = 5

-- use system clipboard
vim.opt.clipboard = 'unnamedplus'

-- line numbers in left margin
vim.opt.number = true

vim.opt.winminwidth = 10 -- Minimum window width

vim.opt.virtualedit = "block" -- Allow cursor to move where there is no text in visual block mode

vim.g.mapleader = ' '
-- vim.keymap.set({'n', 'x'}, '<leader>y', '"+y', {desc = "Yank to clipboard"})
-- vim.keymap.set({'n', 'x'}, '<leader>p', '"+p', {desc = "Paste from clipboard"})

-- default mappings in Nvim 0.10
-- nmap("]d", vim.diagnostic.goto_next, "Next diagnostic")
-- nmap("[d", vim.diagnostic.goto_prev, "Previous diagnostic")



-- From LazyVim: https://www.lazyvim.org/configuration/general
vim.keymap.set({"n", "x"}, "j",  "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, noremap = true, silent = true, })
vim.keymap.set({"n", "x"}, "k",  "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, noremap = true, silent = true, })
vim.keymap.set({"n", "x"}, "<Down>",  "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, noremap = true, silent = true, })
vim.keymap.set({"n", "x"}, "<Up>",  "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, noremap = true, silent = true, })

-- From LazyVim: https://www.lazyvim.org/configuration/general
-- Add undo break-points
vim.keymap.set("i", ",", ",<c-g>u", {noremap = true, silent = true })
vim.keymap.set("i", ".", ".<c-g>u", {noremap = true, silent = true })
vim.keymap.set("i", ";", ";<c-g>u", {noremap = true, silent = true })
 
vim.keymap.set("n", "<leader>L", "<cmd>Lazy<cr>", { desc = "Lazy" })

vim.keymap.set("n", "<leader>w", "<c-w>", { desc = "Windows", noremap = true, silent = true })

-- From LazyVim: https://www.lazyvim.org/configuration/general
-- better indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")


nmap('U', "<cmd>redo<cr>", "Redo") 

nmap('<C-j>', go_to_next_window, "Next window")
nmap('<C-k>', go_to_prev_window, "Previous window")
nmap('<C-h>', '<CMD> bprevious <CR>', "Previous buffer")
nmap('<C-l>', '<CMD> bnext <CR>', "Next buffer")

nmap('<leader>k', vim.lsp.buf.hover, "Show LSP docs for symbol at cursor")
nmap("K", vim.diagnostic.open_float, "Show LSP messages at cursor")
-- TODO: treesitter-based fallback
nmap('<leader>r', vim.lsp.buf.rename, "Rename with LSP")

nivmap("<C-s>", '<CMD> wa <CR>', "Save all buffers" )

nmap('ge', 'G', "Go to end of file")
nmap('gD', vim.lsp.buf.declaration, "Go to declaration")
-- nmap('gd', vim.lsp.buf.definition, "Go to definition")

vim.keymap.set({ "n" }, "<leader> R" , "<cmd>InspectTree<cr>", { desc = "Inspect treesitter tree " })

vim.keymap.set({ "n" }, "<cr>", "<cmd>nohlsearch<cr> <cr>", { desc = "Enter and Clear hlsearch" })
vim.keymap.set({ "n" }, "<esc>", "<cmd>nohlsearch<cr><esc>", { desc = "Escape and Clear hlsearch" })

vim.keymap.set('v', 'R', '"_dP', {
  --noremap = true, 
  silent = true, 
  desc =  "replace with contents of clipboard"})

nmap('<leader>a',vim.lsp.buf.code_action, "Open LSP code actions")

nmap('<leader>?', '<CMD> Telescope keymaps <CR>', "search keymaps")
local telescope_mappings = {
  {'gd', "lsp_definitions", "Go to definitions"},
  {'gi', "lsp_implementations", "Go to implementations"},
  {'gt', "lsp_type_definitions", "Go to type definition"},
  {'gr', "lsp_references", "Go to references"},
  -- {'<leader>/', "live_grep", "Workspace grep"},
  {'<leader>/', "grep_string", "Workspace fuzzy text search", {
    path_display = { 'smart' },
    only_sort_text = true,
    word_match = "-w",
    search = '',
  }
  },
  {'<leader>b', "buffers", "Search open buffers"},
  {'<leader>f', "find_files", "Search files" },
  {'<leader>g', "git_files", "Search git files", {use_git_root=false} },
  {'<leader>P', "commands", "Search commands"},
  {'<leader>D', "diagnostics", "Workspace diagnostics", {sort_by="severity"}},
  {'<leader>d', "diagnostics", "Single file diagnostics", {bufnr=0, sort_by="severity"} },
  {'<C-f>', "current_buffer_fuzzy_find", "Current buffer fuzzy find"},
  {'<leader>s', "lsp_document_symbols", "LSP symbols in document"},
  {'<leader>S', "lsp_dynamic_workspace_symbols", "LSP symbols in workspace"},
  {'<leader>t', "treesitter", "Treesitter symbols"},
  {'<leader>T', "builtin", "Telescope builtins"},
  {'<leader>\'', "resume", "Resume last telescope picker"},
  {'<leader>j', "jumplist", "Jumplist"},
  {'<leader>o', "oldfiles", "Recent files"},
  {'<leader>O', "vim_options", "Vim options"},
  {'<leader>m', "marks", "Vim marks"},
}

apply_telescope_theme = function(opts)
  opts = opts or {}
  -- opts = require('telescope.themes').get_dropdown(opts)
  -- opts.layout_config.width = 0.9
  -- opts.layout_config.height = 0.9
  -- opts.layout_config.preview_cutoff = 1
  return opts
end

for _, mapping in ipairs(telescope_mappings) do
  local key, func, desc, opts = unpack(mapping)
  opts = apply_telescope_theme(opts)
  nmap(key, function() require("telescope.builtin")[func](opts) end, desc)
end

live_grep_word_under_cursor = function() 
  local opts = {default_text = vim.fn.expand("<cword>")}
  opts = apply_telescope_theme(opts)
  require("telescope.builtin").live_grep(opts)
end

nmap('<leader>*', live_grep_word_under_cursor, "Workspace grep for word under cursor")

--[[
vim.api.nvim_create_autocmd({"CursorHold", "CursorHoldI"}, {
  buffer = bufnr,
  callback = function()
    local opts = {
      focusable = false,
      close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
      border = 'rounded',
      source = 'always',
      prefix = ' ',
      scope = 'cursor',
    }
    vim.diagnostic.open_float(nil, opts)
  end
})
]]

-- -- Highlight on yank
-- vim.api.nvim_create_autocmd("TextYankPost", {
--   pattern  = "*",
--   callback = function() vim.highlight.on_yank { timeout = 200 } end
-- })
--
function autocommands()
  local function augroup(name)
    return vim.api.nvim_create_augroup("wrsh_autocommands_" .. name, { clear = true })
  end
  -- Highlight on yank
  -- From LazyVim: https://www.lazyvim.org/configuration/general
  vim.api.nvim_create_autocmd("TextYankPost", {
    group = augroup("highlight_yank"),
    callback = function()
      vim.highlight.on_yank({ timeout = 150 })
    end,
  })

  -- autoformat on save
  vim.api.nvim_create_autocmd('BufWritePre', {
    -- buffer = vim.fn.bufnr(),
    group = augroup("autoformat "),
    pattern = { "rust" };
    callback = function() vim.lsp.buf.format({ timeout_ms = 3000 }) end
  })

  -- Check if we need to reload the file when it changed
  -- From LazyVim: https://www.lazyvim.org/configuration/general
  vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
    group = augroup("checktime"),
    callback = function()
      if vim.o.buftype ~= "nofile" then
        vim.cmd("checktime")
      end
    end,
  })

  -- resize splits if window got resized
  -- From LazyVim: https://www.lazyvim.org/configuration/general
  vim.api.nvim_create_autocmd({ "VimResized" }, {
    group = augroup("resize_splits"),
    callback = function()
      local current_tab = vim.fn.tabpagenr()
      vim.cmd("tabdo wincmd =")
      vim.cmd("tabnext " .. current_tab)
    end,
  })

  -- close some filetypes with <q>
  -- From LazyVim: https://www.lazyvim.org/configuration/general
  vim.api.nvim_create_autocmd("FileType", {
    group = augroup("close_with_q"),
    pattern = {
      "PlenaryTestPopup",
      "help",
      "lspinfo",
      "notify",
      "qf",
      "spectre_panel",
      "startuptime",
      "tsplayground",
      "neotest-output",
      "checkhealth",
      "neotest-summary",
      "neotest-output-panel",
      "dbout",
    },
    callback = function(event)
      vim.bo[event.buf].buflisted = false
      vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
    end,
  })

  -- TODO: what does this do?
  -- From LazyVim: https://www.lazyvim.org/configuration/general
  -- make it easier to close man-files when opened inline
  vim.api.nvim_create_autocmd("FileType", {
    group = augroup("man_unlisted"),
    pattern = { "man" },
    callback = function(event)
      vim.bo[event.buf].buflisted = false
    end,
  })

  -- From LazyVim: https://www.lazyvim.org/configuration/general
  -- wrap and check for spell in text filetypes
  vim.api.nvim_create_autocmd("FileType", {
    group = augroup("wrap_spell"),
    pattern = { "*.txt", "*.tex", "*.typ", "gitcommit", "markdown" },
    callback = function()
      vim.opt_local.wrap = true
      vim.opt_local.spell = true
    end,
  })

end

autocommands()

-- J and K move selected lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")


-- Close help window with 'q'
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'help',
  callback = function()
    -- vim.api.nvim_buf_set_keymap(0, 'n', 'q', '<CMD> q <CR>', { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(0, 'n', 'q', '<CMD> helpclose <CR>', { noremap = true, silent = true })
  end,
})


vim.opt.cursorline = true -- highlight entire cursor line
vim.g.have_nerd_font = false -- effect unknown
vim.opt.undofile = true -- Default location appears to be ~/.local/state/nvim/undo/
vim.opt.inccommand = 'split' -- better previews for substitue commands (`:s/ ... / ... /g`)

vim.lsp.inlay_hint.enable(true)



nmap('<leader>=', function() vim.lsp.buf.format({ timeout_ms = 3000 }) end, "Format file")
