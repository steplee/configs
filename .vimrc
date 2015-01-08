syntax on

execute pathogen#infect()

filetype indent on
set autoindent
set number
syntax on
set ic
set hls
set lbr

" Creates a .cpp in the current dir and a .h in the next found include folder 
"   with the name specified
function! CreateCPPFiles (name)
	let safety = 0
	let dir = "./"
	while ( ! isdirectory(dir . "include") )
		let safety = safety + 1
		if ( safety > 40 )
			echo "No include directory found!"
			return
		endif
		let dir = dir . "../"
	endwhile
	let dir = dir . "include/"
	execute 'tabe ' . a:name . ".cpp"
	execute 'split ' . dir . a:name . ".h"
	execute 'res - 8'
endfunction

" Finds the header of the currently opened .cpp or vice versa
" Took me forever to write !!
function! FindCPPorHeader()

	let cur = fnamemodify(bufname("%"), ':p')
	echo "Current file: " . cur . " \t Length of cur: " . len(cur)
	if ( match(cur, ".h" ) )
		let basedir = cur . "../"
		let curname = split(cur, "/")
		let curname2 = curname[len(curname)-1]
		let curname3 = split(curname2, "\\.")
		echo "curname2 : " . curname2 . "\t curname3 len : " . len(curname3)
		let curname2 = curname3[0]
		let curdir = split(cur, "include")
		let curdir2 = curdir[0] 
		echo "Curname : " . curdir2
		let cpp = system("find " . curdir2 . " -name \"" . curname2 . ".cpp\"")
		echo " executing " .  "find " . curdir2 . " -name \"" . curname2 . ".cpp\""
		if ( !empty(cpp) )
			echo "Found cpp, opening : " . cpp 
			execute 'split ' . cpp
		endif
	elseif ( match(cur, ".cpp") )
		let basedir = cur . "../"
		let curname = split(cur, "/")
		let curname2 = curname[len(curname)-1]
		let curname3 = split(curname2, "\\.")
		echo "curname2 : " . curname2 . "\t curname3 len : " . len(curname3)
		let curname2 = curname3[0]
		let curdir = split(cur, "src")
		let curdir2 = curdir[0] 
		echo "Curname : " . curdir2
		let h  = system("find " . curdir2 . " -name \"" . curname2 . ".h\"")
		echo " executing " .  "find " . curdir2 . " -name \"" . curname2 . ".h\""
		if ( !empty(h) )
			echo "Found .h, opening : " . h
			execute 'split ' . h 
		else
			echo "No .h found from " . curdir2 . "../*/" . curname2 . ".h"
		endif
	else
		echo "Current file must be either a .h or .cpp"
	endif
endfunction


" Create a new .cpp in current dir and .h in next parent include
command! -nargs=1 CC call CreateCPPFiles(<f-args>)
" From an opened .cpp / .h, find its other .h / .cpp
command! -nargs=0 FF call FindCPPorHeader()
