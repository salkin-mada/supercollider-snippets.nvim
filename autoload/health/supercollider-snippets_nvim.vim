function! s:check_snippets_nvim_is_installed() abort
	if !has('snippets.nvim')
		call health#report_error('has(snippets.nvim)','requires snippets.nvim to be installed')
	else
		call health#report_ok("supercollider-snippets.nvim: satisfied")
	endif
endfunction

function! health#openscad_nvim#check() abort
	call health#report_start('supercollider-snippets.nvim')
	call s:check:snippets_nvim_is_installed()
endfunction
