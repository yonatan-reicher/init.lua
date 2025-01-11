vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

    -- Icons!
    use 'nvim-tree/nvim-web-devicons'

    use {
        "SmiteshP/nvim-navic",
        requires = {
            "neovim/nvim-lspconfig",
        },
        config = function()
            require('nvim-navic').setup {
                lsp = {
                    auto_attach = true,
                },
            }
        end,
    }
    
    -- Install as secondary plugin for nvim-navic icon colors.
    use {
        "catppuccin/nvim",
        as = "catppuccin",
        config = function()
            require('catppuccin').setup {
                integrations = {
                    navic = {
                        enabled = false,
                        custom_bg = "NONE",
                    },
                },
            }
        end,
    }
    
    -- Status line plugin.
    -- The configuration uses nvim-navic (for finding what function the cursor
    -- is at)
	use({
		'glepnir/galaxyline.nvim',
		branch = 'main',
		-- your statusline
		config = function()
			require('plugins/statusline')
		end,
	})

    -- Adds the tokyonight colorschemes.
    use {
        'folke/tokyonight.nvim',
        config = function()
            require('plugins/tokyonight')
        end,
    }

    -- Adds the hybrid colorscheme.
    use 'w0ng/vim-hybrid'

    -- Git support via :G.
    use 'tpope/vim-fugitive'

    -- GitHub AI autocomplete.
    use {
        'github/copilot.vim',
        config = function()
            require('plugins/copilot')
        end,
    }

    -- Multiple cursors functionality.
    use {
        'mg979/vim-visual-multi',
        config = function()
            require('plugins/vim-visual-multi')
        end
    }

    -- iv and av text-objects.
    use {
        'Julian/vim-textobj-variable-segment',
        requires = { 'kana/vim-textobj-user' },
    }

    -- Leap - Amazing s and f commands.
    use {
        'ggandor/leap.nvim',
        requires = { 'tpope/vim-repeat' },
        config = function ()
            require('plugins/leap')
        end
    }
    
    -- Treesitter for Ast parsing!
    -- Note: There are additional installation instructions
    -- in https://github.com/wbthomason/packer.nvim about folding that I
    -- ignored.
    use {
        'nvim-treesitter/nvim-treesitter',
        config = function()
            require('plugins/treesitter')
        end,
        run = ':TSUpdate',
    }

    -- Fuzzy finder.
    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            { 'nvim-lua/plenary.nvim' },
        },
        config = function()
            require('plugins/telescope')
        end,
    }

    -- Automatic Lsp Configurations.
    use {
        'neovim/nvim-lspconfig',
        config = function()
            require('plugins/nvim-lspconfig')
        end,
    }

    -- Debugging
    -- TODO: move to a configuration file.
    use {
        'mfussenegger/nvim-dap',
        requires = { 'nvim-lua/plenary.nvim' },
        config = function()
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
        end,
    }

    -- Automatic rust configurations.
    use {
        'simrat39/rust-tools.nvim',
        config = function()
            require('plugins/rust-tools')
        end
    }

    -- Editing parenthesis with commands like `csiw{`.
    use {
        'tpope/vim-surround',
    }

    -- ai and ii text objects.
    use {
        'michaeljsmith/vim-indent-object'
    }

    -- Git magrins.
    use 'airblade/vim-gitgutter'

    use {
        'folke/twilight.nvim',
        config = function()
            require('twilight').setup {}
        end,
    }
    use {
        'folke/zen-mode.nvim',
        config = function()
            require('zen-mode').setup {}
        end,
    }

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

    -- Dispalying lists.
    use {
        "folke/trouble.nvim",
        config = function()
            require("trouble").setup {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end,
    }

    -- Completion engine!
    use {
        'hrsh7th/nvim-cmp',
        as = 'nvim-cmp',
        requires = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
        },
        config = function()
            require('plugins/nvim-cmp')
        end,
    }

    -- Small minimap plugin!
    -- <leader>mm toggle
    -- <leader>mc close
    -- <leader>mo open
    -- <leader>mf focus
    use {
        'gorbit99/codewindow.nvim',
        config = function()
            local codewindow = require('codewindow')
            codewindow.setup()
            codewindow.apply_default_keybinds()
        end,
    }

    use {
        'David-Kunz/gen.nvim',
        config = function()
            vim.keymap.set('v', '<leader>]', ':Gen<CR>')
            vim.keymap.set('n', '<leader>]', ':Gen<CR>')
            require('gen').command = 'wsl -e ollama run $model $prompt' -- default 'ollama run $model $prompt'
        end,
    }

    use {
        'PhilT/vim-fsharp',
        config = function()
        end,
    }

    -- Syntax highlighting for Dafny.
    use {
        'mlr-msft/vim-loves-dafny',
        config = function()
        end,
    }

    -- Latex support.
    use {
        'lervag/vimtex',
        config = function ()
        end,
    }
    
    use {
        'whonore/Coqtail',
        config = function ()
        end,
    }

    -- better typescript support!
    use {
        "pmizio/typescript-tools.nvim",
        requires = {
            "nvim-lua/plenary.nvim",
            "neovim/nvim-lspconfig",
        },
        config = function()
            require("plugins/typescript-tools")
        end,
    }
end)
