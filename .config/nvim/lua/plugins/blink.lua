return {
  "saghen/blink.cmp",
  opts = {
    keymap = {
      preset = "default",

      -- Enter should make a newline, not accept completion
      ["<CR>"] = { "fallback" },

      -- Tab accepts the currently highlighted suggestion
      ["<Tab>"] = {
        function(cmp)
          if cmp.is_visible() then
            return cmp.accept()
          end
        end,
        "snippet_forward",
        "fallback",
      },

      -- Shift+Tab can go backwards in snippets / fallback normally
      ["<S-Tab>"] = {
        "snippet_backward",
        "fallback",
      },
    },

    completion = {
      list = {
        selection = {
          -- Automatically highlight the first suggestion
          preselect = true,

          -- Do NOT insert it into the text until you press Tab
          auto_insert = false,
        },
      },
    },
  },
}
