local M = {}

function M.setup()
  local whichkey = require "which-key"

  local conf = {
    window = {
      border = "single", -- none, single, double, shadow
      position = "bottom", -- bottom, top
    },
  }

  local opts = {
    mode = "n", -- Normal mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false, -- use `nowait` when creating keymaps
  }

  local mappings = {
    ["w"] = { "<cmd>update!<CR>", "Save" },
    ["q"] = { "<cmd>q!<CR>", "Quit" },
		["r"] = { "<cmd>e<CR>", "Reload file"},

    b = {
      name = "Buffer",
      c = { "<cmd>bd!<Cr>", "Close current buffer" },
      D = { "<cmd>%bd|e#|bd#<Cr>", "Delete all buffers" },
			e = { "<ccc>Neotree source=buffers position=current<CR>", "Explore all buffers" },
			b = { "<cmd>Telescope buffers<CR>", "Find buffer with Telescope" }
    },

    z = {
      name = "Packer",
      c = { "<cmd>PackerCompile<cr>", "Compile" },
      i = { "<cmd>PackerInstall<cr>", "Install" },
      s = { "<cmd>PackerSync<cr>", "Sync" },
      S = { "<cmd>PackerStatus<cr>", "Status" },
      u = { "<cmd>PackerUpdate<cr>", "Update" },
    },

    n = {
      name = "Netrw",
      s = { "<cmd>Explore<CR>", "Filebrowser" },
    },

		f = {
			name = "Files",
			e = { "<cmd>Neotree position=current<CR>", "Explore file tree" },
			f = { "<cmd>Telescope find_files<CR>", "Find Files with Telescope" },
			g = { "<cmd>Telescope live_grep<CR>", "Grep Files with Telescope" },
		},

		F = {
			name = "Formatting Helpers",
			f = { function () require('whitespace-nvim').trim() end, "Remove trailing whitespace" }
	 	},

		t = {
			name = "Testing",
			n = { function() require("neotest").run.run() end, "Run nearest test" },
			f = { function() require("neotest").run.run(vim.fn.expand("%")) end, "Run whole test file" },
			p = { function() require("neotest").output_panel.toggle() end, "Toggle output panel" },
		},

		h = {
			name = "Help",
			t = { "<cmd>Telescope help_tags<CR>", "Telescope Help Tags" },
			s = { "<cmd>SymbolsOutline<CR>", "Toggle SymbolsOutline" }
		},

		T = {
			name = "TODO's",
			l = { "<cmd>TodoLocList<CR>", "Show TODO's in Location List" },
			q = { "<cmd>TodoQuickFix<CR>", "Show TODO's in Quickfix List" },
			t = { "<cmd>TodoTelescope<CR>", "Show TODO's in Telescope" },
		}
  }

  whichkey.setup(conf)
  whichkey.register(mappings, opts)
end

return M
