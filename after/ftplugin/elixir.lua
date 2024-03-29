vim.bo.shiftwidth = 2
vim.bo.tabstop = 2
vim.bo.softtabstop = 2
vim.bo.textwidth = 78

require("neotest").setup({
  adapters = {
    require("neotest-elixir")({
      -- The Mix task to use to run the tests
      -- Can be a function to return a dynamic value.
      -- Default: "test"
      -- mix_task = {"my_custom_task"},
      -- Other formatters to pass to the test command as the formatters are overridden
      -- Can be a function to return a dynamic value.
      -- Default: {"ExUnit.CLIFormatter"}
      -- extra_formatters = {"ExUnit.CLIFormatter", "ExUnitNotifier"},
      -- Extra arguments to pass to mix test
      -- Can be a function that receives the position, to return a dynamic value
      -- Default: {}
      -- args = {"--trace"},
      -- Delays writes so that results are updated at most every given milliseconds
      -- Decreasing this number improves snappiness at the cost of performance
      -- Can be a function to return a dynamic value.
      -- Default: 1000
      -- write_delay = 1000,
    }),
  }
})
