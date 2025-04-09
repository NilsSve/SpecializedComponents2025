// This sample shows how to create and use a data aware ActiveX
// control. We imported the calendar control and created a data
// aware class for it. We use that object in this sample. See
// the comments cComDbCalendar.pkg for more!

Use dfClient.pkg
Use DataDict.pkg
Use dfEntry.pkg
Use dfSpnEnt.pkg
Use dfCEntry.pkg
Use cComDbCalendar.pkg
Use Windows.pkg
Use cDbCJGrid.pkg
Use cCJGridColumnRowIndicator.pkg

Use Vendor.DD
Use Invt.DD
Use Customer.DD
Use SalesP.DD
Use OrderHea.DD
Use OrderDtl.DD
Use cTextEdit.pkg


Deferred_View Activate_oOrderEntryView for ;
;
Object oOrderEntryView is a dbView
    Set Border_Style to Border_Thick
    Set Maximize_Icon to True
    Set Label to "Order Entry Calendar Sample"
    Set Location to 2 3
    Set Size to 174 523
    Set piMinSize to 174 523
    Set pbAutoActivate to True
    
    
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
    
    Object oDbContainer3d1 is a dbContainer3d
        Set Size to 85 377
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
            Set Location to 4 201
            Set peAnchors to anTopRight
            Set Label_Col_Offset to 2
            Set Label_Justification_Mode to jMode_Right
        End_Object
        
        Object oOrderHea_Order_Date is a dbSpinForm
            Entry_Item OrderHea.Order_Date
            Set Label to "Order Date:"
            Set Size to 13 67
            Set Location to 4 299
            Set peAnchors to anTopRight
            Set Label_Col_Offset to 2
            Set Label_Justification_Mode to jMode_Right
        End_Object
        
        Object oCustomer_Name is a dbForm
            Entry_Item Customer.Name
            Set Label to "Customer Name:"
            Set Size to 13 180
            Set Location to 18 63
            Set peAnchors to anTopLeftRight
            Set Label_Col_Offset to 2
            Set Label_Justification_Mode to jMode_Right
        End_Object
        
        Object oCustomer_Address is a dbForm
            Entry_Item Customer.Address
            Set Label to "Street Address:"
            Set Size to 13 180
            Set Location to 34 63
            Set peAnchors to anTopLeftRight
            Set Label_Col_Offset to 2
            Set Label_Justification_Mode to jMode_Right
        End_Object
        
        Object oCustomer_City is a dbForm
            Entry_Item Customer.City
            Set Label to "City/State/Zip:"
            Set Size to 13 84
            Set Location to 49 63
            Set peAnchors to anTopLeftRight
            Set Label_Col_Offset to 2
            Set Label_Justification_Mode to jMode_Right
        End_Object
        
        Object oCustomer_State is a dbForm
            Entry_Item Customer.State
            Set Size to 13 20
            Set Location to 49 155
            Set peAnchors to anTopRight
        End_Object
        
        Object oCustomer_Zip is a dbForm
            Entry_Item Customer.Zip
            Set Size to 13 60
            Set Location to 49 183
            Set peAnchors to anTopRight
        End_Object
        
        Object oOrderHea_Ordered_By is a dbForm
            Entry_Item OrderHea.Ordered_By
            Set Label to "Ordered By:"
            Set Size to 13 67
            Set Location to 34 299
            Set peAnchors to anTopRight
            Set Label_Col_Offset to 2
            Set Label_Justification_Mode to jMode_Right
        End_Object
        
        Object oOrderHea_Salesperson_ID is a dbForm
            Entry_Item Salesp.Id
            Set Label to "Salesperson ID:"
            Set Size to 13 40
            Set Location to 49 299
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
            Set Location to 64 183
            Set peAnchors to anTopRight
            Set Form_Border to 0
            Set Label_Col_Offset to 2
            Set Label_Justification_Mode to jMode_Right
        End_Object
        
    End_Object
    
    Object oDbContainer2 is a dbContainer3d
        Set Size to 168 139
        Set Location to 2 381
        Set peAnchors to anTopRight

// calendar control does not work in 64-bit Windows
#IFDEF Is$Win64 

        Object oNoCalendarTextEdit is a cTextEdit
            Set Size to 42 130
            Set Location to 40 3
            Set Label to ">>> Calendar Control NOT loaded <<<"
            Set Value to "The calendar control is an ActiveX that cannot be loaded in 64-bit applications."
            Set Enabled_State to False
            Set Read_Only_State to True
            Set Label_TextColor to clBlack
            Set Border_Style to Border_None
            Set Window_Style to WS_VSCROLL False
        End_Object
 

#ELSE       
        Object oOrderCalendar is a cComDbCalendar
            // WARNING: Do NOT modify this code.
            // The Embed_ActiveX_Resource...End_Embed_ActiveX_Resource code block
            // is generated and maintained by the Studio.
            Embed_ActiveX_Resource
            AAAIALQVAAB2FwAA0gcKAB4ADwAAgAAA/wAAAKAAEAAAgAAAoAABAAEAAgAAAAIAAAABAAAAAQAAAAEAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
            AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
            AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
            AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAALwCREIBAAVBcmlhbAEAAACQAURCAQAFQXJpYWwBAAAAvALA1AEABUFyaWFs.
            End_Embed_ActiveX_Resource
            
            Entry_Item Orderhea.Order_Date
            Set Size to 140 140
            Set Location to 3 -3
            
            // Notice that there is no code here. All the work is done in the
            // imported data aware ActiveX class.
            
            // Also note that that all of the standard DEO keys and features are
            // automatically built into this class. Such as:
            // 1. Standard key suppot (f4=prompt, f7, f78, f9=find, f2=save, etc.)
            // 2. Support for the tool bar buttons.
            // 3. You can change the date using the calendar - just select a day and
            //    save it. You can select the date from either of the two DEO date objects
            // 4. Synchronization with other DEO objects. The two date controls stay
            //    in synch. Change the date in the calendar and the date form changes.
            //    Use the date spin form and the calendar changes.
            //
            //
            // To learn more about this sample you want to look at the code and comments in:
            //       cComDbCalendar.pkg  and cComDbCalendar-original.pkg
            // (place you cursor over these file names, right click and select "Open file under Cursor")
            //
            
            // make today's date the initial date on the control
            Procedure Activating
                Date dToday
                
                Sysdate dToday
                Set ControlValue to dToday
            End_Procedure
            
            Function Value Integer iItem Returns String
                Integer iLocalItem
                String sReturnValue
                
                Move 0 to iLocalItem
                Forward Get Value iLocalItem to sReturnValue
                Function_Return sReturnValue
            End_Function
            
        End_Object

        
        Object oDatePrompt is a Button
            Set Label to "Prompt"
            Set Location to 144 47
            
            Procedure OnClick
                // we want this button to invoke a prompt list. Since the calendar is
                // data aware and understands the prompt message we simply need to.
                // 1) activate the calendar object, send the prompt message.
                Send Activate of oOrderCalendar
                Send Prompt   of oOrderCalendar
            End_Procedure
        End_Object
        
#ENDIF   
     
    End_Object
    
    Object oOrderDtl_Grid is a cDbCJGrid
        Set Server to OrderDtl_DD
        Set Ordering to 1
        Set Size to 63 377
        Set Location to 90 3
        Set peAnchors to anAll
        Set pbAllowInsertRow to False
        Set pbRestoreLayout to False
        Set psLayoutSection to "OrderView_oOrderDtl_Grid2"
        Set piLayoutBuild to 6
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
            Set piWidth to 213
            Set psCaption to "Description"
        End_Object
        
        Object oInvt_Unit_Price is a cDbCJGridColumn
            Entry_Item Invt.Unit_Price
            Set piWidth to 53
            Set psCaption to "Unit Price"
        End_Object
        
        Object oOrderDtl_Qty_Ordered is a cDbCJGridColumn
            Entry_Item OrderDtl.Qty_Ordered
            Set piWidth to 50
            Set psCaption to "Quantity"
        End_Object
        
        Object oOrderDtl_Price is a cDbCJGridColumn
            Entry_Item OrderDtl.Price
            Set piWidth to 62
            Set psCaption to "Price"
        End_Object
        
        Object oOrderDtl_Extended_Price is a cDbCJGridColumn
            Entry_Item OrderDtl.Extended_Price
            Set piWidth to 81
            Set psCaption to "Total"
        End_Object
        
    End_Object
    
    Object oOrderHea_Order_Total is a dbForm
        Entry_Item OrderHea.Order_Total
        Set Label to "Order Total:"
        Set Size to 13 60
        Set Location to 156 307
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
    
    // Define alternative confirmation Messages
    Set Verify_Save_MSG       to (RefFunc(Confirm_Save_Order))
    Set Verify_Delete_MSG     to (RefFunc(Confirm_Delete_Order))
    Set Auto_Clear_DEO_State  to False // don't clear Header on save
    
    
    
    // refresh is sent to containers. We will use that to control the detail grid and only
    // enable it when an order exists
    Procedure Refresh Integer eMode
        Boolean bChanged bRec
        Handle hoServer
        Get Server to hoServer
        Get HasRecord of hoServer to bRec
        Set Enabled_State of oOrderDtl_Grid to bRec
    End_Procedure
    
    
    
CD_End_Object

