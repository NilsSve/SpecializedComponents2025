Use DFClient.pkg
Use Windows.pkg
Use cDbCJGridPromptList.pkg

Use Customer.DD


Cd_Popup_Object Customer_sl is a dbModalPanel
    
    Set Border_Style to Border_Thick
    Set Minimize_Icon to False
    Set Label to "Customer List"
    Set Size to 134 238
    Set Location to 4 5
    Set piMinSize to 134 238
    
    Object Customer_DD is a Customer_DataDictionary
    End_Object
    
    Set Main_DD to Customer_DD
    Set Server to Customer_DD
    
    Object oSelList is a cDbCJGridPromptList
        Set Size to 100 224
        Set Location to 9 8
        Set peAnchors to anAll
        Set pbAllowColumnRemove to False
        
        Object oNumber is a cDbCJGridColumn
            Entry_Item Customer.Customer_Number
            Set piWidth to 93
            Set psCaption to "Number"
        End_Object
        
        Object oCustomerName is a cDbCJGridColumn
            Entry_Item Customer.Name
            Set piWidth to 243
            Set psCaption to "Customer Name"
        End_Object
    End_Object
    
    Object oOK_bn is a Button
        Set Label to "&Ok"
        Set Location to 116 77
        Set peAnchors to anBottomRight
        
        Procedure OnClick
            Send OK of oSelList
        End_Procedure
        
    End_Object
    
    Object oCancel_bn is a Button
        Set Label to "&Cancel"
        Set Location to 116 130
        Set peAnchors to anBottomRight
        
        Procedure OnClick
            Send Cancel of oSelList
        End_Procedure
        
    End_Object
    
    Object oSearch_bn is a Button
        Set Label to "&Search..."
        Set Location to 116 183
        Set peAnchors to anBottomRight
        
        Procedure OnClick
            Send Search of oSelList
        End_Procedure
        
    End_Object
    
    On_Key Key_Alt+Key_O Send KeyAction of oOk_bn
    On_Key Key_Alt+Key_C Send KeyAction of oCancel_bn
    On_Key Key_Alt+Key_S Send KeyAction of oSearch_bn
    
    Function GetSelectedNames String sSeed String ByRef sFirst String ByRef sLast Returns Boolean
        Boolean bCancel
        Integer iSize
        String[] SelectionValues
        
        Send OnStoreDefaults of oSelList
        
        Set peUpdateMode of oSelList to umPromptNonInvoking
        Set piUpdateColumn of oSelList to 1
        Set pbMultipleSelection of oSelList to True
        Set psSeedValue of oSelList to sSeed
        
        Send Popup
        
        Send OnRestoreDefaults of oSelList
        
        Get pbCanceled of oSelList to bCancel
        If not bCancel Begin
            Get SelectedColumnValues of oSelList 1 to SelectionValues
            Move (SizeOfArray(SelectionValues)) to iSize
            If (iSize) Begin
                // return them in the correct alpha order
                If (SelectionValues[0]<=SelectionValues[iSize-1]) Begin
                    Move SelectionValues[0] to sFirst
                    Move SelectionValues[iSize-1] to sLast
                End
                Else Begin
                    Move SelectionValues[iSize-1] to sFirst
                    Move SelectionValues[0] to sLast
                End
                Function_Return True
            End
        End
        Function_Return False
    End_Function
Cd_End_Object
