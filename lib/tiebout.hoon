::
::::  /hoon/tiebout/lib
  ::
/?  309
/-  hall
=,  eyre
:: ::
~%  %tiebout-lib  ..is  ~
|%
+$  move  [bone card]
::
+$  card
  $%  [%poke wire dock poke]
      [%peer wire dock path]
      [%pull wire dock ~]
      [%diff diff]
      [%hiss wire [~ ~] %httr %hiss hiss]
  ==
::
+$  diff
  $%  [%hall-rumor rumor:hall]
  ==
::
+$  poke
  $%  [%tiebout-action action]
  ==
::
+$  state
  $%  [%0 tie=tiebout-zero]
  ==
::
+$  tiebout-zero
  $:
      token=@t
      king=@p
      baseurl=@t
      ::  names, configs, and last read of all circles we know about
      ::
      circles=(map name:hall @)
  ==
::
+$  notification
  $:  token=@t
      topic=@t
      payload=(map @t json)
  ==
+$  action
  $%  [%token tok=@t]
      [%king kng=@p]
      [%baseurl bur=@t]
      [%notify not=notification]
      [%add-circle nom=name:hall]
      [%del-circle nom=name:hall]
  ==
--
