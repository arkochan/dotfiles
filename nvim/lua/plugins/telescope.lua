return {
  "nvim-telescope/telescope.nvim",
  keys = {
    { "<leader>sS", false },
    {
      "<leader>sS",
      function()
        require("telescope.builtin").lsp_document_symbols()
      end,
      desc = "Lsp Document Symbols",
    },
    { "<leader>ss", false },
    {
      "<leader>ss",
      function()
        require("telescope.builtin").lsp_dynamic_workspace_symbols()
      end,
      desc = "Lsp Workspace Symbols",
    },
    { "<leader><leader>", false },
    {
      "<leader><leader>",
      function()
        require("telescope.builtin").lsp_dynamic_workspace_symbols()
      end,
      desc = "Lsp Workspace Symbols",
    },
  },
}
