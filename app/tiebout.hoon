::
::::  /app/tiebout/hoon
  ::
/-  hall
/+  tiebout
::
=,  tiebout
=,  eyre
::
::  state:
::
~%  %tiebout  ..^is  ~
|_  [bol=bowl:gall sta=state]
::
::  +this: app core subject
::
++  this  .
::
::  +prep:
::
++  prep
  ~/  %tie-prep
  |=  old=(unit state)
  ^-  (quip move _this)
  ?~  old
    :_  this  ~
::      :~  [ost.bol %peer /circles [our.bol %hall] /circles/[(scot %p our.bol)]]
::          [ost.bol %peer /inbox [our.bol %hall] /circle/inbox/config/grams]
::      ==
  ?-    -.u.old
      %0
    :_  this  ~
  ==
++  poke-noun
  |=  act=action
  ^-  (quip move _this)
  (poke-tiebout-action act)
::
::  +poke-tiebout-action: main action handler
::
++  poke-tiebout-action
  ~/  %tie-poke-tiebout-action
  |=  act=action
  ^-  (quip move _this)
  ?-  -.act
    $king
      (set-king +.act)
    $token
      (set-token +.act)
    $baseurl
      (set-baseurl +.act)
    $notify
      (send-notify +.act)
  ==
::
::  +set-king: set king @p
::
++  set-king
  |=  kng=@p
  ^-  (quip move _this)
  =/  newtie  tie.sta.this(king kng)
  =/  newstate  sta.this(tie newtie)
  :_  this(sta newstate)  ~
::
::  +set-token: set token @t
::
++  set-token
  |=  tok=@t
  ^-  (quip move _this)
  =/  newtie  tie.sta.this(token tok)
  =/  newstate  sta.this(tie newtie)
  :_  this(sta newstate)  ~
::
::  +set-baseurl: set base url @t
::
++  set-baseurl
  |=  burl=@t
  ^-  (quip move _this)
  =/  newtie  tie.sta.this(baseurl burl)
  =/  newstate  sta.this(tie newtie)
  :_  this(sta newstate)  ~
::
::  +send-notify: if king, send hiss. if not king, send to king.
::
++  send-notify
  |=  not=notification
  ^-  (quip move _this)
  ?:  =(king.tie.sta our.bol)
    :_  this
    [ost.bol %hiss /request [~ ~] %httr %hiss (create-hiss not)]~
  :_  this
  =/  doc/dock  [king.tie.sta %tiebout]
  [ost.bol %poke /ask-king doc [%tiebout-action [%notify not=not]]]~
::
++  create-hiss
  |=  not=notification
  ^-  hiss
  =/  furl=@t  (crip (weld (trip baseurl.tie.sta) (trip token.tie.sta)))
  =/  url=purl  (need (de-purl:html furl))
  =/  jon=json  :-  %o  %-  my  :~
    aps+o+payload.not
  ==
  :^  url  %post
  %-  my  :~
    apns-topic+[topic.not ~]  :: generate map from raw noun
  ==
  (some (as-octt:mimes:html (en-json:html jon)))

--
::  +coup: recieve acknowledgement for poke, print error if it failed
::
::++  coup
::  |=  [wir=wire err=(unit tang)]
::  ^-  (quip move _this)
::  ?~  err
::    [~ this]
::  (mean u.err)
::
::  +sigh-httr: receive result of http request
::
::++  sigh-httr
::  |=  [wir=wire code=@ud headers=mess:eyre body=(unit octs)]
::  ^-  [(list move) _this]
::  ?:  &((gte code 200) (lth code 300))
::    ~&  [%all-is-well code]
::    ~&  [%headers headers]
::    ~&  [%body body]
::    [~ this]
::  ~&  [%we-have-a-problem code]
::  ~&  [%headers headers]
::  ~&  [%body body]
::  [~ this]
::
::  +reap: recieve acknowledgement for peer, retry on failure
::
::++  reap
::  |=  [wir=wire err=(unit tang)]
::  ^-  (quip move _this)
::  ::~&  reap+[wir =(~ err)]
::  ?~  err
::    ::  XX send message to users inbox
::    [~ this]
::  ?~  wir
::    (mean [leaf+"invalid wire for diff: {(spud wir)}"]~)
::  ?+  i.wir
::    (mean [leaf+"invalid wire for diff: {(spud wir)}"]~)
::  ::
::      %circles
::    :_  this
::    [ost.bol %peer /circles [our.bol %hall] /circles/[(scot %p our.bol)]]~
::  ::
::      %inbox
::    :_  this
::    [ost.bol %peer /inbox [our.bol %hall] /circle/inbox/config/grams]~
::  ::
::      %our
::    ?<  ?=(~ t.wir)
::    :_  this
::    [ost.bol %peer /our/[i.t.wir] [our.bol %hall] /circle/[i.t.wir]/config]~
::  ==
::::
::::  +quit:
::::
::++  quit
::  |=  wir=wire
::  ^-  (quip move _this)
::  ?~  wir
::    (mean [leaf+"invalid wire for diff: {(spud wir)}"]~)
::  ?+  i.wir
::    (mean [leaf+"invalid wire for diff: {(spud wir)}"]~)
::  ::
::      %circles
::    :_  this
::    [ost.bol %peer /circles [our.bol %hall] /circles/[(scot %p our.bol)]]~
::  ::
::      %inbox
::    :_  this
::    [ost.bol %peer /inbox [our.bol %hall] /circle/inbox/config/grams]~
::  ::
::      %our
::    ?<  ?=(~ t.wir)
::    :_  this
::    [ost.bol %peer /our/[i.t.wir] [our.bol %hall] /circle/[i.t.wir]/config]~
::  ==

