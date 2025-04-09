Use Windows.pkg
Use DFClient.pkg
Use cDbSplitterContainer.pkg
Use dfTreeVw.pkg
Use cDbScrollingContainer.pkg
Use Customer.DD
Use cLinkLabel.pkg
Use Dfentry.pkg
Use Dfcentry.pkg
Use cDbTextEdit.pkg

Activate_View Activate_oCustomers for oCustomers
Object oCustomers is a dbView
    Object oCustomer_DD is a Customer_DataDictionary
    End_Object
    
    Set Main_DD to oCustomer_DD
    Set Server to oCustomer_DD
    
    Set Border_Style to Border_Thick
    Set Size to 273 476
    Set Location to 1 2
    Set Label to "Customers"
    Set pbAutoActivate to True
    Set piMinSize to 200 300
    
    Procedure RefreshList
        Handle hoTree
        Handle hItem
        Move (oCustTree) to hoTree
        Set CurrentTreeItem of hoTree to 0
        Send ClearAll of hoTree
        Clear Customer
        Find gt Customer by 1
        While (Found)
            Get AddTreeItem of hoTree Customer.Name 0 Customer.Customer_Number 0 0 to hItem
            Find gt Customer by 1
        Loop
    End_Procedure
    
    Object oDbSplitterContainer1 is a cDbSplitterContainer
        Set piSplitterLocation to 153
        Set piSplitterColor to clWhite
        Set piMinSplitterLocation to 100
        Set piMaxSplitterLocation to 200
        Object oDbSplitterContainerChild1 is a cDbSplitterContainerChild
            Object oCustTree is a TreeView
                Set Size to 257 152
                Set Location to -1 0
                Set peAnchors to anAll
                Set Border_Style to Border_None
                Set pbEnableInfoTips to True
                
                Procedure OnCreateTree
                    Send RefreshList
                End_Procedure
                
                Procedure OnItemChanged Handle hItem Handle hItemOld
                    Integer iCustNum
                    If hItem Begin
                        Clear Customer
                        Get ItemData hItem to Customer.Customer_Number
                        Send Request_Find of oCustomer_DD eq Customer.File_Number 1
                    End
                End_Procedure
                
                Procedure OnGetInfoTip Handle hItem String  ByRef sInfoTip
                    Integer iRec
                    If hItem Begin
                        Clear Customer
                        Get ItemData hItem to Customer.Recnum
                        Find eq Customer by 0
                        Move (String(Customer.Customer_Number) * "-" * Customer.Name * ":" * Customer.EMail_Address) to sInfoTip
                    End
                End_Procedure
                
            End_Object
            
            Object oRefresh is a Button
                Set Size to 14 152
                Set Location to 258 0
                Set Label to "Refresh"
                
                Set psToolTip to "Synchronize the list with the latest changes in the database"
                Set peAnchors to anBottomLeftRight
                
                // fires when the button is clicked
                Procedure OnClick
                    Send RefreshList
                End_Procedure
                
            End_Object
        End_Object
        
        Object oDbSplitterContainerChild2 is a cDbSplitterContainerChild
            Object oDbScrollingContainer1 is a cDbScrollingContainer
                Object oDbScrollingClientArea1 is a cDbScrollingClientArea
                    Set piAutoScrollMarginY to 0
                    Set piAutoScrollMarginX to 0
                    Object oCustomer_Number is a dbForm
                        Entry_Item Customer.Customer_Number
                        Set Label to "Customer Number:"
                        Set Size to 13 42
                        Set Location to 5 72
                        Set peAnchors to anTopLeft
                        Set Label_Col_Offset to 2
                        Set Label_Justification_Mode to jMode_Right
                    End_Object
                    Object oCustomer_Name is a dbForm
                        Entry_Item Customer.Name
                        Set Label to "Name:"
                        Set Size to 13 186
                        Set Location to 21 72
                        Set peAnchors to anNone
                        Set Label_Col_Offset to 2
                        Set Label_Justification_Mode to jMode_Right
                    End_Object
                    
                    Object oCustomer_Address is a dbForm
                        Entry_Item Customer.Address
                        Set Label to "Street Address:"
                        Set Size to 13 180
                        Set Location to 37 72
                        Set peAnchors to anNone
                        Set Label_Col_Offset to 2
                        Set Label_Justification_Mode to jMode_Right
                    End_Object
                    Object oCustomer_City is a dbForm
                        Entry_Item Customer.City
                        Set Label to "City/State/Zip:"
                        Set Size to 13 84
                        Set Location to 53 72
                        Set peAnchors to anNone
                        Set Label_Col_Offset to 2
                        Set Label_Justification_Mode to jMode_Right
                    End_Object
                    Object oCustomer_State is a dbComboForm
                        Entry_Item Customer.State
                        Set Size to 13 32
                        Set Location to 53 162
                        Set peAnchors to anNone
                        Set Form_Border to 0
                        Set Code_Display_Mode to cb_code_display_code
                    End_Object
                    Object oCustomer_Zip is a dbForm
                        Entry_Item Customer.Zip
                        Set Size to 13 51
                        Set Location to 53 200
                        Set peAnchors to anNone
                    End_Object
                    Object oCustomer_Phone_number is a dbForm
                        Entry_Item Customer.Phone_Number
                        Set Label to "Phone Number:"
                        Set Size to 13 120
                        Set Location to 69 72
                        Set peAnchors to anNone
                        Set Label_Col_Offset to 2
                        Set Label_Justification_Mode to jMode_Right
                    End_Object
                    Object oCustomer_Fax_number is a dbForm
                        Entry_Item Customer.Fax_Number
                        Set Label to "Fax Number:"
                        Set Size to 13 120
                        Set Location to 85 72
                        Set peAnchors to anNone
                        Set Label_Col_Offset to 2
                        Set Label_Justification_Mode to jMode_Right
                    End_Object
                    Object oCustomer_Email_address is a dbForm
                        Entry_Item Customer.EMail_Address
                        Set Label to "E-Mail Address:"
                        Set Size to 13 180
                        Set Location to 101 72
                        Set peAnchors to anNone
                        Set Label_Col_Offset to 2
                        Set Label_Justification_Mode to jMode_Right
                    End_Object
                    
                    Object oCustomer_Credit_Limit is a dbForm
                        Entry_Item Customer.Credit_limit
                        Set Label to "Credit Limit:"
                        Set Size to 13 48
                        Set Location to 117 72
                        Set Label_Col_Offset to 2
                        Set Label_Justification_Mode to jMode_Right
                    End_Object
                    Object oCustomer_Purchases is a dbForm
                        Entry_Item Customer.Purchases
                        Set Label to "Total Purchases:"
                        Set Size to 13 48
                        Set Location to 133 72
                        Set Label_Col_Offset to 2
                        Set Label_Justification_Mode to jMode_Right
                    End_Object
                    Object oCustomer_Balance is a dbForm
                        Entry_Item Customer.Balance
                        Set Label to "Balance Due:"
                        Set Size to 13 48
                        Set Location to 149 72
                        Set Label_Col_Offset to 2
                        Set Label_Justification_Mode to jMode_Right
                    End_Object
                    
                    Object oCustomer_Comments is a cDbTextEdit
                        Entry_Item Customer.Comments
                        Set Size to 71 242
                        Set piMinSize to 70 0
                        Set Location to 165 71
                        Set peAnchors to anTopBottom
                        Set Label to "Comments:"
                        Set Label_Justification_Mode to JMode_Right
                        Set Label_Row_Offset to 2
                    End_Object
                    
                    Object oVisitDAWLink is a cLinkLabel
                        Set Size to 14 82
                        Set Location to 9 178
                        Set Label to '<A HREF="http://www.DataAccess.com">Visit Data Access Online</A>'
                        Set psToolTip to "http://www.DataAccess.com"
                    End_Object
                    
//                    Object oButton2 is a Button
//                        Set Location to 243 31
//                        Set Label to 'oButton2'
//                        Set peAnchors to anBottomLeft
//
//                        // fires when the button is clicked
//                        Procedure OnClick
//
//                        End_Procedure
//
//                    End_Object
                    
                    Object oReportBugLink is a cLinkLabel
                        Set Size to 8 101
                        Set Location to 243 7
                        Set Label to 'Found a Bug? <A HREF="mailto:support@dataaccess.com?Subject=Bug Report">Report it here.</A>'
                        Set psToolTip to "Send an email to technical support"
                        Set peAnchors to anBottomLeft
                        
                    End_Object
                    
                    Object oLinkAbout is a cLinkLabel
                        Set Size to 8 63
                        Set Location to 243 250
                        Set Label to '<A ID="LinkId">About this program</A>'
                        Set psToolTip to "Display the About dialog"
                        Set peAnchors to anBottomLeft
                        
                        Procedure OnClick Integer iItem String sID String sUrl
                            Send Activate_About
                        End_Procedure
                        
                    End_Object
                    
                    
                End_Object
            End_Object
        End_Object
    End_Object
    
End_Object

