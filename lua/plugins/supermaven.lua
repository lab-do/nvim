return {
  "supermaven-inc/supermaven-nvim",
  event = "BufRead",
  config = function()
    require("supermaven-nvim").setup({
      keymaps = {
        accept_word = "<C-]>",
        clear_suggestion = "<C-[>",
      },
      color = {
        suggestion_color = "#414868",
        cterm = 244,
      },
      disable_inline_completion = false, -- disables inline completion for use with cmp
      disable_keymaps = false, -- disables built in keymaps for more manual control
    })
  end,
}
