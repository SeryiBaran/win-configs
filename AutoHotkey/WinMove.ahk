; Перемещение активного окна с помощью Win+Ctrl + стрелки
; (удерживайте Win и Ctrl, нажимая стрелки)

#^Left::   ; Win+Ctrl+Влево
#^Right::  ; Win+Ctrl+Вправо
#^Up::     ; Win+Ctrl+Вверх
#^Down::   ; Win+Ctrl+Вниз

; Определяем, какая клавиша была нажата
Hotkey := A_ThisHotkey

; Получаем текущие координаты и размеры активного окна
WinGetPos, X, Y, Width, Height, A

; Если окно развёрнуто на весь экран — не двигаем его (можно убрать)
WinGet, WinState, MinMax, A
if (WinState = 1)  ; 1 = развёрнуто (максимизировано)
    return

; Вычисляем новое положение
if (Hotkey = "#^Left")
    X -= 1
else if (Hotkey = "#^Right")
    X += 1
else if (Hotkey = "#^Up")
    Y -= 1
else if (Hotkey = "#^Down")
    Y += 1

; Перемещаем окно
WinMove, A,, %X%, %Y%
return