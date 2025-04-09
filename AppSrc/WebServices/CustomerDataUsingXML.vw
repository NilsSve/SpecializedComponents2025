Use WebClientHelper.vw
Use dfClient.pkg
Use Windows.pkg
Use cTextEdit.pkg
Use WebServices\cWSCustomerXML.pkg
Use cCJGrid.pkg
Use cCJGridColumn.pkg

Activate_View Activate_oCustomerDataUsingXML for oCustomerDataUsingXML
Object oCustomerDataUsingXML is a dbView

    On_Key kCancel Send Request_Cancel

    Set Label to "Customer Data from Server using XML"
    Set Location to 1 1
    Set Size to 251 297

    Object oLoadCustList is a Button
        Set Label to "Load Customer Data"
        Set Size to 14 75
        Set Location to 199 14
        Set peAnchors to anBottomLeft

        Procedure OnClick
           Boolean bOk
        
           Send Cursor_Wait of Cursor_Control
           Delegate Get DoRequestCustomerList to bOk
           
           Send MoveToRow of oCustomerGrid 0 True 
           Send MoveToFirstEnterableColumn of oCustomerGrid
           
           Send Cursor_Ready of Cursor_Control
        End_Procedure // OnClick

    End_Object    // oLoadCustList

    Object oDeleteCustList is a Button
        Set Label to "Process Selected Lines"
        Set Size to 14 81
        Set Location to 199 205
        Set peAnchors to anBottomLeft

        Procedure OnClick
           Boolean bOk
        
           Send Cursor_Wait of Cursor_Control
           Delegate Get DoRequestDeleteCustomers to bOk
           Send Cursor_Ready of Cursor_Control
        End_Procedure // OnClick

    End_Object    // oDeleteCustList

    Object oDebugMode is a CheckBox
        Set Label to "Activate Debug Mode"
        Set Size to 10 85
        Set Location to 228 13
        Set peAnchors to anBottomLeft

        Procedure OnChange
            Boolean bChecked
        
            Get Checked_State To bChecked
            if (bChecked) begin
                Set phoSoapClientHelper of oWSCustomerXML to oClientWSHelper
            end
            else begin
                Set phoSoapClientHelper of oWSCustomerXML to ""
            end
        End_Procedure // OnChange

    End_Object    // oDebugMode

    Object oDisplayDebug is a Button
        Set Label to "Display Debug Information"
        Set Size to 14 96
        Set Location to 228 103
        Set peAnchors to anBottomLeft

        Procedure OnClick
            send Popup of oClientWSHelper
        End_Procedure // OnClick

    End_Object    // oDisplayDebug

    Object oInfoEdit is a cTextEdit
        Set Size to 51 270
        Set Location to 12 15
        Set Color to clBtnFace
        Set TextColor to clMaroon
        Set Read_Only_State to TRUE
        Set Enabled_State to False

        Set Value of oInfoEdit ;
            to "This sample will retrieve the contents from the Order Sample Customer file through a web service. After the records are displayed in the grid, users can select the ones that should be removed from the file. In order for you to be able to run this sample many times, the records will NOT be deleted from the file, but will be removed from the list returned after the delete operation is processed."

    End_Object    // oInfoEdit

    Object oWSCustomerXML is a cWSCustomerXML

        // Web Service Class is defined in cWSCustomerXML.pkg
        // Interface:
        // Function wsCustomerXMLList returns handle
        // Function wsDelCustomerXMLList handle llCustomerList returns handle

        // phoSoapClientHelper
        //     Setting this property will pop up a view that provides information
        //     about the Soap (xml) data transfer. This can be useful in debugging.
        //     If you use this you must make sure you USE the test view at the top
        //     of your program/view by adding:   Use WebClientHelper.vw // oClientWSHelper
        //Set phoSoapClientHelper to oClientWSHelper

    End_Object    // oWSCustomerXML

    Object oCustomerGrid is a cCJGrid
        Set Size to 118 272
        Set Location to 72 13
        Set Color to clInfoBk
        Set pbSelectionEnable to True
        Set piHighlightBackColor to clLtGray
        Set piHighlightForeColor to clMaroon
        Set pbAllowColumnRemove to False
        Set pbAllowColumnReorder to False
        Set pbHeaderReorders to True
        Set pbHeaderTogglesDirection to True
        Set pbAllowAppendRow to False
        Set pbAllowDeleteRow to False
        Set pbAllowInsertRow to False
        Set pbInitialSelectionEnable to False
        Set pbUseFocusCellRectangle to False

        Object oNameColumn is a cCJGridColumn
            Set piWidth to 408
            Set psCaption to "Name"
            Set pbEditable to False
            Set pbFocusable to False
        End_Object

        Object oNumberColumn is a cCJGridColumn
            Set piWidth to 100
            Set psCaption to "Number"
            Set pbEditable to False
            Set pbFocusable to False
        End_Object

        Object oStateColumn is a cCJGridColumn
            Set piWidth to 100
            Set psCaption to "State"
            Set pbEditable to False
            Set pbFocusable to False
        End_Object

        Object oDeleteColumn is a cCJGridColumn
            Set piWidth to 100
            Set psCaption to "Delete"
            Set pbCheckbox to True
            Set psCheckboxFalse to "N"
            Set psCheckboxTrue to "Y"
        End_Object
    End_Object

    // Fill the grid with customer information passed in XML document
    // create XML document, load it, then fill the grid with info from document
    Function FillCustomerList Handle hoXML Returns Integer
        Handle  hoRoot hoCust hoCustomerGrid 
        Integer iCount
        String sNs
        tDataSourceRow[] DataSource
    
        Move oCustomerGrid to hoCustomerGrid  // object ID of VDF grid
    
        Get DocumentElement of hoXML to hoRoot
        Move "http://www.dataaccess.com/Test/CustomerList" to sNs
        Get ChildElementNS of hoRoot sNs "Customer" to hoCust
        While hoCust
            Get ChildElementValueNS of hoCust sNs "Name"   to DataSource[iCount].sValue[0]
            Get ChildElementValueNS of hoCust sNs "Number" to DataSource[iCount].sValue[1]
            Get ChildElementValueNS of hoCust sNs "State"  to DataSource[iCount].sValue[2]
            Move "N" to DataSource[iCount].sValue[3]
  
            // get (and replace) next customer node, until all are gone.
            Get NextElementNS of hoCust sNs "Customer" to hoCust
            Increment iCount
        Loop
        
        Send InitializeData of hoCustomerGrid DataSource
        
        Function_Return 1
    End_Function  // FillCustomerList

    //  Get the customer list from server and fill the grid with data
    Function DoRequestCustomerList Returns Integer
        Handle  hoXml
        Boolean bOk
    
        // make the web service call. Will return the customer list as an XML object
        Get wsCustomerXMLList of oWSCustomerXML to hoXml
        If hoXml Begin
            Get FillCustomerList hoXml to bOk
            Send Destroy of hoXml
        end
        Function_Return bOk
    End_function  // DoRequestCustomerList

    // Request Web Service to delete customers
    Function DoRequestDeleteCustomers Returns Integer
        handle  hoXML hoRoot hoCust hoList hoReplyXml hoCustomerGrid
        integer iRows iRow
        Boolean bOk
        String  sName sNumber sState sDelete sNameSpace
        tDataSourceRow[] GridDataSource
        Handle hoDataSource 
        
        Move oCustomerGrid to hoCustomerGrid
    
        // create XML document to send to web service.
        Move "http://www.dataaccess.com/Test/CustomerList" to sNameSpace
        Get Create (RefClass(cXMLDomDocument)) to hoXML
        Get CreateDocumentElementNS of hoXML sNameSpace "CustomerList" to hoRoot
        
        Get phoDataSource of hoCustomerGrid to hoDataSource
        Get DataSource of hoDataSource to GridDataSource
        Move (SizeOfArray(GridDataSource)) to iRows     

        For iRow from 0 to (iRows - 1) // for each customer in the grid
    
           // get customer info from the grid
           Move GridDataSource[iRow].sValue[0] to sName
           Move GridDataSource[iRow].sValue[1] to sNumber
           Move GridDataSource[iRow].sValue[2] to sState
           Move GridDataSource[iRow].sValue[3] to sDelete
    
           // add customer info to XML Customer node
           Get AddElementNS of hoRoot sNameSpace "Customer" "" to hoCust
               Send AddElementNS of hoCust sNameSpace "Name"    sName
               Send AddElementNS of hoCust sNameSpace "Number"  sNumber
               Send AddElementNS of hoCust sNameSpace "State"   sState
               // this will tell the server if the customer should be deleted
               Send AddAttributeNS of hoCust "" "Delete" sDelete
           Send Destroy of hoCust
        Loop
    
        // send to web service, it will return a reply document
        Get wsDelCustomerXMLList of oWSCustomerXML hoXml to hoReplyXml
        Send Destroy of hoXml
    
        If hoReplyXml begin
            Get FillCustomerList hoReplyXml to bOk
            Send Destroy of hoReplyXml
        end
    
        Function_Return 1
    End_Function  // DoRequestDeleteCustomers

End_Object
