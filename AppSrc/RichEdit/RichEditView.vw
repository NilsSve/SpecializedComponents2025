// find dialog for rich edit control
Use RichEdit\RichEditFind.dg
// find & replace dialog for rich edit control
Use RichEdit\RichEditFindReplace.dg

Use dfClient.pkg
Use cRichEdit.pkg
Use File_dlg.Pkg
Use Windows.pkg
Use DfLine.Pkg

Activate_View Activate_oRichEditControl for oRichEditControl
Object oRichEditControl is a dbView
    
    // Since ShellExecute is already used in some predefined DataFlex packages,
    // this #IFDEF statement will stop interference of this declaration with those
    // in the DataFlex packages.
#IFDEF GET_SHELLEXECUTE
#ELSE
    
    // external function call used in Procedure DoStartDocument
External_Function ShellExecute "ShellExecuteA" shell32.dll ;
    Handle hWnd ;
    String lpOperation ;
    String lpFile ;
    String lpParameters ;
    String lpDirectory ;
    DWord iShowCmd Returns Handle
#ENDIF

// toolbar for rich edit control
Use RichEdit\RichEditComponentToolbar.pkg

// indicates whether the text in the control has exceeded the limit set by piMaxChars
Property Boolean pbTextExceededLimit False

// indicates whether Save should be allowed on an open file
Property Boolean pbAllowSaves True

Set Border_Style to Border_Thick
Set Label to "RichEdit Test View"
Set Location to 2 2
Set Size to 313 466
Set pbAutoActivate to True

Object oRichEdit1 is a cRichEdit
    
    // define custom floating context menu for control
    Object oCustomMenu is a FloatingPopupMenu
        Send Add_Item msg_Undo "&Undo"
        Send Add_Item msg_Redo "&Redo"
        Send Add_Item msg_None "" // create a spacer
        Send Add_Item msg_Cut "Cu&t"
        Send Add_Item msg_Copy "&Copy"
        Send Add_Item msg_Paste "&Paste"
        Send Add_Item msg_None "" // create a spacer
        Send Add_Item msg_Select_All "Select &All"
        
        Procedure Popup
            Integer iFocus
            Boolean bCanUndo bCanRedo
            
            Get Focus to iFocus // the object that called us
            
            // shadow Undo item if no undo operations available
            Get pbCanUndo of iFocus to bCanUndo
            Set Shadow_State 0 to (not(bCanUndo))
            // shadow Redo item if no redo operations available
            Get pbCanRedo of iFocus to bCanRedo
            Set Shadow_State 1 to (not(bCanRedo))
            
            Forward Send Popup
        End_Procedure
    End_Object
    
    // define the context menu property for the control
    Set Floating_Menu_Object to oCustomMenu
    
    // object id of toolbar "attached to"/"used by" control
    Property Integer piToolbar (oRichEditToolBar(Self))
    
    // tracks current document name
    // if blank (""), no existing document has been opened or saved
    Property String psCurrentDocument
    
    Set Size to 274 455
    Set Location to 32 5
    Set Color to clWhite
    Set TextColor to clBlack
    Set peAnchors to anAll
    
    // define additional shortcut keys for control
    On_Key Key_Ctrl+Key_N Send DoNewDocument
    On_Key Key_Ctrl+Key_O Send DoOpenDocument
    On_Key Key_Ctrl+Key_S Send DoSaveDocument
    On_Key Key_Ctrl+Key_F Send DoFind
    On_Key Key_Ctrl+Key_H Send DoFindReplace
    
    // initialize control when entering
    // Entering is called each time the user navigates into the control.
    // Since this view only contains one control, this will happen only once,
    // when opening the view.
    Procedure Entering
        Forward Send Entering
        
        // make sure undo buffer is clear when we initialize control
        Send ClearUndoBuffer
        
        // disable undo & redo buttons
        Set pbEnabled of (oUndo(piToolbar(Self))) to False
        Set pbEnabled of (oRedo(piToolbar(Self))) to False
        
        Set label of oCurFile to "Current File: <new>"
        
    End_Procedure
    
    // left aligns selected paragraph(s)called from toolbar
    Procedure AlignLeft
        Set peAlignment to alLeft
    End_Procedure
    
    // centers selected paragraph(s) called from toolbar
    Procedure AlignCenter
        Set peAlignment to alCenter
    End_Procedure
    
    // right aligns selected paragraph(s)
    // called from toolbar
    Procedure AlignRight
        Set peAlignment to alRight
    End_Procedure
    
    // indents selected paragraph(s) by 0.5 inches
    // called from toolbar
    Procedure DoIndent
        Integer iTwipsPerInch iCurrentIndent
        
        // number of twips per inch
        Move 1440 to iTwipsPerInch
        
        // indent 0.5 inches from current indentation
        Get piParagraphIndent to iCurrentIndent
        Set piParagraphIndent to (iCurrentIndent + (iTwipsPerInch * 0.5))
    End_Procedure
    
    // indents selected paragraph(s) by 0.5 inches
    Procedure DoOffsetIndent
        Integer iTwipsPerInch iCurrentIndent
        
        // number of twips per inch
        Move 1440 to iTwipsPerInch
        
        // indent 0.5 inches from current indentation
        Get piParagraphIndent to iCurrentIndent
        Set piParagraphIndent to (iCurrentIndent + (iTwipsPerInch * 0.5))
        
        // indent 2nd and subsequent lines 0.5 inches from 1st line
        Set piOffsetIndent to (iCurrentIndent - (iTwipsPerInch * 0.5))
    End_Procedure
    
    // outdents selected paragraph(s) by 0.5 inches called from toolbar
    Procedure DoOutdent
        Integer iTwipsPerInch iCurrentIndent
        
        // number of twips per inch
        Move 1440 to iTwipsPerInch
        
        // outdent 0.5 inches from current indentation
        Get piParagraphIndent to iCurrentIndent
        Set piParagraphIndent to (iCurrentIndent - (iTwipsPerInch * 0.5))
    End_Procedure
    
    // sets numbering style of selected paragraph(s) to passed in style
    // called from toolbar
    Procedure DoNumbering Integer iStyle
        Set peBullets to iStyle
    End_Procedure
    
    // toggles numbering on or off for selected paragraph(s)
    // called from toolbar
    Procedure ToggleNumbering
        Integer iBullets
        
        // default numbering style to "number followed by period"
        Set peBulletStyle to busPeriod
        
        // default to 1 for numbering
        Set piBulletStart to 1
        
        Get peBullets to iBullets
        
        // if we currently have nothing or bullets, set style to Arabic numbers
        If ((iBullets = buNone) or (iBullets = buBullets)) ;
            Set peBullets to buArabicNumbers
        
        // otherwise, set style to nothing (no bullets or numbering)
        Else ;
            Set peBullets to buNone
    End_Procedure
    
    // toggles bullets on or off for selected paragraph(s)
    // called from toolbar
    Procedure ToggleBullets
        Integer iBullets
        
        Get peBullets to iBullets
        
        // if style is currently not bullets, set it to bullets
        If (iBullets <> buBullets) ;
            Set peBullets to buBullets
        
        // otherwise, set style to nothing (no bullets or numbering)
        Else ;
            Set peBullets to buNone
    End_Procedure
    
    // launches clicked link in default application as defined in Windows
    Procedure OnLinkClicked Integer iPositionStart Integer iPositionEnd
        Handle hInstance hWnd
        String sLinkText
        
        Get TextRange iPositionStart iPositionEnd to sLinkText
        
        If (sLinkText <> "") Begin
            Get Window_Handle to hWnd
            Move (ShellExecute (hWnd, "open", (Trim (sLinkText)), '', '', 1)) to hInstance
            If (hInstance <= 32) Begin
                Send Stop_Box ;
                    ("The attachment could not be opened.\nThe returned error is:" * String (hInstance)) "Open document/file failed"
            End
        End
    End_Procedure
    
    // open document
    // called from toolbar
    Procedure DoOpenDocument
        Boolean bOk bOkToOpen bOver
        Integer eResponse
        String sFileName sMsg
        
        
        Move False to bOkToOpen
        
        // there are changes
        If (not(pbCanUndo(Self))) Begin
            Move True to bOkToOpen
        End
        // if there are changes, ask user whether to abandon them or not
        Else Begin
            Move (YesNo_Box("Changes Exist. Abandon changes and open new document?", "Abandon Changes?", MB_DEFBUTTON2)) to eResponse
            If (eResponse = MBR_YES) Begin
                Move True to bOkToOpen
            End
            Else Begin
                Move False to bOkToOpen
            End
        End
        
        If (bOkToOpen = True) Begin
            Get Show_Dialog of oOpenDialog1 to bOk
            If (bOk = True) Begin
                // Enable save button
                Send AdjustSaveButton True
                
                Get File_Name of oOpenDialog1 to sFileName
                Send Read sFileName
                Set label of oCurFile to ("Current File:" * sFileName)
                
                Get pbTextExceededLimit to bOver
                If (bOver) Begin
                    Move "The document loaded exceeded the limit currently set for this control.\n\n" to sMsg
                    Move (sMsg * "You will be able to see only part of its content and saving will not be allowed.") to sMsg
                    Send stop_box sMsg "RichEdit"
                    Set pbAllowSaves to False
                End
                Else Begin
                    Set pbAllowSaves to True
                End
                
                // set psCurrentDocument to selected file name
                Set psCurrentDocument to sFileName
                
                // clear undo buffer
                // we want undo buffer to only apply to the new document
                Send ClearUndoBuffer
            End
        End
    End_Procedure
    
    // save current document, or ask user to create new RTF document
    // called from toolbar
    Procedure DoSaveDocument
        String sFileName
        Integer eResponse
        Boolean bOk bOkToSave
        
        Move False to bOkToSave
        
        // there are changes
        If (pbCanUndo(Self) = True) Begin
            // if current document, just save it
            If (psCurrentDocument(Self) <> "") Begin
                Move True to bOkToSave
            End
            
            // if no current document, pop up save dialog
            Else Begin
                Get Show_Dialog of oSaveAsDialog1 to bOk
                
                // if user saves file, set psCurrentDocument to new file name and save it
                If (bOk = True) Begin
                    Get File_Name of oSaveAsDialog1 to sFileName
                    Set psCurrentDocument to sFileName
                    Set label of oCurFile to ("Current File:" * sFileName)
                    Move True to bOkToSave
                End
                // user did not save new file
                Else Begin
                    Move False to bOkToSave
                End
            End  // else
        End  // if (pbCanUndo(Self) = True) begin
        
        // perform operations required for save
        If (bOkToSave = True) Begin
            If (psCurrentDocument(Self) <> "") Begin
                // write the file out
                Send Write (psCurrentDocument(Self))
            End
            
            // clear undo buffer on save
            // we want undo buffer to only apply to the new document
            Send ClearUndoBuffer
            
            // fire OnChange to update state of toolbar buttons
            Send OnChange
        End
    End_Procedure
    
    // clear control (to the user, this looks like we're starting a new document)
    // called from toolbar
    Procedure DoNewDocument
        Integer eResponse
        Boolean bOkToClear
        
        Move False to bOkToClear
        
        // there are changes
        If (not(pbCanUndo(Self))) Begin
            Move True to bOkToClear
        End
        // if there are changes, ask user whether to abandon them or not
        Else Begin
            Move (YesNo_Box("Changes Exist. Abandon changes and open new document?", "Abandon Changes?", MB_DEFBUTTON2)) to eResponse
            If (eResponse = MBR_YES) Begin
                Move True to bOkToClear
            End
            Else Begin
                Move False to bOkToClear
            End
        End
        
        If (bOkToClear = True) Begin
            // clear control
            Send Delete_Data
            
            // set psCurrentDocument to new document (which is "" until it is saved)
            Set psCurrentDocument to ""
            
            // clear undo buffer
            // we want undo buffer to only apply to the new document
            Send ClearUndoBuffer
            
            // fire OnChange to update state of toolbar buttons
            Send OnChange
            
            // Enable save button
            Send AdjustSaveButton True
            Set pbAllowSaves to True
            
            // Set file name
            Set label of oCurFile to "Current File: <new>"
            
        End
    End_Procedure
    
    // enable or disable undo and redo buttons on toolbar as user types
    Procedure OnChange
        Boolean bWithinLimit bResetSaveButton
        
        Move True to bWithinLimit
        Get pbAllowSaves to bResetSaveButton
        If (bResetSaveButton) Begin
            Get IsWithinLimit to bWithinLimit
        End
        
        If (pbCanUndo(Self) = True) Begin
            Set pbEnabled of (oUndo(piToolbar(Self))) to True
            If (bResetSaveButton and bWithinLimit) Begin
                Send AdjustSaveButton True
            End
        End
        Else ;
            Set pbEnabled of (oUndo(piToolbar(Self))) to False
        
        If (pbCanRedo(Self) = True) Begin
            Set pbEnabled of (oRedo(piToolbar(Self))) to True
            If (bResetSaveButton and bWithinLimit) Begin
                Send AdjustSaveButton True
            End
        End
        Else ;
            Set pbEnabled of (oRedo(piToolbar(Self))) to False
        
    End_Procedure
    
    // calls find dialog (RichEditFind.dg)
    // called from shortcut key
    Procedure DoFind
        Send DoSearch of oRichEditFind Self
    End_Procedure
    
    // gets called from find dialog (RichEditFind.dg)
    // with user's parameters for the search
    Procedure DoSearch String sSearchText Integer eSearchOptions
        Integer iStart iSelEnd
        
        Get FindText sSearchText eSearchOptions to iStart
        // was search successful?
        If (iStart <> -1) Begin
            // get length of search text
            Move (Length(sSearchText)+iStart) to iSelEnd
            // select search text found
            Send SetSel iStart iSelEnd
        End
        Else ;
            Send Info_Box ("Text '" + sSearchText + "' not found") "Find Text"
    End_Procedure
    
    // calls find & replace dialog (RichEditFindReplace.dg)
    // called from toolbar
    Procedure DoFindReplace
        Send DoReplace of oRichEditFindReplace Self
    End_Procedure
    
    
    // gets called from find & replace dialog (RichEditFindReplace.dg)
    // with user's parameters for the search and replace
    Procedure DoReplace String sSearchText String sReplaceText Boolean bAll
        Integer iReplacementCount
        
        // do not replace all
        If (not(bAll)) Begin
            Send ReplaceSel sReplaceText
        End
        // do replace all
        Else Begin
            Get ReplaceAll sSearchText sReplaceText to iReplacementCount
            // tell user how many replacements were made
            Send Info_Box (String(iReplacementCount) + " replacements made") "Replace All"
        End
    End_Procedure
    
    // Event fired when  we try to type more characters than the control can hold
    // OR we try to load a document that has piMaxChars characters or more
    // The default limit size (piMaxChars) is 64 KB (65536 bytes or characters)
    Procedure OnMaxText
        // Disable save button
        Send AdjustSaveButton False
    End_Procedure
    
    // Enables/disables the save button and set the label of the view accordingly
    Procedure AdjustSaveButton Boolean bWithinLimit
        
        If (not(bWithinLimit)) Begin
            // Disable the Save button on the toolbar
            Set pbEnabled of (oSave(piToolbar(Self))) to False
            Set label of oRichEditControl to "RichEdit Test View - Limit number of characters exceeded. Save button disabled."
            Set pbTextExceededLimit to True
        End
        Else Begin
            // Enable the Save button on the toolbar
            Set pbEnabled of (oSave(piToolbar(Self))) to True
            Set label of oRichEditControl to "RichEdit Test View"
            Set pbTextExceededLimit to False
        End
        
    End_Procedure
    
    Function IsWithinLimit Returns Boolean
        Integer iLimit iCharCnt
        String sTxt
        Boolean bOK
        
        Get piMaxChars to iLimit
        Get TextRange 0 iLimit to sTxt
        Move (Length(sTxt)) to iCharCnt
        
        If ( iCharCnt <= iLimit ) Begin
            Move True to bOK
        End
        Else Begin
            Move False to bOK
        End
        
        Function_Return bOK
    End_Function
    
End_Object

Object oOpenDialog1 is a OpenDialog
    Set Dialog_Caption to "Select a file"
    Set Filter_String to "RTF Documents (*.rtf)|*.rtf|All Files (*.*)|*.*"
End_Object

Object oSaveAsDialog1 is a SaveAsDialog
    Set FileMustExist_State to False
    Set Filter_String to "RTF Documents (*.rtf)|*.rtf"
End_Object

Object oCurFile is a Textbox
    Set Label to "Current File:"
    Set TextColor to clBlue
    Set Location to 20 4
    Set Size to 10 39
    Set FontWeight to FW_Bold
End_Object

Object oLineControl1 is a LineControl
    Set Size to 2 455
    Set Location to 15 3
End_Object

End_Object

