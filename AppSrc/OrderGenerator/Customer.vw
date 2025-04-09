Use DFClient.pkg
Use DataDict.pkg
Use DFEntry.pkg
Use DFTabDlg.pkg
Use DFCEntry.pkg
Use cDbTextEdit.Pkg

Use Customer.DD

Deferred_View Activate_Customer For ;
;
Object Customer is a dbView
    Set Label to "Customer Entry View"
    Set Location to 4 10
    Set Size to 146 277
    
    Object Customer_DD is a Customer_DataDictionary
    End_Object
    
    Set Main_DD to Customer_DD
    Set Server to Customer_DD
    
    Object Customer_Number is a dbForm
        Entry_Item Customer.Customer_number
        Set Label to "Customer Number:"
        Set Size to 13 42
        Set Location to 5 72
        Set Label_Col_Offset to 2
        Set Label_Justification_Mode to jMode_Right
    End_Object
    
    Object Customer_Name is a dbForm
        Entry_Item Customer.Name
        Set Label to "Name:"
        Set Size to 13 186
        Set Location to 20 72
        Set Label_Col_Offset to 2
        Set Label_Justification_Mode to jMode_Right
    End_Object
    
    Object CustTD is a dbTabDialog
        Set Size to 105 265
        Set Location to 36 7
        Set Rotate_Mode to RM_Rotate
        Object Address_TP is a dbTabPage
            Set Label to "Address"
            Object Customer_Address is a dbForm
                Entry_Item Customer.Address
                Set Label to "Street Address:"
                Set Size to 13 180
                Set Location to 8 62
                Set Label_Col_Offset to 2
                Set Label_Justification_Mode to jMode_Right
            End_Object
            
            Object Customer_City is a dbForm
                Entry_Item Customer.City
                Set Label to "City/State/Zip:"
                Set Size to 13 84
                Set Location to 24 62
                Set Label_Col_Offset to 2
                Set Label_Justification_Mode to jMode_Right
            End_Object
            
            Object Customer_State is a dbComboForm
                Entry_Item Customer.State
                Set Size to 13 32
                Set Location to 24 152
                Set Form_Border to 0
            End_Object
            
            Object Customer_Zip is a dbForm
                Entry_Item Customer.Zip
                Set Size to 13 51
                Set Location to 24 191
            End_Object
            
            Object Customer_Phone_Number is a dbForm
                Entry_Item Customer.Phone_Number
                Set Label to "Phone Number:"
                Set Size to 13 120
                Set Location to 39 62
                Set Label_Col_Offset to 2
                Set Label_Justification_Mode to jMode_Right
            End_Object
            
            Object Customer_Fax_Number is a dbForm
                Entry_Item Customer.Fax_Number
                Set Label to "Fax Number:"
                Set Size to 13 120
                Set Location to 54 62
                Set Label_Col_Offset to 2
                Set Label_Justification_Mode to jMode_Right
            End_Object
            
            Object Customer_Email_Address is a dbForm
                Entry_Item Customer.Email_Address
                Set Label to "E-Mail Address:"
                Set Size to 13 180
                Set Location to 69 62
                Set Label_Col_Offset to 2
                Set Label_Justification_Mode to jMode_Right
            End_Object
            
        End_Object
        
        Object Balances_TP is a dbTabPage
            Set Label to "Balances"
            Object Customer_Credit_Limit is a dbForm
                Entry_Item Customer.Credit_limit
                Set Label to "Credit Limit:"
                Set Size to 13 48
                Set Location to 9 72
                Set Label_Col_Offset to 2
                Set Label_Justification_Mode to jMode_Right
            End_Object
            
            Object Customer_Purchases is a dbForm
                Entry_Item Customer.Purchases
                Set Label to "Total Purchases:"
                Set Size to 13 48
                Set Location to 24 72
                Set Label_Col_Offset to 2
                Set Label_Justification_Mode to jMode_Right
            End_Object
            
            Object Customer_Balance is a dbForm
                Entry_Item Customer.Balance
                Set Label to "Balance Due:"
                Set Size to 13 48
                Set Location to 39 72
                Set Label_Col_Offset to 2
                Set Label_Justification_Mode to jMode_Right
            End_Object
            
        End_Object
        
        Object Comments_TP is a dbTabPage
            Set Label to "Comments"
            Object Customer_Comments is a cDbTextEdit
                Entry_Item Customer.Comments
                Set Size to 60 242
                Set Location to 15 9
            End_Object
            
        End_Object
        
    End_Object
    
CD_End_Object

