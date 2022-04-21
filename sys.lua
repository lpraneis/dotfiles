if vim.fn.has('mac') == 1 then 
	macos = true
	linux = false
	windows = false
elseif vim.fn.has('unix') == 1 then 
	macos = false
	linux = true
	windows = false
elseif vim.fn.has('win32') == 1 then 
	macos = false
	linux = false
	windows = true
end

return {
	is_macos = macos,
	is_linux = linux,
	is_windows = windows,
}
