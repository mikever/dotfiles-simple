" Autoload plugins
    if empty(glob('~/.vim/autoload/plug.vim'))
      silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
      autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif


" Plugins will be downloaded under the specified directory
call plug#begin('~/.vim/plugged')

    Plug 'scrooloose/nerdtree'
    Plug 'Xuyuanp/nerdtree-git-plugin'
        " Autoclose nerdtree after file is opened
        let NERDTreeQuitOnOpen=1
        let NERDTreeShowHidden=1
        let NERDTreeIgnore = ['\.DAT$', '\.LOG1$', '\.LOG1$']
        let NERDTreeIgnore += ['\.png$','\.jpg$','\.gif$','\.mp3$','\.flac$', '\.ogg$', '\.mp4$','\.avi$','.webm$','.mkv$','\.pdf$', '\.zip$', '\.tar.gz$', '\.rar$']

    Plug 'itchyny/lightline.vim'
    Plug 'stephpy/vim-yaml'
    Plug 'kshenoy/vim-signature'  " toggle and display marks
    Plug 'luochen1990/rainbow'  " rainbow parentheses
    Plug 'leafgarland/typescript-vim'
    Plug 'tmhedberg/SimpylFold'  " Helps with better folds for python
    Plug 'Konfekt/FastFold'  " manages auto-folds for better speed
    Plug 'adelarsq/vim-matchit'  " extension matching for % operator
    Plug 'alvan/vim-closetag'  " auto-close HTML tags
    Plug 'tpope/vim-commentary'  " toggle comments: gc (motion) and gcc (line)
    Plug 'tpope/vim-surround'
        " cs - change surround;
        " cst - change surround tag;
        " ds - delete surround;
        " ysiw - yank surround inner word
        " yss - yank surround line
    Plug 'justinmk/vim-sneak'  " jump to a location with s{char}{char}
    Plug 'jiangmiao/auto-pairs'  " auto-close pairs with cursor in middle
    " " let g:AutoPairsShortcutToggle = <M-m>
    Plug 'mattn/emmet-vim'
    Plug 'maxmellon/vim-jsx-pretty'
    Plug 'jeffkreeftmeijer/vim-numbertoggle'  " Manages line number modes

    " ColorSchemes
    Plug 'morhetz/gruvbox'
    Plug 'jacoborus/tender.vim'
    Plug 'rakr/vim-two-firewatch'
    Plug 'romainl/Apprentice'
    Plug 'vivekvjn/vim-solarized8'

    " Plug List ends here. Plugins become visible to Vim after this call
    call plug#end()

" Theme/Layout
    set t_Co=256  " fixes glitch in colors when using vim with tmux; set before colorscheme
    set background=light
    syntax enable
    colorscheme solarized8_light
    " let g:gruvbox_contrast_dark = 'soft'
    set colorcolumn=100

    " Solarized settings
    " let g:solarized_italics=1

" lightline
    let g:lightline = {
        \ 'colorscheme': 'solarized',
        \ }

    set laststatus=2  " make sure bar isn't a blank black line
    set noshowmode  " --INSERT-- not necessary since lightline handles it

" vimdiff colorscheme
    if &diff
        syntax off
        colorscheme solarized8_light

        let g:lightline = {
            \ 'colorscheme': 'solarized',
            \ }
    endif

" Change background between light/dark
    nnoremap  <leader>B :<c-u>exe "colors" (g:colors_name =~# "dark"
    \ ? substitute(g:colors_name, 'dark', 'light', '')
    \ : substitute(g:colors_name, 'light', 'dark', '')
    \ )<cr>

" UI Layout
    set number              " show line numbers
    set relativenumber
    set showcmd             " show command in bottom bar
    set nocursorline        " highlight current line
    set wildmenu            " display command line's tab complete options as a menu
    set lazyredraw          " don't update screen during macro and script execution
    set showmatch           " higlight matching parenthesis
    set fillchars+=vert:┃
    set wrap linebreak nolist   " does not change text on break; simply displays on multiple lines
    set textwidth=0
    set wrapmargin=0

" Functionality Settings
    " Save (update) with fewer keystrokes
        nnoremap <C-S> :update<cr>
        inoremap <C-S> <Esc>:update<cr>gi

    " Quit with fewer keystrokes
        nnoremap <C-Q> :quit<cr>
        inoremap <C-Q> <Esc>:quit<cr>

    " Set the working directory to wherever the open file lives `:set autochdir!` to toggle
    set autochdir
    " `gf` opens file under cursor in a new horizontal split
    nnoremap gf :horizontal wincmd f<CR>

" Leader Shortcuts
    " Buffer list shortcut
    nnoremap <Leader>b :buffers<CR>:buffer<Space>

    " Rainbow Levels
    map <Leader>l :RainbowLevelsToggle<CR>

" Folds
    set foldmethod=syntax "syntax highlighting items specify folds
    set foldcolumn=1 "defines 1 col at window left, to indicate folding
    let javaScript_fold=1 "activate folding by JS syntax
    set foldlevelstart=99 "start file with all folds opened

    " set nofoldenable  " Folds are unfolded when file is first opened

" FastFold
    nmap zuz <Plug>(FastFoldUpdate)
    let g:fastfold_savehook = 1
    let g:fastfold_fold_command_suffixes =  ['x','X','a','A','o','O','c','C']
    let g:fastfold_fold_movement_commands = [']z', '[z', 'zj', 'zk']

    let g:markdown_folding = 1
    let g:tex_fold_enabled = 1
    let g:vimsyn_folding = 'af'
    let g:xml_syntax_folding = 1
    let g:javaScript_fold = 1
    let g:sh_fold_enabled= 7
    let g:ruby_fold = 1
    let g:perl_fold = 1
    let g:perl_fold_blocks = 1
    let g:r_syntax_folding = 1
    let g:rust_fold = 1
    let g:php_folding = 1

" Paste
    set pastetoggle=<F5>        " <FN>5 on my keeb

" Indents and Spaces
    " Flag unnecessary whitespace
    highlight ExtraWhitespace ctermbg=red guibg=red
    match ExtraWhitespace /\s\+$/
    autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
    autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
    autocmd InsertLeave * match ExtraWhitespace /\s\+$/
    autocmd BufWinLeave * call clearmatches()

    " au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

    set tabstop=4  " Width of tab character
    set softtabstop=0  " Fine tunes the amount of whitespace added
    set shiftwidth=4  " Determines the amount of whitespace to add in normal mode, and configures fold level
    set expandtab  " When on uses space instead of tabs
    set smarttab

    syntax match Tab /\t/
    hi Tab gui=underline guifg=blue ctermbg=blue

    set autoindent          " turns it on
    set smartindent         " does the right thing (mostly) in programs
    " set modelines=1         " 1 line of vim-specific code at top of file

    filetype plugin on      " plugin file is loaded when file is edited
    filetype indent on      " detect filetype. works with syntax highlighting; indent detection on

" Disable automatic commenting on newline
    autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Swap files - moved them into their own space
    set backupdir=~/.vim/backup//
    set directory=~/.vim/swap//
    set undodir=~/.vim/undo//

" Search all subdirs
    set backspace=indent,eol,start
    let g:vimwiki_list = [{'path': '~/.wiki/'}]
    set clipboard=unnamed

" Searching
    set incsearch           " search as characters are entered
    " hi Search guibg=guibg guifg=white gui=underline
    " hi Search cterm=underline ctermfg=white ctermbg=black
    set hlsearch            " highlight all matches
    set smartcase           " search is case-sensitive if it contains an uppercase letter

    " clear highlights
    nmap <C-_> :noh<CR>

" pylint configuration
" set makeprg=pylint\ --reports=n\ --output-format=parseable\ %:p
" set errorformat=%f:%l:\ %m

" Movement
    " Jumps between code blocks
    nnoremap <nowait> ] ]]
    nnoremap <nowait> [ [[

    " Insert blank lines without entering Insert Mode
    nnoremap <C-J> m`o<Esc>``
    nnoremap <C-K> m`O<Esc>``

" Buffer commands
    map <C-h> :bprev<CR>
    map <C-l> :bnext<CR>

" Insert Time
    :nnoremap <F4> "=strftime("%a %b, %d %Y")<CR>Po
    :inoremap <F4> "<C-R>=strftime("%a %b, %d %Y")<CR>o

" CtrlP
    let g:ctrlp_match_window = 'bottom,order:ttb'
    let g:ctrlp_switch_buffer = 0
    let g:ctrlp_working_path_mode = 0
    let g:ctrlp_custom_ignore = '\vbuild/|dist/|venv/|target/|\.(o|swp|pyc|egg)$'

" AutoGroups
    augroup configgroup
        autocmd!
        autocmd VimEnter * highlight clear SignColumn
        " autocmd BufWritePre *.php,*.py,*.js,*.txt,*.hs,*.java,*.md,*.rb :call <SID>StripTrailingWhitespaces()
        " autocmd BufEnter *.cls setlocal filetype=java
        " autocmd BufEnter *.zsh-theme setlocal filetype=zsh
        autocmd BufEnter Makefile setlocal noexpandtab
        autocmd BufEnter *.sh,*.js,*.md setlocal tabstop=2
        autocmd BufEnter *.sh,*.js,*.md setlocal shiftwidth=2
        autocmd BufEnter *.sh,*.js,*.md setlocal softtabstop=2
        autocmd BufEnter *.py setlocal tabstop=4
        autocmd BufEnter *.md setlocal ft=markdown
        autocmd BufEnter *.go setlocal noexpandtab
        autocmd BufEnter *.avsc setlocal ft=json
        " Sets current working directory to current file's directory, to help NERDTree
        " autocmd BufEnter * lcd %:p:h
    augroup END

" NERDTree
    map <Leader>d :NERDTreeToggle<CR>
    set shell=sh

" Testing
"     let test#strategy = 'neovim'
"     let test#python#runner = 'nose'

" Backups
    set backup
    set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
    set backupskip=/tmp/*,/private/tmp/*
    set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
    set writebackup

" Sneak Configuration
    let g:sneak#s_next = 1

" vim rainbow configuration
    let g:rainbow_active = 0 "set to 0 if you want to enable it later via :RainbowToggle

" closetag configuration
    " filenames like *.xml, *.html, *.xhtml, ...
    " These are the file extensions where this plugin is enabled.
    let g:closetag_filenames = '*.html,*.xhtml,*.phtml, *.jsp'

    " filenames like *.xml, *.xhtml, ...
    " This will make the list of non-closing tags self-closing in the specified files.
    let g:closetag_xhtml_filenames = '*.xhtml,*.jsx'

    " filetypes like xml, html, xhtml, ...
    " These are the file types where this plugin is enabled.
    let g:closetag_filetypes = 'html,xhtml,phtml'

    " filetypes like xml, xhtml, ...
    " This will make the list of non-closing tags self-closing in the specified files.
    let g:closetag_xhtml_filetypes = 'xhtml,jsx'

    " integer value [0|1]
    " This will make the list of non-closing tags case-sensitive (e.g. `<Link>` will be closed while `<link>` won't.)
    let g:closetag_emptyTags_caseSensitive = 1

    " dict
    " Disables auto-close if not in a "valid" region (based on filetype)
    let g:closetag_regions = {
        \ 'typescript.tsx': 'jsxRegion,tsxRegion',
            \ 'javascript.jsx': 'jsxRegion',
                \ }

                " Shortcut for closing tags, default is '>'
                let g:closetag_shortcut = '>'

                " Add > at current position without closing the current tag, default is ''
                let g:closetag_close_shortcut = '<leader>>'


" -- EMMET CONFIG --
    " redefine trigger key. Type `,,` to trigger
    " let g:user_emmet_expandabbr_key = '<Tab>'  " <Tab> , to trigger, or default <C-Y>
    let g:user_emmet_leader_key=','

" Functions

    " Changing cursor shape per mode
        " 1 or 0 -> blinking block
        " 2 -> solid block
        " 3 -> blinking underscore
        " 4 -> solid underscore
        if exists('$TMUX')
            " tmux will only forward escape sequences to the terminal if surrounded by a DCS sequence
            let &t_SI .= "\<Esc>Ptmux;\<Esc>\<Esc>[4 q\<Esc>\\"
            let &t_EI .= "\<Esc>Ptmux;\<Esc>\<Esc>[2 q\<Esc>\\"
            autocmd VimLeave * silent !echo -ne "\033Ptmux;\033\033[0 q\033\\"
        else
            let &t_SI .= "\<Esc>[4 q"
            let &t_EI .= "\<Esc>[2 q"
            autocmd VimLeave * silent !echo -ne "\033[0 q"
        endi

    " strips trailing whitespace at the end of files. this
    " is called on buffer write in the autogroup above.
        " function! <SID>StripTrailingWhitespaces()
        "     " save last search & cursor position
        "     let _s=@/
        "     let l = line(".")
        "     let c = col(".")
        "     %s/\s\+$//e
        "     let @/=_s
        "     call cursor(l, c)
        " endfunc

        function! <SID>CleanFile()
            " Preparation: save last search, and cursor position.
            let _s=@/
            let l = line(".")
            let c = col(".")
            " Do the business:
            %!git stripspace
            " Clean up: restore previous search history, and cursor position
            let @/=_s
            call cursor(l, c)
        endfunc

        function! <SID>RunFile()
            let ext = expand("%:e")
            if(ext == "go")
                :GoRun
            endif
        endfunc

        function! <SID>BuildFile()
            let ext = expand("%:e")
            if(ext == "go")
                :GoBuild
            endif
        endfunc

    " Coc Configuration
        " better display for messages
        set cmdheight=2

        " diagnostic messages default is 4000, but will give bad experience
        set updatetime=300

        " don't give |ins-completion-menu| messages
        set shortmess+=c

        " always show signcolumns
        " set signcolumn=yes

        " get correct comment highlighting:
        autocmd FileType json syntax match Comment +\/\/.\+$+

        " use <tab> for trigger completion and navigate to the next complete item
        function! s:check_back_space() abort
           let col = col('.') - 1
           return !col || getline('.')[col - 1]  =~ '\s'
        endfunction

       " inoremap <silent><expr> <Tab>
       "             \ pumvisible() ? "\<C-n>" :
       "             \ <SID>check_back_space() ? "\<Tab>" :
       "             \ coc#refresh()

       "  " Remap for rename current word
       "  nmap <leader>rn <Plug>(coc-rename)

       "  " Remap for format selected region
       "  xmap <leader>f  <Plug>(coc-format-selected)
       "  nmap <leader>f  <Plug>(coc-format-selected)

       "  " Use `:Format` to format current buffer
       "  command! -nargs=0 Format :call CocAction('format')

       "  " Using CocList
       "  " Show all diagnostics
       "  nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
       "  " Manage extensions
       "  nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
       "  " Show commands
       "  nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
       "  " Find symbol of current document
       "  nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
       "  " Search workspace symbols
       "  nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
       "  " Do default action for next item.
       "  nnoremap <silent> <space>j  :<C-u>CocNext<CR>
       "  " Do default action for previous item.
       "  nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
       "  " Resume latest coc list
       "  nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

