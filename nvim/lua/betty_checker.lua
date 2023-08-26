local M = {}

function M.check_betty_errors()
	-- Save the buffer
	vim.cmd("w")

	local filename = vim.fn.expand("%:t") -- Only the filename without the full path
	if vim.fn.filereadable(filename) == 1 then
		local output = vim.fn.system("betty " .. filename)
		local lines = vim.split(output, "\n")

		local buffer_number = vim.fn.bufnr() -- Get the current buffer number
		local namespace_id = vim.api.nvim_create_namespace("betty_checker_errors")

		-- Clear existing signs and virtual text in the namespace
		vim.fn.sign_unplace("LinterError", { buffer = buffer_number })
		vim.api.nvim_buf_clear_namespace(buffer_number, namespace_id, 0, -1)

		vim.fn.sign_define("LinterError", { text = "", texthl = "ErrorMsg" })
		for _, line in ipairs(lines) do
			local _, _, line_number, message = string.find(line, "(%d+): (.+)")
			if line_number and message then
				line_number = tonumber(line_number)
				vim.fn.sign_place(0, "LinterError", "LinterError", filename, { lnum = line_number, priority = 10 })
				vim.api.nvim_buf_set_virtual_text(
					buffer_number,
					namespace_id,
					line_number - 1,
					{ { message, "ErrorMsg" } },
					{}
				)
			end
		end
	end
end

return M
