Use Windows.pkg
Use DFClient.pkg
Use cTextEdit.pkg
Use cLinkLabel.pkg
Use cRichEdit.pkg
Use File_dlg.pkg

Use Collate\DisabledContextMenu.pkg
Use Collate\ICUFunctions.pkg

Include_Text Collate\DemoInfo.txt as C_TXTDemoInfo
Define C_CollateTxtFiles for "\Collate\Collation Files"

Register_Function GetICUAttributeType Handle hoSettingGroup Returns String

Activate_View Activate_oDemoCollate for oDemoCollate
Object oDemoCollate is a dbView
    
    Set Border_Style to Border_Thick
    Set Size to 257 549
    Set Location to 2 -2
    Set Label to "DemoCollate"
    Set piMinSize to 257 549
    Set pbAutoActivate to True
    
    Object oNormalizationGrp is a RadioGroup
        Set Location to 2 5
        Set Size to 24 97
        Set Label to 'Normalization'
    
        Object oRadio1 is a Radio
            Set Label to "Default"
            Set Size to 10 38
            Set Location to 10 5
        End_Object
    
        Object oRadio2 is a Radio
            Set Label to "Off"
            Set Size to 10 26
            Set Location to 10 43
        End_Object
    
        Object oRadio3 is a Radio
            Set Label to "On"
            Set Size to 10 25
            Set Location to 10 69
        End_Object
        
    
        Procedure Notify_Select_State Integer iToItem Integer iFromItem
            String sVal 
            
            Forward Send Notify_Select_State iToItem iFromItem
            
            Case Begin
                Case (iToItem = 1)
                    Move "no" to sVal
                    Case Break
                Case (iToItem = 2)
                    Move "yes" to sVal
                    Case Break
                Case Else
                    Move "" to sVal
            Case End
            
            Send DoSetAttribute (GetICUAttributeType(Self, Self)) sVal
        End_Procedure

    End_Object
    

    Object oNumericGrp is a RadioGroup
        Set Location to 2 106
        Set Size to 24 97
        Set Label to 'Numeric'
    
        Object oRadio1 is a Radio
            Set Label to "Default"
            Set Size to 10 36
            Set Location to 11 5
        End_Object
    
        Object oRadio2 is a Radio
            Set Label to "Off"
            Set Size to 10 23
            Set Location to 11 44
        End_Object
    
        Object oRadio3 is a Radio
            Set Label to "On"
            Set Size to 10 24
            Set Location to 11 70
        End_Object
    
        Procedure Notify_Select_State Integer iToItem Integer iFromItem
            String sVal
            
            Forward Send Notify_Select_State iToItem iFromItem
            
            Case Begin
                Case (iToItem = 1)
                    Move "no" to sVal
                    Case Break
                Case (iToItem = 2)
                    Move "yes" to sVal
                    Case Break
                Case Else
                    Move "" to sVal
            Case End
            
            Send DoSetAttribute (GetICUAttributeType(Self, Self)) sVal
        End_Procedure
           
    End_Object
    

    Object oStrengthGrp is a RadioGroup
        Set Location to 27 5
        Set Size to 38 147
        Set Label to 'Strength'
    
        Object oRadio1 is a Radio
            Set Label to "Default"
            Set Size to 10 40
            Set Location to 10 5
        End_Object
    
        Object oRadio2 is a Radio
            Set Label to "Primary"
            Set Size to 10 35
            Set Location to 10 97
        End_Object
    
        Object oRadio3 is a Radio
            Set Label to "Secondary"
            Set Size to 10 50
            Set Location to 24 5
        End_Object
        
        Object oRadio4 is a Radio
            Set Label to "Tertiary"
            Set Size to 10 37
            Set Location to 24 52
        End_Object
        Object oRadio5 is a Radio
            Set Label to "Quaternary"
            Set Size to 10 47
            Set Location to 24 97
        End_Object
        Object oRadio6 is a Radio
            Set Label to "Identical"
            Set Size to 10 40
            Set Location to 10 52
        End_Object
    
        Procedure Notify_Select_State Integer iToItem Integer iFromItem
            String sVal
            
            Forward Send Notify_Select_State iToItem iFromItem
            
            Case Begin
                Case (iToItem = 1)
                    Move "primary" to sVal
                    Case Break
                Case (iToItem = 2)
                    Move "secondary" to sVal
                    Case Break
                Case (iToItem = 3)
                    Move "tertiary" to sVal
                    Case Break
                Case (iToItem = 4)
                    Move "quaternary" to sVal
                    Case Break
                Case (iToItem = 5)
                    Move "identical" to sVal
                    Case Break
                Case Else
                    Move "" to sVal
            Case End
            
            Send DoSetAttribute (GetICUAttributeType(Self, Self)) sVal
        End_Procedure
  
    End_Object
    

    Object oBackwardsSecondaryGrp is a RadioGroup
        Set Location to 27 156
        Set Size to 31 111
        Set Label to 'Backwards secondary'
    
        Object oRadio1 is a Radio
            Set Label to "Default"
            Set Size to 10 37
            Set Location to 11 5
        End_Object
    
        Object oRadio2 is a Radio
            Set Label to "Off"
            Set Size to 10 25
            Set Location to 11 49
        End_Object
    
        Object oRadio3 is a Radio
            Set Label to "On"
            Set Size to 9 23
            Set Location to 11 80
        End_Object
    
        Procedure Notify_Select_State Integer iToItem Integer iFromItem
            String sVal
            
            Forward Send Notify_Select_State iToItem iFromItem
            
            Case Begin
                Case (iToItem = 1)
                    Move "no" to sVal
                    Case Break
                Case (iToItem = 2)
                    Move "yes" to sVal
                    Case Break
                Case Else
                    Move "" to sVal
            Case End
            
            Send DoSetAttribute (GetICUAttributeType(Self, Self)) sVal
        End_Procedure
           
    End_Object


    Object oCaseLevelGrp is a RadioGroup
        Set Location to 103 156
        Set Size to 25 111
        Set Label to 'Case level'
    
        Object oRadio1 is a Radio
            Set Label to "Default"
            Set Size to 10 35
            Set Location to 10 5
        End_Object
    
        Object oRadio2 is a Radio
            Set Label to "Off"
            Set Size to 10 25
            Set Location to 10 50
        End_Object
    
        Object oRadio3 is a Radio
            Set Label to "On"
            Set Size to 10 23
            Set Location to 10 81
        End_Object
    
        Procedure Notify_Select_State Integer iToItem Integer iFromItem
            String sVal
            
            Forward Send Notify_Select_State iToItem iFromItem
            
            Case Begin
                Case (iToItem = 1)
                    Move "no" to sVal
                    Case Break
                Case (iToItem = 2)
                    Move "yes" to sVal
                    Case Break
                Case Else
                    Move "" to sVal
            Case End
            
            Send DoSetAttribute (GetICUAttributeType(Self, Self)) sVal
        End_Procedure
           
    End_Object
    

    Object oCaseFirstGrp is a RadioGroup
        Set Location to 64 156
        Set Size to 36 111
        Set Label to 'Case first'
    
        Object oRadio1 is a Radio
            Set Label to "Default"
            Set Size to 10 37
            Set Location to 10 5
        End_Object
    
        Object oRadio2 is a Radio
            Set Label to "Off"
            Set Size to 9 25
            Set Location to 10 48
        End_Object
    
        Object oRadio3 is a Radio
            Set Label to "Lower"
            Set Size to 10 31
            Set Location to 22 5
        End_Object

        Object oRadio4 is a Radio
            Set Label to "Upper"
            Set Size to 10 31
            Set Location to 22 48
        End_Object    

        Procedure Notify_Select_State Integer iToItem Integer iFromItem
            String sVal
            
            Forward Send Notify_Select_State iToItem iFromItem
            
            Case Begin
                Case (iToItem = 1)
                    Move "no" to sVal
                    Case Break
                Case (iToItem = 2)
                    Move "lower" to sVal
                    Case Break
                Case (iToItem = 3)
                    Move "upper" to sVal
                    Case Break
                Case Else
                    Move "" to sVal
            Case End
            
            Send DoSetAttribute (GetICUAttributeType(Self, Self)) sVal
        End_Procedure
            
    End_Object
    

    Object oAlternateGrp is a RadioGroup
        Set Location to 103 5
        Set Size to 25 148
        Set Label to "Alternate"
    
        Object oRadio1 is a Radio
            Set Label to "Default"
            Set Size to 10 35
            Set Location to 10 4
        End_Object
    
        Object oRadio2 is a Radio
            Set Label to "Non-ignorable"
            Set Size to 10 58
            Set Location to 10 44
        End_Object
    
        Object oRadio3 is a Radio
            Set Label to "Shifted"
            Set Size to 10 35
            Set Location to 10 109
        End_Object
    
        Procedure Notify_Select_State Integer iToItem Integer iFromItem
            String sVal
            
            Forward Send Notify_Select_State iToItem iFromItem
            
            Case Begin
                Case (iToItem = 1)
                    Move "non-ignorable" to sVal
                    Case Break
                Case (iToItem = 2)
                    Move "shifted" to sVal
                    Case Break
                Case Else
                    Move "" to sVal
            Case End
            
            Send DoSetAttribute (GetICUAttributeType(Self, Self)) sVal
        End_Procedure
            
    End_Object


    Object oMaxVariableGrp is a RadioGroup
        Set Location to 66 5
        Set Size to 35 137
        Set Label to "Max variable"
    
        Object oRadio1 is a Radio
            Set Label to "Default"
            Set Size to 9 36
            Set Location to 10 5
        End_Object
    
        Object oRadio2 is a Radio
            Set Label to "Space"
            Set Size to 10 32
            Set Location to 10 52
        End_Object
    
        Object oRadio3 is a Radio
            Set Label to "Punct"
            Set Size to 10 32
            Set Location to 10 97
        End_Object
        
        Object oRadio5 is a Radio
            Set Label to "Currency"
            Set Size to 10 40
            Set Location to 22 52
        End_Object
        Object oRadio6 is a Radio
            Set Label to "Symbol"
            Set Size to 10 36
            Set Location to 22 5
        End_Object
    
        Procedure Notify_Select_State Integer iToItem Integer iFromItem
            String sVal
            
            Forward Send Notify_Select_State iToItem iFromItem
            
            Case Begin
                Case (iToItem = 1)
                    Move "space" to sVal
                    Case Break
                Case (iToItem = 2)
                    Move "punct" to sVal
                    Case Break
                Case (iToItem = 3)
                    Move "currency" to sVal
                    Case Break
                Case (iToItem = 4)
                    Move "symbol" to sVal
                    Case Break
                Case Else
                    Move "" to sVal
            Case End
            
            Send DoSetAttribute (GetICUAttributeType(Self, Self)) sVal
        End_Procedure
           
    End_Object
    

    Object oResetDefaultValuesBtn is a Button
        Set Size to 20 56
        Set Location to 6 210
        Set Label to 'Reset to Default Options'
        Set MultiLineState to True
        
        Procedure ResetRadiosAndLocaleAttributes
            Send SelectDefaultSetting oNormalizationGrp
            Send SelectDefaultSetting oNumericGrp
            Send SelectDefaultSetting oStrengthGrp
            Send SelectDefaultSetting oBackwardsSecondaryGrp
            Send SelectDefaultSetting oCaseLevelGrp
            Send SelectDefaultSetting oCaseFirstGrp
            Send SelectDefaultSetting oAlternateGrp
            Send SelectDefaultSetting oMaxVariableGrp           
        End_Procedure
    
        Procedure OnClick
            Send ResetRadiosAndLocaleAttributes
        End_Procedure
    
    End_Object
    

    Object oLocaleCode is a ComboForm
        Set Size to 12 213
        Set Location to 8 330
        Set Label to "Locale code:"
        Set Label_Col_Offset to 50
        Set peAnchors to anTopLeftRight
        Set Floating_Menu_Object to oDisabledContextMenu   // only options available: Copy and Select All

        // Intercep any typing into the combo so locale code can only be changed through combo and radio selections
        Procedure key Integer iKeyValue Returns Integer
            // Allow Ctrl+C (2147) and Ctrl+A (2145) to be processed
            If ((iKeyValue = 2147) or (iKeyValue = 2145)) Begin
             Forward Send Key iKeyValue
            End
        End_Procedure
        
        Procedure Combo_Fill_List
            String[] AllLocalesAvailable
            Integer iNumLocalesAvailable iLoc
            
            // get list of available locale codes
            Get ListOfLocaleCodesForDefaultLgg to AllLocalesAvailable
            Move (SizeOfArray(AllLocalesAvailable)) to iNumLocalesAvailable
            
            // if function did not retrieve list, we fallback on adding default collate to the combo
            If (iNumLocalesAvailable = 0) Begin
                Get_Attribute DF_LOCALE_CODE to AllLocalesAvailable[-1]
                Increment iNumLocalesAvailable
            End
            
            For iLoc from 0 to (iNumLocalesAvailable - 1)
                Send Combo_Add_Item AllLocalesAvailable[iLoc]
            Loop
        End_Procedure
        
        Procedure Combo_Item_Changed
            Send ResetRadiosAndLocaleAttributes of oResetDefaultValuesBtn
        End_Procedure
      
    End_Object

    Object oLoadUnsortedList is a Form
        Set Size to 14 167
        Set Location to 24 375
        Set Label to 'Load unsorted list from file:'
        Set Prompt_Button_Mode to PB_PromptOn
        Set Label_Col_Offset to 95
        Set psToolTip to "Enter the text filename. File must have one character/word per line, with a CRLF marking the end of the line"
        Set peAnchors to anTopLeftRight
    
        Object oOpenFile is an OpenDialog
            Set Dialog_Caption to "Select File to Load Characters from"
            Set Filter_String to 'TXT|*.txt|All Files|*.*'
            Set Initial_Folder to (psAppSrcPath(phoWorkspace(ghoApplication)) - C_CollateTxtFiles)
            Set FileMustExist_State to False
            Set ShowFileTitle_State to True
        End_Object
        
        Procedure Prompt
            Boolean bOpen
            Integer hDialog iNumLinesLoaded
            String sFileName
            
            Move oOpenFile to hDialog
            Get Show_Dialog of hDialog to bOpen
            If bOpen Begin
                Get File_Name of hDialog to sFileName
                Set Value to sFileName
            End
            
            Get LoadListToSort sFileName to iNumLinesLoaded
        End_Procedure
    
    End_Object

    Object oSortData is a cTextEdit
        Set Size to 206 94
        Set Location to 48 280
        Set peAnchors to anTopBottomLeft
        Set Label to "Unsorted List"
        Set Label_Row_Offset to 0
        
        Procedure AddLine String sVal
            Send AppendText sVal
            Send AppendText (Character(10))
        End_Procedure

        Procedure Page Integer iPageObject
            Forward Send Page iPageObject
        
            Send AddLine "ｶ"
            Send AddLine "ヵ"
            Send AddLine "abc"
            Send AddLine "ab\uFFFEc"
            Send AddLine "ab©"
            Send AddLine "𝒶bc"
            Send AddLine "𝕒bc"
            Send AddLine "ガ"
            Send AddLine "が"
            Send AddLine "abç"
            Send AddLine "äbc"
            Send AddLine "カ"
            Send AddLine "か"
            Send AddLine "Abc"
            Send AddLine "abC"
            Send AddLine "File-3"
            Send AddLine "file-12"
            Send AddLine "filé-110"
            Send AddLine "filé-12"
            Send AddLine "file-110"
            Send AddLine " "             
            Send AddLine "!"
            Send AddLine "0"
            Send AddLine "?"
            Send AddLine '"'
            Send AddLine "'"
            Send AddLine "-"
            Send AddLine "/"
            Send AppendText "\"
        End_Procedure
        
    End_Object

    Object oSortBtn is a Button
        Set Size to 14 59
        Set Location to 76 381
        Set Label to "Sort"
    
        Procedure OnClick
            Send DoSort
        End_Procedure
    
    End_Object

    Object oClearSortedBtn is a Button
        Set Size to 14 59
        Set Location to 96 381
        Set Label to 'Clear Sorted List'
    
        Procedure OnClick
            Send Delete_Data of oOutput
        End_Procedure
    
    End_Object

    Object oOutput is a cTextEdit
        Set Size to 206 94
        Set Location to 48 448
        Set peAnchors to anTopBottomLeft
        Set Label to "Sorted List"
        Set Label_Row_Offset to 0
    End_Object

    Function LoadListToSort String sListToLoad Returns Boolean
        Boolean bFileLoadedOK
        String sLine 
        Integer iChnIn iNumLines 
        
        Move 0 to iNumLines
        
        If (sListToLoad<>"") Begin
            Move (Seq_New_Channel()) to iChnIn

            If (iChnIn=DF_SEQ_CHANNEL_NOT_AVAILABLE) Begin
                Send UserError "No Channel Available to process the file" "Error"
                Procedure_Return
            End
            
            // clear edit control
            Send Delete_Data of oSortData
            
            // populate edit control
            Direct_Input channel iChnIn sListToLoad
            While (not(SeqEof))
                  Readln channel iChnIn sLine
                  
                  If (sLine <> " ") Begin
                     Send AddLine of oSortData sLine
                  End
                  Else Begin
                     Send AppendText of oSortData sLine
                  End
                  
                  Increment iNumLines
            Loop
            Close_Input channel iChnIn

            Send Seq_Release_Channel iChnIn
        End
        
        Function_Return iNumLines
    End_Function

    Procedure DoSetAttribute String sAttribute String sVal
        String sLocaleCode sAttributes sNewAttr
        String[] aAttributes aAttribute
        Integer iPosAt iAttribute
        Boolean bFound
        
        Get Value of oLocaleCode to sLocaleCode
        Move (Pos("@", sLocaleCode)) to iPosAt
        
        If (iPosAt > 0) Begin
            Move (Mid(sLocaleCode, Length(sLocaleCode) - iPosAt, iPosAt + 1)) to sAttributes
            Move (StrSplitToArray(sAttributes, ";")) to aAttributes
            Move False to bFound
            
            For iAttribute from 0 to (SizeOfArray(aAttributes) - 1)
                Move (StrSplitToArray(aAttributes[iAttribute], "=")) to aAttribute
                If (SizeOfArray(aAttribute) > 0 and aAttribute[0] = sAttribute) Begin
                    If (sVal = "") Begin
                        Move (RemoveFromArray(aAttributes, iAttribute)) to aAttributes
                        Decrement iAttribute
                    End
                    Else Begin
                        Move (sAttribute + "=" + sVal) to aAttributes[iAttribute]
                    End
                    Move True to bFound
                End
            Loop
            
            If (not(bFound) and sVal <> "") ;
                Move (sAttribute + "=" + sVal) to aAttributes[SizeOfArray(aAttributes)]
                
            If (SizeOfArray(aAttributes) > 0) Begin
                Move (Left(sLocaleCode, iPosAt - 1) + "@" + StrJoinFromArray(aAttributes, ";")) to sLocaleCode
            End
            Else Begin
                Move (Left(sLocaleCode, iPosAt - 1)) to sLocaleCode
            End
        End
        Else If (sVal <> "") Begin
            Move (sLocaleCode + "@" + sAttribute + "=" + sVal) to sLocaleCode
        End
        
        Set Value of oLocaleCode to sLocaleCode
    End_Procedure

    Procedure DoSort
        String sValues sResult sLocale sOrigLocale
        String[] aValues aSorted
        Integer iVal
        
        Get Value of oLocaleCode to sLocale
        Get Value of oSortData to sValues
        Move (StrSplitToArray(sValues, (Character(13) + Character(10)))) to aValues
        For iVal from 0 to (SizeOfArray(aValues) - 1)
            If (aValues[iVal] <> " ") Begin   
                Move (Trim(aValues[iVal])) to aValues[iVal]
            
                If (aValues[iVal] = "") Begin
                    Move (RemoveFromArray(aValues, iVal)) to aValues
                    Decrement iVal
                End
            End
        Loop
        
        
        Get_Attribute DF_LOCALE_CODE to sOrigLocale
        Set_Attribute DF_LOCALE_CODE to sLocale
        
        Move (SortArray(aValues)) to aSorted
        
        Set Value of oOutput to (StrJoinFromArray(aSorted, Character(10)))
        
        Set_Attribute DF_LOCALE_CODE to sOrigLocale
    End_Procedure

    Procedure Activating
        Forward Send Activating
        
        String sLocale
        String sStartFolder
        
        Get_Attribute DF_LOCALE_CODE to sLocale
        Set Value of oLocaleCode to sLocale 
        
    End_Procedure
    
    
    Function GetICUAttributeType Handle hoSettingGroup Returns String
        String sAttributeType
                 
        Case Begin
            Case (hoSettingGroup = (Object_Id(oNormalizationGrp)))
                Move "colNormalization" to sAttributeType
                Case Break

            Case (hoSettingGroup = (Object_Id(oNumericGrp)))
                Move "colNumeric" to sAttributeType
                Case Break

            Case (hoSettingGroup = (Object_Id(oStrengthGrp)))
                Move "colStrength" to sAttributeType
                Case Break

            Case (hoSettingGroup = (Object_Id(oBackwardsSecondaryGrp)))
                Move "colBackwards" to sAttributeType
                Case Break
 
             Case (hoSettingGroup = (Object_Id(oCaseLevelGrp)))
                Move "colCaseLevel" to sAttributeType
                Case Break

            Case (hoSettingGroup = (Object_Id(oCaseFirstGrp)))
                Move "colCaseFirst" to sAttributeType
                Case Break
                            
            Case (hoSettingGroup = (Object_Id(oAlternateGrp)))
                Move "colAlternate" to sAttributeType
                Case Break

            Case (hoSettingGroup = (Object_Id(oMaxVariableGrp)))
                Move "maxVariable" to sAttributeType
                Case Break
                            
        Case End
        
        Function_Return sAttributeType
    End_Function   
    
    Procedure SelectDefaultSetting Handle hoRadioGrp
        String sAttrType
        
        Set Current_Radio of hoRadioGrp to 0
        
        Get GetICUAttributeType hoRadioGrp to sAttrType
        Send DoSetAttribute of hoRadioGrp sAttrType ""         
    End_Procedure

    Object oDemoCredit is a TextBox
        Set Size to 9 84
        Set Location to 128 5
        Set Label to 'This demo is based on the'
    End_Object

    Object oICUDemoLink is a cLinkLabel
        Set Size to 8 68
        Set Location to 128 90
        Set Label to '<A HREF="https://icu4c-demos.unicode.org/icu-bin/collation.html">ICU Collation Demo</A>'
    End_Object
    
    Object oAttributesInfo is a TextBox
        Set Size to 9 47
        Set Location to 128 157
        Set Label to 'and uses these'
    End_Object

    Object oICUAttributesLink is a cLinkLabel
        Set Size to 8 51
        Set Location to 128 205
        Set Label to '<A HREF="https://unicode-org.github.io/icu/userguide/collation/architecture.html#attribute-types">Attribute Types</A>'
    End_Object    
    

    Object oDemoInfo is a cRichEdit
        Set Size to 88 266
        Set Location to 148 4
        Set piMinSize to 1 68
        Set Border_Style to Border_None
        Set Color to clMenu
        Set Read_Only_State to True
        
        // hide vertical scrollbar
        Set window_style to ws_vscroll False
        
        Set Value to C_TXTDemoInfo
        Set Label to "About this Demo"
        Set Label_FontWeight to fw_Bold
    End_Object


    Object oMoreInfoLink is a cLinkLabel
        Set Size to 8 144
        Set Location to 243 112
        Set Label to '<A HREF="https://docs.dataaccess.com/dataflexhelp/#t=mergedProjects%2FDevelopmentGuide%2FUnicode_and_Collation.htm">Read more about the new collating system...</A>'
    End_Object
    

End_Object
