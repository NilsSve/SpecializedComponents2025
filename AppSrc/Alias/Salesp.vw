Use dfClient.pkg
Use DataDict.pkg
Use dfEntry.pkg
Use cSalesPersonManagerDataDictionary.dd
Use SalesP_DataDictionary2.dd
Use dfallent.pkg
Use Windows.pkg

// Here is the premise for this example.
//
// The standard order entry system has a SalesP (sales person) Table which is used with orders. Assume that the
// order entry system is part of a big system and these tables and views have been in place and deployed for a long
// time. A decision is made that Sales People should all have managers and that these managers are actually sales-people.
// In addition, the decision was to make this manager assignment optional. Because a salesperson can be a manager the decision
// was made to no longer allow the deleting of a Sales Person. Finally, this should only be added to this salesperson view
// and all other existing views should work, as much as possible, like they did. As a programmer you will want to do everything
// you can to minimize changes that will impact other parts of the applications.
//
// To make this work we need to create an Alias of SalesP to act as the Mananger Table. We will create a new field in SalesP
// named ManagerSalesPersonId, which will relate to the alias manager table. We will create a new SalesP DD sub-class
// (SalesP_DataDictionary2) and define the relationship local to that DD.
// In addition, we will use that DD sub-class to specify that this relationship to the Manager alias table allows a null parent.
//
//
// Here are the steps required to do this:
//
// 1. In TableEditor load SalesP and add a new Column: ManagerSalesPersonId, ASCII, length 4. Save the table definition
//    This will add the column that will relate to the manager alias table. The relationship will be defined locally in the
//    DD and NOT at the table (global) level.
//
// 2. In Table Explorer right click on SalesP and select "New <SalesP> Alias Table". Enter the name as SalesPersonManager
//    and Ok it. This will add the Alias table to Filelist and create an Alias DataDictionary.
//
// 3. Open the SalesP_DataDictionary and set No_Delete_State to True. This will stop any deletes to SalesP.
//
// 4. Create a new DD sub-class for SalesP. In Table Explorer, click on SalesP and select "Create New Data Dictionary...".
//    Select SalesP_DataDictionary as the super-class and name this new DD SalesP_DataDictionary2. This is the DD class we
//    will use for this view. By using this sub-class instead of SalesP_DataDictionary we can customize this sub-class without
//    worrying about changing this DD behavior in other views. Alternatively, we could have made the customizations in the next
//    step in the DD object, but creating a sub-class leaves us with a DD class that can be used for other purposes.
//
// 5. Customize the SalesP_DataDictionary2 by setting local DD relates (Set pbUseDDRelates) and setting a local relationship
//    (Set Field_Related_FileField) from SalesP.ManagerSalesPersonID to SalesPersonManager.ID. Also, add a Set Server
//    so that SalesPersonManagerId is a required parent. Finally, tell this DD that the parent SalesPersonManager may be a
//    null record (Set ParentNullAllowed). See the code in cSalesPersonManagerDataDictionary.dd to see how this is done.
//
// 6. Create a Prompt List (SalesPersonManager_sl) for SalesPersonManager using the Lookup list wizard. Open cSalesPersonManagerDataDictionary
//    and add SalesPersonManager_sl to be used by ID and Name (see Set Field_Prompt_Object)
//
// 7. Now build the view as shown below using the SalesP_DataDictionary2 sub-class as the main DD and
//    cSalesPersonManagerDataDictionary as the parent sub-class. Add the parent manager DEOs as shown.
//
// 8. Note the addition of the "Clear Manager" button. Pressing this allows a user to set a null manager by sending
//    Request_ClearBindingTable to the mananger DEO. This is not really needed since entering a blank ID will do the
//    exact same thing. That may not be clear to the user, so we added this helper button.
//

Activate_View Activate_oSalesPersonView for oSalesPersonView
Object oSalesPersonView is a dbView
    Set Border_Style to Border_None
    Set Label to "Sales Person Entry View with Manager parent"
    Set Location to 6 6
    Set Size to 110 245
    Set pbAutoActivate to True
    
    Object oSalesPersonManager_DD is a cSalesPersonManagerDataDictionary
    End_Object
    
    Object SalesP_DD is a SalesP_DataDictionary2
        Set DDO_Server to oSalesPersonManager_DD
    End_Object
    
    Set Main_DD to SalesP_DD
    Set Server to SalesP_DD
    
    Object oContainer1 is a dbContainer3d
        Set Size to 40 233
        Set Location to 5 6
        Object oSalesP_ID is a dbForm
            Entry_Item SalesP.ID
            Set Label to "Sales Person ID:"
            Set Size to 13 46
            Set Location to 4 70
            Set Label_Col_Offset to 2
            Set Label_Justification_Mode to jMode_Right
        End_Object
        
        Object oSalesP_Name is a dbForm
            Entry_Item SalesP.Name
            Set Label to "Sales Person Name:"
            Set Size to 13 156
            Set Location to 20 70
            Set Label_Col_Offset to 2
            Set Label_Justification_Mode to jMode_Right
        End_Object
        
    End_Object
    
    Object oDbGroup1 is a dbGroup
        Set Size to 50 233
        Set Location to 53 6
        Set Label to "Optional Manager"
        
        Object oSalesPersonManager_ID is a dbForm
            Entry_Item SalesPersonManager.ID
            Set Location to 9 72
            Set Size to 13 42
            Set Label to "Manager ID:"
            Set Label_Justification_Mode to JMode_Right
            Set Label_Col_Offset to 3
        End_Object
        
        Object oSalesPersonManager_Name is a dbForm
            Entry_Item SalesPersonManager.Name
            Set Location to 27 72
            Set Size to 13 156
            Set Label to "Name:"
            Set Label_Col_Offset to 3
            Set Label_Justification_Mode to JMode_Right
        End_Object
        
        Object oNoManager is a Button
            Set Size to 14 56
            Set Location to 9 118
            Set Label to "Clear Manager"
            Set psToolTip to "Click here if this salesperson has no assigned manager"
            
            // Use this to clear the manager. Typing a blank will do the same thing
            // but this makes it easier for users to understand
            Procedure OnClick
                Send Request_ClearBindingTable of oSalesPersonManager_ID
            End_Procedure
            
        End_Object
    End_Object
    
End_Object











