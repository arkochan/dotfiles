return {
	"hrsh7th/nvim-cmp",
	dependencies = { "hrsh7th/cmp-emoji" },
	opts = function(_, opts)
		local has_words_before = function()
			unpack = unpack or table.unpack
			local line, col = unpack(vim.api.nvim_win_get_cursor(0))
			return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
		end
		local cmp = require("cmp")

		local ls = require("luasnip")
		local s = ls.snippet
		local t = ls.text_node
		local i = ls.insert_node
		local f = ls.function_node

		local function file_name_without_extension()
			local file_name = vim.fn.expand("%:t:r")
			return file_name
		end

		ls.add_snippets("typescriptreact", {
			s("rf", {
				t({
					'import react from "react";',
					'import { cn } from "@/utils/cn";',
					"",
					"export default function ",
				}),
				f(file_name_without_extension),
				t({
					"({",
					'  classname = "",',
					"}: {",
					"  classname?: string;",
					"}) {",
					"  return ",
				}),
				t('<div className={cn("", classname)}>'),
				i(1, ""),
				t("</div>"),
				t({
					";",
					"}",
				}),
			}),
		})

		-- Custom sorting
		opts.sources = {
			{ name = "copilot", priority = 100 }, -- Adjust the name if you're using a different snippet engine
			{ name = "luasnip", priority = 90 }, -- Adjust the name if you're using a different snippet engine
			{ name = "nvim_lsp", priority = 75 },
			{ name = "buffer", priority = 50 },
			{ name = "path", priority = 25 },
			-- Add other sources you're using with appropriate priorities
		}
		opts.sorting = {
			priority_weight = 2,
			comparators = {
				-- ensure copilot suggestions stay at the top
				cmp.config.compare.score,
				-- prioritize items that match the text under the cursor
				cmp.config.compare.exact,
				-- recently used items
				cmp.config.compare.recently_used,
				-- fallback to the default sort
				cmp.config.compare.offset,
				cmp.config.compare.sort_text,
				cmp.config.compare.kind,
				cmp.config.compare.length,
				cmp.config.compare.order,
			},
		}

		-- Custom key mappings
		opts.mapping = vim.tbl_extend("force", opts.mapping, {
			["<tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.confirm({ select = true })
				else
					fallback()
				end
			end, { "i", "s" }),
			["<c-tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				elseif vim.snippet.active({ direction = 1 }) then
					vim.schedule(function()
						vim.snippet.jump(1)
					end)
				elseif has_words_before() then
					cmp.complete()
				else
					fallback()
				end
			end, { "i", "s" }),
			["<s-tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				elseif vim.snippet.active({ direction = -1 }) then
					vim.schedule(function()
						vim.snippet.jump(-1)
					end)
				else
					fallback()
				end
			end, { "i", "s" }),
			-- Ignore enter for auto-completion, insert a new line instead
			["<cr>"] = cmp.mapping(function(fallback)
				fallback()
			end, { "i", "s" }),
		})
	end,
}
