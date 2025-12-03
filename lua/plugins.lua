require('nvim-navic').setup {
    lsp = { auto_attach = true },
}

-- Install as secondary plugin for nvim-navic icon colors.
require('catppuccin').setup {
    integrations = {
        navic = {
            enabled = false,
            custom_bg = "NONE",
        },
    },
}

-- GitHub AI autocomplete.
require('plugins/copilot')

-- Multiple cursors functionality.
require('plugins/vim-visual-multi')

-- Leap - Amazing s and f commands.
require('plugins/leap')

-- Treesitter for Ast parsing!
-- Note: There are additional installation instructions
-- in https://github.com/wbthomason/packer.nvim about folding that I
-- ignored.
require('plugins/treesitter')
-- run = ':TSUpdate',

-- Fuzzy finder.
require('plugins/telescope')

-- Automatic Lsp Configurations.
require('plugins/nvim-lspconfig')

-- Debugging
-- TODO: move to a configuration file.
local dap = require('dap')
dap.adapters.lldb = {
    type = 'executable',
    command = 'C:/Program Files/LLVM/bin/lldb-vscode', -- must be absolute path
    name = "lldb"
}
dap.configurations.cpp = {
    {
        name = 'Launch',
        type = 'lldb',
        request = 'launch',
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = {},
    },
}
dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = {
    {
        name = 'Launch',
        type = 'lldb',
        request = 'launch',
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = {},
        initCommands = function()
            -- Find out where to look for the pretty printer Python module
            local rustc_sysroot = vim.fn.trim(vim.fn.system('rustc --print sysroot'))

            local script_import = 'command script import "' .. rustc_sysroot .. '/lib/rustlib/etc/lldb_lookup.py"'
            local commands_file = rustc_sysroot .. '/lib/rustlib/etc/lldb_commands'

            local commands = {}
            local file = io.open(commands_file, 'r')
            if file then
                for line in file:lines() do
                    table.insert(commands, line)
                end
                file:close()
            end
            table.insert(commands, 1, script_import)

            return commands
        end,
    },
}

-- Automatic rust configurations.
require('plugins/rust-tools')

require('twilight').setup {}
require('zen-mode').setup {}

-- use {
--     "Maan2003/lsp_lines.nvim",
--     config = function()
--         require("lsp_lines").setup()
--         -- Disable virtual_text since it's redundant due to lsp_lines.
--         vim.diagnostic.config({
--             virtual_text = false,
--         })
--     end,
-- }

-- -- Completion engine!
-- use {
-- 'hrsh7th/nvim-cmp',
-- as = 'nvim-cmp',
-- requires = {
-- 'hrsh7th/cmp-nvim-lsp',
-- 'hrsh7th/cmp-buffer',
-- 'hrsh7th/cmp-path',
-- 'hrsh7th/cmp-cmdline',
-- },
-- config = function()
-- require('plugins/nvim-cmp')
-- end,
-- }

-- Small minimap plugin!
-- <leader>mm toggle
-- <leader>mc close
-- <leader>mo open
-- <leader>mf focus
local codewindow = require('codewindow')
codewindow.setup()
codewindow.apply_default_keybinds()

-- LLM generation.
vim.keymap.set('v', '<leader>]', ':Gen<CR>')
vim.keymap.set('n', '<leader>]', ':Gen<CR>')
require('gen').command = 'wsl -e ollama run $model $prompt' -- default 'ollama run $model $prompt'

-- better typescript support!
require("plugins/typescript-tools")

-- Lean
require('plugins/lean')

-- Taboo - tab renaming!
require('plugins/taboo')
