return {
  {
    "neovim/nvim-lspconfig",
    optional = true,
    init = function()
      -- unmap hover keymap
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      keys[#keys + 1] = { "K", false }
    end,
  },
  { -- better fold
    "kevinhwang91/nvim-ufo",
    enabled = true,
    event = { "BufRead", "BufNewFile" },
    dependencies = { "kevinhwang91/promise-async" },
    -- stylua: ignore
    keys = {
      { "zR", function() require("ufo").openAllFolds() end },
      { "zM", function() require("ufo").closeAllFolds() end },
      { "K", function()
          if not require("ufo").peekFoldedLinesUnderCursor() then
            vim.lsp.buf.hover()
          end
        end,
      },
    },
    -- Specifies code to run before this plugin is loaded.
    opts = function()
      local handler = function(virtText, lnum, endLnum, width, truncate)
        local newVirtText = {}
        local suffix = (" 󰁂 %d "):format(endLnum - lnum)
        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth
        local curWidth = 0
        for _, chunk in ipairs(virtText) do
          local chunkText = chunk[1]
          local chunkWidth = vim.fn.strdisplaywidth(chunkText)
          if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
          else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
              suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
            end
            break
          end
          curWidth = curWidth + chunkWidth
        end
        table.insert(newVirtText, { suffix, "MoreMsg" })
        return newVirtText
      end

      return {
        fold_virt_text_handler = handler,
        provider_selector = function()
          return { "treesitter", "indent" }
        end,
        preview = {
          win_config = { winblend = 0 },
        },
      }
    end,
  },
}
