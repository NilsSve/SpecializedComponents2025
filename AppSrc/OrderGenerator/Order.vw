Use dfClient.pkg
Use DataDict.pkg
Use dfEntry.pkg
Use dfSpnEnt.pkg
Use dfCEntry.pkg
Use Windows.pkg

Use Vendor.DD
Use Invt.DD
Use Customer.DD
Use SalesP.DD
Use OrderHea.DD
Use OrderDtl.DD

Use cDbCJGrid.pkg
Use cCJGridColumnRowIndicator.pkg

Use MonthCalendarPrompt.dg

Activate_View Activate_oOrderEntryView for oOrderEntryView
Object oOrderEntryView is a dbView
    Set Border_Style to Border_Thick
    Set Maximize_Icon to True
    Set Label to "Order Entry"
    Set Location to 2 3
    Set Size to 178 383
    Set piMinSize to 178 383

    Object Vendor_DD is a Vendor_DataDictionary
    End_Object
    
    Object Invt_DD is a Invt_DataDictionary
        Set DDO_Server to Vendor_DD
    End_Object
    
    Object Customer_DD is a Customer_DataDictionary
    End_Object
    
    Object SalesP_DD is a Salesp_DataDictionary
    End_Object
    
    Object OrderHea_DD is a OrderHea_DataDictionary
        Set DDO_Server to Customer_DD
        Set DDO_Server to SalesP_DD
        
        // this lets you save a new OrderHea from within OrderDtl.
        Set Allow_Foreign_New_Save_State to True
        
        // for this sample, we want to change dates using the calendar
        Set Field_Option Field OrderHea.Order_Date DD_COMMIT to False
        
    End_Object
    
    Object OrderDtl_DD is a OrderDtl_DataDictionary
        Set DDO_Server to OrderHea_DD
        Set DDO_Server to Invt_DD
        Set Constrain_File to OrderHea.File_Number
    End_Object
    
    Set Main_DD to OrderHea_DD
    Set Server to OrderHea_DD
    
    
    Object oDbContainer3d1 is a dbGroup
        Set Size to 89 377
        Set Location to 2 3
        Set peAnchors to anTopLeftRight

        Object oOrderHeader_Order_Number is a dbForm
            Entry_Item OrderHea.Order_Number
            Set Label to "Order Number:"
            Set Size to 12 42
            Set Location to 11 63
            Set peAnchors to anTopLeft
            Set Label_Col_Offset to 2
            Set Label_Justification_Mode to jMode_Right
        End_Object

        Object oOrderHeader_Customer_Number is a dbForm
            Entry_Item Customer.Customer_Number
            Set Label to "Customer Number:"
            Set Size to 12 42
            Set Location to 11 201
            Set peAnchors to anTopRight
            Set Label_Col_Offset to 2
            Set Label_Justification_Mode to jMode_Right
        End_Object

        Object oOrderHeader_Order_Date is a dbForm
            Entry_Item OrderHea.Order_Date
            Set Label to "Order Date:"
            Set Size to 12 67
            Set Location to 11 299
            Set peAnchors to anTopRight
            Set Label_Col_Offset to 2
            Set Label_Justification_Mode to jMode_Right

            Set Prompt_Object to oMonthCalendarPrompt
            Set Prompt_Button_Mode to PB_PromptOn
        End_Object

        Object oCustomer_Name is a dbForm
            Entry_Item Customer.Name
            Set Label to "Customer Name:"
            Set Size to 12 180
            Set Location to 25 63
            Set peAnchors to anTopLeftRight
            Set Label_Col_Offset to 2
            Set Label_Justification_Mode to jMode_Right
        End_Object

        Object oCustomer_Address is a dbForm
            Entry_Item Customer.Address
            Set Label to "Street Address:"
            Set Size to 12 180
            Set Location to 39 63
            Set peAnchors to anTopLeftRight
            Set Label_Col_Offset to 2
            Set Label_Justification_Mode to jMode_Right
        End_Object

        Object oCustomer_City is a dbForm
            Entry_Item Customer.City
            Set Label to "City/State/Zip:"
            Set Size to 12 84
            Set Location to 53 63
            Set peAnchors to anTopLeftRight
            Set Label_Col_Offset to 2
            Set Label_Justification_Mode to jMode_Right
        End_Object

        Object oCustomer_State is a dbForm
            Entry_Item Customer.State
            Set Size to 12 20
            Set Location to 53 155
            Set peAnchors to anTopRight
        End_Object

        Object oCustomer_Zip is a dbForm
            Entry_Item Customer.Zip
            Set Size to 12 60
            Set Location to 53 183
            Set peAnchors to anTopRight
        End_Object

        Object oOrderHeader_Ordered_By is a dbForm
            Entry_Item OrderHea.Ordered_By
            Set Label to "Ordered By:"
            Set Size to 12 67
            Set Location to 39 299
            Set peAnchors to anTopRight
            Set Label_Col_Offset to 2
            Set Label_Justification_Mode to jMode_Right
        End_Object

        Object oOrderHeader_Salesperson_ID is a dbForm
            Entry_Item SalesP.Id
            Set Label to "Salesperson ID:"
            Set Size to 12 40
            Set Location to 53 299
            Set peAnchors to anTopRight
            Set Label_Col_Offset to 2
            Set Label_Justification_Mode to jMode_Right
        End_Object

        Object oOrderHeader_Terms is a dbComboForm
            Entry_Item OrderHea.Terms
            Set Label to "Terms:"
            Set Size to 12 85
            Set Location to 67 63
            Set peAnchors to anTopLeft
            Set Form_Border to 0
            Set Label_Col_Offset to 2
            Set Label_Justification_Mode to jMode_Right

        End_Object

        Object oOrderHeader_Ship_Via is a dbComboForm
            Entry_Item OrderHea.Ship_Via
            Set Label to "Ship Via:"
            Set Size to 12 103
            Set Location to 67 183
            Set peAnchors to anTopRight
            Set Form_Border to 0
            Set Label_Col_Offset to 2
            Set Label_Justification_Mode to jMode_Right

        End_Object
    End_Object

    Object oOrderDetail_Grid is a cDbCJGrid
        Set Server to OrderDtl_DD
        Set Ordering to 1
        Set Size to 64 377
        Set Location to 94 3
        Set peAnchors to anAll
        Set pbAllowInsertRow to False
        Set pbRestoreLayout to False
        Set psLayoutSection to "OrderView_oOrderDetail_Grid2"
        Set piLayoutBuild to 6
        Set pbHeaderPrompts to True

        On_Key Key_F11 Send Request_InsertRow

        Object oMark is a cCJGridColumnRowIndicator
        End_Object

        Object oInventory_Item_ID is a cDbCJGridColumn
            Entry_Item Invt.Item_ID
            Set piWidth to 91
            Set psCaption to "Item ID"
            Set psImage to "ActionPrompt.ico"
        End_Object

        Object oInventory_Description is a cDbCJGridColumn
            Entry_Item Invt.Description
            Set piWidth to 213
            Set psCaption to "Description"
        End_Object

        Object oInventory_Unit_Price is a cDbCJGridColumn
            Entry_Item Invt.Unit_Price
            Set piWidth to 53
            Set psCaption to "Unit Price"
        End_Object

        Object oOrderDetail_Qty_Ordered is a cDbCJGridColumn
            Entry_Item OrderDtl.Qty_Ordered
            Set piWidth to 50
            Set psCaption to "Quantity"
        End_Object

        Object oOrderDetail_Price is a cDbCJGridColumn
            Entry_Item OrderDtl.Price
            Set piWidth to 62
            Set psCaption to "Price"
        End_Object

        Object oOrderDetail_Extended_Price is a cDbCJGridColumn
            Entry_Item OrderDtl.Extended_Price
            Set piWidth to 81
            Set psCaption to "Total"
        End_Object

    End_Object

    Object oOrderHeader_Order_Total is a dbForm
        Entry_Item OrderHea.Order_Total
        Set Label to "Order Total:"
        Set Size to 12 60
        Set Location to 161 307
        Set peAnchors to anBottomRight
        Set Label_Col_Offset to 3
        Set Label_Justification_Mode to jMode_Right
    End_Object


    // Change:   Create custom confirmation messages for save and delete
    //           We must create the new functions and assign verify messages
    //           to them.
    Function Confirm_Delete_Order Returns Integer
        Integer iRetVal
        Get Confirm "Delete Entire Order?" to iRetVal
        Function_Return iRetVal
    End_Function

    // Only confirm on the saving of new records
    Function Confirm_Save_Order Returns Integer
        Integer iNoSave iSrvr
        Boolean bOld
        Get Server to iSrvr
        Get HasRecord of iSrvr to bOld
        If not bOld Begin
            Get Confirm "Save this NEW order header?" to iNoSave
        End
        Function_Return iNoSave
    End_Function

    // Define alternate confirmation Messages
    Set Verify_Save_MSG       to (RefFunc(Confirm_Save_Order))
    Set Verify_Delete_MSG     to (RefFunc(Confirm_Delete_Order))
    Set Auto_Clear_DEO_State  to False // don't clear Header on save

End_Object
