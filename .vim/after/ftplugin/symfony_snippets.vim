if !exists('loaded_snippet') || &cp
  finish
endif

let st = g:snip_start_tag
let et = g:snip_end_tag
let cd = g:snip_elem_delim

exec "Snippet request $this->getRequestParameter('".st."param".et. "');<CR>".st.et
exec "Snippet verror return sfView::ERROR;".st.et
exec "Snippet forward $this->forward('".st."module".et."', '".st."action".et."');".st.et
exec "Snippet redirect $this->redirect('".st."param".et."');".st.et
exec "Snippet serror $this->getRequest()->setError('".st."name".et."', '".st."text".et."');<CR>".st.et

exec "Snippet partial <?php include_partial('".st."partial".et."'".st.et.") ?>"
exec "Snippet component <?php include_component('".st."module".et."', '".st."component".et."'".st.et.") ?>"
exec "Snippet slot <?php include_slot('".st."slot".et."') ?><CR>".st.et."<CR><?php end_slot() ?>"

exec "Snippet newc $c = new Criteria();<CR>".st.et
exec "Snippet add $c->add(".st."column".et.", ".st."value".et.");<CR>".st.et
exec "Snippet desc $c->addDescendingOrderByColumn(".st."column".et.");<CR>".st.et
exec "Snippet asc $c->addAscendingOrderByColumn(".st."column".et.");<CR>".st.et
exec "Snippet limit $c->setLimit(".st."column".et.");<CR>".st.et
exec "Snippet dos ".st."model".et."::doSelect($c);".st.et
exec "Snippet doo ".st."model".et."::doSelectOne($c);".st.et
exec "Snippet doc ".st."model".et."::doCount($c);".st.et


exec "Snippet action <?php<CR><CR>class ".st."action".et."Action extends sfAction<CR>{<CR><Tab>public function execute($request) {<CR><Tab>".st.et."<CR><BS>}<CR><BS>}"
