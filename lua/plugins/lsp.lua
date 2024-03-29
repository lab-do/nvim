return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        signs = false,
      },
      servers = {
        -- pyright will be automatically installed with mason and loaded with lspconfig
        ----@type lspconfig.options.svelte
        svelte = {},
        ----@type lspconfig.options.tailwindcss
        tailwindcss = {
          settings = {
            tailwindCSS = {
              experimental = {
                classRegex = {
                  -- Custom class name attributes (e.g. buttonClassName)
                  { [==[[a-zA-Z]*ClassName=["'`]([^"'`]+)["'`]]==] },
                  -- cls, clsx
                  -- https://github.com/tailwindlabs/tailwindcss-intellisense/issues/682#issuecomment-1364585313
                  {
                    [[cn\(([^)(]*(?:\([^)(]*(?:\([^)(]*(?:\([^)(]*\)[^)(]*)*\)[^)(]*)*\)[^)(]*)*)\)]],
                    '"(.*?)"',
                  },
                  -- Tailwind Variants
                  -- https://www.tailwind-variants.org/docs/getting-started#intellisense-setup-optional
                  {
                    [[tv\(([^)(]*(?:\([^)(]*(?:\([^)(]*(?:\([^)(]*\)[^)(]*)*\)[^)(]*)*\)[^)(]*)*)\)]],
                    '"(.*?)"',
                  },
                  -- `styles` objects
                  -- https://github.com/tailwindlabs/tailwindcss-intellisense/issues/682#issuecomment-1364585313
                  { [[styles =([^}]*)\}]], [==[["'`]([^"'`]*).*?["'`]]==] },
                },
              },
            },
          },
        },
      },
      -- you can do any additional lsp server setup here
      -- return true if you don't want this server to be setup with lspconfig
      setup = {
        -- example to setup with typescript.nvim
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      -- add more treesitter parsers
      ensure_installed = {
        "bash",
        "html",
        "css",
        "svelte",
        "javascript",
        "typescript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "yaml",
        "toml",
        "sql",
      },
    },
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ui = {
        border = "rounded",
      },
      ensure_installed = {
        "stylua",
        "prettierd",
        "svelte-language-server",
        "tailwindcss-language-server",
      },
    },
  },
}
