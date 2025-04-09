Use Windows.pkg
Use DFClient.pkg
Use cSplitterContainer.pkg
Use dfTreeVw.pkg
Use cCJGrid.pkg
Use cCJGridColumnRowIndicator.pkg
Use cCJGridColumn.pkg

// The purpose of this component is to show how you can search a TreeView control using
// the DoEnumerateTree method. The results of the search are shown in a CodeJock control
// On selection of one of the grid items the corresponding tree item is made visible and
// its bold state is set to true. As part of that operation the DoEnumerateTree method
// is again used; this time to remove the bold state of other tree items
// The component further makes use a splitter containers and responds correctly on resizing
// of the view or splitter.

Deferred_View Activate_oFileListView for ;
Object oFileListView is a dbView
    Set Border_Style to Border_Thick
    Set Size to 200 354
    Set Location to 2 2
    Set Label to "List of Tables"
    
    Object oFileListSplitterContainer is a cSplitterContainer
        Set piSplitterLocation to 141
        
        Object oFileListSplitterContainerChild is a cSplitterContainerChild
            Object oFileListTree is a TreeView
                Set Size to 183 139
                Set Location to 0 0
                Set peAnchors to anAll
                
                // This event is used to traverse the filelist of the workspace and for each
                // filelist entry a root level node is added with the table's logical name, a value
                // that should be unique. The root, display name and table number are added as
                // child items of the root node
                Procedure OnCreateTree
                    Handle hTable hItem hVoid
                    String sName
                    
                    Get_Attribute DF_FILE_NEXT_USED of hTable to hTable
                    While (hTable <> 0)
                        Get_Attribute DF_FILE_LOGICAL_NAME of hTable to sName
                        Get AddTreeItem sName 0 hTable 0 0 to hItem
                        
                        Get_Attribute DF_FILE_ROOT_NAME of hTable to sName
                        Get AddTreeItem ("Root Name:" * sName) hItem hTable 0 0 to hVoid
                        
                        Get_Attribute DF_FILE_DISPLAY_NAME of hTable to sName
                        Get AddTreeItem ("Display Name:" * sName) hItem hTable 0 0 to hVoid
                        
                        Get AddTreeItem ("Table#:" * String (hTable)) hItem hTable 0 0 to hVoid
                        
                        Get_Attribute DF_FILE_NEXT_USED of hTable to hTable
                    Loop
                End_Procedure
                
                { DesignTime = False }
                { Description = "Holds the search results" }
                Property tDataSourceRow[] pSearchResults
                
                // Called for each tree item to compare if the search value is in the
                // tree item label. Case sensitive compare. If the match is found the
                // label and the tree item handle are stored in the search results property
                // declared above.
                Procedure CompareTreeItem Handle hItem Integer iLevel
                    String sText sSearchValue
                    tDataSourceRow[] SearchResults
                    Integer iElement
                    
                    Get Value of oSearchForm to sSearchValue
                    Get ItemLabel hItem to sText
                    If (sText contains sSearchValue) Begin
                        Get pSearchResults to SearchResults
                        Move (SizeOfArray (SearchResults)) to iElement
                        Move sText to SearchResults[iElement].sValue[2]
                        Move hItem to SearchResults[iElement].sValue[1]
                        Set pSearchResults to SearchResults
                    End
                End_Procedure
                
                // This method is started from the search form and requests the
                // tree to enumerate all tree items. After the tree has been
                // searched the results grid is populated with the data.
                Procedure SearchInTree
                    Handle hRoot
                    tDataSourceRow[] SearchResults
                    
                    Get RootItem to hRoot
                    Set pSearchResults to SearchResults
                    Send DoEnumerateTree (RefProc (CompareTreeItem)) hRoot 0
                    Get pSearchResults to SearchResults
                    Send InitializeData of oResultsGrid SearchResults
                End_Procedure
                
                // Method to remove the bold state of each tree item (if set)
                Procedure RemoveBoldState Handle hItem Integer iLevel
                    Set ItemBold hItem to False
                End_Procedure
                
                // Started from the results grid on row change. First all
                // tree items are traversed to remove the bold state, then the
                // tree is requested to show the passed tree item and make the
                // item bold.
                Procedure ShowItem Handle hItem
                    Handle hRoot
                    
                    Get RootItem to hRoot
                    Send DoEnumerateTree (RefProc (RemoveBoldState)) hRoot 0
                    Send DoMakeItemVisible hItem
                    Set CurrentTreeItem to hItem
                    Set ItemBold hItem to True
                End_Procedure
            End_Object
            
            Object oSearchForm is a Form
                Set Size to 13 108
                Set Location to 185 31
                Set peAnchors to anBottomLeftRight
                Set Label to "Search:"
                Set Label_Col_Offset to 2
                Set Label_Justification_Mode to JMode_Right
                Set psToolTip to "Enter a value and press ENTER to start the search"
                
                // Pressing the enter key starts the search
                On_Key Key_Enter Send SearchInTree of oFileListTree
            End_Object
        End_Object
        
        Object oResultsSplitterContainerChild is a cSplitterContainerChild
            Object oResultsGrid is a cCJGrid
                Set Size to 199 210
                Set Location to 0 0
                Set peAnchors to anAll
                Set pbReadOnly to True
                Set psNoItemsText to "Use the search form to get results in this grid"
                Set pbHotTracking to True
                Set pbUseAlternateRowBackgroundColor to True
                
                Object oCJGridColumnRowIndicator is a cCJGridColumnRowIndicator
                    Set piWidth to 23
                    Set pbResizable to True
                End_Object
                
                // This column remains hidden, cannot be added by a user and is used
                // to keep track of the treeview item handle
                Object oTreeItemGridColumn is a cCJGridColumn
                    Set pbVisible to False
                    Set pbShowInFieldChooser to False
                End_Object
                
                Object oResultGridColumn is a cCJGridColumn
                    Set piWidth to 344
                    Set psCaption to "Result"
                End_Object
                
                Procedure OnRowChanged Integer iOldRow Integer iNewSelectedRow
                    Handle hItem
                    
                    Forward Send OnRowChanged iOldRow iNewSelectedRow
                    
                    // Get the tree handle to show
                    Get RowValue of oTreeItemGridColumn iNewSelectedRow to hItem
                    Send ShowItem of oFileListTree hItem
                End_Procedure
            End_Object
        End_Object
    End_Object
Cd_End_Object

