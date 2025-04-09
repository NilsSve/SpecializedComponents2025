Use Windows.pkg
Use DFClient.pkg
Use Customer.DD
Use cDbCJGrid.pkg
Use cdbCJGridColumn.pkg

Activate_View Activate_oCustomerStaticList For oCustomerStaticList
Object oCustomerStaticList is a dbView
    Object oCustomer_DD is a Customer_DataDictionary
    End_Object
    
    Set Main_DD to oCustomer_DD
    Set Server to oCustomer_DD
    
    Set Border_Style to Border_Thick
    Set Size to 201 300
    Set Location to 2 2
    Set Label to "Customer Static List"
    Set piMinSize to 180 250
    Set pbAutoActivate to True
    
    Object oCustomerGrid is a cDbCJGrid
        Set Size to 178 297
        Set Location to 2 1
        Set peAnchors to anAll
        Set pbHeaderReorders to True
        Set pbHeaderTogglesDirection to True
        Set pbStaticData to True
        Set Auto_Fill_State to False
        Set pbSelectionEnable to True
        Set pbUseAlternateRowBackgroundColor to True
        Set pbUseFocusCellRectangle to False
        //        Set pbMultipleSelection to True
        
        // if you want to provide your own data, do so in activating
        Procedure Activating
            Send LoadData
        End_Procedure
        
        Object oCustomer_Customer_Number is a cDbCJGridColumn
            Entry_Item Customer.Customer_Number
            Set piWidth to 51
            Set psCaption to "Number"
            
            Function OnGetTooltip Integer iRow String sValue String sText Returns String
                Get BuildToolTip iRow to sText
                Function_Return sText
            End_Function
        End_Object
        
        Object oCustomer_Name is a cDbCJGridColumn
            Entry_Item Customer.Name
            Set piWidth to 196
            Set psCaption to "Customer Name"
            
            Function OnGetTooltip Integer iRow String sValue String sText Returns String
                Get BuildToolTip iRow to sText
                Function_Return sText
            End_Function
        End_Object
        
        Object oCustomer_State is a cDbCJGridColumn
            Entry_Item Customer.State
            Set piWidth to 77
            Set psCaption to "St."
            Set pbComboButton to True
            
            Function OnGetTooltip Integer iRow String sValue String sText Returns String
                Get BuildToolTip iRow to sText
                Function_Return sText
            End_Function
            
            Procedure OnEntry
                Set piFocusCellForeColor of oCustomerGrid to clBlack
            End_Procedure
            
            Procedure OnExit
                Set piFocusCellForeColor of oCustomerGrid to clNone
            End_Procedure
            
        End_Object
        
        Object oCustomer_Zip is a cDbCJGridColumn
            Entry_Item Customer.Zip
            Set piWidth to 71
            Set psCaption to "Zip"
            
            Function OnGetTooltip Integer iRow String sValue String sText Returns String
                Get BuildToolTip iRow to sText
                Function_Return sText
            End_Function
        End_Object
        
        Object oCustomer_Status is a cDbCJGridColumn
            Entry_Item Customer.Status
            Set piWidth to 50
            Set psCaption to "Active?"
            Set pbCheckbox to True
            
            Function OnGetTooltip Integer iRow String sValue String sText Returns String
                Get BuildToolTip iRow to sText
                Function_Return sText
            End_Function
        End_Object
        
        // load customized static data into the datasource. This shows how you can populate a DEO grid
        // with custom data which bypasses the normal cached / constrained finding the datasource
        // normally does.
        Procedure LoadData
            Handle hoServer hoDataSource
            Boolean bFound
            tDataSourceRow[] DataSource
            Integer iRows iFile
            Get Server to hoServer
            Get Main_File of hoServer to iFile
            Send Request_Read of hoServer FIRST_RECORD iFile 1
            Move (Found) to bFound
            Get phoDataSource to hoDataSource
            While bFound
                If (Customer.State<>"CA") Begin
                    // creates a datasourcerow based on current buffer data
                    Get CreateDataSourceRow of hoDataSource to DataSource[iRows]
                    Increment iRows
                End
                Send Request_Read of hoServer GT iFile 1
                Move (Found) to bFound
            Loop
            Send InitializeData DataSource
            Send MovetoFirstRow
        End_Procedure
        
        //Procedure ProcessSelectedItems
        //    Integer[] SelRows
        //    Integer i iSels iRow
        //    String sName
        //    Handle hoDataSource
        //    tDataSourceRow[] MyData
        //    Get GetIndexesForSelectedRows to SelRows
        //    Get phoDataSource to hoDataSource
        //    Get DataSource of hoDataSource to MyData
        //    Move (SizeOfArray(SelRows)) to iSels
        //    For i from 0 to (iSels-1)
        //        Move SelRows[i] to iRow
        //        Move MyData[iRow].sValue[1] to sName
        //        Showln sName
        //    Loop
        //End_Procedure
        
        
        Function BuildToolTip Integer iRow Returns String
            String sNum sName sState sZip sStatus sCr sText
            
            Get RowValue of oCustomer_Customer_Number iRow to sNum
            Get RowValue of oCustomer_Name iRow to sName
            Get RowValue of oCustomer_State iRow to sState
            Get RowValue of oCustomer_Zip iRow to sZip
            Get RowValue of oCustomer_Status iRow to sStatus
            If (sStatus = "Y") Begin
                Move "Active" to sStatus
            End
            Else Begin
                Move "Not Active" to sStatus
            End
            
            Move (Character(13)) to sCr
            Move ("Customer:" + sNum + sCr + sName + sCr +  sState + ", " + sZip + sCr + sStatus) to sText
            
            Function_Return sText
        End_Function
        
    End_Object
    
    
    
    Object oRefresh is a Button
        Set Location to 185 245
        Set Label to 'Refresh'
        Set peAnchors to anBottomRight
        
        Procedure OnClick
            //            Send ProcessSelectedItems of oCustomerGrid
            Send ResetGrid of oCustomerGrid
            Send LoadData  of oCustomerGrid
        End_Procedure
        
    End_Object
    
End_Object
