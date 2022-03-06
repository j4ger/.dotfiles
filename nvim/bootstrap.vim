function! bootstrap#after() abort  

    function! s:cargo_task() abort
        if filereadable('Cargo.toml')
            let commands = ['build', 'run', 'test']
            let conf = {}
            for cmd in commands
                call extend(conf, {
                            \ cmd : {
                            \ 'command': 'cargo',
                            \ 'args' : [cmd],
                            \ 'isDetected' : 1,
                            \ 'detectedName' : 'cargo:'
                            \ }
                            \ })
            endfor
            return conf
        else
            return {}
        endif
    endfunction
    call SpaceVim#plugins#tasks#reg_provider(funcref('s:cargo_task'))

    " let g:neoformat_enabled_rust = ["cargo"]
    " let g:neoformat_rust_cargo = {
      " \ "exe": "cargo fmt"
      " \ }
endfunction

function! bootstrap#before() abort
    let g:tokyonight_transparent = 1
    let g:tokyonight_transparent_sidebar = 1
endfunction
