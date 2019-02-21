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
    :_  this(king.tie.sta.this ~bus)  ~
  ?-    -.u.old
      %0
    :_  this  ~
  ==
::
::  +poke-noun: debugging
::
++  poke-noun
  |=  act=action
  ^-  (quip move _this)
  (poke-tiebout-action act)
::
::
::

::  +poke-json: action handler for web events

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
    $add-circle
      (add-circle +.act)
    $del-circle
      (del-circle +.act)
    $notify
      (send-notify +.act)
  ==
::
::  +add-circle: add circle and subscribe for updates
::
++  add-circle
  |=  nom=name:hall
  ^-  (quip move _this)
  :_  this(circles.tie.sta (~(put by circles.tie.sta.this) nom 0))
  [ost.bol %peer /our/[nom] [our.bol %hall] /circle/[nom]/config]~
::
::  +del-circle: delete circle and unsubscribe from updates
::
++  del-circle
  |=  nom=name:hall
  ^-  (quip move _this)
  :_  this(circles.tie.sta (~(del by circles.tie.sta.this) nom))
  [ost.bol %pull /our/[nom] [our.bol %hall] ~]~
::
::  +set-king: set king @p
::
++  set-king
  |=  kng=@p
  ^-  (quip move _this)
  :_  this(king.tie.sta kng)  ~
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
  =/  furl=@t  (crip (weld (trip baseurl.tie.sta) (trip token.not)))
  =/  url=purl  (need (de-purl:html furl))
  =/  jon=json  :-  %o  %-  my  :~
    aps+o+payload.not
  ==
  :^  url  %post
  %-  my  :~
    apns-topic+[topic.not ~]  :: generate map from raw noun
  ==
  (some (as-octt:mimes:html (en-json:html jon)))
::
::  +diff-hall-prize:
::
++  diff-hall-prize
  |=  [wir=wire piz=prize:hall]
  ^-  (quip move _this)
  ~&  prize+[wir piz]
  ?~  wir
    (mean [leaf+"invalid wire for diff: {(spud wir)}"]~)
  ?+  wir
    (mean [leaf+"invalid wire for diff: {(spud wir)}"]~)
  ::
  ::  %our: set config of circle and iterate through messages, sending
  ::  notifications for all messages where number is higher than our last-read
  ::
      {%our @ @}
    ?>  ?=(%circle -.piz)
    =/  nom/name:hall  i.t.wir
    =/  red/@ud  red.loc.cos.piz
    :_  this(circles.tie.sta (~(put by circles.tie.sta.this) nom red))  ~
  ==

++  helper
  |=  [red=@ud env=envelope:hall]
  ^-  (list move)
  ~&  env
  =/  pay  %-  my  :~
    alert+s+'New message'
  ==
  =/  not/notification  :+
    token.tie.sta
    'com.tlon.urbit-client'
    pay
  ?:  (gth num.env red)
    [ost.bol %poke /me [our.bol dap.bol] [%tiebout-action [%notify not]]]~
  ~
::
::  +diff-hall-rumor:
::
++  diff-hall-rumor
  |=  [wir=wire rum=rumor:hall]
  ^-  (quip move _this)
  ~&  rumor+[wir rum]
  ?~  wir
    (mean [leaf+"invalid wire for diff: {(spud wir)}"]~)
  ?+  wir
    (mean [leaf+"invalid wire for diff: {(spud wir)}"]~)
  ::
  ::  %our: set config of circle and iterate through messages, sending
  ::  notifications for all messages where number is higher than our last-read
  ::
      {%our @ @}
    ?>  ?=(%circle -.rum)
    =/  nom/name:hall  i.t.wir
    ::  get new read number if possible from config change
    ::  if not a read event, then use previous read number
    ::  then, generate a list of moves based on the messages in the rumor
    ::  that are higher in number than the read number
    ?+  -.rum.rum
      :_  this  ~
      %gram
    =/  red/@  (need (~(get by circles.tie.sta.this) nom))
    ?:  (gth num.nev.rum.rum red)
      :_  this(circles.tie.sta (~(put by circles.tie.sta.this) nom red))
      (helper red nev.rum.rum) 
    :_  this
    (helper red nev.rum.rum)
      %config
    ?+  -.dif.rum.rum
      [~ this]
          %read
        =/  red/@ud  red.dif.rum.rum
        :_  this(circles.tie.sta (~(put by circles.tie.sta.this) nom red))  ~
      ==
    ==
  ==
--
