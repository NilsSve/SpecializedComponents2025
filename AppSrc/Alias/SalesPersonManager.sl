// SalesPersonManager.sl
// Sales Person Manager Lookup List

Use DFClient.pkg
Use cDbCJGridPromptList.pkg
Use cDbCJGridColumn.pkg
Use Windows.pkg

Use cSalesPersonManagerDataDictionary.dd

CD_Popup_Object SalesPersonManager_sl is a dbModalPanel
    Set Location to 5 5
    Set Size to 134 210
    Set Label To "Sales Person Manager Lookup List"
    Set Border_Style to Border_Thick
    Set Minimize_Icon to False
    
    
    Object oSalesPersonManager_DD is a cSalesPersonManagerDataDictionary
    End_Object
    
    Set Main_DD To oSalesPersonManager_DD
    Set Server  To oSalesPersonManager_DD
    
    
    
    Object oSelList is a cDbCJGridPromptList
        Set Size to 105 200
        Set Location to 5 5
        Set peAnchors to anAll
        Set psLayoutSection to "SalesPersonManager_sl_oSelList"
        Set Ordering to 1
        Set pbAutoServer to True
        
        Object oSalesPersonManager_ID is a cDbCJGridColumn
            Entry_Item SalesPersonManager.ID
            Set piWidth to 70
            Set psCaption to "ID"
        End_Object
        
        Object oSalesPersonManager_Name is a cDbCJGridColumn
            Entry_Item SalesPersonManager.Name
            Set piWidth to 262
            Set psCaption to "Sales Person Name"
        End_Object
        
        
    End_Object
    
    Object oOk_bn is a Button
        Set Label to "&Ok"
        Set Location to 115 47
        Set peAnchors to anBottomRight
        
        Procedure OnClick
            Send OK of oSelList
        End_Procedure
        
    End_Object
    
    Object oCancel_bn is a Button
        Set Label to "&Cancel"
        Set Location to 115 101
        Set peAnchors to anBottomRight
        
        Procedure OnClick
            Send Cancel of oSelList
        End_Procedure
        
    End_Object
    
    Object oSearch_bn is a Button
        Set Label to "&Search..."
        Set Location to 115 155
        Set peAnchors to anBottomRight
        
        Procedure OnClick
            Send Search of oSelList
        End_Procedure
        
    End_Object
    
    On_Key Key_Alt+Key_O Send KeyAction of oOk_bn
    On_Key Key_Alt+Key_C Send KeyAction of oCancel_bn
    On_Key Key_Alt+Key_S Send KeyAction of oSearch_bn
    
    
CD_End_Object

