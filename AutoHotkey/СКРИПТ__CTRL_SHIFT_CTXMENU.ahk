#Requires AutoHotkey 1.1.37+  ;Needs a recent AHK v1
#SingleInstance Force         ;Run only one instance
CoordMode ToolTip             ;Allow for TT Warning

+^AppsKey::AudioLayer(1)            ;Toggle Audio keys

#If AudioLayer()              ;If AudioLayer is On
F1::Volume_Mute               ;These become active
F2::Volume_Down
F3::Volume_Up
F5::Media_Play_Pause
F6::Media_Prev
F7::Media_Next
#If                           ;End #If block

AudioLayer(Set:=0){           ;Main Func
  Static Toggle:=0            ;  Store Toggle state
  If Set                      ;  If value passed
    Toggle:=!Toggle           ;    Flip Toggle
  ToolTip % Toggle?"Audio Keys Active":"",0,A_ScreenHeight
  Return Toggle               ;  Send Toogle state back 
}                             ;End
