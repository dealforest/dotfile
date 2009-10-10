" Firefox browser content is reloaded when file(*.html,*htm,*.js,*.css) is saved.
" This script requires MozLab(http://dev.hyperstruct.net/trac/mozlab) extension.
"
" file created in 2006/10/05 08:22:45.
" LastUpdated :2008/07/12 10:59:48.
" author iNo
" blog : http://www.serendip.ws/
" web site : http://www.serendip.ws/
"
" Command
" :Setreloadfirefox
"

if exists('g:reload_firefox')
    finish
endif

command -nargs=0 Setreloadfirefox :call SetMozreplReloadFirefox()

function! ReloadFirefox()
    if has('ruby')
        :ruby <<EOF
            require "net/telnet"

            telnet = Net::Telnet.new({
                "Host" => "localhost",
                "Port" => 4242
            })

            telnet.puts("content.location.reload(true)\n")
            telnet.puts("repl.quit()\n")
            telnet.close
EOF
    elseif has('python')
        :python <<EOF
import telnetlib
HOST = "localhost"
PORT = 4242
telnet = telnetlib.Telnet(HOST, PORT)
telnet.read_until("repl>")
telnet.write("content.location.reload(true)\n")
telnet.write("repl.quit()\n")
telnet.close()
EOF
    elseif has('perl')
        :perl <<EOF
            use strict;
            use warnings;
            use Net::Telnet;

            my $host = 'localhost';
            my $port = 4242;
            my $prompt = '/[repl>]/';

            my $telnet = new Net::Telnet(
                Host => $host,
                Port => $port,
                Timeout => 10,
                Prompt => $prompt,
            );

            $telnet->open($host);
            $telnet->cmd("content.location.reload(true)\n");
            $telnet->cmd("repl.quit()\n");
            $telnet->close;
EOF
    else
        if has('gui_win32')
            " for Windows
            let ruby_script_file = 'd:/cygwin/home/tom/bin/mozrepl_reload_firefox.rb'
        else
            " for Mac, Linux, Cygwin
            let ruby_script_file = $HOME . '/bin/mozrepl_reload_firefox.rb'
        endif

        if filereadable(ruby_script_file)
            call system(ruby_script_file)
        else
            echo "ERROR : File \"" . ruby_script_file . "\" is NOT found."
        endif
    endif
endfunction

function! SetMozreplReloadFirefox()
    if exists('g:reload_firefox')
        autocmd! mozreplreloadfirefox
        unlet g:reload_firefox
        echo "\"mozreplreloadfirefox\" of augroup has been deleted."
    else
        augroup mozreplreloadfirefox
           autocmd BufWritePost *.html,*.htm,*.php,*.js,*.css call ReloadFirefox()
        augroup END
        let g:reload_firefox=1
        echo "Firefox browser content is reloaded when file(*.html,*htm,*.php,*.js,*.css) is saved."
    endif
endfunction
