Use Windows.pkg
Use DFClient.pkg
Use Customer.DD
Use cDbCJGrid.pkg
Use cdbCJGridColumn.pkg
Use cCJGridColumnRowIndicator.pkg
Use dfEntry.pkg
Use dfcentry.pkg

Deferred_View Activate_oGridColorOptions For ;
Object oGridColorOptions is a dbView
    Object oCustomer_DD is a Customer_DataDictionary
    End_Object
    
    Set Main_DD to oCustomer_DD
    Set Server to oCustomer_DD
    
    Set Border_Style to Border_Thick
    Set Size to 220 466
    Set piMinSize to 210 350
    Set Location to 2 2
    Set Label to "Grid Color Options"
    
    Object oCustomerGrid is a cDbCJGrid
        Set Size to 213 332
        Set Location to 4 4
        Set peAnchors to anAll
        Set pbHeaderReorders to True
        Set pbHeaderTogglesDirection to True
        Set pbStaticData to True
        Set Auto_Fill_State to False
        
        // if you want to provide your own data, do so in activating
        Procedure Activating
            Send LoadData
        End_Procedure
        
        Object oCJGridColumnRowIndicator1 is a cCJGridColumnRowIndicator
        End_Object
        
        Object oCustomer_Customer_Number is a cDbCJGridColumn
            Entry_Item Customer.Customer_Number
            Set piWidth to 78
            Set psCaption to "Number"
        End_Object
        
        Object oCustomer_Name is a cDbCJGridColumn
            Entry_Item Customer.Name
            Set piWidth to 221
            Set psCaption to "Customer Name"
        End_Object
        
        Object oCustomer_State is a cDbCJGridColumn
            Entry_Item Customer.State
            Set piWidth to 118
            Set psCaption to "St."
            Set pbComboButton to True
            Property Integer piPrevColor
            
            Procedure OnEntry
                Integer iPrevColor
                
                Get piFocusCellForeColor of oCustomerGrid to iPrevColor
                Set piPrevColor to iPrevColor
                
                Set piFocusCellForeColor of oCustomerGrid to clBlack
            End_Procedure
            
            Procedure OnExit
                Integer iPrevColor
                
                Get piPrevColor to iPrevColor
                Set piFocusCellForeColor of oCustomerGrid to iPrevColor
            End_Procedure
            
        End_Object
        
        Object oCustomer_Status is a cDbCJGridColumn
            Entry_Item Customer.Status
            Set piWidth to 60
            Set psCaption to "Status"
            Set pbCheckbox to True
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
                // creates a datasourcerow based on current buffer data
                Get CreateDataSourceRow of hoDataSource to DataSource[iRows]
                Increment iRows
                Send Request_Read of hoServer GT iFile 1
                Move (Found) to bFound
            Loop
            Send InitializeData DataSource
            Send MovetoFirstRow
        End_Procedure
    End_Object
    
    Object oNavigateCellFocus_chkbx is a CheckBox
        Set Size to 10 111
        Set Location to 8 347
        Set Label to "Allow Focused Cell Navigation"
        Set peAnchors to anTopRight
        Set Checked_State to True
        
        Procedure OnChange
            Boolean bChecked
            
            Forward Send OnChange
            
            Get Checked_State to bChecked
            Set pbFocusSubItems of oCustomerGrid to bChecked
            
            Send Activate of oCustomerGrid
        End_Procedure
    End_Object
    
    Object oGroup1 is a Group
        Set Size to 67 122
        Set Location to 28 340
        Set Label to 'Focused cell highlight options'
        Set peAnchors to anTopRight
        
        Object oHighlightSelectedRow_chkbx is a CheckBox
            Set Size to 10 50
            Set Location to 14 7
            Set Label to "Highlight Selected Row"
            Set peAnchors to anTopRight
            
            Procedure OnChange
                Boolean bChecked
                
                Forward Send OnChange
                
                Get Checked_State to bChecked
                Set pbSelectionEnable of oCustomerGrid to bChecked
                
                Send LoadData of oCustomerGrid
                Send Activate of oCustomerGrid
            End_Procedure
        End_Object
        
        Object oFocusCellRectangle_chkbx is a CheckBox
            Set Size to 10 50
            Set Location to 29 7
            Set Label to "Use Focus Cell Rectangle"
            Set peAnchors to anTopRight
            Set Checked_State to True
            
            Procedure OnChange
                Boolean bChecked
                
                Forward Send OnChange
                
                Get Checked_State to bChecked
                Set pbUseFocusCellRectangle of oCustomerGrid to bChecked
                
                Send ComRedraw of oCustomerGrid
                Send Activate of oCustomerGrid
            End_Procedure
        End_Object
        
        Object oCustomFocusCellColors_chkbx is a CheckBox
            Set Size to 10 50
            Set Location to 46 7
            Set Label to "Use Custom Focus Cell Colors"
            Set peAnchors to anTopRight
            
            Procedure OnChange
                Boolean bChecked
                Integer iBackColor iForeColor
                
                Forward Send OnChange
                
                Get Checked_State to bChecked
                If (not(bChecked)) Begin
                    Set piFocusCellBackColor of oCustomerGrid to clNone
                    Set piFocusCellForeColor of oCustomerGrid to clNone
                End
                Else Begin
                    Set piFocusCellBackColor of oCustomerGrid to (RGB(153,217,234))
                    Set piFocusCellForeColor of oCustomerGrid to 10158087
                End
                Send ComRedraw of oCustomerGrid
                Send Activate of oCustomerGrid
            End_Procedure
        End_Object
    End_Object
    
    Object oGroup2 is a Group
        Set Size to 45 122
        Set Location to 100 340
        Set Label to "Other cell color options"
        Set peAnchors to anTopRight
        
        Object oShadeSortColumn_chkbx is a CheckBox
            Set Size to 10 50
            Set Location to 13 7
            Set Label to "Shade Sorted Column"
            Set peAnchors to anTopRight
            
            Procedure OnChange
                Boolean bChecked
                Integer iSortCol
                
                Forward Send OnChange
                
                Get Checked_State to bChecked
                Set pbShadeSortColumn of oCustomerGrid to bChecked
                
                // Sort by customer number column if no sort column was selected so we can see
                // what shaded Sort color looks like.
                If (bChecked) Begin
                    Get piSortColumn of oCustomerGrid to iSortCol
                    If (iSortCol = -1) Begin
                        Set piSortColumn of oCustomerGrid to 1  // 1 = oCustomer_Customer_Number
                    End
                End
                Send Activate of oCustomerGrid
            End_Procedure
        End_Object
        
        Object oAlternateRowColors_chkbx is a CheckBox
            Set Size to 10 50
            Set Location to 28 7
            Set Label to "Alternate Row Background"
            Set peAnchors to anTopRight
            
            Procedure OnChange
                Boolean bChecked
                
                Forward Send OnChange
                
                Get Checked_State to bChecked
                Set pbUseAlternateRowBackgroundColor of oCustomerGrid to bChecked
                
                Send ComRedraw to oCustomerGrid
                Send Activate of oCustomerGrid
            End_Procedure
        End_Object
    End_Object
    
    Object oTextBox1 is a TextBox
        Set Auto_Size_State to False
        Set Size to 20 119
        Set Justification_Mode to JMode_Left
        Set Location to 152 342
        Set Label to "Each color demonstrated here can be individually changed. "
        Set peAnchors to anTopRight
    End_Object
    
    Object oGridColors_btn is a Button
        Set Size to 14 120
        Set Location to 177 342
        Set Label to "Default Grid Color Options"
        Set peAnchors to anTopRight
        
        // fires when the button is clicked
        Procedure OnClick
            Set Checked_State of oNavigateCellFocus_chkbx to True
            Set Checked_State of oHighlightSelectedRow_chkbx to False
            Set Checked_State of oFocusCellRectangle_chkbx to True
            Set Checked_State of oCustomFocusCellColors_chkbx to False
            Set Checked_State of oShadeSortColumn_chkbx to False
            Set Checked_State of oAlternateRowColors_chkbx to False
        End_Procedure
        
    End_Object
    
    Object oPromptListColors_btn is a Button
        Set Size to 14 120
        Set Location to 195 342
        Set Label to "Default Prompt List Color Options"
        Set peAnchors to anTopRight
        
        // fires when the button is clicked
        Procedure OnClick
            Set Checked_State of oNavigateCellFocus_chkbx to True
            Set Checked_State of oHighlightSelectedRow_chkbx to True
            Set Checked_State of oFocusCellRectangle_chkbx to False
            Set Checked_State of oCustomFocusCellColors_chkbx to False
            Set Checked_State of oShadeSortColumn_chkbx to True
            Set Checked_State of oAlternateRowColors_chkbx to False
        End_Procedure
        
    End_Object
Cd_End_Object
