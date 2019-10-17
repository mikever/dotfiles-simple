" Vim Plug
    if empty(glob('~/.vim/autoload/plug.vim'))
      silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
      autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif

    " Plugins will be downloaded under the specified directory
    call plug#begin('~/.vim/plugged')

    Plug 'scrooloose/nerdtree'
    Plug 'Xuyuanp/nerdtree-git-plugin'
        map <Leader>d :NERDTreeToggle<CR>

    Plug 'neoclide/coc.nvim', {'branch': 'release'}

    Plug 'kshenoy/vim-signature'  " toggle and display marks
    Plug 'luochen1990/rainbow' " rainbow parentheses
    Plug 'thiagoalessio/rainbow_levels.vim'
    Plug 'tmhedberg/SimpylFold' " Helps with better folds
    Plug 'Konfekt/FastFold'  " manages auto-folds for better speed
    Plug 'adelarsq/vim-matchit' " extension matching for % operator
    Plug 'alvan/vim-closetag'  " auto-close HTML tags
    Plug 'tpope/vim-surround'  " manage surroundings for text units
    Plug 'tpope/vim-commentary'  " toggle comments: gc (motion) and gcc (line)
    Plug 'tpope/vim-fugitive'  " Git wrapper :G
    Plug 'justinmk/vim-sneak'  " jump to a location with s{char}{char}
    Plug 'thiagoalessio/rainbow_levels.vim'  " toggle rainbow level colors
    Plug 'jiangmiao/auto-pairs' " auto-close pairs with cursor in middle
    Plug 'mattn/emmet-vim'
        let g:user_emmet_leader_key=','  " {,,} to trigger


    Plug '/usr/local/opt/fzf'
    Plug 'junegunn/fzf.vim'  " fzf must be installed above
        "{{{
            let $FZF_DEFAULT_COMMAND = 'ag -l -g ""'
            let $FZF_DEFAULT_OPTS="--preview '[[ $(file --mime {}) =~ binary ]] && echo {} is a binary file || (bat --style=numbers --color=always {} || highlight -O ansi -l {} || coderay {} || rougify {} || cat {}) 2> /dev/null'"
            let g:fzf_layout = { 'down': '40%' }
            let g:fzf_nvim_statusline = 0  " disable statusline overwriting
            let g:fzf_colors =
            \ { 'fg':      ['fg', 'Normal'],
              \ 'bg':      ['bg', 'Normal'],
              \ 'hl':      ['fg', 'Comment'],
              \ 'fg+':     ['fg', 'Conditional', 'CursorColumn', 'Normal'],
              \ 'bg+':     ['bg', 'Conditional', 'Conditional'],
              \ 'hl+':     ['fg', 'Statement'],
              \ 'info':    ['fg', 'PreProc'],
              \ 'border':  ['fg', 'Ignore'],
              \ 'prompt':  ['fg', 'Conditional'],
              \ 'pointer': ['fg', 'Exception'],
              \ 'marker':  ['fg', 'Keyword'],
              \ 'spinner': ['fg', 'Label'],
              \ 'header':  ['fg', 'Comment'] }

            nnoremap <silent> <leader><space> :Files<CR>
            nnoremap <silent> <leader>b :Buffers<CR>
        "}}}

        " Optional
        command! -bang -nargs=? -complete=dir Files
          \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
        " Optional
        command! Evals call fzf#run(fzf#wrap({'source': map(filter(map(reverse(range(histnr(':') - 1000, histnr(':'))), 'histget(":", v:val)'),'v:val =~ "^Eval "'), 'substitute(v:val, "^Eval ", "", "")'), 'sink': function('<sid>eval_handler')}))

        " An action can be a reference to a function that processes selected lines
        function! s:build_quickfix_list(lines)
          call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
          copen
          cc
        endfunction

        let g:fzf_action = {
          \ 'ctrl-q': function('s:build_quickfix_list'),
          \ 'ctrl-t': 'tab split',
          \ 'ctrl-x': 'split',
          \ 'ctrl-v': 'vsplit' }
    
    Plug 'neoclide/coc.nvim', { 'do': 'yarn install --frozen-lockfile' }  " Completion

    Plug 'prettier/vim-prettier', { 'do': 'yarn install', 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html']  }
        let g:prettier#autoformat = 0
        autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html PrettierAsync

    " ColorSchemes
    Plug 'morhetz/gruvbox'
    Plug 'jacoborus/tender.vim'  " pleasant and colorful
    Plug 'andreypopp/vim-colors-plain'  " minimal
    Plug 'rakr/vim-two-firewatch'  " pleasant and beautiful

    " Theme
    Plug 'itchyny/lightline.vim'

    " Syntax
    " semshi neovim only
    " Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}  " semantic highlighting for python
    Plug 'stephpy/vim-yaml'
    Plug 'moll/vim-node'
    Plug 'leafgarland/typescript-vim'
    Plug 'rust-lang/rust.vim'
    Plug 'JulesWang/css.vim'
    Plug 'maxmellon/vim-jsx-pretty'

    " Plug List ends here. Plugins become visible to Vim after this call
    call plug#end()


" Theme/Layout
    syntax enable
    colorscheme gruvbox

    set colorcolumn=100
    " set background=dark
    set t_Co=256  " fixes glitch? in colors when using vim with tmux

" lightline
    let g:lightline = {
        \ 'colorscheme': 'gruvbox',
        \ }

    set laststatus=2  " make sure bar isn't a blank black line
    set noshowmode  " --INSERT-- not necessary since lightline handles it

" vimdiff colorscheme
    if &diff
        syntax off
        colorscheme apprentice

        let g:lightline = {
            \ 'colorscheme': 'apprentice',
            \ }
    endif

" UI Layout
    set number              " show line numbers
    set relativenumber
    set showcmd             " show command in bottom bar
    set nocursorline        " highlight current line
    " set wildmode=longest,list
    " set wildmenu
    set wildmenu
    set lazyredraw
    set showmatch           " higlight matching parenthesis
    set fillchars+=vert:┃
    set wrap linebreak nolist   " does not change text on break; simply displays on multiple lines
    set textwidth=0
    set wrapmargin=0

" Functionality Settings
    " Set the working directory to wherever the open file lives `:set autochdir!` to toggle
    set autochdir
    " `gf` opens file under cursor in a new horizontal split
    nnoremap gf :horizontal wincmd f<CR>

" Leader Shortcuts

    " Buffer list shortcut
    nnoremap <Leader>b :buffers<CR>:buffer<Space>

    " Rainbow Levels
    map <Leader>l :RainbowLevelsToggle<CR>

    " Rainbow indent custom colors
    if &l:background == 'dark'
        hi! RainbowLevel0 ctermfg=142 guifg=#b8bb26
        hi! RainbowLevel1 ctermfg=108 guifg=#8ec07c
        hi! RainbowLevel2 ctermfg=109 guifg=#83a598
        hi! RainbowLevel3 ctermfg=175 guifg=#d3869b
        hi! RainbowLevel4 ctermfg=167 guifg=#fb4934
        hi! RainbowLevel5 ctermfg=208 guifg=#fe8019
        hi! RainbowLevel6 ctermfg=214 guifg=#fabd2f
        hi! RainbowLevel7 ctermfg=223 guifg=#ebdbb2
        hi! RainbowLevel8 ctermfg=245 guifg=#928374
    else
        hi! RainbowLevel0 ctermfg=100 guifg=#79740e
        hi! RainbowLevel1 ctermfg=066 guifg=#427b58
        hi! RainbowLevel2 ctermfg=024 guifg=#076678
        hi! RainbowLevel3 ctermfg=096 guifg=#8f3f71
        hi! RainbowLevel4 ctermfg=088 guifg=#9d0006
        hi! RainbowLevel5 ctermfg=130 guifg=#af3a03
        hi! RainbowLevel6 ctermfg=136 guifg=#b57614
        hi! RainbowLevel7 ctermfg=244 guifg=#928374
        hi! RainbowLevel8 ctermfg=237 guifg=#3c3836
    endif 

" Folds
    set foldmethod=syntax
    set nofoldenable

" Paste
        set pastetoggle=<F5>        " <FN>5 on my keeb

" Indents and Spaces
    set tabstop=4           " tabs are at proper location
    set expandtab           " don't use actual tab character
    set shiftwidth=4        " indenting is 4 spaces
    set autoindent          " turns it on
    set smartindent         " does the right thing (mostly) in programs

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
    set hlsearch            " highlight all matches
    set smartcase           " search is case-sensitive if it contains an uppercase letter

" clear highlights
    nmap <C-_> :noh<CR>

" Remappings
    imap jk <Esc>

" Movement
    noremap <Up>    <Nop>
    noremap <Down>  <Nop>
    noremap <Left>  <Nop>
    noremap <Right> <Nop>
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
        autocmd BufWritePre *.php,*.py,*.js,*.txt,*.hs,*.java,*.md,*.rb :call <SID>StripTrailingWhitespaces()
        autocmd BufEnter *.cls setlocal filetype=java
        autocmd BufEnter Makefile setlocal noexpandtab
        autocmd BufEnter *.sh,*.js,*.md setlocal tabstop=2
        autocmd BufEnter *.sh,*.js,*.md setlocal shiftwidth=2
        autocmd BufEnter *.sh,*.js,*.md setlocal softtabstop=2
        autocmd BufEnter *.py setlocal tabstop=4
        autocmd BufEnter *.md setlocal ft=markdown
        autocmd BufEnter *.go setlocal noexpandtab
        autocmd BufEnter *.avsc setlocal ft=json
    augroup END

" Testing
    let test#strategy = 'neovim'
    let test#python#runner = 'nose'

" Backups
    set backup
    set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
    set backupskip=/tmp/*,/private/tmp/*
    set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
    set writebackup

" Sneak Configuration
    let g:sneak#s_next = 1

" vim rainbow configuration
    let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle

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
        function! <SID>StripTrailingWhitespaces()
            " save last search & cursor position
            let _s=@/
            let l = line(".")
            let c = col(".")
            %s/\s\+$//e
            let @/=_s
            call cursor(l, c)
        endfunc

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
        " To get correct comment highlighting:
        autocmd FileType json syntax match Comment +\/\/.\+$+

        " use <tab> for trigger completion and navigate to the next complete item
        function! s:check_back_space() abort
            let col = col('.') - 1
            return !col || getline('.')[col - 1]  =~ '\s'
        endfunction

        inoremap <silent><expr> <Tab>
                    \ pumvisible() ? "\<C-n>" :
                    \ <SID>check_back_space() ? "\<Tab>" :
                    \ coc#refresh()
