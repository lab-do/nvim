local vault_path = "/mnt/buckup/documents/obsidian"

return {
  {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    event = {
      -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
      -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
      ("BufReadPre %s/**.md"):format(vault_path),
      ("BufNewFile %s/**.md"):format(vault_path),
    },
    cmd = { "ObsidianToday", "ObsidianYesterday", "ObsidianTomorrow", "ObsidianNew", "ObsidianSearch" },
    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<leader>nd", "<cmd>ObsidianDailies<CR>", desc = "Daily notes" },
      { "<leader>nn", "<cmd>ObsidianNew<cr>", desc = "New note" },
      { "<leader>nj", "<cmd>ObsidianToday<CR>", desc = "Today note" },
      { "<leader>nt", "<cmd>ObsidianTemplate<CR>", desc = "Template" },
      { "<leader>nb", "<cmd>ObsidianBacklinks<cr>", desc = "Backlinks" },
      { "<leader>nl", "<cmd>ObsidianLink<cr>", desc = "Link selection" },
      { "<leader>nf", "<cmd>ObsidianFollowLink<cr>", desc = "Follow link under cursor" },
      { "<leader>ns", "<cmd>ObsidianSearch<cr>", desc = "Search" },
      { "<leader>nr", "<cmd>ObsidianRename<cr>", desc = "Rename" },
      { "<leader>nf", "<cmd>ObsidianQuickSwitch<cr>", desc = "Find" },
      { "<leader>ng", "<cmd>ObsidianTags<cr>", desc = "Tags" },
      { "<leader>nw", "<cmd>ObsidianWorkspace personal<cr>", desc = "Personal workspace" },
      { "<leader>no", "<cmd>ObsidianOpen<cr>", desc = "Open in app" },
    },
    opts = {
      workspaces = {
        {
          name = "personal",
          path = vault_path,
        },
      },
      completion = {
        nvim_cmp = true,
      },
      -- see below for full list of options 👇
      daily_notes = {
        -- Optional, if you keep daily notes in a separate directory.
        folder = "Journal/Daily",
        -- Optional, if you want to change the date format for the ID of daily notes.
        date_format = "%Y-%m-%d",
        -- Optional, if you want to change the date format of the default alias of daily notes.
        alias_format = "%B %-d, %Y",
        -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
        template = "Assets/Templates/nvim/daily.md",
      },

      templates = {
        folder = "Assets/Templates",
        date_format = "%Y-%m-%d",
        time_format = "%H:%M",
        -- A map for custom variables, the key should be the variable and the value a function
        substitutions = {
          ["now"] = function()
            return os.date("%Y-%m-%d %H:%M")
          end,
          ["long-date"] = function()
            return os.date("%A, %B %d %Y")
          end,
        },
      },

      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { "markdown" },
      },

      -- `true` indicates that you don't want obsidian.nvim to manage frontmatter.
      disable_frontmatter = true,

      -- Optional, alternatively you can customize the frontmatter data.
      ---@return table
      note_frontmatter_func = function(note)
        local out = {
          aliases = note.aliases,
          tags = note.tags,
          created = os.date("%Y-%m-%d %H:%M"),
        }

        -- `note.metadata` contains any manually added fields in the frontmatter.
        -- So here we just make sure those fields are kept in the frontmatter.
        if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
          for k, v in pairs(note.metadata) do
            out[k] = v
          end
        end

        return out
      end,

      mappings = {
        -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
        ["gf"] = {
          action = function()
            return require("obsidian").util.gf_passthrough()
          end,
          opts = { noremap = false, expr = true, buffer = true },
        },
        -- Toggle check-boxes.
        ["<leader>nc"] = {
          action = function()
            return require("obsidian").util.toggle_checkbox()
          end,
          opts = { buffer = true, desc = "Toggle checkbox" },
        },
      },

      ui = {
        enable = false, -- Handeled by markdown.nvim
        checkboxes = {
          -- NOTE: the 'char' value has to be a single character, and the highlight groups are defined below.
          [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
          ["x"] = { char = "", hl_group = "ObsidianDone" },
          [">"] = { char = "", hl_group = "ObsidianRightArrow" },
          ["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },

          ["%-"] = { char = "󰛲", hl_group = "Comment" },
          ["!"] = { char = "󰩳", hl_group = "Error" },
          ["%?"] = { char = "󰞋", hl_group = "Added" },
        },
      },
    },
  },
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      spec = {
        { "<leader>n", group = "obsidian", icon = "" },
      },
    },
  },
}
