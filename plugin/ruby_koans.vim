" This is quickfix for ruby_koans
" vim:set ts=2 sts=2 sw=2 expandtab:
"
if exists("b:loaded_ruby_koans")
	finish
endif

function! IsKoansFile()
	if stridx(getcwd(), 'koans') == -1
		return 0
	endif

	let file_name = bufname("%")
	if stridx(file_name, 'about_') == -1
		return 0
	endif
	if stridx(file_name, '.rb') == -1
		return 0
	endif
	return 1
endfunction

if IsKoansFile() == 0
	finish
endif

let b:loaded_ruby_koans = 1

function! KoansRake()
	if &modified
		write
	endif
	let map = &makeprg
	let ef = &errorformat
	setlocal makeprg=NO_COLOR=1\ rake
	setlocal efm=%EThe\ answers\ you\ seek\.\.\.,%C\ \ %m%[.>],%Z\ \ %f:%l:in\ `%.%#',%-G%.%#
	silent make
	redraw!
	""clist
	let &makeprg = map
	let &errorformat = ef
endfunction

map <Leader>r :call KoansRake()<cr>
au InsertLeave *about_*.rb :call KoansRake()
au BufWritePost *about_*.rb :call KoansRake()
