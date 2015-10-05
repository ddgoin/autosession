fu! SaveSess()
	execute 'mksession! ' . g:autosession_location
endfunction


fu! RestoreSess()
	if filereadable(g:autosession_location)
		execute 'so ' . g:autosession_location
		if bufexists(1)
			for l in range(1, bufnr('$'))
				if bufwinnr(l) == -1
					exec 'sbuffer ' . l
				endif
			endfor
		endif
	endif
endfunction


fu! SetSessFile()
	if !exists('g:autosession_filename')
		let g:autosession_filename = '/.session.vim'
	endif
	if !exists('g:autosession_location')
		let g:autosession_location = getcwd() . g:autosession_filename
	endif
endfunction


fu! OnEnter()
	call SetSessFile()
	if !argc()
		if !exists('g:autosession_save')
			let g:autosession_save=1
		endif
		call RestoreSess()
	else
		if !exists('g.autosession_save')
			let g:autosession_save=0
		endif
	endif
endfunction


fu! OnLeave()
	if g:autosession_save
		call SaveSess()
	endif
endfunction


autocmd VimLeave * call OnLeave()
autocmd VimEnter * nested call OnEnter()

set sessionoptions-=options  " Don't save options (reload from vimrc)
