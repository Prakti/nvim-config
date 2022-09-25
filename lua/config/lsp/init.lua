local M = {}

local servers = {
	"elixirls",
	"erlangls",
	"html",
	"sumneko_lua",
}

local lua_settings = {
	Lua = {
		runtime = {
			diagnostics = {
				globals = {'vim'}
			},
		}
	}
}

local function on_attach(client, bufnr)
  -- Enable completion triggered by <C-X><C-O>
  -- See `:help omnifunc` and `:help ins-completion` for more information.
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Use LSP as the handler for formatexpr.
  -- See `:help formatexpr` for more information.
  vim.api.nvim_buf_set_option(0, "formatexpr", "v:lua.vim.lsp.formatexpr()")

  -- Configure key mappings
  require("config.lsp.keymaps").setup(client, bufnr)
end

function M.setup()
	require("mason").setup({
		ui = {
			icons = {
				package_installed = "✓",
				package_pending = "➜",
				package_uninstalled = "✗"
			}
		}
	})

	local mason_lspconfig = require("mason-lspconfig")
	mason_lspconfig.setup({
		ensure_installed = servers
	})

	mason_lspconfig.setup_handlers({
		function (server_name)
			local lspconfig = require("lspconfig")

			if server_name == "sumneko_lua" then
				lspconfig[server_name].setup({
					on_attach = on_attach,
					settings = lua_settings
				})
			else
				lspconfig[server_name].setup({
					on_attach = on_attach
				})
			end
		end
	})

end

return M
