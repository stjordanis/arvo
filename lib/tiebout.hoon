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
      ::  names and configs of all circles we know about
      ::
      circles=(map circle:hall (unit config:hall))
      ::  names and last read message of all circles we know about
      ::
      sequence=(map circle:hall @)
      ::  names of all circles we own
      ::
      our-circles=(set name:hall)
  ==
::
+$  prize
  $:  ::  names and configs of all circles we know about
      ::
      circles=(map circle:hall (unit config:hall))
      ::  names and last read message of all circles we know about
      ::
      sequence=(map circle:hall @)
      ::  names of all circles we own
      ::
      our-circles=(set name:hall)
  ==
::
+$  notification
  $:  topic=@t
      payload=(map @t json)
  ==
+$  action
  $%  [%token tok=@t]
      [%king kng=@p]
      [%baseurl bur=@t]
      [%notify not=notification]
  ==
--
