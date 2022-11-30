local M = {}

function M.setup()
  -- Indicate first time installation
  local packer_bootstrap = false

  -- packer.nvim configuration
  local conf = {
    display = {
      open_fn = function()
        return require("packer.util").float { border = "rounded" }
      end,
    },
  }

  -- Check if packer.nvim is installed
  -- Run PackerCompile if there are changes in this file
  local function packer_init()
    local fn = vim.fn
    local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
      packer_bootstrap = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
      }
      vim.cmd [[packadd packer.nvim]]
    end
    vim.cmd "autocmd BufWritePost plugins.lua source <afile> | PackerCompile"
  end

  -- Plugins
  local function plugins(use)
		-- Have Packer manage itself
    use { "wbthomason/packer.nvim" }

		-- Plenary (Util lib for other Plugins)
		use { "nvim-lua/plenary.nvim", module = "plenary" }

		-- UI Lib 
		use { "MunifTanjim/nui.nvim", module = "nui" }

		-- Better Icons 
		use {
			"kyazdani42/nvim-web-devicons",
			module = "nvim-web-devicons",
		}

		-- Kanagawa Colorscheme
    use {
      "rebelot/kanagawa.nvim",
      config = function()
				require('kanagawa').setup()

        vim.cmd [[colorscheme kanagawa]]
      end,
    }

    -- Gruvbox Colorscheme
	  use { "ellisonleao/gruvbox.nvim" }

		-- Onebuddy Colorscheme
		use {'Th3Whit3Wolf/onebuddy',
      requires = { "tjdevries/colorbuddy.vim" }
	  }


		-- Monokai Colorscheme
		use {
			"tanvirtin/monokai.nvim",
			config = function()
				require('monokai').setup()
			end,
		}

		-- Sonokai Colorscheme
		use { "sainnhe/sonokai" }

		-- WichKey key suggester
		use {
			"folke/which-key.nvim",
			config = function()
				require("config.whichkey").setup()
			end,
		}

		-- Use an improved Filebrowser (Can also do buffers)
		use {
			"nvim-neo-tree/neo-tree.nvim",
			branch = "v2.x",
			requires = {
				"nvim-lua/plenary.nvim",
				"kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
				"MunifTanjim/nui.nvim",
			},
			config = function()
				-- Unless you are still migrating, remove the deprecated commands from v1.x
				vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

				require("neo-tree").setup()
			end,
		}

		-- Use an improved statusline
		use {
			'nvim-lualine/lualine.nvim',
			requires = { 'kyazdani42/nvim-web-devicons' },
			config = function ()
				-- require("lualine").setup({ theme = 'monokai'})
				require("lualine").setup({ theme = 'monokai'})
			end,
		}

		-- Use Treesitter for better syntax highlighting
		use {
			'nvim-treesitter/nvim-treesitter',
			run = function()
				require('nvim-treesitter.install').update({ with_sync = true})
			end,
			config = function ()
				require('nvim-treesitter.configs').setup({
					ensure_installed = { "lua", "elixir", "eex", "heex" },
					sync_install = false,
					hightlight = { enable = true },
					auto_install = true,
					additional_vim_regex_highlighting = false,
				})

				-- Apply a workaround to make folding and syntax highlighting behave correctly
				vim.api.nvim_create_autocmd({'BufEnter', 'BufAdd', 'BufNew', 'BufNewFile', 'BufWinEnter'}, {
					group = vim.api.nvim_create_augroup('TS_FOLD_WORKAROUND', {}),
					callback = function ()
						-- Uncomment this to make folding work nicely
						-- vim.opt.foldmethod = 'expr'
						-- vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'

						-- This brute-forces syntax highlighting to work
				    vim.cmd([[TSEnable highlight]])
					end,
				})
			end,
		}

		-- Better Commenting functions
		use {
			"numToStr/Comment.nvim",
			opt = true,
			keys = { "gc", "gcc", "gbc" },
			config = function()
				require("Comment").setup {}
			end,
		}

		-- Autocompletion with CMP
		use {
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lua",
			"ray-x/cmp-treesitter",
			"hrsh7th/cmp-emoji",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-cmdline",
	    "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-calc",
      "f3fora/cmp-spell",
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",
		}

    -- Mason for easy installation of LSP's
		use {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"neovim/nvim-lspconfig",
		}

		-- Show linter warnings from LSP
		use {
			"folke/trouble.nvim",
			requires = "kyazdani42/nvim-web-devicons",
			config = function()
				require("trouble").setup({ })
			end
		}

		-- Telescope for better Finding of Stuff
		use {
			'nvim-telescope/telescope.nvim', tag = '0.1.0',
			requires = { "nvim-lua/plenary.nvim" }
		}

    if packer_bootstrap then
      print "Restart Neovim required after installation!"
      require("packer").sync()
    end
  end

  packer_init()

  local packer = require "packer"
  packer.init(conf)
  packer.startup(plugins)
end

return M
