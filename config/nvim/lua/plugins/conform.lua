return {
	"stevearc/conform.nvim",
	opts = {},
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				go = { "goimports", "gofmt" },
				rust = { "rustfmt" },
				java = { "google-java-format" },
			},
		})

		vim.api.nvim_create_autocmd("BufWritePre", {
			callback = function(args)
				require("conform").format({ bufnr = args.buf })
			end,
		})
	end,
}
