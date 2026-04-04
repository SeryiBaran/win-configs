#Requires AutoHotkey v2.0
#SingleInstance Force

; ==================== НАСТРОЙКИ ====================

; ======== НАСТРОЙКА ПУТИ К АУДИОФАЙЛУ MP3 ========
iniFile := A_WorkingDir . "\MouseIdleSound__SETTINGS.ini"
mp3File := A_WorkingDir . "\MouseIdleSound__SOUND.mp3"

; ======== НАСТРОЙКА ВРЕМЕНИ БЕЗДЕЙСТВИЯ МЫШИ ========
; Указывается в миллисекундах (1/1000 секунды)
; По умолчанию: "5 * 1000" (5 секунд, для теста)
; Операторы:
; - Умножение *
; - Деление /
; - Сложение +
; - Вычитание -
maxIdleTime := 5 * 1000
; ===================================================

maxIdleTimeFromINI := Number(IniRead(iniFile, "settings", "MAX_IDLE_SECS"))

if (maxIdleTimeFromINI > 1)
{
  maxIdleTime := maxIdleTimeFromINI * 1000
}

; дальше - deepseek

global lastX := 0, lastY := 0
global idleStartTime := 0
global isPlaying := false
global isStoppedByMouse := false
global mciAlias := "MyMP3"

shortMp3 := GetShortPath(mp3File)

MouseGetPos(&lastX, &lastY)
SetTimer(CheckIdle, 100)
Hotkey("#Esc", ExitProgram)

CheckIdle() {
    global lastX, lastY, idleStartTime, isPlaying, isStoppedByMouse, maxIdleTime, mciAlias
    MouseGetPos(&curX, &curY)
    if (curX != lastX || curY != lastY) {
        lastX := curX, lastY := curY
        idleStartTime := 0
        if (isPlaying || isStoppedByMouse)
            StopMP3()
        return
    }
    if (idleStartTime == 0)
        idleStartTime := A_TickCount
    idleDuration := A_TickCount - idleStartTime
    if (idleDuration >= maxIdleTime && !isPlaying) {
        PlayMP3()
        isPlaying := true
        isStoppedByMouse := false
    }
    if (isPlaying) {
        status := GetMCIStatus(mciAlias)
        if (status == "stopped") {
            isPlaying := false
            if (A_TickCount - idleStartTime >= maxIdleTime) {
                PlayMP3()
                isPlaying := true
            }
        }
    }
}

PlayMP3() {
    global mciAlias, shortMp3
    mciSendString("close " mciAlias)
    ; Использую одинарные кавычки, чтобы внутри спокойно ставить двойные
    cmd := 'open "' shortMp3 '" alias ' mciAlias
    mciSendString(cmd)
    mciSendString("play " mciAlias)
}

StopMP3() {
    global mciAlias, isPlaying, isStoppedByMouse
    if (isPlaying) {
        mciSendString("stop " mciAlias)
        mciSendString("close " mciAlias)
        isPlaying := false
        isStoppedByMouse := true
    }
}

GetShortPath(longPath) {
    buf := Buffer(260)
    if DllCall("GetShortPathName", "Str", longPath, "Ptr", buf, "UInt", 260, "UInt")
        return StrGet(buf)
    return longPath
}

mciSendString(command) {
    DllCall("winmm.dll\mciSendString", "Str", command, "Ptr", 0, "UInt", 0, "Ptr", 0)
}

GetMCIStatus(alias) {
    buf := Buffer(256)
    DllCall("winmm.dll\mciSendString", "Str", "status " alias " mode", "Ptr", buf, "UInt", 256, "Ptr", 0)
    return StrGet(buf)
}

ExitProgram(*) {
    StopMP3()
    ExitApp
}
