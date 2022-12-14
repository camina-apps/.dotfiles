local status_ok, neotree = pcall(require, "neo-tree")
if not status_ok then
	return
end

local Icons = require("camina.icons")

neotree.setup({
	close_if_last_window = true,
	enable_diagnostics = false,
	source_selector = {
		winbar = true,
		content_layout = "center",
	},
	default_component_configs = {
		indent = {
			padding = 0,
		},
		git_status = {
			symbols = {
				added = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
				modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
				deleted = Icons.ui.BoldClose, -- this can only be used in the git_status source
				renamed = Icons.ui.DoubleChevronRight, -- this can only be used in the git_status source
				-- Status type
				untracked = Icons.ui.QuestionMark,
				ignored = Icons.git.FileIgnored,
				unstaged = Icons.ui.BoxUnchecked,
				staged = Icons.uiBoxChecked,
				conflict = Icons.git.FileUnmerged,
			},
		},
	},
	window = {
		width = 40,
		mappings = {
			["o"] = "open",
		},
	},
	filesystem = {
		follow_current_file = true,
		hijack_netrw_behavior = "open_current",
		use_libuv_file_watcher = true,
	},
	event_handlers = {
		{
			event = "neo_tree_buffer_enter",
			handler = function(_)
				vim.opt_local.signcolumn = "auto"
			end,
		},
		{
			event = "file_opened",
			handler = function()
				neotree.close_all()
			end,
		},
	},
})
