if !exists('loaded_snippet') || &cp
  finish
endif

let st = g:snip_start_tag
let et = g:snip_end_tag
let cd = g:snip_elem_delim

exec "Snippet php <?php ".st.et." ?>"
exec "Snippet if if (".st.et.") {<CR><Tab>".st.et."<CR><BS>}"
exec "Snippet elseif elseif (".st.et.") {<CR><Tab>".st.et."<CR><BS>}"
exec "Snippet else else {<CR><Tab>".st.et."<CR><BS>}"
exec "Snippet for for ($i = ".st."0".et."; $i ".st.et."; $i++) {<CR><Tab>".st.et."<CR><BS>}"
exec "Snippet foreach foreach (".st.et." as ".st.et.") {<CR><Tab>".st.et."<CR><BS>}"

exec "Snippet fpub public function ".st."funcname".et."(".st.et.") {<CR><Tab>".st.et."<CR><BS>}"
exec "Snippet fpri private function ".st."funcname".et."(".st.et.") {<CR><Tab>".st.et."<CR><BS>}"
exec "Snippet fpro protected function ".st."funcname".et."(".st.et.") {<CR><Tab>".st.et."<CR><BS>}"

exec "Snippet fspub public static function ".st."funcname".et."(".st.et.") {<CR><Tab>".st.et."<CR><BS>}"
exec "Snippet fspri private static function ".st."funcname".et."(".st.et.") {<CR><Tab>".st.et."<CR><BS>}"
exec "Snippet fspro protected static function ".st."funcname".et."(".st.et.") {<CR><Tab>".st.et."<CR><BS>}"
