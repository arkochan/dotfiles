return {
  "monaqa/dial.nvim",
  opts = function()
    local augend = require("dial.augend")

    -- Custom augmentation for TailwindCSS classes
    local tailwind_augend = {
      -- Match TailwindCSS classes using a regex pattern
      find = function(text, cursor_pos)
        local pattern = "%-?[a-z]+%-?%d*" -- Matches TailwindCSS classes like mt-2, px-8, shadow-lg, etc.
        local start_pos, end_pos = text:find(pattern, cursor_pos)
        if start_pos and end_pos then
          return {
            text = text:sub(start_pos, end_pos),
            start_pos = start_pos,
            end_pos = end_pos,
          }
        end
      end,

      -- Increment the TailwindCSS class
      add = function(text, cursor_pos, delta)
        -- Extract the numeric value from the class (if any)
        local prefix, number = text:match("^(%-?[a-z]+%-?)(%d*)$")
        if not prefix then
          return text -- If no numeric part, return the original text
        end

        -- Convert the number to an integer (default to 0 if no number)
        number = tonumber(number) or 0

        -- Increment or decrement the number based on delta
        number = number + delta

        -- Ensure the number is non-negative
        if number < 0 then
          number = 0
        end

        -- Return the new class with the updated number
        return prefix .. number
      end,

      -- Decrement the TailwindCSS class (same as increment but with negative delta)
      sub = function(text, cursor_pos, delta)
        return tailwind_augend.add(text, cursor_pos, -delta)
      end,
    }

    local logical_alias = augend.constant.new({
      elements = { "&&", "||" },
      word = false,
      cyclic = true,
    })

    local ordinal_numbers = augend.constant.new({
      -- elements through which we cycle. When we increment, we go down
      -- On decrement we go up
      elements = {
        "first",
        "second",
        "third",
        "fourth",
        "fifth",
        "sixth",
        "seventh",
        "eighth",
        "ninth",
        "tenth",
      },
      -- if true, it only matches strings with word boundary. firstDate wouldn't work for example
      word = false,
      -- do we cycle back and forth (tenth to first on increment, first to tenth on decrement).
      -- Otherwise nothing will happen when there are no further values
      cyclic = true,
    })

    local weekdays = augend.constant.new({
      elements = {
        "Monday",
        "Tuesday",
        "Wednesday",
        "Thursday",
        "Friday",
        "Saturday",
        "Sunday",
      },
      word = true,
      cyclic = true,
    })

    local months = augend.constant.new({
      elements = {
        "January",
        "February",
        "March",
        "April",
        "May",
        "June",
        "July",
        "August",
        "September",
        "October",
        "November",
        "December",
      },
      word = true,
      cyclic = true,
    })

    local capitalized_boolean = augend.constant.new({
      elements = {
        "True",
        "False",
      },
      word = true,
      cyclic = true,
    })

    local access_modifier = augend.constant.new({
      elements = { "private", "public" },
      word = true,
      cyclic = true,
    })

    return {
      dials_by_ft = {
        css = "css",
        vue = "vue",
        javascript = "typescript",
        typescript = "typescript",
        typescriptreact = "typescript",
        javascriptreact = "typescript",
        json = "json",
        lua = "lua",
        markdown = "markdown",
        sass = "css",
        scss = "css",
        python = "python",
      },
      groups = {
        default = {
          augend.integer.alias.decimal, -- nonnegative decimal number (0, 1, 2, 3, ...)
          augend.integer.alias.decimal_int, -- nonnegative and negative decimal number
          augend.integer.alias.hex, -- nonnegative hex number  (0x01, 0x1a1f, etc.)
          augend.date.alias["%Y/%m/%d"], -- date (2022/02/19, etc.)
          ordinal_numbers,
          weekdays,
          months,
          capitalized_boolean,
          augend.constant.alias.bool, -- boolean value (true <-> false)
          logical_alias,
          access_modifier,
        },
        vue = {
          augend.constant.new({ elements = { "let", "const" } }),
          augend.hexcolor.new({ case = "lower" }),
          augend.hexcolor.new({ case = "upper" }),
        },
        typescript = {
          augend.constant.new({ elements = { "let", "const" } }),
        },
        typescriptreact = {
          tailwind_augend,
          augend.constant.new({ elements = { "let", "const" } }),
        },
        javascriptreact = {
          tailwind_augend,
          augend.constant.new({ elements = { "let", "const" } }),
        },
        css = {
          augend.hexcolor.new({
            case = "lower",
          }),
          augend.hexcolor.new({
            case = "upper",
          }),
        },
        markdown = {
          augend.constant.new({
            elements = { "[ ]", "[x]" },
            word = false,
            cyclic = true,
          }),
          augend.misc.alias.markdown_header,
        },
        json = {
          augend.semver.alias.semver, -- versioning (v1.1.2)
        },
        lua = {
          augend.constant.new({
            elements = { "and", "or" },
            word = true, -- if false, "sand" is incremented into "sor", "doctor" into "doctand", etc.
            cyclic = true, -- "or" is incremented into "and".
          }),
        },
        python = {
          augend.constant.new({
            elements = { "and", "or" },
          }),
        },
      },
    }
  end,
}
