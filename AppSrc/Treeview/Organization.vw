Use DFClient.pkg
Use DataDict.pkg
Use Windows.pkg
Use DFTreeVw.pkg
Use DFEntry.pkg

Use Company.DD
Use Dept.DD
Use Empl.DD
Use cDbSplitterContainer.pkg

Activate_View Activate_oOrganizationView for oOrganizationView
Object oOrganizationView is a dbView
    Set Icon to "Default.Ico"
    Set Label to "Organization Treeview"
    Set Location to 8 11
    Set Size to 220 401
    Set pbAutoActivate to True
    
    Object Company_DD is a Company_DataDictionary
        
        Procedure Request_Save
            Boolean bIsNullRowId
            RowId riCompany
            
            Move (GetRowId (Company.File_Number)) To riCompany
            Move (IsNullRowId (riCompany)) To bIsNullRowId
            
            Forward Send Request_Save
            
            Send DoUpdateTreeView Of oOrganizationTreeView bIsNullRowId
        End_Procedure
        
        Procedure Request_Delete
            Forward Send Request_Delete
            
            Send DoDeleteTreeItem Of oOrganizationTreeView
        End_Procedure
        
    End_Object
    
    Object Dept_DD is a Dept_DataDictionary
        Set DDO_Server to Company_DD
        Set Constrain_File to Company.File_Number
        
        Procedure Request_Save
            Boolean bIsNullRowId
            RowId riDept
            
            Move (GetRowId (Dept.File_Number)) To riDept
            Move (IsNullRowId (riDept)) To bIsNullRowId
            
            Forward Send Request_Save
            
            Send DoUpdateTreeView Of oOrganizationTreeView bIsNullRowId
        End_Procedure
        
        Procedure Request_Delete
            Forward Send Request_Delete
            
            Send DoDeleteTreeItem Of oOrganizationTreeView
        End_Procedure
        
    End_Object
    
    Object Empl_DD is a Empl_DataDictionary
        Set DDO_Server to Dept_DD
        Set Constrain_File to Dept.File_Number
        
        Procedure Request_Save
            Boolean bIsNullRowId
            RowId riEmpl
            
            Move (GetRowId (Empl.File_Number)) To riEmpl
            Move (IsNullRowId (riEmpl)) To bIsNullRowId
            
            Forward Send Request_Save
            
            Send DoUpdateTreeView Of oOrganizationTreeView bIsNullRowId
        End_Procedure
        
        Procedure Request_Delete
            Forward Send Request_Delete
            
            Send DoDeleteTreeItem Of oOrganizationTreeView
        End_Procedure
        
    End_Object
    
    Set Main_DD to Company_DD
    Set Server to Company_DD
    
    Object oImageList is a cImageList32
        
        // Define two constants so that we can refer to a name instead
        // of a number when addressing a bitmap handle in the imagelist
        // Enum_List's start at 0 by default.
        Enum_List
            Define BMP_CLOSEFOLDER
            Define BMP_OPENFOLDER
        End_Enum_List
        
        Set piMaxImages to 2
        
        // When the imagelist is created we will add two bitmaps to the
        // list. Each image that we try to load returns its itemhandle.
        // When it is -1 an error occured, most likely that the bitmap
        // could not be found. We notify the user of this by using a
        // stop_box message. To see how this works, just rename the
        // bitmap in the bitmaps directory of this workspace and
        // start this sample application.
        Procedure OnCreate
            Integer iIndex
            
            Get AddImage "ClosFold.bmp" to iIndex
            If (iIndex = -1) Begin
                Send Stop_Box "Image ClosFold.bmp could not be loaded"
            End
            Get AddImage "OpenFold.bmp" to iIndex
            If (iIndex = -1) Begin
                Send Stop_Box "Image OpenFold.bmp could not be loaded"
            End
        End_Procedure
        
    End_Object
    
    Object oRowIdsArray is a Array
        
        // This object is used to store the row ID and table number of each
        // added tree item. Tree items do have an item data value and this could have
        // been used to store - via a complex integer method - the two values. Since
        // the maximum capacity of a half complex integer is 65536 the technique would
        // limit us to a maximum of 65536 records. Per VDF11.0 we support non numeric
        // record identifiers so we cannot use that technique at all anymore. So this
        // technique to store the values in a separate array was a good choice prior
        // to the release of VDF11.0 and after. Instead of storing the rowid directly
        // it will be serialized so that the string value can be stored. Our traditional
        // array does not handle RowId's.
        // The method AddRowId stores the values and returns the item number. Note that
        // we do return the second item of each pair because the first time item 0
        // and 1 will be used and a value of 0 as pointer to this array could be
        // misleading for the treeview functions.
        Function AddRowId RowId riRow Integer iTableNumber Returns Integer
            Integer iItem
            String sRowId
            
            Get Item_Count To iItem
            Set Array_Value iItem To iTableNumber
            
            Increment iItem
            Move (SerializeRowId (riRow)) To sRowId
            Set Array_Value iItem To sRowId
            
            Function_Return iItem
        End_Function
        
        // This function takes the N-th array value and converts it by deserializing
        // from string to rowid. That value is returned. No checks whether the N-th
        // element is a ROWID or not.
        Function TableRowId Integer iPointer Returns RowId
            String sRowId
            RowId riRow
            
            Get Value iPointer to sRowId
            Move (DeSerializeRowId (sRowId)) To riRow
            
            Function_Return riRow
        End_Function
        
    End_Object
    
    Object oDbSplitterContainer1 is a cDbSplitterContainer
        Set piSplitterLocation to 174
        Set piMinSplitterLocation to 100
        Set piMaxSplitterLocation to 230
        Object oDbSplitterContainerChild1 is a cDbSplitterContainerChild
            
            Object oOrganizationTreeView is a TreeView
                Set Size to 218 173
                Set Location to 0 0
                Set TreeRootLinesState to False
                Set pbEnableInfoTips to True
                
                // Give the treeview an imagelist
                // Note that the imagelist object needs to be coded befor this
                // operation, else the expression (oImageList (Self)) will
                // return a ZERO and the sample will fail.
                Set ImageListObject to oImageList
                Set peAnchors to anAll
                Set Border_Style to Border_None
                
                Procedure DoDeleteTreeItem
                    Handle hItem hParentItem
                    Integer iRecIdHandle
                    
                    Get CurrentTreeItem to hItem
                    Get ItemData hItem to iRecIdHandle
                    
                    // Do not delete the item since it would condense the
                    // array and this will give find errors.
                    Set Value of oRowIdsArray (iRecIdHandle - 1) to 0
                    Set Value of oRowIdsArray iRecIdHandle to 0
                    
                    // Make sure the treeview gets the focus
                    Send Activate
                    // Clear the DD's
                    Send Clear of Empl_DD
                    
                    // Find out the parent item to change to it after delete
                    Get ParentItem hItem to hParentItem
                    // Now delete the treeview item
                    Send DoDeleteItem hItem
                    // Change the current item
                    Set CurrentTreeItem to hParentItem
                End_Procedure
                
                // This method will either update the current item or
                // send a message to refresh the whole tree
                Procedure DoUpdateTreeView Boolean bRefreshTotal
                    Handle hRootItem
                    
                    If (bRefreshTotal) Begin
                        Get RootItem to hRootItem
                        Send DoDeleteItem hRootItem
                        Send OnCreateTree
                        Send Activate
                    End
                    Else Begin
                        Send DoRereadCurrentTreeItem
                    End
                End_Procedure
                
                // This method will refresh the current tree item
                Procedure DoRereadCurrentTreeItem
                    Handle hItem
                    Integer iRecIdHandle iTableNum
                    String sItemLabel
                    RowID riEmpl
                    
                    Get CurrentTreeItem to hItem
                    Get ItemData hItem to iRecIdHandle
                    
                    // Get the filenumber based on the item handle
                    Get Value of oRowIdsArray (iRecIdHandle - 1) to iTableNum
                    // Show the filenumber
                    Set Value of oTableNumberForm to iTableNum
                    // Get the record id
                    Get TableRowId of oRowIdsArray iRecIdHandle to riEmpl
                    
                    If (iTableNum > 0 and (not (IsNullRowId (riEmpl)))) Begin
                        // Refind the record of the current treeitem
                        Send FindByRowId of Empl_DD iTableNum riEmpl
                        // Based on the filenumber retrieve the value of a specific field
                        Case Begin
                            Case (iTableNum = Company.File_Number)
                                Get Field_Current_Value of Company_DD Field Company.Name to sItemLabel
                                Case Break
                            Case (iTableNum = Dept.File_Number)
                                Get Field_Current_Value of Dept_DD Field Dept.Name to sItemLabel
                                Case Break
                            Case (iTableNum = Empl.File_Number)
                                Get Field_Current_Value of Empl_DD Field Empl.Last_name to sItemLabel
                                Case Break
                        Case End
                        // Set the label of the item
                        Set ItemLabel hItem to sItemLabel
                    End
                End_Procedure
                
                // This method is used to fill the treeview with items. It will
                // find in a loop all company records and per found company
                // record it will try to find all departments connected to the
                // company. For each of them the routine will try to find all
                // employees. The finding of records is done via the DataDictionary
                // objects. Important issue is that DEPT_DD does have a RELATES TO
                // constraint to COMPANY_DD and EMPL_DD does have a RELATES TO
                // constraint to DEPT_DD.
                // When a record is found it is stored in the object oRowIdsArray by
                // sending the message AddRecordID. This returns a handle to the item
                // pair created.
                // All object references are done by first moving the object-id to an
                // integer variable for speed up the process.
                Procedure OnCreateTree
                    Handle hItemRoot hItemCompany hItemDept
                    Integer hoCompanyDD hoDeptDD hoEmplDD iRecordId
                    Integer hItemEmpl hoRowIdsArray iRecIdHandle
                    Boolean bEofCompany bEofDept bEofEmpl
                    String sLabel
                    RowID riCompany riDept riEmpl
                    
                    Move Company_DD to hoCompanyDD
                    Move Dept_DD to hoDeptDD
                    Move Empl_DD to hoEmplDD
                    Move oRowIdsArray to hoRowIdsArray
                    
                    Send Clear to hoCompanyDD
                    Repeat
                        // Use the index on company name
                        Send Find of hoCompanyDD Gt 2
                        Move (Finderr) to bEofCompany
                        If (not (bEofCompany)) Begin
                            // Get the current COMPANY record id
                            Get CurrentRowId of hoCompanyDD to riCompany
                            // Pass both record id and filenumber and get back a handle to the itempair
                            Get AddRowId of hoRowIdsArray riCompany Company.File_Number to iRecIdHandle
                            // Get the name of the company to be shown in the treeview
                            Get Field_Current_Value of hoCompanyDD Field Company.Name to sLabel
                            // If no items in the treeview we will add a rootitem. If we would not do this
                            // all company records would be root items (also acceptable, but we won't be
                            // able to expand/collapse all childitems at once.
                            If (hItemRoot = 0) Begin
                                Get AddTreeItem "Organization Root" 0 0 BMP_CLOSEFOLDER BMP_OPENFOLDER to hItemRoot
                            End
                            // Connect this item to the rootitem of the treeview
                            Get AddTreeItem sLabel hItemRoot iRecIdHandle BMP_CLOSEFOLDER BMP_OPENFOLDER to hItemCompany
                            // set company names bold in the tree
                            Set ItemBold hItemCompany to True
                            
                            Send Clear to hoDeptDD
                            Repeat
                                // The best index to be used is index 3
                                Send Find of hoDeptDD Gt 3
                                Move (Finderr) to bEofDept
                                If (not (bEofDept)) Begin
                                    // Get the current DEPT record id
                                    Get CurrentRowId of hoDeptDD to riDept
                                    // Pass both record id and filenumber and get back a handle to the itempair
                                    Get AddRowId of hoRowIdsArray riDept Dept.File_Number to iRecIdHandle
                                    // Get the name of the department to be shown in the treeview
                                    Get Field_Current_Value of hoDeptDD Field Dept.Name to sLabel
                                    // Connect this item to the last company treeview item
                                    Get AddTreeItem sLabel hItemCompany iRecIdHandle BMP_CLOSEFOLDER BMP_OPENFOLDER to hItemDept
                                    
                                    Send Clear to hoEmplDD
                                    Repeat
                                        // The best index to be used is index 3
                                        Send Find of hoEmplDD Gt 3
                                        Move (Finderr) to bEofEmpl
                                        If (not (bEofEmpl)) Begin
                                            // Get the current EMPL record id
                                            Get CurrentRowId of hoEmplDD to riEmpl
                                            // Pass both record id and filenumber and get back a handle to the itempair
                                            Get AddRowId of hoRowIdsArray riEmpl Empl.File_Number to iRecIdHandle
                                            // Get the name of the employee to be shown in the treeview
                                            Get Field_Current_Value of hoEmplDD Field Empl.Last_Name to sLabel
                                            // Connect this item to the last department item
                                            Get AddTreeItem sLabel hItemDept iRecIdHandle BMP_CLOSEFOLDER BMP_OPENFOLDER to hItemEmpl
                                        End
                                    Until (bEofEmpl)
                                End
                            Until (bEofDept)
                        End
                    Until (bEofCompany)
                    
                    // This will expand the root item so that all department records are shown when the
                    // view opens.
                    Send DoExpandItem hItemRoot
                    // Make the rootitem the current item
                    Set CurrentTreeItem to hItemRoot
                End_Procedure
                
                // This method is used to let the DataDictionary objects find the correct record
                // The method is called from OnItemChanged and by itself (so recursive). If recursive
                // it will automatically stop when an item without a record handle if found (should
                // be the rootitem). The find of a record should be top-down, so first the company
                // record and then the dept and empl record.
                Procedure DoFindParentRecord Handle hItem Integer hoRowIdsArray
                    Integer hParentItem iRecIdHandle iTableNum hoServer hoMainDD
                    RowID riRow
                    
                    Get ParentItem hItem to hParentItem
                    If (hParentItem <> 0) Begin
                        Get ItemData hParentItem to iRecIdHandle
                        If (iRecIdHandle > 0) Begin
                            Get Value of hoRowIdsArray (iRecIdHandle - 1) to iTableNum
                            Get TableRowId of hoRowIdsArray iRecIdHandle to riRow
                            Get Main_DD to hoMainDD
                            Get Data_Set of hoMainDD iTableNum to hoServer
                            // Do a recursive call
                            Send DoFindParentRecord hParentItem hoRowIdsArray
                            Send FindByRowId of hoServer iTableNum riRow
                        End
                    End
                End_Procedure
                
                // When the user clicks on an item in the treeview (or moves down/up with arrow
                // keys) this event will fire. We will retrieve the record id handle of the item
                // we went to and when this is not NULL we will enable the DEO groups aside the
                // treeview. Then we send the message DoFindParentRecord to find the right records
                // in the DDO's before we find our own record. If we would not do this the current
                // record might not fit the constraints and not show up in the DEO groups.
                Procedure OnItemChanged Handle hItemNew Handle hItemOld
                    Integer iRecIdHandle hoRowIdsArray iTableNum hoServer hoMainDD
                    RowID riRow
                    
                    Get ItemData hItemNew to iRecIdHandle
                    If (iRecIdHandle > 0) Begin
                        Move oRowIdsArray to hoRowIdsArray
                        // Get the filenumber based on the item handle
                        Get Value of hoRowIdsArray (iRecIdHandle - 1) to iTableNum
                        // Show the filenumber
                        Set Value of oTableNumberForm to iTableNum
                        // Try to find the right DDO object
                        Get Main_DD to hoMainDD
                        Get Data_Set of hoMainDD iTableNum to hoServer
                        If (hoServer <> 0) Begin
                            Send DoFindParentRecord hItemNew hoRowIdsArray
                            Get TableRowId of hoRowIdsArray iRecIdHandle to riRow
                            Send FindByRowId of hoServer iTableNum riRow
                            Send DoEnableDataEntry True
                        End
                        Else Begin
                            // This should never happen!
                            Send DoEnableDataEntry False
                        End
                    End
                    Else Begin
                        Set Value of oTableNumberForm to ""
                        Send Request_Clear_All
                        Send DoEnableDataEntry False
                    End
                    
                End_Procedure
                
                // Tell the framework that the treeview is not a DEO control
                // so that the toolbar buttons that are fired to a DEO control
                // won't cause invalid message errors.
                Function Deo_Object Returns Integer
                    Function_Return False
                End_Function
                
                // Called when pbEnableInfoTips is True to display info tips when
                // hovering over tree items
                Procedure OnGetInfoTip Handle hItem String ByRef sInfoTip
                    Handle hRoot hParent hChild
                    Integer iHasChild iChildCount
                    String sCompany
                    
                    Get RootItem to hRoot
                    Get ParentItem hItem to hParent
                    If (hParent = hRoot) Begin
                        Get ItemChildCount hItem to iHasChild
                        If (iHasChild) Begin
                            Get ChildItem hItem to hChild
                            Repeat
                                Increment iChildCount
                                Get NextSiblingItem hChild to hChild
                            Until (hChild = 0)
                            
                            Get ItemLabel hItem to sCompany
                            Move (sCompany * "has" * String(iChildCount) * "departments.") to sInfoTip
                        End
                    End
                    
                End_Procedure
                
                
            End_Object
        End_Object
        
        Object oDbSplitterContainerChild2 is a cDbSplitterContainerChild
            
            Object oCompanyGroup is a dbGroup
                
                // Group of DEO objects to show (and enter) the company information
                // Auto_Clear_Deo_State is false so that a save will not clear the
                // dbForms. If it did this we would have a treeview not in sync with
                // with the dbgroup information
                
                Set Size to 41 203
                Set Location to 23 11
                Set Auto_Clear_DEO_State to False
                Set Label to "Company"
                Set peAnchors to anBottomLeftRight
                Object Company_Company_Code is a dbForm
                    Entry_Item Company.Company_code
                    Set Label to "Code:"
                    Set Size to 13 46
                    Set Location to 10 50
                    Set Label_Col_Offset to 2
                    Set Label_Justification_Mode to jMode_Right
                End_Object
                
                Object Company_Name is a dbForm
                    Entry_Item Company.Name
                    Set Label to "Name:"
                    Set Size to 13 149
                    Set Location to 25 50
                    Set Label_Col_Offset to 2
                    Set Label_Justification_Mode to jMode_Right
                End_Object
                
            End_Object
            Object oDeptGroup is a dbGroup
                
                // Group of DEO objects to show (and enter) the department information
                // Auto_Clear_Deo_State is false so that a save will not clear the
                // dbForms. If it did this we would have a treeview not in sync with
                // with the dbgroup information
                
                Set Server to Dept_DD
                Set Size to 42 203
                Set Location to 68 11
                Set Auto_Clear_DEO_State to False
                Set Label to "Department"
                Set peAnchors to anBottomLeftRight
                Object Dept_Dept_Code is a dbForm
                    Entry_Item Dept.Dept_code
                    Set Label to "Code:"
                    Set Size to 13 46
                    Set Location to 10 50
                    Set Label_Col_Offset to 2
                    Set Label_Justification_Mode to jMode_Right
                End_Object
                
                Object Dept_Number_Of_Empl is a dbForm
                    Entry_Item Dept.Number_of_empl
                    Set Label to "Empl#:"
                    Set Size to 13 18
                    Set Location to 10 146
                    Set Label_Col_Offset to 2
                    Set Label_Justification_Mode to jMode_Right
                End_Object
                
                Object Dept_Budget is a dbForm
                    Entry_Item Dept.Budget
                    Set Label to "Budget:"
                    Set Size to 13 54
                    Set Location to 25 50
                    Set Label_Col_Offset to 2
                    Set Label_Justification_Mode to jMode_Right
                End_Object
                
            End_Object
            Object oEmplGroup is a dbGroup
                
                // Group of DEO objects to show (and enter) the employee information
                // Auto_Clear_Deo_State is false so that a save will not clear the
                // dbForms. If it did this we would have a treeview not in sync with
                // with the dbgroup information
                
                Set Server to Empl_DD
                Set Size to 98 203
                Set Location to 115 11
                Set Auto_Clear_DEO_State to False
                Set Label to "Employee"
                Set peAnchors to anBottomLeftRight
                Object Empl_Code is a dbForm
                    Entry_Item Empl.Code
                    Set Label to "Code:"
                    Set Size to 13 30
                    Set Location to 10 50
                    Set Label_Col_Offset to 2
                    Set Label_Justification_Mode to jMode_Right
                End_Object
                
                Object Empl_Last_Name is a dbForm
                    Entry_Item Empl.Last_Name
                    Set Label to "Last Name:"
                    Set Size to 13 126
                    Set Location to 25 50
                    Set Label_Col_Offset to 2
                    Set Label_Justification_Mode to jMode_Right
                End_Object
                
                Object Empl_First_Name is a dbForm
                    Entry_Item Empl.First_Name
                    Set Label to "First Name:"
                    Set Size to 13 126
                    Set Location to 40 50
                    Set Label_Col_Offset to 2
                    Set Label_Justification_Mode to jMode_Right
                End_Object
                
                Object Empl_City is a dbForm
                    Entry_Item Empl.City
                    Set Label to "City:"
                    Set Size to 13 78
                    Set Location to 55 50
                    Set Label_Col_Offset to 2
                    Set Label_Justification_Mode to jMode_Right
                End_Object
                
                Object Empl_Term_Date is a dbForm
                    Entry_Item Empl.Term_Date
                    Set Label to "Term Date:"
                    Set Size to 13 66
                    Set Location to 70 50
                    Set Label_Col_Offset to 2
                    Set Label_Justification_Mode to jMode_Right
                End_Object
                
            End_Object
            
            Object oTableNumberForm is a Form
                Set Label to "Table containing branch information :"
                Set Size to 13 40
                Set Location to 6 149
                Set Label_Col_Offset to 2
                Set Label_Justification_Mode to jMode_Right
                Set Form_DataType to 0
                
                // Make the form disabled. It should only show the table number of
                // the treeview item
                Set Enabled_State to False
                Set Label_TextColor to clMaroon
                
            End_Object
        End_Object
    End_Object
    
    // This method is called from OnItemChanged in the treeview and
    // will disable or enable the data entry groups based on the
    // passed bState. bState will be false when the current treeitem
    // is sitting on the root item where no database value is known.
    //
    // Instead of setting the enabled_state of the group we use the
    // broadcast command to only disable the contents of the group,
    // the group box and label stay colored normal.
    Procedure DoEnableDataEntry Boolean bState
        Broadcast Set Enabled_State Of oCompanyGroup To bState
        Broadcast Set Enabled_State Of oDeptGroup To bState
        Broadcast Set Enabled_State Of oEmplGroup To bState
    End_Procedure
    
End_Object

