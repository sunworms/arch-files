return {
	"nvim-tree/nvim-tree.lua",
	keys = { { "<leader>nt", ":NvimTreeToggle<CR>", desc = "Toggle Nvim Tree" } },
	opts = {
		sort = { sorter = "case_sensitive" },
		view = { width = 30 },
		renderer = { group_empty = true },
		filters = { dotfiles = true },
	},
}
