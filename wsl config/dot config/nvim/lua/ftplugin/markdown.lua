system=require('os').execute
function compile()
	local linux_path=vim.api.nvim_eval('expand("%:p")')
	if string.sub(linux_path,0,5)~='/mnt/' then
		print('Path not accessible by windows')
		return
	end
	local pdf_file=string.sub(linux_path,#linux_path-string.find(string.reverse(linux_path),'/')+2,#linux_path-2)..'pdf'
	system('pandoc.exe -f markdown -t pdf "'..string.upper(string.sub(linux_path,6,6))..':\\'..string.gsub(string.sub(linux_path,8),'/','\\')..'" > "'..pdf_file..'"')--compile
	system('cmd.exe /c "echo|set /p=%cd%\\'..pdf_file..' | win32yank.exe -i"')--change clipboard
	print('Compiled to '..pdf_file)
end
--wrap options
vim.api.nvim_win_set_option(0,'wrap',true)
vim.api.nvim_win_set_option(0,'linebreak',true)
vim.api.nvim_win_set_option(0,'list',false)
vim.api.nvim_win_set_option(0,'number',false)
vim.api.nvim_win_set_option(0,'relativenumber',false)
--no folds
vim.api.nvim_win_set_option(0,'foldenable',false)
vim.api.nvim_win_set_option(0,'spell',true)
--quick return to end (if dictation resumes while spelling correction)
vim.api.nvim_buf_set_keymap(0,'n','E','GA',{noremap=true,silent=true})
--quick compile and manipulate clipbaord to share notes over Whatsapp
vim.api.nvim_buf_set_keymap(0,'n','<F5>',':lua compile()<CR>',{noremap=true,silent=true})
