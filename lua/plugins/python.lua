return {
  -- 🌳 Treesitter (Better Syntax Highlighting)
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "python", "ninja", "rst" },
    },
  },

  -- 🚀 LSP Configuration (Pyright + Ruff LSP)
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {}, -- Type checking & autocomplete
        basedpyright = {},

        ruff_lsp = {
          init_options = {
            settings = {
              logLevel = "error", -- or "debug" for verbose logs
            },
          },
          keys = {
            {
              "<leader>co",
              function()
                vim.lsp.buf.execute_command({ command = "ruff.applyOrganizeImports" })
              end,
              desc = "Organize Imports",
            },
          },
        },
      },

      setup = {
        ["ruff_lsp"] = function(_, opts)
          LazyVim.lsp.on_attach(function(client, _)
            if client.name == "ruff_lsp" then
              client.server_capabilities.hoverProvider = false -- let pyright handle hover
            end
          end)
          require("lspconfig").ruff_lsp.setup(opts)
          return true
        end,
      },
    },
  },

  -- 🧪 Neotest for Python Testing
  { "nvim-neotest/neotest-python" },

  -- 💬 Comments
  { "preservim/nerdcommenter" },

  -- 🐍 Debugging with nvim-dap-python
  {
    "mfussenegger/nvim-dap-python",
    dependencies = { "mfussenegger/nvim-dap" },
    keys = {
      {
        "<leader>dPt",
        function()
          require("dap-python").test_method()
        end,
        desc = "Debug Method",
        ft = "python",
      },
      {
        "<leader>dPc",
        function()
          require("dap-python").test_class()
        end,
        desc = "Debug Class",
        ft = "python",
      },
    },
    config = function()
      local debugpy_path
      if vim.fn.has("win32") == 1 then
        debugpy_path = LazyVim.get_pkg_path("debugpy", "/venv/Scripts/pythonw.exe")
      else
        debugpy_path = LazyVim.get_pkg_path("debugpy", "/venv/bin/python")
      end
      require("dap-python").setup(debugpy_path)
    end,
  },
}
