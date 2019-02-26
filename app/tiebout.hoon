::
::::  /app/tiebout/hoon
::
/?  309
/-  hall
/+  tiebout
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
::  +prep: set up app state, upgrade app state
::
++  prep
  |=  old=(unit state)
  ^-  (quip move _this)
  ?~  old
    :-  ~
    %=  this
      king.tie.sta  ~dopzod
      baseurl.tie.sta  'https://api.push.apple.com/3/device/'
    ==
  ?-  -.u.old
    %0
      [~ this(sta u.old)]
  ==
::
::  +coup: receive acknowledgement for poke, print error if it failed
::
++  coup
  |=  [wir=wire err=(unit tang)]
  ^-  (quip move _this)
  ?~  err
    [~ this]
  (mean u.err)
::
::  +poke-noun: receive debugging actions
::
++  poke-noun
  |=  act=action
  ^-  (quip move _this)
  (poke-tiebout-action act)
::
::  +poke-tiebout-action: main action handler
::
++  poke-tiebout-action
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
  :_  this(circles.tie.sta (~(put by circles.tie.sta) nom 0))
  [ost.bol %peer /our/[nom] [our.bol %hall] /circle/[nom]/config/grams]~
::
::  +del-circle: delete circle and unsubscribe from updates
::
++  del-circle
  |=  nom=name:hall
  ^-  (quip move _this)
  :_  this(circles.tie.sta (~(del by circles.tie.sta) nom))
  [ost.bol %pull /our/[nom] [our.bol %hall] ~]~
::
::  +set-king: set king @p
::
++  set-king
  |=  kng=@p
  ^-  (quip move _this)
  [~ this(king.tie.sta kng)]
::
::  +set-token: set iOS device token @t
::
++  set-token
  |=  tok=@t
  ^-  (quip move _this)
  [~ this(token.tie.sta tok)]
::
::  +set-baseurl: set base url @t
::
++  set-baseurl
  |=  burl=@t
  ^-  (quip move _this)
  [~ this(baseurl.tie.sta burl)]
::
::  +send-notify: if king, send hiss. if not, do nothing.
::
++  send-notify
  |=  not=notification
  ^-  (quip move _this)
  ?:  =(king.tie.sta our.bol)
    :_  this
    [ost.bol %hiss /request [~ ~] %httr %hiss (create-apns-request not)]~
  [~ this]
::
::  +diff-hall-prize: receive new circle data
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
    [~ this(circles.tie.sta (~(put by circles.tie.sta) nom red))]
  ==
::
::  +reap: recieve acknowledgement for peer
::
++  reap
  |=  [wir=wire err=(unit tang)]
  ^-  (quip move _this)
  ::~&  reap+[wir =(~ err)]
  ?~  err
    ::  XX send message to users inbox
    [~ this]
  ?~  wir
    (mean [leaf+"invalid wire for diff: {(spud wir)}"]~)
  ?+  i.wir
    (mean [leaf+"invalid wire for diff: {(spud wir)}"]~)
      %our
    ?<  ?=(~ t.wir)
    :_  this
    ~
  ==
::
::  +quit: receive subscription failed, resubscribe
::
++  quit
  |=  wir=wire
  ^-  (quip move _this)
  ?~  wir
    (mean [leaf+"invalid wire for diff: {(spud wir)}"]~)
  ?+  i.wir
    (mean [leaf+"invalid wire for diff: {(spud wir)}"]~)
      %our
    ?<  ?=(~ t.wir)
    :_  this
    =/  doc/dock  [our.bol %hall]
    [ost.bol %peer /our/[i.t.wir] doc /circle/[i.t.wir]/config/grams]~
  ==

::
::  +diff-hall-rumor: receive message or a read event from a hall circle
::
++  diff-hall-rumor
  |=  [wir=wire rum=rumor:hall]
  ^-  (quip move _this)
  ::~&  rumor+[wir rum]
  ?~  wir
    (mean [leaf+"invalid wire for diff: {(spud wir)}"]~)
  ?+  wir
    (mean [leaf+"invalid wire for diff: {(spud wir)}"]~)
  ::
  ::  %our
  ::
      {%our @ @}
    ?>  ?=(%circle -.rum)
    =/  nom/name:hall  i.t.wir
    ?+  -.rum.rum
      [~ this]
    ::
    ::  %gram: send notification if envelope is lower than read number
    ::
      %gram
    =/  red  (~(get by circles.tie.sta) nom)
    ?~  red
      (mean [leaf+"invalid circle for diff: {(spud wir)}"]~)
    ?:  (gth num.nev.rum.rum u.red)
      :_  this(circles.tie.sta (~(put by circles.tie.sta) nom u.red))
      (message-to-notification u.red nev.rum.rum)
    :_  this
    (message-to-notification u.red nev.rum.rum)
    ::
    ::   %config: set our read number
    ::
      %config
    ?+  -.dif.rum.rum
      [~ this]
          %read
        =/  red/@ud  red.dif.rum.rum
        [~ this(circles.tie.sta (~(put by circles.tie.sta) nom red))]
      ==
    ==
  ==
::
::  generate notification move from hall message
::
++  message-to-notification
  |=  [red=@ud env=envelope:hall]
  ^-  (list move)
  ?:  =(aut.gam.env our.bol)
    ~
  =/  pay  %-  my  :~
    alert+s+'New message from {(cite:title aut.gam.env)}'
  ==
  =/  not/notification  :+
    token.tie.sta
    'com.tlon.urbit-client'
    pay
  ?:  (lte num.env red)
    ~
  =/  doc/dock  [king.tie.sta dap.bol]
  [ost.bol %poke /ask-king doc %tiebout-action [%notify not]]~

::
::  +create-apns-request: create hiss with payload for APNs
::
++  create-apns-request
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
--
