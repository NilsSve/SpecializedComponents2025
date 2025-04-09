Use Windows.pkg
Use DFClient.pkg
Use StdFont.pkg
Use cCJGrid.pkg
Use cCJGridColumnRowIndicator.pkg

Deferred_View Activate_oGridwithInPlaceEditing For ;
Object oGridwithInPlaceEditing is a dbView
    Set Label to  "Regular Grid with in place Editing"
    Set Border_Style to Border_Thick
    Set Size to 243 508
    Set Location to 2 2
    Set piMinSize to 170 400
    
    Object oGrid is a cCJGrid
        Set Size to 230 408
        Set Location to 7 9
        Set peAnchors to anAll
        Set pbShowFooter to True
        Set piFreezeColumnsCount to 2
        Set pbAutoAppend to False
        
        Set psNoFieldsAvailableText to "Field Chooser"
        
        Object oRowIndicator is a cCJGridColumnRowIndicator
        End_Object
        
        Object oName is a cCJGridColumn
            Set psCaption to "Name"
            Set piWidth to 95
            Set psImage to "Columns.ico"
            Set pbDrawFooterDivider to False
            Set piMinimumWidth to 5
            Set pbAllowDrag to False
        End_Object
        
        Object oType is a cCJGridColumn
            
            Object oSpecialFont is a cComStdFont
            End_Object
            
            Set psCaption to "Type"
            Set piWidth to 80
            Set psImage to "Table.bmp"
            Set pbComboButton to True
            Set pbComboEntryState to False
            
            Send ComboAddItem "Int" 0
            Send ComboAddItem "Char" 2
            Send ComboAddItem "DateTime" 3
            Send ComboAddItem "Number" 4
            Send ComboAddItem "Binary" 5
            Send ComboAddItem "Overlap" 6
            Send ComboAddItem "Text" 7
            
            Function InitialValue Returns String
                Function_Return "Char"
            End_Function
            
            Procedure OnSetDisplayMetrics Handle hoGridItemMetrics Integer iRow String sValue
                Variant vFont
                If (Uppercase(sValue) = "DATETIME") Begin
                    Get ComFont of hoGridItemMetrics to vFont
                    Set pvComObject of oSpecialFont to vFont
                    Set ComItalic of oSpecialFont to True
                End
            End_Procedure
            
            // when this changes we may need to change size and calculated size
            Procedure OnEndEdit String sOldValue String sNewValue
                Integer iSize
                If (sOldValue<>sNewValue) Begin
                    If (Uppercase(sNewValue)="DATETIME") Begin
                        Move 6 to iSize
                        Send UpdateCurrentValue of oSize iSize
                    End
                    Else Begin
                        Get SelectedRowValue of oSize to iSize
                        Move (iSize * 2) to iSize
                    End
                    Send UpdateCurrentValue of oCalculatedSize iSize
                End
                
            End_Procedure
            
        End_Object
        
        Object oSize is a cCJGridColumn
            Set psCaption to "Size"
            Set piWidth to 50
            Set peTextAlignment to xtpAlignmentRight
            Set psFooterText to "Total Size:"
            Set piMaxLength to 2
            
            // if this is a date time row we want to use a different color so they know
            // it cannot be edited (see CanEditColumn)
            Procedure OnSetDisplayMetrics Handle hoGridItemMetrics Integer iRow String sValue
                String sType
                Get RowValue of oType iRow to sType
                If (Uppercase(sType)="DATETIME") Begin
                    Set ComForeColor of hoGridItemMetrics to clDkGray
                End
                Else If (Integer(sValue) >= 20) Begin
                    Set ComForeColor of hoGridItemMetrics to clRed
                End
            End_Procedure
            
            // update the calculated size
            Procedure OnEndEdit String sOldValue String sNewValue
                If (sOldValue<>sNewValue) Begin
                    Send UpdateCurrentValue of oCalculatedSize (sNewValue * 2)
                End
            End_Procedure
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
            Set pbEditable to False
            
        End_Object
        
        Object oNulls is a cCJGridColumn
            Set psCaption to "Allow Nulls?"
            Set piWidth to 40
            Set pbCheckbox to True
            Set peIconAlignment to xtpAlignmentIconCenter
            
            Function OnGetTooltip Integer iRow String sValue String sText Returns String
                String sRetVal
                Forward Get OnGetTooltip iRow sValue sText to sRetVal
                Move "if checked, nulls are allowed" to sRetVal
                Function_Return sRetVal
            End_Function
        End_Object
        
        Object oDescription is a cCJGridColumn
            Set psCaption to "Description"
            Set piWidth to 416
            Set TextColor to clBlue
            //            Set pbMultiLine to True
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
            
            Move sName to TheRow.sValue[1]
            Move sType to TheRow.sValue[2]
            Move iLen to TheRow.sValue[3]
            Move sIndex to TheRow.sValue[4]
            Move iSizeX2 to TheRow.sValue[5]
            Move bNull to TheRow.sValue[6]
            Move sDescription to TheRow.sValue[7]
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
        
        // a quick way to make the grid larger
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
                Showln TheDataSource[i].sValue[1]
            Loop
            
        End_Procedure
        
        
        Procedure Activating
            Forward Send Activating
            Send InitializeMyGrid
        End_Procedure
        
        // special logic to stop edits at the cell level. If the datatype
        // is datetime, we don't allow editing of the size cell. This restricts editing
        // at the cell level.
        Function CanEditColumn Integer iCol Returns Boolean
            String sValue
            Boolean bCanDo
            Integer iRow iSizeCol
            Handle hoDataSource
            Forward Get CanEditColumn iCol to bCanDo
            If (bCanDo) Begin
                Get piColumnId of oSize to iSizeCol
                If (iCol=iSizeCol) Begin
                    Get SelectedRowValue of oType to sValue
                    If (Uppercase(sValue)="DATETIME") Begin
                        Move False to bCanDo
                    End
                End
            End
            Function_Return bCanDo
        End_Function
        
        // normally a grid saves or clears data upon exit (i.e., it treats it like a row change)
        // but we will not do that here. We make this a funciton so we can see where we are going.
        Function ShouldCommitOnObjectExit Handle hoDestination Returns Boolean
            Function_Return False
        End_Function
        
        Object oCustomHeaderContext is a cCJContextMenu
            
            Object oFieldChooser is a cCJGridFieldChooserMenuItem
            End_Object
            
            Object oLayout is a cCJGridRestoreLayoutMenuItem
            End_Object
            
            Object oAutoSizeToggle is a cCJMenuItem
                Set pbControlBeginGroup to True
                Set psCaption to "AutoSize Columns"
                
                Procedure OnExecute Variant vCommandBarControl
                    Handle hoFocus
                    Boolean bAuto
                    Get IsChecked to bAuto
                    Get Focus to hoFocus
                    Set pbAutoColumnSizing of hoFocus to (not(bAuto))
                End_Procedure
                
                Function IsChecked Returns Boolean
                    Handle hoFocus
                    Boolean bAuto
                    Get Focus to hoFocus
                    Get pbAutoColumnSizing of hoFocus to bAuto
                    Function_Return (bAuto)
                End_Function
            End_Object
            
            Object oBestFit is a cCJMenuItem
                Set pbControlBeginGroup to True
                Set psCaption to "Best Fit Column"
                
                Procedure OnExecute Variant vCommandBarControl
                    Handle hoFocus hoCol
                    Get Focus to hoFocus
                    Get phoContextMenuColumn of hoFocus to hoCol
                    Send ComBestFit of hoCol
                End_Procedure
                
                Function IsEnabled Returns Boolean
                    Handle hoFocus
                    Handle hoCol
                    Get Focus to hoFocus
                    Get phoContextMenuColumn of hoFocus to hoCol
                    Function_Return (hoCol)
                End_Function
                
                
            End_Object
            
            Object oHideCol is a cCJMenuItem
                Set psCaption to "Hide Column"
                
                Procedure OnExecute Variant vCommandBarControl
                    Handle hoFocus hoCol
                    Get Focus to hoFocus
                    Get phoContextMenuColumn of hoFocus to hoCol
                    Set pbVisible of hoCol to False
                End_Procedure
                
                Function IsEnabled Returns Boolean
                    Handle hoFocus hoCol
                    Boolean bAllow bAllow1
                    Get Focus to hoFocus
                    Get phoContextMenuColumn of hoFocus to hoCol
                    Get pbAllowColumnRemove of hoFocus to bAllow
                    If (hoCol) Begin
                        Get pbAllowDrag of hoCol to bAllow1
                    End
                    Function_Return (hoCol<>0 and bAllow and bAllow1)
                End_Function
                
            End_Object
            
            Object oBestFit is a cCJMenuItem
                Set psCaption to "Show All Columns"
                
                Procedure OnExecute Variant vCommandBarControl
                    Handle hoFocus hoCol
                    Get Focus to hoFocus
                    Send ShowAllColumns of hoFocus
                End_Procedure
                
            End_Object
            
            Object oFreeze is a cCJGridFreezeColumnMenuItem
                Set pbControlBeginGroup to True
            End_Object
            
            
        End_Object
        
        Set phoHeaderContextMenu to (oCustomHeaderContext)
        
        Procedure ShowAllColumns
            Handle hoCol
            Integer i iCols
            Boolean bShow bVis
            Get ColumnCount to iCols
            For i From 0 to (iCols-1)
                Get ColumnObject i to hoCol
                Get pbShowInFieldChooser of hoCol to bShow
                Get pbVisible of hoCol to bVis
                If (not(bVis) and bShow) Begin
                    Set pbVisible of hoCol to True
                End
            Loop
        End_Procedure
        
    End_Object
    
    
    Object oInsert_btn is a Button
        Set Size to 14 81
        Set Location to 6 424
        Set Label to "Insert Row"
        Set peAnchors to anTopRight
        
        // fires when the button is clicked
        Procedure OnClick
            Send Request_InsertRow of oGrid
        End_Procedure
        
    End_Object
    
    Object oAppend_btn is a Button
        Set Size to 14 81
        Set Location to 22 424
        Set Label to "Add row to end"
        Set peAnchors to anTopRight
        
        // fires when the button is clicked
        Procedure OnClick
            Send Request_AppendRow of oGrid
        End_Procedure
    End_Object
    
    Object oRemove_btn is a Button
        Set Size to 14 81
        Set Location to 38 424
        Set Label to "Remove Row"
        Set peAnchors to anTopRight
        
        // fires when the button is clicked
        Procedure OnClick
            Send Request_Delete of oGrid
        End_Procedure
        
    End_Object
    
    Object oRestoreRow_btn is a Button
        Set Size to 14 81
        Set Location to 54 424
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
        Set Location to 76 424
        Set Label to "Restore Column Layout"
        Set peAnchors to anTopRight
        
        // fires when the button is clicked
        Procedure OnClick
            Send RestoreLayout of oGrid
        End_Procedure
        
    End_Object
    
    Object oRefresh is a Button
        Set Size to 14 81
        Set Location to 92 424
        Set Label to "Reload Data"
        Set peAnchors to anTopRight
        
        // fires when the button is clicked
        Procedure OnClick
            Send InitializeMyGrid of oGrid
        End_Procedure
    End_Object
    
    Object oAppend_btn is a Button
        Set Size to 14 81
        Set Location to 108 424
        Set Label to "Append Data to Grid"
        Set peAnchors to anTopRight
        
        // fires when the button is clicked
        Procedure OnClick
            Send AppendData to oGrid
        End_Procedure
    End_Object
    
    Object oProcessData is a Button
        Set Size to 14 81
        Set Location to 124 424
        Set Label to "Process Data"
        Set peAnchors to anTopRight
        
        // fires when the button is clicked
        Procedure OnClick
            Send ProcessData of oGrid
        End_Procedure
    End_Object
    
Cd_End_Object
