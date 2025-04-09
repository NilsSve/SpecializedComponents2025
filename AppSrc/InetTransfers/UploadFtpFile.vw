Use InetTransfers\SelectFilename.dg
Use DFClient.pkg
Use Windows.pkg
Use DFLine.Pkg
Use InetTransfer.pkg
Use File_Dlg.pkg

ACTIVATE_VIEW Activate_oUpload_vw FOR oUpload_vw

Object oUpload_vw is a dbView
    Set Label to "Upload a File to an FTP Server"
    Set Location to 6 120
    Set Size to 200 282
    Set pbAutoActivate to True
    
    Object oLocal_tb is a Textbox
        Set Label to "Local Machine"
        Set TextColor to clNavy
        Set Location to 9 17
        Set Size to 9 51
        Set FontWeight to FW_Bold
    End_Object
    
    Object oFileSource_fm is a Form
        Set Label to "Source File:"
        Set Size to 13 199
        Set Location to 23 75
        Set Label_Col_Offset to 2
        Set Label_Justification_Mode to jMode_Right
        Set Prompt_Button_Mode to pb_PromptOn
        
        Procedure Prompt
            Boolean bFileSelected
            String sFilename
            
            Get Show_Dialog of oOpenDialog To bFileSelected
            If bFileSelected Begin
                Get File_Name of oOpenDialog To sFilename
                Set Value To sFilename
            End
        End_Procedure
        
    End_Object
    
    Object oRemoteMachine_tb is a Textbox
        Set Label to "Remote Machine"
        Set TextColor to clNavy
        Set Location to 46 16
        Set Size to 9 59
        Set FontWeight to FW_Bold
    End_Object
    
    Object oHost_fm is a Form
        Set Label to "Host:"
        Set Size to 13 153
        Set Location to 61 75
        Set Label_Col_Offset to 2
        Set Label_Justification_Mode to jMode_Right
    End_Object
    
    Object oPort_fm is a Form
        Set Label to "Port:"
        Set Size to 13 24
        Set Location to 61 249
        Set Label_Col_Offset to 2
        Set Label_Justification_Mode to jMode_Right
    End_Object
    
    Object oUser_fm is a Form
        Set Label to "User Id:"
        Set Size to 13 65
        Set Location to 76 75
        Set Label_Col_Offset to 2
        Set Label_Justification_Mode to jMode_Right
    End_Object
    
    Object oPassword_fm is a Form
        Set Password_State 0 To True
        Set Label to "Password:"
        Set Size to 13 88
        Set Location to 76 185
        Set Label_Col_Offset to 2
        Set Label_Justification_Mode to jMode_Right
    End_Object
    
    Object oProxy_fm is a Form
        Set Label to "Proxy:"
        Set Size to 13 199
        Set Location to 90 75
        Set Label_Col_Offset to 2
        Set Label_Justification_Mode to jMode_Right
    End_Object
    
    Object oDirectory_fm is a Form
        Set Label to "Directory:"
        Set Size to 13 199
        Set Location to 105 75
        Set Label_Col_Offset to 2
        Set Label_Justification_Mode to jMode_Right
    End_Object
    
    Object oFileDestination_fm is a Form
        Set Label to "DestinationFile:"
        Set Size to 13 199
        Set Location to 119 75
        Set Label_Col_Offset to 2
        Set Label_Justification_Mode to jMode_Right
        Set Prompt_Button_Mode to pb_PromptOn
        
        Procedure Prompt
            Boolean bFileSelected
            String sHost sDirectory
            
            Get Value of oHost_fm To sHost
            If (sHost="") Begin
                Send Stop_Box "You need to provide the Remote Host to connect to" "Missing Information"
                Procedure_return
            End
            
            Send DoSetDefaults // load oFtpTransfer with the defauts from the controls
            
            Get Value of oDirectory_fm To sDirectory
            Get GetSelect of oSelectFilename_dg False (oFtpTransfer(self)) sDirectory To bFileSelected
            If (bFileSelected) Begin
                Get psDirectory of oSelectFilename_dg To sDirectory
                Set Value of oDirectory_fm To sDirectory
            End
        End_Procedure
        
    End_Object
    
    Object oTransferType_cb is a ComboForm
        Set Label to "TransferType:"
        Set Size to 13 78
        Set Location to 134 75
        Set Form_Border to 0
        Set Label_Col_Offset to 2
        Set Label_Justification_Mode to jMode_Right
        Set Entry_State 0 to False
        
        Procedure Combo_Fill_List
            Send Combo_Add_Item "Ascill"
            Send Combo_Add_Item "Binary"
        End_Procedure
        
    End_Object
    
    Object oBufferSize_fm is a Form
        Set Label to "Buffer Size:"
        Set Size to 13 67
        Set Location to 134 206
        Set Label_Col_Offset to 2
        Set Label_Justification_Mode to jMode_Right
    End_Object
    
    Object oLine is a LineControl
        Set Size to 2 267
        Set Location to 175 11
    End_Object
    
    Object oPassiveModeCheckBox is a CheckBox
        Set Size to 10 50
        Set Location to 153 75
        Set Label to "Connect Using Passive Mode"
        
        //Fires whenever the value of the control is changed
        //Procedure OnChange
        //    Boolean bChecked
        //
        //    Get Checked_State To bChecked
        //End_Procedure
        
    End_Object
    
    Object oUpload_bn is a Button
        Set Label to "Upload File"
        Set Size to 14 57
        Set Location to 182 220
        Set Default_State to TRUE
        
        Procedure OnClick
            Integer iRetVal
            Boolean bFileExists
            String sHost sPort sDirectory sFileSource sBufferSize sFileDestination
            
            Get Value of oHost_fm            To sHost
            Get Value of oPort_fm            To sPort
            Get Value of oBufferSize_fm      To sBufferSize
            Get Value of oDirectory_fm       To sDirectory
            Get Value of oFileSource_fm      To sFileSource
            Get Value of oFileDestination_fm To sFileDestination
            
            If (sHost="") Begin
                Send Stop_Box "You need to supply the Remote Host" "Missing Information"
                Send Activate of oHost_fm
                Procedure_Return
            End
            
            If (sFileSource="") Begin
                Send Stop_Box "You need to supply the local filename to copy from" "Missing Information"
                Send Activate of oFileSource_fm
                Procedure_Return
            End
            
            If (sBufferSize="") Begin
                Send Stop_Box "You need to supply the number of bytes in each Packet" "Missing Information"
                Send Activate of oBufferSize_fm
                Procedure_Return
            End
            
            If (sFileDestination="") Begin
                Send Stop_Box "You need to supply the filename on the Remote Host to copy to" "Missing Information"
                Send Activate of oFileDestination_fm
                Procedure_Return
            End
            
            File_Exist sFileSource bFileExists
            If (bFileExists=False) Begin
                Send Stop_Box "Cannot find the local file that you want to copy." "Invalid Local Filename"
                Send Activate of oFileSource_fm
                Procedure_Return
            End
            
            Send DoSetDefaults // load oFtpTransfer with the defauts from the controls
            
            Send DoUploadFile of oFtpTransfer sDirectory sFileSource sFileDestination
        End_Procedure
        
    End_Object
    
    Object oFtpTransfer is a cFtpTransfer
        
        Set piBufferSize to 8192
        Set psRemoteHost to "ftp.dataaccess.com"
        
        Procedure OnTransferStatus Integer iBytesTransferred Integer iFileSize
            Integer bCancel iRetVal
            
            Set Message_Text of ghoSentinel To (String(iBytesTransferred) +' of ' +String(iFileSize) + '')
            Send Update_StatusPanel of ghoSentinel (Integer(iBytesTransferred/iFileSize*100.0))
            Get Check_StatusPanel of ghoSentinel to bCancel     // check for user interrupt
            If (bCancel) Begin
                Get YesNo_Box "Are you sure you want to Abort the File Transfer?" "Abort File Transfer" To iRetVal
                If (iRetVal = MBR_YES) ;
                    Send CancelTransfer
                Else ;
                    Send Start_StatusPanel to ghoSentinel
            End
        End_Procedure
        
        Procedure DoUploadFile String sDirectory String sFileSource String sFileDestination
            Integer bDeleted bFileExists
            Boolean bOk
            
            Get Connect to bOk
            if bOk Begin
                Get ChangeDirectory sDirectory to bOk
                If (bOk) Begin
                    // Delete file on server, if it already exists
                    Get FtpFileExist sFileDestination To bFileExists
                    If bFileExists Begin
                        Get DeleteFtpFile sFileDestination To bDeleted // delete file if it already exists on server
                        If (bDeleted = False) Begin
                            Send Stop_Box "A file already exists on the server with this name.\n\nAn attempt to delete it has failed, so the copy cannot proceed" "Cannot Upload File"
                            Procedure_Return
                        End
                    End
                    Send Initialize_StatusPanel to ghoSentinel 'Upload File To FTP Server' ('Copying: ' +sDirectory +"/" +sFileSource) ("To: " +sFileDestination)
                    Send Start_StatusPanel      to ghoSentinel
                    Get UploadFile sFileSource sFileDestination to bOk
                    Send Stop_StatusPanel to ghoSentinel
                    If (bOk) ;
                        Send Info_Box ("File " +sFileSource +" copied successfully") "FTP File Uploaded"
                    Else ;
                        Send Stop_Box "Failed to upload file"
                End
                Else ;
                    Send Stop_Box ("Unable To Change To The '" +sDirectory +"' Directory") "FTP Failure"
                Get Disconnect to bOk
            End
            Else ;
                Send Stop_Box ("Connect to '" +psRemoteHost(self) +"' failed") "FTP Failure"
        End_Procedure
        
    End_Object
    
    Object oOpenDialog is a OpenDialog
        //AB/ Set Location to 158 35
        Set CreatePrompt_State to FALSE
        Set Dialog_Caption to "Copy file to FTP server..."
        Set HideReadOnly_State to TRUE
    End_Object
    
    // Updates the controls with the values of the oFtpTransfer object
    Procedure DoGetDefaults
        String sValue
        
        Get psRemoteHost of oFtpTransfer To sValue
        Set Value of oHost_fm To sValue
        
        Get piRemotePort of oFtpTransfer To sValue
        Set Value of oPort_fm To sValue
        
        Get psUsername of oFtpTransfer To sValue
        Set Value of oUser_fm To sValue
        
        Get psPassword of oFtpTransfer To sValue
        Set Value of oPassword_fm To sValue
        
        Get psProxy of oFtpTransfer To sValue
        Set Value of oProxy_fm To sValue
        
        Get peTransferType of oFtpTransfer To sValue
        If (sValue = ttAscii) ;
            Set Value of oTransferType_cb to "Ascii"
        Else ;
            Set Value of oTransferType_cb to "Binary"
        
        Get piBufferSize of oFtpTransfer To sValue
        Set Value of oBufferSize_fm To sValue
    End_Procedure
    
    // Updates oFtpTransfer with the values in the controls
    Procedure DoSetDefaults
        String sValue
        Boolean bPassiveMode
        
        Get Value of oHost_fm To sValue
        Set psRemoteHost of oFtpTransfer To sValue
        
        Get Value of oPort_fm To sValue
        Set piRemotePort of oFtpTransfer To sValue
        
        Get Value of oUser_fm To sValue
        Set psUsername of oFtpTransfer To sValue
        
        Get Value of oPassword_fm To sValue
        Set psPassword of oFtpTransfer To sValue
        
        Get Value of oProxy_fm To sValue
        Set psProxy of oFtpTransfer To sValue
        
        Get Value of oTransferType_cb To sValue
        If (sValue = "Ascii") ;
            Set peTransferType of oFtpTransfer to ttAscii
        Else ;
            Set peTransferType of oFtpTransfer to ttBinary
        
        Get Checked_State of oPassiveModeCheckBox to bPassiveMode
        Set pbPassiveMode of oFtpTransfer to bPassiveMode
        
        Get Value of oBufferSize_fm To sValue
        Set piBufferSize of oFtpTransfer To sValue
    End_Procedure
    
    Procedure Activating
        Forward Send Activating
        Send DoGetDefaults // put the FTP defaults into the controld
    End_Procedure
    
End_Object

