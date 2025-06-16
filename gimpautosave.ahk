#Requires AutoHotkey v2.0+
#SingleInstance force

#HotIf WinActive("– GIMP", , "*[Untitled]")
~*LButton up:: {
    static lastSave := A_TickCount - 5000
    static saveInterval := 5000  ; Adjust the interval as needed (in milliseconds)

    MouseGetPos(&x, &y)
    if (x <= 275 or y <= 170) ;don't save when click is outside top/left of canvas
        return
    OutputDebug("Mouse up at: " x ", " y "`nLast save was " (A_TickCount - lastSave) // 1000 " seconds ago`n")

    if (A_TickCount - lastSave >= saveInterval) {
        OutputDebug("Saving...`n")
        lastSave := A_TickCount
        Send("^s")  ;press Ctrl+S to trigger GIMP's save function
    }
}
#HotIf