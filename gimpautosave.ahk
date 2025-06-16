#Requires AutoHotkey v2.0+
#SingleInstance force

#HotIf WinActive("– GIMP", , "*[Untitled]")
~*LButton up:: {
    static saveInterval := 5000  ; Adjust the interval as needed (in milliseconds)
    static lastSave := A_TickCount - saveInterval

    winTitle := WinGetTitle("– GIMP")
    if (SubStr(winTitle, 1, 1) != "*") ;Don't save if there are no changes
        return

    OutputDebug("Last save was " (A_TickCount - lastSave) // 1000 " seconds ago`n")

    if (A_TickCount - lastSave >= saveInterval) { ;don't save if already saved less than 5 seconds ago
        OutputDebug("Saving...`n")
        lastSave := A_TickCount
        Send("^s")  ;press Ctrl+S to trigger GIMP's save function
    }
}
#HotIf