local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("lazy").setup("plugins", {
  install = {
    colorscheme = { "tokyonight", "habamax" },
  },
  default = { lazy = true, },
  change_detection = {
    -- automatically check for plugin updates
    notify = false,
  },
  performance = {
    cache = {
      enabled = true,
    },
    reset_packpath = true, -- reset the package path to improve startup time
    rtp = {
      reset = true, -- reset the runtime path to $VIMRUNTIME and your config directory
      ---@type string[]
      paths = {}, -- add any custom paths here that you want to includes in the rtp
      ---@type string[] list any plugins you want to disable here
      disabled_plugins = {
        "gzip", -- Plugin for editing compressed files.
        -- "matchit", -- What is it?
        --  "matchparen", -- Plugin for showing matching parens
         "netrwPlugin", -- Handles file transfers and remote directory listing across a network
         "tarPlugin", -- Plugin for browsing tar files
         "tohtml", -- Converting a syntax highlighted file to HTML
         -- "tutor", -- Vim tutorial
         "zipPlugin", -- Handles browsing zipfiles
      },
    },
  },
})
