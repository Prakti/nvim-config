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
				local overrides = function (colors)
					return {
			  	  ["@symbol"] = { fg = colors.lightBlue },
					}
				end

				require('kanagawa').setup({
					overrides = overrides,
				})
      end,
    }

    -- Gruvbox Colorscheme
	  use { "ellisonleao/gruvbox.nvim" }

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

    use {
			'navarasu/onedark.nvim',
			config = function()
				require('onedark').setup({
					style = 'deep'
				})
			end

		}

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
				require("lualine").setup({ theme = 'kanagawa'})
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
					callback = function ()
						-- This brute-forces syntax highlighting to work
				    vim.cmd([[TSEnable highlight]])
					end,
				})
			end,
		}

		-- Better Commenting functions
		use {
			"numToStr/Comment.nvim",
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

    use {
			'simrat39/symbols-outline.nvim',
       config = function ()
				 require("symbols-outline").setup()
			 end
		}

		-- Telescope for better Finding of Stuff
		use {
			'nvim-telescope/telescope.nvim',
			requires = { "nvim-lua/plenary.nvim" }
		}

		-- Nvim-nio for async-io execution of e.g. tests
		use { "nvim-neotest/nvim-nio" }

		-- Testing support
		use {
			'nvim-neotest/neotest',
			requires = {
				"nvim-lua/plenary.nvim",
				"nvim-treesitter/nvim-treesitter",
				"antoinemadec/FixCursorHold.nvim",
				"jfpedroza/neotest-elixir",
        "nvim-neotest/nvim-nio",
			}
		}

		-- Todo Management
		use {
			"folke/todo-comments.nvim",
			requires = "nvim-lua/plenary.nvim",
			config = function()
				require("todo-comments").setup {
					-- your configuration comes here
					-- or leave it empty to use the default settings
					-- refer to the configuration section below
				}
			end
		}

		-- Whitespace Handling
		use {
			'johnfrankmorgan/whitespace.nvim',
			config = function ()
				require('whitespace-nvim').setup({
					-- configuration options and their defaults

					-- `highlight` configures which highlight is used to display
					-- trailing whitespace
					highlight = 'DiffDelete',

					-- `ignored_filetypes` configures which filetypes to ignore when
					-- displaying trailing whitespace
					ignored_filetypes = { 'TelescopePrompt', 'Trouble', 'help', 'neo-tree' },

					-- `ignore_terminal` configures whether to ignore terminal buffers
					ignore_terminal = true,
				})
			end
		}

		-- Git Support (Commit from neovim itself)
		use({
			"kdheepak/lazygit.nvim",
			-- optional for floating window border decoration
			requires = {
				"nvim-lua/plenary.nvim",
			}
		})

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
