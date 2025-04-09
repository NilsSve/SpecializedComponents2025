Use WebClientHelper.vw
Use Windows.pkg
Use DFClient.pkg
Use dfBitmap.pkg
Use WebServices\cWSNumberConversion.pkg
Use WebServices\cWSTextCasing.pkg
Use cWinReport2.pkg

// Struct to store the check information typed
Struct tCheck
    String sCheckDate
    String sDollarAmount
    String sPayToTheOrderOf
    String sAmountSpelledOut
    String sMemo    
End_Struct

// Default text to display when amount is zero
Define DefaultAmountText for "<Dollar amount entered will be displayed here>"


Deferred_View Activate_oCheckBook for ;
Object oCheckBook is a dbView

    Set Border_Style to Border_Thick
    Set Size to 194 492
    Set Location to 3 2
    Set Label to "Check Book"

    Object oCheckInformation is a Group
        Set Size to 127 469
        Set Location to 42 12
        Set Label to "Enter the information for the check you would like to print"
        
        Object oWSNumberConverter is a cWSNumberConversion
            //
            // Interface:
            //
            // Function wsNumberToWords ubigint llubiNum Returns string
            // Function wsNumberToDollars decimal lldNum Returns string
            //
        
        
            // phoSoapClientHelper
            //     Setting this property will pop up a view that provides information
            //     about the Soap (xml) data transfer. This can be useful in debugging.
            //     If you use this you must make sure you USE the test view at the top
            //     of your program/view by adding:   Use WebClientHelper.vw // oClientWSHelper
            //Set phoSoapClientHelper to oClientWSHelper
        
        End_Object  
        
        Object oWSTextCaser is a cWSTextCasing
        
            //
            // Interface:
            //
            // Function wsTitleCaseWordsWithToken string llsText string llsToken Returns string
            // Function wsInvertStringCase string llsAString Returns string
            // Function wsInvertCaseFirstAdjustStringToPrevious string llsAString Returns string
            // Function wsInvertCaseFirstAdjustStringToCurrent string llsAString Returns string
            // Function wsAllUppercaseWithToken string llsAString string llsToken Returns string
            // Function wsAllLowercaseWithToken string llsAString string llsToken Returns string
            // Function wsUppercaseWordsWithToken string llsAString string llsToken Returns string
            // Function wsLowercaseWordsWithToken string llsAString string llsToken Returns string
            //
        
        
            // phoSoapClientHelper
            //     Setting this property will pop up a view that provides information
            //     about the Soap (xml) data transfer. This can be useful in debugging.
            //     If you use this you must make sure you USE the test view at the top
            //     of your program/view by adding:   Use WebClientHelper.vw // oClientWSHelper
            //Set phoSoapClientHelper to oClientWSHelper
        
        End_Object        

        Object oDate is a Form
            Set Size to 13 59
            Set Location to 9 392
            Set Label to "Date"
            Set Label_Col_Offset to 25
            Set Form_Datatype to Mask_Date_Window
            
            Procedure Activating
                Date dDefaultDate
                
                Sysdate dDefaultDate
                Set Value to dDefaultDate
            End_Procedure
       
        End_Object

        Object oDollarAmount is a Form
            Set Size to 13 100
            Set Location to 25 351
            Set Label to "$"
            Set Label_Col_Offset to 15
            Set Form_Mask to "###,###,###,###.00"
            Set Form_Datatype to Mask_Numeric_Window
        
            Procedure Exiting Handle hoNextObject Returns Integer
                Integer iRetVal iStatus
                Decimal dAmount
                String sAmountWord
            
                Forward Get msg_Exiting hoNextObject to iRetVal
                If (iRetVal) Begin
                    Procedure_Return iRetVal
                End
                
                Get Value of oDollarAmount to dAmount
                If (dAmount = 0) Begin
                    Send DisplayDefaultText of oAmountSpelledOut
                    Procedure_Return iRetVal
                End
                
                Send Cursor_Wait of Cursor_Control
                
                Get wsNumberToDollars of oWSNumberConverter dAmount to sAmountWord
                
                Get peTransferStatus of oWSNumberConverter to iStatus
                If (iStatus = wssOk) Begin
                    // title case the words
                    Get wsTitleCaseWordsWithToken of oWSTextCaser sAmountWord " " to sAmountWord
                    
                    Get peTransferStatus of oWSNumberConverter to iStatus
                    If (iStatus <> wssOk) Begin
                        Send Stop_Box "Unable to title case amount. Error executing 'wsTitleCaseWordsWithToken'" "Check Book"
                    End
                    
                    // display amount title-cased or not
                    Set Value of oAmountSpelledOut to sAmountWord
                End
                Else Begin
                     // display error and default text for the amount
                     Send Stop_Box "Unable to convert amount to words. Error executing 'wsNumberToDollars'" "Check Book"
                     Send DisplayDefaultText of oAmountSpelledOut
                End                
            
                Send Cursor_Ready of Cursor_Control
                
                Procedure_Return iRetVal
            End_Procedure            
        
        End_Object

        Object oPayToTheOrderOf is a Form
            Set Size to 13 380
            Set Location to 42 71
            Set Label to "Pay to the order of"
            Set Label_Col_Offset to 65
            Set Form_Margin to 110
       
        End_Object

        Object oAmountSpelledOut is a TextBox
            Set Auto_Size_State to False
            Set Size to 16 443
            Set Location to 63 7
            Set Label to DefaultAmountText
            Set piMinSize to 9 150
            Set Justification_Mode to JMode_Left
            Set Color to clInfoBk
            
            Procedure DisplayDefaultText
                Set Value to DefaultAmountText
            End_Procedure
            
        End_Object

        Object oMemo is a Form
            Set Size to 13 197
            Set Location to 107 40
            Set Label to "Memo"
            Set Label_Col_Offset to 30
            Set Form_Margin to 55
        
        End_Object

        Object oSignature is a BitmapContainer
            Set Size to 29 196
            Set Location to 91 255
            Set Bitmap_Style to Bitmap_Stretch
            Set Bitmap to "signature.bmp"
            Set Border_Style to Border_StaticEdge
        End_Object
        
        
        Function CheckInformation Returns tCheck
            tCheck CheckEntered
            
            Get Value of oDate to CheckEntered.sCheckDate
            Get Masked_Value of oDollarAmount to CheckEntered.sDollarAmount
            Get Value of oPayToTheOrderOf to CheckEntered.sPayToTheOrderOf
            Get Value of oAmountSpelledOut to CheckEntered.sAmountSpelledOut
            Get Value of oMemo to CheckEntered.sMemo
            
            Function_Return CheckEntered            
        End_Function

    End_Object


    Object oPrintableCheck is a cWinReport2
        
        Function Starting_Main_Report Returns Integer
            Boolean bErr
            
            Send DFSetMetrics wpm_CM
            Send DFSetmargins 1 1 0.5 1
            
            Forward Get Starting_Main_Report to bErr
           
            Function_Return bErr
        End_Function
    
        Procedure Body
            String  sFont
            Integer iFontSize iStyle
            tCheck CheckToPrint
                    
            Move "Arial" to sFont
            Move 10 to iFontSize
            Move (Font_Default) to iStyle
        
            DFFont sFont
            DFFontSize iFontSize
           
            Get CheckInformation of oCheckInformation to CheckToPrint
        
            //DFWritePos {Value} {Position} {Style} {DecPoints} {MaxLength}
            DFWriteLn
            DFWritePos "Date:"                             9 iStyle 0
            DFWriteLnPos CheckToPrint.sCheckDate          12 (iStyle + FONT_RIGHT) 0
            DFWriteLnPos CheckToPrint.sDollarAmount       19 (iStyle + FONT_RIGHT) -1 5
            DFWriteLn
            DFWritePos "Pay to the order of:"              1.5 iStyle -1 5
            DFWriteLnPos CheckToPrint.sPayToTheOrderOf     4.5 (iStyle + FONT_UNDER) -1 17
            DFWriteLn
            DFWriteLnPos CheckToPrint.sAmountSpelledOut    1.5 iStyle -1 20
            DFWriteLn
            DFWriteLn
            DFWriteLn
            DFWritePos "Memo:"                              1.5 iStyle -1 5
            DFWriteLnPos CheckToPrint.sMemo                 2.6 (iStyle + FONT_UNDER) -1 10
            
            // DFWriteBMP {path\filename} {vert_Location} {horz_Location} {height} {width} [{update_cur_pos}]
            DFWriteBMP 'signature.bmp' 4 13 2 7 DFGR_SETPOS
            
            // DFWriteRect {vert} {horz} {height} {width} [{line_color} [{line_width} [{reprint} [{fill_color} [{update_cur_pos}]]]]]
            DFWriteRect 0 0 7 20 RGB_BLACK 0.1               
        End_Procedure
        
        
        Function Start_Report Returns Integer
            Integer Rpt_Status
            
            Forward Get Start_Report to Rpt_Status

            // print once
            Get Handle_Report_Line to Rpt_Status
            Get End_Report Rpt_Status to Rpt_Status        
    
            Function_Return Rpt_Status
        End_Function
        
    End_Object


    Object oPrintCheck is a Button
        Set Location to 175 431
        Set Label to "Print Check"
    
        Procedure OnClick
            tCheck CheckToPrint
            
            Get CheckInformation of oCheckInformation to CheckToPrint
            If (CheckToPrint.sAmountSpelledOut <> DefaultAmountText) Begin
                // set output to window
                Set OutPut_Device_Mode of oPrintableCheck to PRINT_TO_WINDOW
                            
                Send Run_Report of oPrintableCheck                
            End
            Else Begin
                Send Stop_Box "No amount specified. Check cannot be printed. Please enter a dollar amount and try again." "Check Book"
            End

        End_Procedure
    
    End_Object

    Object oInfoEdit is a cTextEdit
        Set Size to 28 469
        Set Location to 8 12
        Set Color to clBtnFace
        Set TextColor to clMaroon
        Set Read_Only_State to True
        Set Enabled_State to False

        Set Value of oInfoEdit ;
            to "This sample uses two different services published by Data Access: one to get the number typed in and generate the corresponding words for the dollar amount, and a second service that will title case the words to be displayed."

    End_Object    // oInfoEdit

    Object oDebugMode is a CheckBox
        Set Label to "Activate Debug Mode"
        Set Size to 10 85
        Set Location to 177 15
        Set peAnchors to anBottomLeft

        Procedure OnChange
            Boolean bChecked
        
            Get Checked_State to bChecked
        
            If (bChecked) Begin
                // Activates the debug information for the services used
                // Leave uncommented the line for the service you would like to see information on
                Set phoSoapClientHelper of oWSNumberConverter to oClientWSHelper
                //Set phoSoapClientHelper of oWSTextCaser to oClientWSHelper
            End
            Else Begin
                Set phoSoapClientHelper of oWSNumberConverter to ""
                //Set phoSoapClientHelper of oWSTextCaser to ""
            End
        End_Procedure // OnChange

    End_Object    // oDebugMode
    Object oDisplayDebug is a Button
        Set Label to "Display Debug Information"
        Set Size to 14 96
        Set Location to 175 118
        Set peAnchors to anBottomLeft

        Procedure OnClick
            Send Popup of oClientWSHelper
        End_Procedure // OnClick

    End_Object    // oDisplayDebug

Cd_End_Object
