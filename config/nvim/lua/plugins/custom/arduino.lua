function Arduino_status()
	if vim.bo.filetype ~= "arduino" then
		return ""
	end
	local port = vim.fn["arduino#GetPort"]()
	local line = string.format("[%s]", vim.g.arduino_board)
	if vim.g.arduino_programmer ~= "" then
		line = line .. string.format(" [%s]", vim.g.arduino_programmer)
	end
	if port ~= 0 then
		line = line .. string.format(" (%s:%s)", port, vim.g.arduino_serial_baud)
	end
	return line
end

return {
	"stevearc/vim-arduino",
	dependencies = {
		"jpalardy/vim-slime",
	},
	config = function()
		vim.g.arduino_use_slime = 1
		vim.keymap.set("n", "<leader>au", "<cmd>ArduinoUpload<CR>",
			{ desc = "Upload to arduino board" })
	end
}
