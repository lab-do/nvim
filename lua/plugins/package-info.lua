return {
  {
    "vuki656/package-info.nvim",
    dependencies = { "folke/which-key.nvim", "MunifTanjim/nui.nvim" },
    ft = { "json" },
    opts = {
      colors = {
        up_to_date = "#B1D99C", -- Text color for up to date dependency virtual text
        outdated = "#EAAC86", -- Text color for outdated dependency virtual text
      },

      icons = {
        enable = true, -- Whether to display icons
        style = {
          up_to_date = "|  ", -- Icon for up to date dependencies
          outdated = "|  ", -- Icon for outdated dependencies
        },
      },
      autostart = true, -- Whether to autostart when `package.json` is opened
      hide_up_to_date = false, -- It hides up to date versions when displaying virtual text
      hide_unstable_versions = false, -- It hides unstable versions from version list e.g next-11.1.3-canary3
      -- Can be `npm`, `yarn`, or `pnpm`. Used for `delete`, `install` etc...
      -- The plugin will try to auto-detect the package manager based on
      -- `yarn.lock` or `package-lock.json`. If none are found it will use the
      -- provided one, if nothing is provided it will use `yarn`
      package_manager = "pnpm",
    },
    keys = function()
      local function map(key, cmd, desc)
        vim.keymap.set({ "n" }, "<leader>p" .. key, cmd, { desc = desc, silent = true, noremap = true })
      end
      local pi = require("package-info")
      map("p", pi.toggle, "Toggle package info")
      map("s", pi.show, "Show package info")
      map("h", pi.hide, "Hide package info")
      map("u", pi.update, "Update package")
      map("d", pi.delete, "Delete package")
      map("i", pi.install, "Install package")
      map("v", pi.change_version, "Change package version")
    end,
  },
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      defaults = {
        ["<leader>p"] = { name = "PackageInfo" },
      },
    },
  },
}
