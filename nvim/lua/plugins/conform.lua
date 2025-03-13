return {
  "stevearc/conform.nvim",
  opts = function(_, opts)
    -- Extend the existing options
    opts.formatters_by_ft = opts.formatters_by_ft or {}
    -- Add php to formatters_by_ft
    opts.formatters_by_ft.php = { "php_cs_fixer" }

    -- Configure the formatter
    opts.formatters = opts.formatters or {}
    opts.formatters.php_cs_fixer = {
      command = "php-cs-fixer",
      args = { "fix", "--quiet", "--no-interaction", "$FILENAME" },
      stdin = false,
      env = {
        PHP_CS_FIXER_IGNORE_ENV = "1",
      },
    }
  end,
}
