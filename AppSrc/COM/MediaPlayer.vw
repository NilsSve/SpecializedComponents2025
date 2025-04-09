// This sample shows how to use Media Player in an application. We import the
// class and added a dialog that allows us to select a file to read.
//
// The Media Player control was selected and imported using the Studio's Import
// ActiveX feature. We created a non-data aware control and placed it in the
// workspaces local area. No changes were made to the imported class.

Use DFClient.pkg
Use Windows.pkg
Use File_dlg.pkg

Use COM\cComWindowsMediaPlayer.pkg

ACTIVATE_VIEW Activate_oMediaPlayer FOR oMediaPlayer

Object oMediaPlayer is a dbView
    
    Property String psCurrentMedia ''
    
    Set Label to "Play Media File"
    Set Location to 4 9
    Set Size to 228 294
    
    Object oSelectMedia is a Form
        Set Label to "Select Media File to View"
        Set Size to 13 193
        Set Location to 208 93
        Set peAnchors to anBottomLeftRight
        Set Label_Col_Offset to 2
        Set Label_Justification_Mode to jMode_Right
        Set Prompt_Button_Mode to pb_PromptOn
        
        // set so pressing enter changes the media file
        On_Key kEnter Send Next
        
        Object oOpenFile is an OpenDialog
            Set Dialog_Caption to "Select Media File"
            Set Filter_String To 'All Media|*.wav;*.mpg;*.avi;*.mp3;*.rmi|MP3|*.mp3|MPEG|*.mpg'
            Set FileMustExist_State to False
            Set Initial_Folder to (PathAtIndex(phoWorkspace(ghoApplication), psDataPath(phoWorkspace(ghoApplication)), 1))
            Set ShowFileTitle_State to True
        End_Object
        
        // used to select media file
        Procedure Prompt
            Boolean bOpen
            Integer hDialog
            String sFileTitle sFileName
            
            Move oOpenFile to hDialog
            Get Show_Dialog of hDialog To bOpen
            If bOpen Begin
                Get File_Name of hDialog To sFileName
                Set Value to sFileName
            End
            Send DoDisplayMedia sFileName
        End_Procedure
        
        // select new media file when TAB or Enter is pressed
        Procedure Next
            String sFileName
            Get Value to sFileName
            Send DoDisplayMedia sFileName
        End_procedure
        
    End_Object

    Object oMediaPlayer1 is a cComWindowsMediaPlayer
        Set Size to 193 273
        Set Location to 4 10
        Set peAnchors to anAll

        Embed_ActiveX_Resource 
        AQMAAAgAAgAAAAAABQAAAAAAAADwPwMAAAAAAAUAAAAAAAAAAAAIAAIAAAAAAAMAAQAAAAsA//8DAAAAAAALAP//CAACAAAAAAADADIAAAALAAAACAAKAAAAZgB1AGwA
        bAAAAAsAAAALAAAACwD//wsA//8LAAAACAACAAAAAAAIAAIAAAAAAAgAAgAAAAAACAACAAAAAAALAAAABy8AAE8lAAA.
        End_Embed_ActiveX_Resource 
        
    End_Object
    
    // Message to select and display a media file.
    Procedure DoDisplayMedia string sFileName
        Integer bOk
        String sCurrentMedia
        
        // we keep track of current file that is loaded. Only change this
        // if we have a new file.
        Get psCurrentMedia to sCurrentMedia
        If (sCurrentMedia<>sFilename) Begin
            // load the file
            Set ComURL of oMediaPlayer1 to sFileName
            Set Label to ("Play Media File:" * sFileName)     // update caption bar
            Set psCurrentMedia to sFileName                   // set current file name
        End
    End_Procedure
    
End_Object

