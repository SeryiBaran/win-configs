#Requires AutoHotkey v1.0

#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn ; Enable warnings to assist with detecting common errors.
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.

#y::
 WinGetTitle, ActiveWindowTitle, A ; Get the active window's title for "targetting" it/acting on it.
 WinGetPos,,, Width, Height, %ActiveWindowTitle% ; Get the active window's position, used for our calculations.

 TargetX := (A_ScreenWidth/2)-(Width/2) ; Calculate the horizontal target where we'll move the window.
 TargetY := (A_ScreenHeight/2)-(Height/2) ; Calculate the vertical placement of the window.
 
 WinMove, %ActiveWindowTitle%,, %TargetX%, %TargetY% ; Move the window to the calculated coordinates.
 
return
