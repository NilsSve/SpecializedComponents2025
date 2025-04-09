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


Deferred_View Activate_oOrderEntryLegacyStyle For ;
Object oOrderEntryLegacyStyle is a dbView
    Set Border_Style to Border_Thick
    Set Maximize_Icon to True
    Set Label to "Order Entry Legacy Style"
    Set Location to 2 3
    Set Size to 174 387
    Set piMinSize to 174 381
    
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
    End_Object
    
    Object OrderDtl_DD is a OrderDtl_DataDictionary
        Set DDO_Server to OrderHea_DD
        Set DDO_Server to Invt_DD
        Set Constrain_File to OrderHea.File_Number
    End_Object
    
    Set Main_DD to OrderHea_DD
    Set Server to OrderHea_DD
    
    Object oDbContainer3d1 is a dbContainer3d
        Set Size to 85 381
        Set Location to 2 3
        Set peAnchors to anTopLeftRight
        Object oOrderHea_Order_Number is a dbForm
            Entry_Item OrderHea.Order_Number
            Set Label to "Order Number:"
            Set Size to 13 42
            Set Location to 4 63
            Set peAnchors to anTopLeft
            Set Label_Col_Offset to 2
            Set Label_Justification_Mode to jMode_Right
            
        End_Object
        
        Object oOrderHea_Customer_Number is a dbForm
            Entry_Item Customer.Customer_Number
            Set Label to "Customer Number:"
            Set Size to 13 42
            Set Location to 4 205
            Set peAnchors to anTopRight
            Set Label_Col_Offset to 2
            Set Label_Justification_Mode to jMode_Right
            
        End_Object
        
        Object oOrderHea_Order_Date is a dbSpinForm
            Entry_Item OrderHea.Order_Date
            Set Label to "Order Date:"
            Set Size to 13 67
            Set Location to 4 303
            Set peAnchors to anTopRight
            Set Label_Col_Offset to 2
            Set Label_Justification_Mode to jMode_Right
        End_Object
        
        Object oCustomer_Name is a dbForm
            Entry_Item Customer.Name
            Set Label to "Customer Name:"
            Set Size to 13 184
            Set Location to 18 63
            Set peAnchors to anTopLeftRight
            Set Label_Col_Offset to 2
            Set Label_Justification_Mode to jMode_Right
        End_Object
        
        Object oCustomer_Address is a dbForm
            Entry_Item Customer.Address
            Set Label to "Street Address:"
            Set Size to 13 184
            Set Location to 34 63
            Set peAnchors to anTopLeftRight
            Set Label_Col_Offset to 2
            Set Label_Justification_Mode to jMode_Right
        End_Object
        
        Object oCustomer_City is a dbForm
            Entry_Item Customer.City
            Set Label to "City/State/Zip:"
            Set Size to 13 88
            Set Location to 49 63
            Set peAnchors to anTopLeftRight
            Set Label_Col_Offset to 2
            Set Label_Justification_Mode to jMode_Right
        End_Object
        
        Object oCustomer_State is a dbForm
            Entry_Item Customer.State
            Set Size to 13 20
            Set Location to 49 159
            Set peAnchors to anTopRight
        End_Object
        
        Object oCustomer_Zip is a dbForm
            Entry_Item Customer.Zip
            Set Size to 13 60
            Set Location to 49 187
            Set peAnchors to anTopRight
        End_Object
        
        Object oOrderHea_Ordered_By is a dbForm
            Entry_Item OrderHea.Ordered_By
            Set Label to "Ordered By:"
            Set Size to 13 67
            Set Location to 34 303
            Set peAnchors to anTopRight
            Set Label_Col_Offset to 2
            Set Label_Justification_Mode to jMode_Right
        End_Object
        
        Object oOrderHea_Salesperson_ID is a dbForm
            Entry_Item Salesp.Id
            Set Label to "Salesperson ID:"
            Set Size to 13 40
            Set Location to 49 303
            Set peAnchors to anTopRight
            Set Label_Col_Offset to 2
            Set Label_Justification_Mode to jMode_Right
        End_Object
        
        Object oOrderHea_Terms is a dbComboForm
            Entry_Item OrderHea.Terms
            Set Label to "Terms:"
            Set Size to 13 85
            Set Location to 64 63
            Set peAnchors to anTopLeft
            Set Form_Border to 0
            Set Label_Col_Offset to 2
            Set Label_Justification_Mode to jMode_Right
            
        End_Object
        
        Object oOrderHea_Ship_Via is a dbComboForm
            Entry_Item OrderHea.Ship_Via
            Set Label to "Ship Via:"
            Set Size to 13 103
            Set Location to 64 187
            Set peAnchors to anTopRight
            Set Form_Border to 0
            Set Label_Col_Offset to 2
            Set Label_Justification_Mode to jMode_Right
            
            Procedure Switch
                Boolean bCancel
                Get Save_Header to bCancel
                If not bCancel Begin
                    //Send Activate of oOrderDtl_Grid
                    Forward Send Switch
                End
            End_Procedure
            
        End_Object
        
    End_Object
    
    Object oOrderDtl_Grid is a cDbCJGrid
        Set Server to OrderDtl_DD
        Set Ordering to 1
        Set Size to 63 381
        Set Location to 90 3
        Set peAnchors to anAll
        Set pbAllowInsertRow to False
        Set pbRestoreLayout to True
        Set psLayoutSection to "OrderView_oOrderDtl_Grid2"
        Set piLayoutBuild to 6
        Set pbEditOnKeyNavigation to True
        Set pbEditOnClick to True
        Set pbHeaderPrompts to True
        
        
        On_Key Key_F11 Send Request_InsertRow
        
        Object oMark is a cCJGridColumnRowIndicator
        End_Object
        
        Object oInvt_Item_ID is a cDbCJGridColumn
            Entry_Item Invt.Item_ID
            Set piWidth to 91
            Set psCaption to "Item ID"
            Set psImage to "ActionPrompt.ico"
        End_Object
        
        Object oInvt_Description is a cDbCJGridColumn
            Entry_Item Invt.Description
            Set piWidth to 219
            Set psCaption to "Description"
        End_Object
        
        Object oInvt_Unit_Price is a cDbCJGridColumn
            Entry_Item Invt.Unit_Price
            Set piWidth to 56
            Set psCaption to "Unit Price"
        End_Object
        
        Object oOrderDtl_Qty_Ordered is a cDbCJGridColumn
            Entry_Item OrderDtl.Qty_Ordered
            Set piWidth to 50
            Set psCaption to "Quantity"
        End_Object
        
        Object oOrderDtl_Price is a cDbCJGridColumn
            Entry_Item OrderDtl.Price
            Set piWidth to 60
            Set psCaption to "Price"
        End_Object
        
        Object oOrderDtl_Extended_Price is a cDbCJGridColumn
            Entry_Item OrderDtl.Extended_Price
            Set piWidth to 80
            Set psCaption to "Total"
        End_Object
        
        Function OnPostEntering Returns Boolean
            Boolean bCancel
            Delegate Get Save_Header to bCancel
            Function_Return bCancel
        End_Function
        
        // augment to enable PostEntering only when needed - when there is a change
        Procedure OnEntering
            Handle hoSrvr
            Boolean bChanged
            Delegate Get Server to hoSrvr        // The Header DDO.
            Get Should_Save of hoSrvr to bChanged          // Are there any current changes?
            If ( bChanged)  Begin
                Set pbNeedPostEntering to True
            End
        End_Procedure
        
        
        // augment to not allow this when there is no header record
        Function CanAddRow Returns Boolean
            Boolean bChanged bRec bCanDo
            Handle hoServer
            Forward Get CanAddRow to bCanDo
            If bCanDo Begin
                Delegate Get Server to hoServer
                Get Should_Save of hoServer to bChanged
                Get HasRecord of hoServer to bRec
                Function_Return (not(bChanged) and bRec)
            End
        End_Function
        
    End_Object
    
    Object oOrderHea_Order_Total is a dbForm
        Entry_Item OrderHea.Order_Total
        Set Label to "Order Total:"
        Set Size to 13 60
        Set Location to 156 311
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
    
    
    // Change: Table entry checking - attempt to save header record
    //         before entering a table (this is called by table. Return
    //         a non-zero if the save failed (i.e., don't enter table)
    Function Save_Header Returns Integer
        Boolean bHasRec bChanged
        Handle hoSrvr
        
        Get Server to hoSrvr                 // The Header DDO.
        Get HasRecord of hoSrvr to bHasRec   // Do we have a record?
        Get Should_Save to bChanged          // Are there any current changes?
        
        // If there is no record and no changes we have an error.
        If ( not(bHasRec) and not(bChanged) ) Begin  // no rec
            //            Send UserError "You must First Create & Save Main Order Header" ""
            Function_Return 1
        End
        
        // Attempt to Save the current Record
        // request_save_no_clear does a save without clearing.
        Send Request_Save_No_Clear
        
        // The save succeeded if there are now no changes, and we
        // have a saved record. Should_save tells us if we've got changes.
        // We must check the data-sets hasRecord property to see if
        // we have a record. If it is not, we had no save.
        Get Should_Save to bChanged  // is a save still needed
        Get HasRecord of hoSrvr to bHasRec // current record of the DD
        // if no record or changes still exist, return an error code of 1
        If ( not(bHasRec) or (bChanged)) ;
            Function_Return 1
    End_Function
    
    //    // Only confirm on the saving of new records
    //    Function Confirm_Save_Order Returns Integer
    //        Integer iNoSave iSrvr
    //        Boolean bOld
    //        Get Server to iSrvr
    //        Get HasRecord of iSrvr to bOld
    //        If not bOld Begin
    //            Get Confirm "This will create a NEW order. Proceed?" to iNoSave
    //        End
    //        Function_Return iNoSave
    //    End_Function
    //
    //    // Define alternate confirmation Messages
    //    Set Verify_Save_MSG       to (RefFunc(Confirm_Save_Order))
    //    Set Verify_Delete_MSG     to (RefFunc(Confirm_Delete_Order))
    //
    //    // Change: Table entry checking - attempt to save header record
    //    //         before entering a table (this is called by table. Return
    //    //         a non-zero if the save failed (i.e., don't enter table)
    //    Function Save_Header Returns Integer
    //        Boolean bHasRec bChanged
    //        Handle hoSrvr
    //        Get Server to hoSrvr
    //        // Attempt to Save the current Record
    //        // request_save_no_clear does a save without clearing.
    //        Send Request_Save_No_Clear
    //
    //        // The save succeeded if there are now no changes, and we
    //        // have a saved record. Should_save tells us if we've got changes.
    //        // We must check the data-sets hasRecord property to see if
    //        // we have a record. If it is not, we had no save.
    //        Get Should_Save of hoSrvr to bChanged  // is a save still needed
    //        Get HasRecord of hoSrvr to bHasRec // current record of the DD
    //        // if no record or changes still exist, return an error code of 1
    //        If ( not(bHasRec) or (bChanged)) ;
    //            Function_Return 1
    //    End_Function  // Save_Header
    
    // refresh is now sent to containers so we will use that to control the print button and only
    // enable it when an order exists
    Procedure Refresh Integer eMode
        Boolean bChanged bRec
        Handle hoServer
        String sVal
        Get Server to hoServer
        Get HasRecord of hoServer to bRec
        Move ("Order Entry: " + If(bRec,("Current Order = " + String(OrderHea.Order_Number)), "*** New Order ***"))  to sVal
        Set Label to sVal
    End_Procedure
    
Cd_End_Object
