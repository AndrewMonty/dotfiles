return {
  "johmsalas/text-case.nvim",
  dependencies = { "nvim-telescope/telescope.nvim" },
  config = function()
    require("textcase").setup({})
    require("telescope").load_extension("textcase")
  end,
  keys = {
    "tc", -- Default invocation prefix
    { "tc.", "<cmd>TextCaseOpenTelescope<CR>", mode = { "n", "x" }, desc = "Telescope" },
    { "tcd", "<cmd>textcase.api.to_dot_case<CR>", mode = { "n", "x" }, desc = "[T]ext [C]onvert to [D]ot Case" },
    { "tck", "<cmd>textcase.api.to_dash_case<CR>", mode = { "n", "x" }, desc = "[T]ext [C]onvert to [K]ebab Case" },
    { "tcs", "<cmd>textcase.api.to_dash_case<CR>", mode = { "n", "x" }, desc = "[T]ext [C]onvert to [S]nake Case" },
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
}
