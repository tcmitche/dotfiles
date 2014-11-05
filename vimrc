" INFO: " {{{

" Pathogen: " {{{
let pathogen_directory=$HOME . "/.vim/bundle/pathogen/"
if isdirectory(pathogen_directory)
    exec "set rtp+=" . pathogen_directory
    call pathogen#infect()
endif

" }}}
" Powerline: " {{{
" let g:Powerline_symbols = 'compatible'
" let g:Powerline_symbols = 'unicode'
let g:Powerline_symbols = 'fancy'

" }}}

"}}}
" DEFAULTS: from example .vimrc " {{{
" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
    finish
endif

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
    set nobackup        " do not keep a backup file, use versions instead
else
    set backup      " keep a backup file
endif
set ruler           " show the cursor position all the time
set showcmd         " display incomplete commands
set incsearch       " do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" This is an alternative that also works in block mode, but the deleted
" text is lost and it only works for putting the current register.
vnoremap p "_dp

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
    syntax on
    set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")
    " Enable file type detection.
    " Use the default filetype settings, so that mail gets 'tw' set to 72,
    " 'cindent' is on in C files, etc.
    " Also load indent files, to automatically do language-dependent indenting.
    filetype plugin indent on

    " Put these in an autocmd group, so that we can delete them easily.
    augroup vimrcEx
    au!

    " For all text files set 'textwidth' to 78 characters.
    autocmd FileType text setlocal textwidth=78

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal g`\"" |
      \ endif

    augroup END
    set autoindent      " always set autoindenting on
endif " has("autocmd")
"}}}
" additions
" SETTINGS: " {{{
set encoding=UTF-8                  " use UTF-8 encoding
set nu
set fileencoding=UTF-8              " use UTF-8 encoding as default
set shortmess+=I                    " don't show intro on start
set nospell                         " spelling off by default
set spellcapcheck=off               " ignore case in spellcheck
set nolist                          " don't show invisibles
set listchars=tab:>-,trail:-        " ...but make them look nice when they do show
set expandtab                       " expand tabs to spaces
set tabstop=8                       " default tab stop width
set softtabstop=4                   " set a narrow tab width
set shiftwidth=4                    " and keep sw & sts in sync
set nobackup                        " don't like ~ files littered about; don't need
set laststatus=2                    " always show the status line
set iskeyword+=-                    " usually do not want - to divide words
set lbr                             " wrap lines at word breaks
set noautoindent                    " don't like autoindent
set autowrite                       " auto write changes when switching buffers
set diffopt+=vertical               " use vertical splits for diff
set splitright                      " open vertical splits to the right
set splitbelow                      " open horizonal splits below
set winminheight=0                  " minimized horizontal splits show only statusline
set switchbuf=useopen               " when switching to a buffer, go to where it's already open
set history=10000                   " keep craploads of command history
set undolevels=500                  " keep lots of undo history
set foldlevelstart=9                " first level of folds open by default
set foldmethod=marker               " use markers for the default foldmethod
set foldopen+=jump                  " jumps open folds, too
set display+=lastline               " always show as much of the last line as possible
set guioptions+=c                   " always use console dialogs (faster)
set guioptions-=m                   " no menu
set noerrorbells                    " don't need to hear if i hit esc twice
set visualbell | set t_vb=          " ...nor see it
set cursorline                      " highlight current line
set wildmenu                        " show completion options

colorscheme araxia

let mapleader="\\"                  " <Leader>

" use relative line numbers if available, otherwise just use line numbers

set wildignore+=*.class,*.o,*.sw?,*.git,*.svn,*.hg,**/build,*.?ib,*.png,*.jpg,*.jpeg,
            \*.mov,*.gif,*.bom,*.azw,*.lpr,*.mbp,*.mode1v3,*.gz,*.vmwarevm,
            \*.rtf,*.pkg,*.developerprofile,*.xcodeproj,*.pdf,*.dmg,
            \*.db,*.otf,*.bz2,*.tiff,*.iso,*.jar,*.dat,**/Cache,*.cache,
            \*.sqlite*,*.collection,*.qsindex,*.qsplugin,*.growlTicket,
            \*.part,*.ics,*.ico,**/iPhone\ Simulator,*.lock*,*.webbookmark

" Tags: universal location
set tags+=$HOME/.vim/tags

" Swap: centralized with unique names via //
let swap_directory=$HOME . "/.vim/swap/"
if ! isdirectory(swap_directory)
    if exists("*mkdir")
        call mkdir(swap_directory)
    end
endif
exec "set directory=" . swap_directory . "/"

" Sessionopts: defaults are blank,buffers,curdir,folds,help,options,tabpages,winsize
set ssop=blank,buffers,curdir,folds,help,resize,slash,tabpages,unix,winpos,winsize

set statusline=%<\(%n\)\ %m%y%r\ %f\ %=%-14.(%l,%c%V%)\ %P

"}}}
" MAPPINGS: " {{{

" Annoyances: " {{{
" Don't open help with F1
map <F1> <Nop>
imap <F1> <Nop>

" Uncomment if you hold shift too long...
" command! W :w

" c & p normalization
nmap dD :normal! _y$"_dd<CR>
vmap dD :normal! gvygv"_x<CR>
vmap <BS> :normal! gv"_x<CR>
vmap dC :normal gv"_xP<CR>
nnoremap <expr> <Leader>p ':put ' . v:register . '<CR>'
nnoremap <expr> <Leader>P ':put! ' . v:register . '<CR>'

" sane-itize Y so it behaves more like D
map Y y$

" Undoable deletes in insert
inoremap <C-w> <C-g>u<C-w>
inoremap <C-u> <C-g>u<C-u>

" Extended Navigation
nmap <C-e>h :bnext<CR>
nmap <C-e>l :bprev<CR>
nmap <C-e>j :Herenow<CR>
nmap <C-e>k :exec ":lcd .." \| echo "cwd now: " . getcwd()<CR>

" }}}
" Pasteboard-host Manipulation " {{{
" This requires a `~/.ssh/config` entry for 'pasteboard-host' pointing to
" desired pasteboard host; for virtual machines this is the vm host, for the
" host machine it should be localhost. Also make sure the host's
" `~/.ssh/authorized_keys` contains its own public key.
nmap <silent> <C-y>y :call system("ssh pasteboard-host pbcopy", getreg('"')) \| echo "Copied default register to remote pasteboard."<CR>
nmap <silent> <C-y>Y :call setreg('"', system("ssh pasteboard-host pbpaste 2>/dev/null")) \| echo "Placed remote pasteboard into default register."<CR>
nmap <C-y>p :exec "normal \<C-y>Yp"<CR>
nmap <C-y>P :exec "normal \<C-y>YP"<CR>

" }}}
" Reset: restore some default settings and redraw " {{{
nnoremap <silent> <C-l> :call Reset() \| nohls<CR>
imap <silent> <C-l> <Esc><C-l>

" }}}
" Custom: <C-y> prefixed custom commands " {{{
nmap <C-y>s :call feedkeys(":call OpenRelatedSnippetFileInVsplit()\r\<Tab>\<Tab>", 't')<CR>

" Commit file
map <Leader>o :call CheckinCheckup("show_prompt")<CR>

" Toggle tagbar
map <Leader>t :TagbarToggle<CR>

" }}}
" Completion: show completion preview, without actually completing " {{{
inoremap <C-p> <C-r>=pumvisible() ? "\<lt>Up>" : "\<lt>C-o>:set completeopt+=menuone\<lt>CR>a\<lt>C-n>\<lt>C-p>"<CR>

" }}}
" Cmdline Window: shortcuts " {{{
nnoremap :: q:
nnoremap // q/
nnoremap ?? q?

" }}}
" Learn: hjkl " {{{
" Uncomment to train yourself to stop using the arrow keys...
"nmap <Left>   :echo "You should have typed h instead."<CR>
"nmap <Right>  :echo "You should have typed l instead."<CR>
"nmap <Up>     :echo "You should have typed k instead."<CR>
"nmap <Down>   :echo "You should have typed j instead."<CR>

" }}}
" Tabs: switching " {{{
" set Cmd-# on Mac and Alt-# elsewhere to switch tabs
for n in range(10)
     let k = n == "0" ? "10" : n
     for m in ["D", "A"]
         exec printf("imap <silent> <%s-%s> <Esc>%s", m, n, k)
         exec printf("map <silent> <%s-%s> %sgt", m, n, k)
     endfor
endfor

" }}}

"}}}
" FUNCTIONS: " {{{

" Specialized:
function! Reset() " {{{
    silent pclose
    set completeopt-=menuone
    set nolist
    redraw
    "echo "Reset [ Tip: " . RandomHint() . " ]"
endfunction

" }}}
function! RandomHint() " {{{
    let comment_character = "#"
    try
        if !exists("g:random_hint_list")
            if !exists("g:hint_filename")
                let g:hint_filename = $HOME . "/.vim/vimtips.txt"
            endif
            let g:random_hint_list = readfile(g:hint_filename, '')
            call filter(g:random_hint_list, 'strpart(v:val, 0, 1) != comment_character')
        endif
        let hint_count = len(g:random_hint_list)
        exec "ruby random_line = rand(" . hint_count . ")"
        ruby VIM::command("let hint = #{random_line}")
    catch
        return "Random hints not available."
    endtry
    return g:random_hint_list[hint]
endfunction

" }}}
function! SnippetFilesForCurrentBuffer(A,L,P) " {{{
   let snipfiles = []
   for current_dir in split(g:snippets_dir, ',')
       for current_ft in split(&ft . "._", '\.')
           call add(snipfiles, glob(current_dir . current_ft ."/*.snippet"))
           call add(snipfiles, glob(current_dir . current_ft . "*.snippets"))
       endfor
   endfor
   return join(snipfiles, "\n")
endfunction

" }}}
function! OpenRelatedSnippetFileInVsplit() " {{{
    let snippetfile = input("Edit which related snippet file? ", "", "custom,SnippetFilesForCurrentBuffer")
    if filereadable(snippetfile) == 1
        exe ":vsplit " . snippetfile
    endif
endfunction

" }}}

"}}}
" FILETYPES: " {{{

au BufNewFile,BufRead *.scala setf scala
au BufNewFile,BufRead *.zsh-theme setf zsh
au BufNewFile,BufRead *.applescript   setf applescript
au BufNewFile,BufRead *.json setf javascript
au FileType ruby set fdm=syntax sts=2 sw=2 expandtab

" Java: " {{{
augroup java
    au BufReadPre *.java setlocal foldmethod=syntax
    au BufReadPre *.java setlocal foldlevelstart=-1
augroup END

" }}}
" Extradite: " {{{
augroup Extradite
    au! FileType extradite set showbreak=⇒\ \ \  wrap
augroup END

" }}}

"}}}
" PLUGINS: " {{{

" Fuf: " {{{
augroup FuzzyFinder
    au! FileType tLibInputList set nolist nornu nonu
augroup END

" }}}
" Quickfix: " {{{
augroup Quickfix
    au! FileType qf set nu | :wincmd L
augroup END

" }}}
" Gundo: " {{{
let g:gundo_width = 55
let g:gundo_preview_height = 25
let g:gundo_help = 0

" }}}
" Crontab: " {{{
augroup crontab
    au! BufRead crontab.* set nowritebackup
    au BufRead crontab.* set filetype=crontab
augroup END

" }}}
" Git Commit: " {{{
augroup Git | au!
    au BufNewFile,BufRead *.gitcommit setf gitcommit
    au FileType gitcommit nnoremap <buffer> <silent> <C-n> :DiffGitCached<CR>
    au FileType gitcommit\|gitconfig set nolist ts=4 sts=4 sw=4 | wincmd L
    au FileType gitconfig set noet | wincmd L
augroup END

" }}}
" BufExplorer: " {{{
map <silent> <C-Tab> :BufExplorer<CR>j
map <silent> <C-S-Tab> :BufExplorer<CR>k
" Unmap default bindings.
if maparg("<Leader>be") =~ 'BufExplorer' | exe "nunmap <Leader>be" | endif
if maparg("<Leader>bs") =~ 'BufExplorerHorizontalSplit' | exe "nunmap <Leader>bs" | endif
if maparg("<Leader>bv") =~ 'BufExplorerVerticalSplit' | exe "nunmap <Leader>bv" | endif
augroup BufExplorerAdd | au!
    if !exists("g:BufExploreAdd")
        let g:BufExploreAdd = 1
        au BufWinEnter \[BufExplorer\] map <buffer> <Tab> <CR>
    endif
augroup END

" }}}
" Folding: " {{{
function! FoldMarkerOpen() "{{{
    return substitute(&foldmarker, ",.*", "", "")
endfunction

"}}}
function! FoldMarkerClose() "{{{
    return substitute(&foldmarker, ".*,", "", "")
endfunction

"}}}
function! CommentStringOpen() "{{{
    return substitute(CommentStringFull(), "%s.*", "", "")
endfunction

"}}}
function! CommentStringClose() "{{{
    return substitute(CommentStringFull(), ".*%s", "", "")
endfunction

"}}}
function! CommentStringFull() "{{{
    return len(&commentstring) > 0 ? &commentstring : " %s"
endfunction

"}}}
function! CleanFoldText() "{{{
    let indentation = winwidth(0) - (winwidth(0) / 4)
    let fullline = getline(v:foldstart)
    let commentmatch = "\\s*" . substitute(CommentStringOpen(), "\\s\\+", "\\\\s*", "g")
    let g:replacestring = commentmatch . FoldMarkerOpen() . '.*'
    let line = substitute(fullline, g:replacestring, '', 'g')
    let linecount = v:foldend - v:foldstart - 2
    let linewidth = indentation - v:foldlevel - strlen(line)
    let decoratedline = printf("%s %*s <%s>", line, linewidth, linecount.' lines', v:foldlevel)
    let decoratedline = substitute(decoratedline, '^+\(.*\)done', 'o\1DONE', 'g')
    return decoratedline
endfunction "}}}
set foldtext=CleanFoldText()
" }}}
" FuzzyFinder: " {{{
" To transform wildignore into fuf_exclude...
" s/\*\./\\\./g | s/,/|/g
let g:fuf_file_exclude='\v\~$|\.(class|o|exe|dll|bak|orig|swp)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])|.gitignore|.DS_Store|.htaccess|\/target\/'
let g:fuf_coveragefile_exclude = g:fuf_file_exclude
let g:fuf_dataDir = '~/.vim/swap/.vim-fuf-data'
let g:fuf_maxMenuWidth = 150
map <C-e>e  :FufBuffer<CR>
map <C-e><C-e>  :FufBuffer<CR>
map <C-e>f  :call RecursiveFileSearch(":FufCoverageFile")<CR>
map <C-e>t  :FufTag<CR>
map <C-e>v  :VimFiles<CR>
map <C-e>s  :Scriptnames<CR>

function! RecursiveFileSearch(callback) " {{{
    let bad_paths = '^\(' . expand('~') . '\|' . expand('/') .'\)$'
    if match(getcwd(), bad_paths) > -1
        echo printf("Are you kidding? You want to recursively search in '%s'?", getcwd())
    else
       exe a:callback
    end
endf

command! DotFiles call DotFiles()
command! VimFiles call VimFiles()
command! Scriptnames call Scriptnames()
command! WikiPages call WikiPages()

function! DotFiles() " {{{
    call fuf#givenfile#launch('', '0', 'DotFiles>', split(glob('~/.**/*'), "\n"))
endfunction

" }}}
function! VimFiles() " {{{
    call fuf#givenfile#launch('', '0', 'VimFiles>', split(glob('~/.vim/**/*.vim'), "\n"))
endfunction

" }}}
function! Scriptnames() " {{{
    let output = '' | redir => output | silent! scriptnames | redir END
    let output = substitute(output, '\s*[0-9]\+:\s\+', '', 'g')
    call fuf#givenfile#launch('', '0', 'Scriptnames>', split(output, "\n"))
endfunction

" }}}
function! WikiPages() " {{{
    call fuf#givenfile#launch('', '0', 'WikiPages>', split(glob('~/sandbox/personal/vimwiki/*'), "\n"))
endfunction

" }}}

" }}}
" }}}
" }}}
" EXPERIMENTAL: " {{{

" Execute current line as an ex command.
map <Leader><CR> 0"ty$:<C-r>t<CR>:echo "Executed: " . @t<CR>
"vmap <Leader><CR> "ty \| exec ":call feedkeys(q:" . getreg("t") . ")"<CR>
" Execute current line as an ex command (no status to allow echo).
map <Leader><S-CR> :call feedkeys("\"tyyq:\"tp\r", "n")<CR>


" Toggle number column: " {{{
" <C-e>1 to toggle between nu and rnu

" }}}
" Toggle List: " {{{
" <C-e>2 to toggle between list and nolist
for mapmode in ["n", "x", "o"]
    exe mapmode . "noremap <expr> <C-e>2 ToggleListDisplay()"
endfor

function! ToggleListDisplay()
    exe "setl" &l:list? "nolist" : "list"
endfunction

" }}}
" Diff of changes since opening file " {{{
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
endif

" }}}

command! Herenow :call Herenow()
function! Herenow() " {{{
    exec ":lcd " . expand("%:p:h")
    echo "cwd now: " . getcwd()
endfunction

" }}}
command! -nargs=* Checkin :call Checkin(<q-args>)
function! Checkin(...) " {{{
    let message =  a:000[0]
    let g:last_commit_message = message
    if CheckinCheckup()
        call Herenow()
        if len(message) > 0
            exe ":Gcommit % -m\"" . message . "\""
        else
            exe ":Gcommit -v %" | wincmd T
        endif
    endif
endfunction

" }}}
function! CheckinCheckup(...) " {{{
    let show_prompt = len(a:000) > 0
    if exists(":Gcommit")
        if show_prompt
            call feedkeys(":Checkin ")
        else
            return 1
        endif
    else
        let currentfile = (len(expand("%:p")) > 0) ? expand("%") : "Unsaved buffer"
        echo currentfile . " is not in a recognized vcs work tree."
        return 0
    endif
endfunction

" }}}

" Scala " {{{
let g:tagbar_type_scala = {
    \ 'ctagstype' : 'Scala',
    \ 'kinds'     : [
        \ 'p:packages:1',
        \ 'V:values',
        \ 'v:variables',
        \ 'T:types',
        \ 't:traits',
        \ 'o:objects',
        \ 'a:aclasses',
        \ 'c:classes',
        \ 'r:cclasses',
        \ 'm:methods'
    \ ]
\ }
" }}}

" }}}
" vim: set ft=vim fdm=marker cms=\ \"\ %s  :
