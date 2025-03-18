return {
  -- 🌳 Treesitter (Better Syntax Highlighting)
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "python", "ninja", "rst" },
    },
  },

  -- 🚀 LSP Configuration (Pyright, Ruff, Ruff-LSP)
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {}, -- Type checking & autocomplete
        basedpyright = {},
        ruff = {
          cmd_env = { RUFF_TRACE = "messages" },
          init_options = {
            settings = { logLevel = "error" },
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
        ruff_lsp = {
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
        ["ruff"] = function()
          LazyVim.lsp.on_attach(function(client, _)
            -- Disable hover in favor of Pyright
            client.server_capabilities.hoverProvider = false
          end)
        end,
      },
    },
  },

  -- 🧪 Neotest for Python Testing
  {
    "nvim-neotest/neotest-python",
  },

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
