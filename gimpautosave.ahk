#Requires AutoHotkey v2.0+
#SingleInstance force

disableSave := false
lastTitle := ""
lastSave := A_TickCount-5000

#HotIf WinActive("ahk_exe gimp-3.exe")
~*LButton up:: {
    global disableSave, lastTitle, lastSave
    static saveInterval := 5000  ; Adjust the interval as needed (in milliseconds)
    activeTitle := WinGetTitle("A")

    if(!InStr(activeTitle, "– GIMP")) {
        OutputDebug("not in main window`n")
        return
    }

    if (disableSave and lastTitle = activeTitle) {        
            OutputDebug("Autosave is disabled`n")
            return
    }

    disableSave := false ;Gimp title changed so lets start saving again        

    MouseGetPos(&x, &y)
    if( x <= 275  or y <= 170) ;don't save when click is outside top/left of canvas
        return
    OutputDebug("Mouse up at: " x ", " y "`nLast save was " (A_TickCount-lastSave)//1000 " seconds ago`n")    

    if (A_TickCount - lastSave >= saveInterval) {
        OutputDebug("Saving...`n")
        lastSave := A_TickCount
        Send("^s")  ;press Ctrl+S to trigger GIMP's save function
    }
}

~Escape:: {
    activeTitle := WinGetTitle("A")

    if (activeTitle = "Save Image") {
        OutputDebug("Disabling Auto Save...`n")        

        while(!InStr(activeTitle, "– GIMP")){
            activeTitle := WinGetTitle("A")
            sleep 300
        }        

        global disableSave := true
        global lastTitle := activeTitle
    }
}