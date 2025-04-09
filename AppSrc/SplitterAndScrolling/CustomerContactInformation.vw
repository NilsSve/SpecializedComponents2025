Use DFClient.pkg
Use DFEntry.pkg
Use dfEnChk.pkg
Use dfcentry.pkg
Use cDbTextEdit.pkg
Use Customer.dd
Use cLinkLabel.pkg
Use cDbScrollingContainer.pkg
Use cDbSplitterContainer.pkg

Activate_View Activate_oCustomerContactInformation for oCustomerContactInformation
Object oCustomerContactInformation is a dbView
    Set Location to 6 3
    Set Size to 251 298
    Set Label to "Customer Contact Information"
    Set Border_Style to Border_Thick
    Set pbAutoActivate to True
    Set piMinSize to 235 270
    
    
    Object oCustomer_DD is a Customer_DataDictionary
    End_Object
    
    Set Main_DD To oCustomer_DD
    Set Server  To oCustomer_DD
    
    Object oDbSplitterContainer1 is a cDbSplitterContainer
        Set pbSplitVertical to False
        Set piSplitterLocation to 142
        Set piMaxSplitterLocation to 50
        Set piMinSplitterLocation to 125
        Object oDbSplitterContainerChild1 is a cDbSplitterContainerChild
            Object oDbScrollingContainer1 is a cDbScrollingContainer
                Object oDbScrollingClientArea1 is a cDbScrollingClientArea
                    Object oCustomerNumber is a dbForm
                        Entry_Item Customer.Customer_Number
                        Set Size to 13 51
                        Set Location to 5 55
                        Set peAnchors to anNone
                        Set Label to "Number"
                        Set Label_Justification_mode to jMode_Left
                        Set Label_Col_Offset to 50
                        Set Label_row_Offset to 0
                        Set psToolTip to "Assigned Customer Id"
                        Set Label_FontWeight to 800
                    End_Object
                    Object oCustomerStatus is a dbCheckBox
                        Entry_Item Customer.Status
                        Set Size to 13 60
                        Set Location to 20 55
                        Set peAnchors to anNone
                        Set Label to "Active Customer"
                    End_Object
                    Object oCustomerName is a dbForm
                        Entry_Item Customer.Name
                        Set Size to 13 232
                        Set Location to 35 55
                        Set peAnchors to anNone
                        Set Label to "Name"
                        Set Label_Justification_mode to jMode_Left
                        Set Label_Col_Offset to 50
                        Set Label_row_Offset to 0
                        Set Label_TextColor to clBlue
                        Set Label_FontSize to 15 10
                        Set Label_FontWeight to 600
                        Set FontUnderline to True
                    End_Object
                    Object oCustomerAddress is a dbForm
                        Entry_Item Customer.Address
                        Set Size to 13 232
                        Set Location to 50 55
                        Set peAnchors to anNone
                        Set Label to "Address"
                        Set Label_Justification_mode to jMode_Left
                        Set Label_Col_Offset to 50
                        Set Label_row_Offset to 0
                        Set Label_TextColor to clBlack
                    End_Object
                    Object oCustomerCity is a dbForm
                        Entry_Item Customer.City
                        Set Size to 13 151
                        Set Location to 66 55
                        Set peAnchors to anNone
                        Set Label to "City"
                        Set Label_Justification_mode to jMode_Left
                        Set Label_Col_Offset to 50
                        Set Label_row_Offset to 0
                    End_Object
                    
                    Object oCustomerState is a dbComboForm
                        Entry_Item Customer.State
                        Set Size to 13 39
                        Set Location to 66 248
                        Set peAnchors to anNone
                        Set Label to "State"
                        Set Label_Justification_mode to jMode_Left
                        Set Label_Col_Offset to 25
                        Set Label_row_Offset to 0
                        Set Code_Display_Mode to CB_Code_Display_Code
                    End_Object
                    
                    Object oCustomerPhone_Number is a dbForm
                        Entry_Item Customer.Phone_Number
                        Set Size to 13 135
                        Set Location to 82 55
                        Set peAnchors to anNone
                        Set Label to "Phone Number"
                        Set Label_Justification_mode to jMode_Left
                        Set Label_Col_Offset to 50
                        Set Label_row_Offset to 0
                    End_Object
                    Object oCustomerEmail_Address is a dbForm
                        Entry_Item Customer.EMail_Address
                        Set Size to 13 232
                        Set Location to 98 55
                        Set peAnchors to anNone
                        Set Label to "Email Address"
                        Set Label_Justification_mode to jMode_Left
                        Set Label_Col_Offset to 50
                        Set Label_row_Offset to 0
                    End_Object
                    Object oLinkLabel1 is a cLinkLabel
                        Set Size to 16 85
                        Set Location to 10 155
                        Set Label to 'Tell me <A href="www.dataaccess.com">More</A> or request aditional <A href="mailto:info@dataaccess.com">information</A>'
                        Set peAnchors to anNone
                    End_Object
                    Object oLinkLabel2 is a cLinkLabel
                        Set Size to 8 27
                        Set Location to 10 266
                        Set Label to '<A ID="about">About</A>'
                        Set peAnchors to anNone
                        
                        Procedure OnClick Integer iItem String sID String sUrl
                            Send Activate_About
                        End_Procedure
                        
                    End_Object
                    Object oLinkLabel3 is a cLinkLabel
                        Set Size to 8 45
                        Set Location to 119 241
                        Set Label to '<A ID="clear">Clear</A> or <A ID="save">Save</A>'
                        Set peAnchors to anNone
                        
                        Procedure OnClick Integer iItem String sID String sUrl
                            If (sID="clear") Begin
                                Send Request_Clear
                            End
                            Else Begin
                                Send Request_Save
                            End
                        End_Procedure
                        
                    End_Object
                End_Object
            End_Object
        End_Object
        
        Object oDbSplitterContainerChild2 is a cDbSplitterContainerChild
            Object oCustomerComments is a cDbTextEdit
                Entry_Item Customer.Comments
                Set Size to 106 294
                Set Location to 0 0
                Set peAnchors to anAll
                Set Label_Justification_mode to jMode_Left
                Set Label_Col_Offset to 46
                Set Label_row_Offset to 0
                Set Border_Style to Border_None
            End_Object
        End_Object
    End_Object
    
    
    
End_Object

