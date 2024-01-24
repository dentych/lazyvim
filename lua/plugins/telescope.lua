function git_or_find_files()
	local path = vim.loop.cwd() .. "/.git"
	local ok, err = vim.loop.fs_stat(path)
	if ok then
		require("telescope.builtin").git_files()
	else
		require("telescope.builtin").find_files()
	end
end

return {
	'nvim-telescope/telescope.nvim', tag = '0.1.5',
	dependencies = { 'nvim-lua/plenary.nvim' },
	keys = {
		{ "<leader><space>", git_or_find_files, desc = "Find files" },
		{ "<leader>ff", git_or_find_files, desc = "Find files" },
		{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find buffers" },
	},
}
