function! g:BlueCloth(arg, line1, line2)
ruby << EOF
    require 'rubygems'
    require 'bluecloth'

    firstline = VIM::evaluate('a:line1').to_i
    lastline  = VIM::evaluate('a:line2').to_i

    text = []
    for i in firstline .. lastline
        text.push $curbuf[i]
    end

    parse_text = BlueCloth.new(text.join("\n")).to_html.split("\n").reverse!

    parse_text.each do |line|
        $curbuf.append(lastline, line)
    end

    for i in firstline .. lastline
        $curbuf.delete(firstline)
    end
EOF
endfunction

command! -range=% -nargs=? BlueCloth :call g:BlueCloth(<q-args>, <line1>, <line2>)
