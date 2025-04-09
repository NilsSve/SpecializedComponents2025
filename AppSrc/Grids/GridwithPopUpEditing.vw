Use Windows.pkg
Use DFClient.pkg
Use StdFont.pkg
Use cCJGrid.pkg
Use cCJGridColumnRowIndicator.pkg
Use Grids\DataPopup.dg

Deferred_View Activate_oGridwithPopUpEditing For ;
Object oGridwithPopUpEditing is a dbView
    Set Border_Style to Border_Thick
    Set Size to 243 508
    Set Location to 2 2
    Set Label to "Regular Grid with pop up editing"
    Set piMinSize to 170 400
    
    Object oGrid is a cCJGrid
        Set Size to 230 408
        Set Location to 7 9
        Set peAnchors to anAll
        Set pbAutoAppend to False
        Set pbFocusSubItems to False
        Set pbSelectionEnable to True
        Set pbAllowEdit to False
        
        Object oName is a cCJGridColumn
            Set psCaption to "Name"
            Set piWidth to 95
            Set psImage to "Columns.ico"
            Set piMinimumWidth to 5
            Set pbAllowDrag to False
        End_Object
        
        Object oType is a cCJGridColumn
            
            Object oSpecialFont is a cComStdFont
            End_Object
            
            Set psCaption to "Type"
            Set piWidth to 80
            Set psImage to "Table.bmp"
            
        End_Object
        
        Object oSize is a cCJGridColumn
            Set psCaption to "Size"
            Set piWidth to 50
            Set peTextAlignment to xtpAlignmentRight
        End_Object
        
        Object oMainIndex is a cCJGridColumn
            Property Integer piImage 0
            
            Set psCaption to "Main Index"
            Set piWidth to 70
            Set peIconAlignment to xtpAlignmentIconRight
            Set peTextAlignment to xtpAlignmentCenter
            
            Procedure OnSetDisplayMetrics Handle hoGridItemMetrics Integer iRow String sValue
                Integer iImage
                If (sValue<>"") Begin
                    Get piImage to iImage
                    Set ComItemIcon of hoGridItemMetrics to iImage
                End
            End_Procedure
        End_Object
        
        Object oCalculatedSize is a cCJGridColumn
            Set psCaption to "Size x 2"
            Set piWidth to 55
            Set peDataType to 6
        End_Object
        
        Object oNulls is a cCJGridColumn
            Set psCaption to "Nulls"
            Set piWidth to 40
            Set pbCheckbox to True
            Set peIconAlignment to xtpAlignmentIconCenter
        End_Object
        
        Object oDescription is a cCJGridColumn
            Set psCaption to "Description"
            Set piWidth to 416
            Set TextColor to clBlue
        End_Object
        
        Function CreateRow String sName String sType Integer iLen String sIndex Boolean bNull String sDescription Returns tDataSourceRow
            tDataSourceRow TheRow
            Integer iSizeX2
            
            If (Uppercase(sType)="DATETIME") Begin
                Move 6 to iSizeX2
            End
            Else Begin
                Move (iLen * 2) to iSizeX2
            End
            
            Move sName to TheRow.sValue[0]
            Move sType to TheRow.sValue[1]
            Move iLen to TheRow.sValue[2]
            Move sIndex to TheRow.sValue[3]
            Move iSizeX2 to TheRow.sValue[4]
            Move bNull to TheRow.sValue[5]
            Move sDescription to TheRow.sValue[6]
            Function_Return TheRow
        End_Function
        
        Procedure InitializeMyGrid
            tDataSourceRow[] DataSource
            tDataSourceRow TheRow
            Integer iImage
            
            // Add images to image manager....
            Get AddImage "ActionAddIndex.ico" 0 to iImage
            Set piImage of oMainIndex to iImage
            
            // now let's create some data.
            Get CreateRow "Order_Num" "int" 6 "Index.1" True "Order number (automatically assigned)."  to DataSource[0]
            Get CreateRow "Date" "datetime" 6 "" True "Date of order."  to DataSource[1]
            Get CreateRow "SalesID" "int" 6 "Index.2" False "Sales person ID"  to DataSource[2]
            Get CreateRow "CustomerID" "int" 6 "Index.3" False "Customer ID."  to DataSource[3]
            Get CreateRow "Address" "char" 30 "" True "Customer's street address."  to DataSource[4]
            Get CreateRow "City" "char" 15 "" False "Customer address - city."  to DataSource[5]
            Get CreateRow "Country" "char" 20 "" True "Customer address - country."  to DataSource[6]
            Get CreateRow "Phone" "char" 15 "" False "Phone number."  to DataSource[7]
            Get CreateRow "Mobile" "char" 15 "" False "Mobile Phone number."  to DataSource[8]
            Get CreateRow "mail" "char" 20 "" False "E-mail address."  to DataSource[9]
            
            Send InitializeData DataSource
            
        End_Procedure
        
        Procedure AppendData
            Handle hoDataSource
            tDataSourceRow[] TheDataSource
            tDataSourceRow TheRow
            Integer i
            
            Get phoDataSource to hoDataSource
            Get DataSource of hoDataSource to TheDataSource
            Move (SizeOfArray(TheDataSource)) to i
            
            // now let's create some data.
            Get CreateRow "Order_Num" "int" 6 "Index.1" True "Order number (automatically assigned)."  to TheDataSource[i+0]
            Get CreateRow "Date" "datetime" 6 "" True "Date of order."  to TheDataSource[i+1]
            Get CreateRow "SalesID" "int" 6 "Index.2" False "Sales person ID"  to TheDataSource[i+2]
            Get CreateRow "CustomerID" "int" 6 "Index.3" False "Customer ID."  to TheDataSource[i+3]
            Get CreateRow "Address" "char" 30 "" True "Customer's street address."  to TheDataSource[i+4]
            Get CreateRow "City" "char" 15 "" False "Customer address - city."  to TheDataSource[i+5]
            Get CreateRow "Country" "char" 20 "" True "Customer address - country."  to TheDataSource[i+6]
            Get CreateRow "Phone" "char" 15 "" False "Phone number."  to TheDataSource[i+7]
            Get CreateRow "Mobile" "char" 15 "" False "Mobile Phone number."  to TheDataSource[i+8]
            Get CreateRow "mail" "char" 20 "" False "E-mail address."  to TheDataSource[i+9]
            
            Send InitializeData TheDataSource
            
        End_Procedure
        
        
        // shows how to process the data
        Procedure ProcessData
            Handle hoDataSource
            tDataSourceRow[] TheDataSource
            tDataSourceRow TheRow
            Integer i iRows
            
            Get phoDataSource to hoDataSource
            Get DataSource of hoDataSource to TheDataSource
            Move (SizeOfArray(TheDataSource)) to iRows
            For i From 0 to (iRows-1)
                Showln TheDataSource[i].sValue[0]
            Loop
            
        End_Procedure
        
        
        Procedure Activating
            Forward Send Activating
            Send InitializeMyGrid
        End_Procedure
        
        // normally a grid saves or clears data upon exit (i.e., it treats it like a row change)
        // but we will not do that here. We make this a funciton so we can see where we are going.
        Function ShouldCommitOnObjectExit Handle hoDestination Returns Boolean
            Function_Return False
        End_Function
        
        Procedure OnRowDoubleClick Integer iRow Integer iColumn
            Boolean bOk
            Forward Send OnRowDoubleClick iRow iColumn
            Get EditRowPopup to bOk
        End_Procedure
        
        // popup an edit panel for the selected row. Returns False if cancelled
        Function EditRowPopup Returns Boolean
            Boolean bOk
            tTableDataLine DataLine
            Integer iSizeX2
            Get SelectedRowValue of oName to DataLine.sName
            Get SelectedRowValue of oType to DataLine.sType
            Get SelectedRowValue of oSize to DataLine.iSize
            Get SelectedRowValue of oMainIndex to DataLine.sMain
            Get SelectedRowValue of oNulls to DataLine.bNull
            Get SelectedRowValue of oDescription to DataLine.sDescription
            
            Get GetTableData of oDataPopup (&DataLine) to bOk
            
            If bOk Begin
                If (Uppercase(DataLine.sType)="DATETIME") Begin
                    Move 6 to DataLine.iSize
                    Move 6 to iSizeX2
                End
                Else Begin
                    Move (DataLine.iSize * 2) to iSizeX2
                End
                Send UpdateCurrentValue of oName  DataLine.sName
                Send UpdateCurrentValue of oType  DataLine.sType
                Send UpdateCurrentValue of oSize  DataLine.iSize
                Send UpdateCurrentValue of oCalculatedSize iSizeX2
                Send UpdateCurrentValue of oMainIndex DataLine.sMain
                Send UpdateCurrentValue of oNulls  (If(DataLine.bNull,1,0))
                Send UpdateCurrentValue of oDescription DataLine.sDescription
                
                Send Request_Save
            End
            Function_Return bOk
        End_Function
        
        // add data for a new row. If edit is cancelled, close the row
        Procedure EditNewRow
            Boolean bOk
            Get EditRowPopup to bOk
            If not bOk Begin
                Send Request_Delete
            End
        End_Procedure
        
        Function Verify_Delete Returns Integer
            Handle hoDataSource
            Boolean bCancel bNew
            Integer eRet
            Get phoDataSource to hoDataSource
            Get IsSelectedRowNew of hoDataSource to bNew
            If not bNew Begin
                Get YesNo_Box "Delete this Row" "Delete Confimration" to eRet
                Move (eRet=MBR_No) to bCancel
            End
            Function_Return bCancel
        End_Function
        
    End_Object
    
    
    Object oEditRow is a Button
        Set Size to 14 81
        Set Location to 7 424
        Set Label to "Edit Row"
        Set peAnchors to anTopRight
        
        // fires when the button is clicked
        Procedure OnClick
            Boolean bOk
            Send Activate of oGrid
            Get EditRowPopup of oGrid to bOk
        End_Procedure
        
    End_Object
    
    Object oInsert_btn is a Button
        Set Size to 14 81
        Set Location to 24 424
        Set Label to "Insert Row"
        Set peAnchors to anTopRight
        
        // fires when the button is clicked
        Procedure OnClick
            Send Activate of oGrid
            Send Request_InsertRow of oGrid
            Send EditNewRow of oGrid
        End_Procedure
        
    End_Object
    
    Object oAppend_btn is a Button
        Set Size to 14 81
        Set Location to 40 424
        Set Label to "Add row to end"
        Set peAnchors to anTopRight
        
        // fires when the button is clicked
        Procedure OnClick
            Send Activate of oGrid
            Send Request_AppendRow of oGrid
            Send EditNewRow of oGrid
        End_Procedure
    End_Object
    
    Object oRemove_btn is a Button
        Set Size to 14 81
        Set Location to 56 424
        Set Label to "Remove Row"
        Set peAnchors to anTopRight
        
        // fires when the button is clicked
        Procedure OnClick
            Send Activate of oGrid
            Send Request_Delete of oGrid
        End_Procedure
        
    End_Object
    
    Object oRestoreRow_btn is a Button
        Set Size to 14 81
        Set Location to 72 424
        Set Label to "Reset Row"
        Set peAnchors to anTopRight
        
        // fires when the button is clicked
        Procedure OnClick
            Boolean bCancel
            Get RestoreSelectedRow of oGrid to bCancel
            Send DeferredRedraw of oGrid
        End_Procedure
        
    End_Object
    
    Object oResetColumns_btn is a Button
        Set Size to 14 81
        Set Location to 94 424
        Set Label to "Restore Column Layout"
        Set peAnchors to anTopRight
        
        // fires when the button is clicked
        Procedure OnClick
            Send RestoreLayout of oGrid
        End_Procedure
        
    End_Object
    
    Object oRefresh is a Button
        Set Size to 14 81
        Set Location to 110 424
        Set Label to "Reload Data"
        Set peAnchors to anTopRight
        
        // fires when the button is clicked
        Procedure OnClick
            Send InitializeMyGrid of oGrid
        End_Procedure
    End_Object
    
    Object oAppend_btn is a Button
        Set Size to 14 81
        Set Location to 126 424
        Set Label to "Append Data to Grid"
        Set peAnchors to anTopRight
        
        // fires when the button is clicked
        Procedure OnClick
            Send AppendData to oGrid
        End_Procedure
    End_Object
    
    Object oProcessData is a Button
        Set Size to 14 81
        Set Location to 142 424
        Set Label to "Process Data"
        Set peAnchors to anTopRight
        
        // fires when the button is clicked
        Procedure OnClick
            Send ProcessData of oGrid
        End_Procedure
    End_Object
    
Cd_End_Object
