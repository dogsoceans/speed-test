  ::  /app/speed-test
::::
::
/-  *speed-test
/+  dbug,
    default-agent,
    *speed-test,
    verb,
    server,
    schooner
/*  speed-test-html  %html  /app/index/html
/*  speed-test-js  %js  /app/main/js
/*  style  %css  /app/style/css
/*  video  %mp4  /app/sample-1/mp4
|%
+$  versioned-state
  $%  state-0
  ==
+$  state-0
  $:  %0
      values=(list @)
  ==
+$  card  card:agent:gall
--
%+  verb  &
%-  agent:dbug
=|  state-0
=*  state  -
^-  agent:gall
=<
|_  =bowl:gall
+*  this     .
    default  ~(. (default-agent this %|) bowl)
    aux      ~(. +> bowl)
++  on-init
  ^-  [(list card) _this]
  ~&  >  "%speed-test initialized successfully."
  :-  :~  [%pass /eyre/connect %arvo %e %connect [~ /[dap.bowl]] dap.bowl]
      ==
  this
++  on-save   !>(state)
++  on-load
  |=  old=vase
  ^-  [(list card) _this]
  :-  ^-  (list card)
      ~
  %=  this
    state  !<(state-0 old)
  ==
++  on-poke
  |=  [=mark =vase]
  ^-  [(list card) _this]
  =^  cards  state
    ?+    mark  (on-poke:default mark vase)
        %handle-http-request
      (http-handler:aux !<([@ta inbound-request:eyre] vase))
    ==
  [cards this]
::
++  on-peek
  |=  path=(pole knot)
  ^-  (unit (unit cage))
  ?+    path  (on-peek:default path)
    [%x %value idx=@ ~]  [~ ~ [%noun !>((snag idx.path values))]]
    [%x %values ~]  [~ ~ [%noun !>(values)]]
  ==
++  on-watch
  |=  path=(pole knot)
  ^-  [(list card) _this]
  ?+    path  (on-watch:default path)
      [%values ~]
    `this
      [%http-response *]
    `this
  ==

::
++  on-arvo
  |=  [=wire =sign-arvo]
  ^-  (quip card _this)
  ?+    sign-arvo  (on-arvo:default [wire sign-arvo])
      [%eyre %bound *]
    ?:  accepted.sign-arvo
      %-  (slog leaf+"/apps/{(trip dap.bowl)} bound successfully!" ~)
      [~ this]
    %-  (slog leaf+"Binding /apps/{(trip dap.bowl)} failed!" ~)
    [~ this]
  ==
++  on-leave  on-leave:default
++  on-agent  on-agent:default
++  on-fail   on-fail:default
--
::
::  Helper Core
::
|_  =bowl:gall
+*  this     .
    default  ~(. (default-agent this %|) bowl)
::
++  http-handler
|=  [eyre-id=@ta =inbound-request:eyre]
^-  [(list card) _state]
=/  body  body.request.inbound-request
=/  =request-line:server 
  (parse-request-line:server url.request.inbound-request)
=+  send=(cury response:schooner eyre-id)
::
?+    method.request.inbound-request  
  [(send [405 ~ [%stock ~]]) state]
  :: 
    %'GET'
  ?+    site.request-line  
      :_  state 
      (send [404 ~ [%plain "404 - Not Found"]])
    ::
    ::send css and js
    ::
      [%speed-test %main ~]
    :_  state
    (send [200 ~ [%text-javascript speed-test-js]])

      [%speed-test %style ~]
    :_  state
    (send [200 ~ [%text-css style]])
    ::
    :: main requests
    ::

      [%speed-test %video ~]
    :_  state
    (send [200 ~ [%video-mp4 video]])

      [%speed-test ~]
    :_  state
    (send [200 ~ [%html speed-test-html]])
  == 
== 
++  take-action
  |=  act=action
  ^-  [(list card) _this]
  [~ this]
++  send-update
  |=  =term
  ^-  [(list card) _state]
  :-  :~  [%give %fact ~ %speed-test-update !>(`update`[%risen values])]
      ==
  state
--
