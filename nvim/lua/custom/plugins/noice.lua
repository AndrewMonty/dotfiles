return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  opts = {
    presets = {
      command_palette = true,
      long_message_to_split = true,
    },
    cmdline = {
      format = {
        cmdline = { icon = ":" },
      },
    },
    routes = {
      {
        view = "notify",
        filter = { event = "msg_showmode" },
      },
      {
        filter = {
          event = "msg_show",
          kind = "",
          find = "written",
        },
        opts = { skip = true },
      },
    },
    lsp = {
      hover = {
        silent = true,
      },
    },
  },
  dependencies = {
    'MunifTanjim/nui.nvim',
    'rcarriga/nvim-notify',
  },
}
