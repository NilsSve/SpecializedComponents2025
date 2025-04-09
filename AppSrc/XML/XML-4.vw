Use FleXML.pkg
Open Customer
Open SalesP
Open Vendor
Open Invt
Open OrderHea
Open OrderDtl

Use DFClient.pkg
Use cComWebBrowser.pkg
Use BatchDD.pkg
Use Windows.pkg
Use DFLine.pkg
Use cTextEdit.pkg

ACTIVATE_VIEW Activate_oXMLSample4 FOR oXMLSample4

Object oXMLSample4 is a dbView
    Set Border_Style to Border_Thick
    Set Label to "XML - Example 4"
    Set Location to 0 2
    Set Size to 319 477
    Set piMinSize to 319 477
    
    Procedure Activating
        Send DisplayMessage of oMessage ""
    End_Procedure
    
    Object oWebBrowser1 is a cComWebBrowser
        
        // WARNING: Do NOT modify this code.
        // The Embed_ActiveX_Resource...End_Embed_ActiveX_Resource code block
        // is generated and maintained by the Studio.
        Embed_ActiveX_Resource
        TAAAAM1AAACzGwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAATAAAAAAAAAAAAAAAAQAAAODQVwBzNc8RrmkIACsuEmIIAAAAAAAAAEwAAAABFAIAAAAAAMAAAAAAAABG
        gAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAAA.
        End_Embed_ActiveX_Resource
        
        Set Size to 181 465
        Set Location to 4 6
        Set peAnchors to anAll
        
        Procedure OnCreate
        End_Procedure
        
    End_Object
    
    Object oBPOXMLWrite1 is a BusinessProcess
        
        // This BPO writes files out to XML. This is a low level data transfer.
        // We are not using DDs for this, we are using the direct files and the
        // API commands. For files Customer, SalesP, OrderHea, OrderDtl, Invt and
        // vendor we will read all records and output for each record every field
        // (skipping Overlaps).
        
        Set Display_Error_State to TRUE
        Set Status_Panel_State to FALSE
        
        // This determines how we will write out our text. If we perofrm no
        // translation on the data we might end up with data that has characters
        // embedded in it that XML will recognize as mark up characters such as
        // < or >. The XML classes will encode the characters for you. There is
        // another way to do this. You can write the data out
        // as CData sections which means that XML adds special mark up that handles
        // this for us. CData sections were created specifically to handle this. In
        // our example we will use cData if this flag is set.
        Property Boolean pbUseCData False
        
        Procedure OnProcess
            Integer bTest
            Handle hoRoot hoXML
            String sDataPath sNamespace
            
            Get psDataPath Of (phoWorkspace(ghoApplication)) To sDataPath
            Get PathAtIndex Of (phoWorkspace(ghoApplication)) sDataPath 1 To sDataPath
            
            Get Create (RefClass(cXMLDOMDocument)) to hoXML
            Set psDocumentName of hoXML to (sDatapath - "\records-1.XML")
            
            // Namespace to be used
            Move "http://www.dataaccess.com/Tables" to sNamespace
            
            // psSelectionNamespaces must contain a prefix for each namespace it stores
            // This has to be set in order to use FindNode and FindNodeList
            Set psSelectionNamespaces of hoXML to ("xmlns:tables='" - sNamespace - "'")
            
            Get LoadXMLDocument Of hoXML To bTest
            
            // get document element. If it exists, we are editing an xml file. If
            // it does not exist, it's a new file, create the doc element node
            Get DocumentElement Of hoXML To hoRoot
            If not hoRoot Begin
                Get CreateDocumentElementNS of hoXML sNamespace "Tables" to hoRoot
            End
            
            Showln "Writing XML"
            // Dump the following files out to XML
            Send OutPutTable hoRoot Customer.File_number sNamespace
            Send OutPutTable hoRoot SalesP.File_number sNamespace
            Send OutPutTable hoRoot OrderHea.File_number sNamespace
            Send OutPutTable hoRoot OrderDtl.File_number sNamespace
            Send OutPutTable hoRoot Invt.File_number sNamespace
            Send OutPutTable hoRoot Vendor.File_number sNamespace
            
            Send Destroy Of hoRoot // root node no longer needed
            
            // Save the XML file
            Get  SaveXMLDocument Of hoXML To bTest
            Showln "Saving XML"
            
            Send Destroy Of hoXML // XML document no longer needed
            Showln "Done"
        End_Procedure
        
        // output all rows in a table to an xml file.
        // The DataFlex API is used to get all information needed about the files.
        // Pass the XML parent node, the file number and the namespace to be used
        Procedure OutputTable Handle hoRoot Integer iFile String sNamespace
            String  sFile sQuery
            Handle  hoTable
            Integer bRetVal
            Boolean bUseCData
            
            // This determines if we use CData sections for output
            Get pbUSeCData To bUseCData
            
            // Each table has an attribute called Name which is the name of the file.
            // We will check to see if a node for this table already exists. If it does,
            // we will give the user the choice of skipping or replacing this node.
            
            Get_Attribute DF_FILE_LOGICAL_NAME of iFile to sFile // name of the file
            
            // XML Search Pattern: This looks for an element named "Table" that has
            // an attribute called Name with a value of our file name
            
            // When using namespaces, FindNode must include a prefix
            // that identifies the namespace in use
            Move ("tables:Table[@Name='" + sFile + "']") to sQuery
            Get FindNode Of hoRoot sQuery To hoTable // see such a node exists
            // If a node is returned, it exists. Ask what to do.
            If hoTable Begin
                Get YesNo_Box (sFile * "exists. Replace?") To bRetVal
                If (bRetVal=MBR_No) Begin
                    // We will not replace. Kill the node and return
                    Send destroy Of hoTable
                    Procedure_Return
                End
                Else Begin
                    // We will replace. First remove the node from the XML document
                    // and then destory the node. Note that Removing a node returns a
                    // handle to the destroyed node. This allows you to do something else
                    // with the node, like move it. In this case, we don't need it.
                    Get RemoveNode Of hoRoot hoTable To hoTable
                    Send destroy Of hoTable
                    // continue on writing the table
                End
            End
            
            Showln "Writing " sfile
            
            // Create an element called Table with two attributes, Name and File.
            // The element will use the default namespace
            Get  AddElementNS of hoRoot sNamespace "Table" "" to hoTable
            // Attributes will use the global namespace
            Send AddAttributeNS of hoTable "" "Name" sFile
            Send AddAttributeNS of hoTable "" "File" iFile
            
            //Now for all rows in this Table
            Clear iFile
            Vfind iFile 0 Gt
            While (Found)
                // Write a row Element for each item
                Send OutputRows hoTable iFile bUseCData sNamespace
                Vfind iFile 0 Gt
            Loop
            Send Destroy Of hoTable
        End_Procedure
        
        // Output XML data for each field in the row. Pass the parent node
        // (which is the Table element) and a file number.
        Procedure OutPutRows Handle hoNode Integer iFile Integer bUseCData String sNamespace
            Integer iField iFields iType
            String sTag sField
            Handle hoRow hoField
            
            Get AddElementNS of hoNode sNamespace "Row" "" to hoRow
            Get_Attribute DF_FILE_NUMBER_FIELDS Of iFile To iFields
            For iField From 1 To iFields
                Get_Attribute DF_FIELD_TYPE Of iFile iField To iType
                If (iType<>DF_OVERLAP) Begin
                    
                    Get_Field_Value iFile iField To sField
                    Move (Trim(sField)) To sfield
                    Get_Attribute DF_FIELD_NAME Of iFile iField To sTag
                    
                    // Create Field Element with Field Number and Name attributes
                    // store field value as text or CData
                    Get AddElementNS of hoRow sNamespace "Field" "" to hoField
                    If bUseCData Begin
                        Send AddCDataSection of hoField sField
                    End
                    Else Begin
                        Send AddChildTextNode of hoField sField
                    End
                    
                    // attributes will use the global namespace
                    Send AddAttributeNS of hoField "" "Field-number" iField
                    Send AddAttributeNS of hoField "" "Name" sTag
                    
                    Send Destroy Of hoField
                End
            Loop
            Send Destroy Of hoRow
        End_Procedure
        
    End_Object
    
    Object oWrite1_tb is a Textbox
        Set Label to "Write Single Files to XML #1"
        Set Location to 221 25
        Set Size to 10 94
        Set FontWeight to FW_Bold
        Set peAnchors to anBottomLeft
    End_Object
    
    Object oUseCData1 is a CheckBox
        Set Label to "Write data as CData"
        Set Size to 10 81
        Set Location to 235 39
        Set peAnchors to anBottomLeft
        
        Procedure OnChange
            Set pbUseCData Of oBPOXMLWrite1 To (Checked_State(Self))
        End_Procedure
        
    End_Object
    
    Object oDelete1 is a Button
        Set Label to "Delete XML File "
        Set Size to 14 82
        Set Location to 248 39
        Set peAnchors to anBottomLeft
        
        Procedure OnClick
            String sPath
            
            Get psDataPath Of (phoWorkspace(ghoApplication)) To sPath
            Get PathAtIndex Of (phoWorkspace(ghoApplication)) sPath 1 To sPath
            
            EraseFile (sPath+"\records-1.xml")
            Send Info_Box "XML File has been deleted"
        End_Procedure
        
    End_Object
    
    Object oWriteXml1 is a Button
        Set Label to "Write Tables to XML "
        Set Size to 14 82
        Set Location to 264 39
        Set peAnchors to anBottomLeft
        
        Procedure OnClick
            Send DoProcess Of oBPOXMLWrite1
        End_Procedure
        
    End_Object
    
    Object oViewXML1 is a Button
        Set Label to "View XML File"
        Set Size to 14 82
        Set Location to 281 39
        Set peAnchors to anBottomLeft
        
        Procedure OnClick
            String sPath
            
            Get psDataPath Of (phoWorkspace(ghoApplication)) To sPath
            Get PathAtIndex Of (phoWorkspace(ghoApplication)) sPath 1 To sPath
            
            Send ComNavigate of oWebBrowser1 (sPath+"\records-1.xml") 0 0 0 0 0
            Send DisplayMessage of oMessage ("View the XML file" * spath + "\records-1.xml")
        End_Procedure
        
    End_Object
    
    Object oLineControl1 is a LineControl
        Set Horizontal_State to FALSE
        Set Size to 78 3
        Set Location to 221 141
        Set peAnchors to anBottomLeft
    End_Object
    
    Object oBPOXMLWrite2 is a BusinessProcess
        
        Set Display_Error_State to TRUE
        Set Status_Panel_State to FALSE
        
        // This is like oBPOWrite1 except that it outputs the data a bit
        // differently. In this example it actually uses the name of the fields
        // as element names. Just another way of outputting data
        
        Property Boolean pbUseCData False
        
        Procedure OnProcess
            Integer bTest
            Handle hoRoot hoXML
            String sDataPath sNamespace
            
            Get psDataPath Of (phoWorkspace(ghoApplication)) To sDataPath
            Get PathAtIndex Of (phoWorkspace(ghoApplication)) sDataPath 1 To sDataPath
            
            // Create document object
            
            Get Create (RefClass(cXMLDOMDocument)) to hoXML
            Set psDocumentName Of hoXML To (sDatapath - "\records-2.XML")
            Set pbValidateOnParse of hoXML to True
            
            // Namespace to be used
            Move "http://www.dataaccess.com/Tables" to sNamespace
            
            // psSelectionNamespaces must contain a prefix for each namespace it stores
            // This has to be set in order to use FindNode and FindNodeList
            Set psSelectionNamespaces of hoXML to ("xmlns:tables='" - sNamespace - "'")
            
            Get LoadXMLDocument Of hoXML To bTest
            Get DocumentElement Of hoXML To hoRoot
            If not hoRoot Begin
                Get CreateDocumentElementNS of hoXML sNamespace "Tables" to hoRoot
            End
            
            Showln "Writing XML"
            Send OutPutTable hoRoot Customer.File_number sNamespace
            Send OutPutTable hoRoot SalesP.File_number sNamespace
            Send OutPutTable hoRoot OrderHea.File_number sNamespace
            Send OutPutTable hoRoot OrderDtl.File_number sNamespace
            Send OutPutTable hoRoot Vendor.File_number sNamespace
            Send OutPutTable hoRoot Invt.File_number sNamespace
            
            Send Destroy Of hoRoot
            
            Get  SaveXMLDocument Of hoXML To bTest
            Showln "Saving XML"
            
            Send Destroy Of hoXML
            Showln "Done"
        End_Procedure
        
        Procedure OutputTable Handle hoRoot Integer iTable String sNamespace
            String sFile
            Handle hoTable
            Integer bRetVal
            Boolean bUseCData
            
            // This determines if we use CData sections for output
            Get pbUSeCData To bUseCData
            
            Get_Attribute DF_FILE_LOGICAL_NAME of iTable to sFile
            
            // When using namespaces, FindNode must include a prefix
            // that identifies the namespace in use
            Get FindNode of hoRoot ("tables:" - sFile) to hoTable
            If hoTable Begin
                Get YesNo_Box (sFile * "exists. Replace?") To bRetVal
                If (bRetVal=MBR_No) Begin
                    Send destroy Of hoTable
                    Procedure_Return
                End
                Else Begin
                    Get RemoveNode Of hoRoot hoTable To hoTable
                    Send destroy Of hoTable
                End
            End
            
            Showln "Writing " sfile
            
            // The element will use the default namespace
            Get AddElementNS of hoRoot sNamespace sFile "" to hoTable
            Send AddChildComment of hoTable ("Add all records for "+sFile)
            // the attribute will use the global namespace
            Send AddAttributeNS of hoTable "" "File" iTable
            
            Clear iTable
            Vfind iTable 0 Gt
            While (Found)
                Send OutputRows hoTable iTable bUseCData sNamespace
                Vfind iTable 0 Gt
            Loop
            Send Destroy Of hoTable
        End_Procedure
        
        Procedure OutPutRows Handle hoNode Integer iTable Integer bUseCData String sNamespace
            Integer iField iFields iType
            String sTag sField
            Handle hoRow hoField
            
            Get AddElementNS of hoNode sNamespace "Row" "" to hoRow
            Get_Attribute DF_FILE_NUMBER_FIELDS Of iTable To iFields
            For iField From 1 To iFields
                Get_Attribute DF_FIELD_TYPE Of iTable iField To iType
                If (iType<>DF_OVERLAP) Begin
                    
                    Get_Field_Value iTable iField To sField
                    Move (Trim(sField)) To sfield
                    Get_Attribute DF_FIELD_NAME Of iTable iField To sTag
                    
                    If bUseCData Begin
                        // if write as CData, create the element with no value and
                        // add the cDataSection as a child of the element
                        Get  AddElementNS of hoRow sNamespace sTag "" to hoField
                        Send AddCDataSection Of hoField sField
                    End
                    Else ;// if write as text, add it with the element
                        Get  AddElementNS of hoRow sNamespace sTag sField to hoField
                    
                    // the attribute will use the global namespace
                    Send AddAttributeNS of hoField "" "Field-number" iField
                    Send Destroy Of hoField
                End
            Loop
            Send Destroy Of hoRow
        End_Procedure
        
    End_Object
    
    Object oWrite2_tb is a Textbox
        Set Label to "Write Single Files to XML #2"
        Set Location to 221 161
        Set Size to 10 94
        Set FontWeight to FW_Bold
        Set peAnchors to anBottomLeft
    End_Object
    
    Object oUseCData2 is a CheckBox
        Set Label to "Write data as CData"
        Set Size to 10 81
        Set Location to 235 173
        Set peAnchors to anBottomLeft
        
        Procedure OnChange
            Set pbUseCData Of oBPOXMLWrite2 To (Checked_State(Self))
        End_Procedure
        
    End_Object
    
    Object oDelete2 is a Button
        Set Label to "Delete XML File "
        Set Size to 14 129
        Set Location to 248 173
        Set peAnchors to anBottomLeftRight
        
        Procedure OnClick
            String sPath
            
            Get psDataPath Of (phoWorkspace(ghoApplication)) To sPath
            Get PathAtIndex Of (phoWorkspace(ghoApplication)) sPath 1 To sPath
            
            EraseFile (sPath+"\records-2.xml")
            Send Info_Box "XML File has been deleted"
        End_Procedure
        
    End_Object
    
    Object oWriteXml2 is a Button
        Set Label to "Write Tables to XML "
        Set Size to 14 129
        Set Location to 264 173
        Set peAnchors to anBottomLeftRight
        
        Procedure OnClick
            Send DoProcess Of oBPOXMLWrite2
        End_Procedure
        
    End_Object
    
    Object oViewXML2 is a Button
        Set Label to "View XML File"
        Set Size to 14 129
        Set Location to 281 173
        Set peAnchors to anBottomLeftRight
        
        Procedure OnClick
            String sPath
            
            Get psDataPath Of (phoWorkspace(ghoApplication)) To sPath
            Get PathAtIndex Of (phoWorkspace(ghoApplication)) sPath 1 To sPath
            
            Send ComNavigate of oWebBrowser1 (sPath+"\records-2.xml") 0 0 0 0 0
            Send DisplayMessage of oMessage ("View the XML file" * spath + "\records-2.xml")
        End_Procedure
        
    End_Object
    
    Object oLineControl2 is a LineControl
        Set Horizontal_State to FALSE
        Set Size to 78 3
        Set Location to 221 337
        Set peAnchors to anBottomRight
    End_Object
    
    Object oBPOXMLWrite3 is a BusinessProcess
        
        // Before looking at this sample you should check the first two samples in this
        // view. This is more complicated and it builds on techniques used in the
        // other samples.
        
        Set Display_Error_State to TRUE
        Set Status_Panel_State to FALSE
        
        // This outputs an XML file with data for all orders. For every order
        // all data for the order table, its parent tables (customer and salesp), all
        // details for the order, and all table that relate to the detail (Invt and
        // vendor) are written to a document.
        // Therefore, we are taking our data and de-normalizing it, so that each order
        // contains all of the information about that order.
        // This is an important sample in that it very clearly shows that an XML data does not
        // need to have (and will rarely have) a one to one relationship with your tables.
        // You do not want to think of XML as another database table - it's not! XML represents
        // a method for transfering data between sources. Don't assume that the two sources
        // will use the data the same way (i.e. don't assume that both sources are VDF
        // applications that store data in databases. The whole point of XML is not worry
        // about this or to restrict its uses.
        //
        // This is all done at a low level using DataFlex file commands (no DDs). Notice how
        // easy it is to write a program that extracts all data and writes it to an XML
        // document. This technique could be used for any table.
        
        Property Boolean pbUseCData False
        
        Procedure OnProcess
            Integer bTest
            Handle hoRoot hoXML
            String sDataPath sNamespace
            
            Get psDataPath Of (phoWorkspace(ghoApplication)) To sDataPath
            Get PathAtIndex Of (phoWorkspace(ghoApplication)) sDataPath 1 To sDataPath
            
            // Create document object
            
            Get Create (RefClass(cXMLDOMDocument)) to hoXML
            Set psDocumentName Of hoXML To (sDatapath - "\records-3.XML")
            Set pbValidateOnParse of hoXML to True
            
            // Namespace to be used
            Move "http://www.dataaccess.com/Orders" to sNamespace
            
            // psSelectionNamespaces must contain a prefix for each namespace it stores
            // This has to be set in order to use FindNode and FindNodeList
            Set psSelectionNamespaces of hoXML to ("xmlns:orders='" - sNamespace - "'")
            
            Get CreateDocumentElementNS of hoXML sNamespace "Orders" to hoRoot
            
            Send OutPutOrders hoRoot sNamespace // output all orders to the root document
            
            Send Destroy Of hoRoot
            
            Get  SaveXMLDocument Of hoXML To bTest
            
            Send Destroy Of hoXML
            Showln "Done"
        End_Procedure
        
        // Loop through all orders
        Procedure OutputOrders Handle hoOrders String sNamespace
            Clear OrderHea
            Find Gt OrderHea by 1
            While (Found)
                Showln "Writing Order " OrderHea.Order_Number
                Send OutputRow hoOrders OrderHea.File_Number sNamespace
                Find Gt OrderHea by 1
            Loop
        End_Procedure
        
        // This add a row element name=Tag and Value=Field. It uses
        // the pbUseCData property to determine if the Value should be
        // written as CDataSection or as encoded text
        Procedure AddRowData Handle hoRow String sTag String sField String sNamespace
            Boolean bUseCData
            Handle hoNode
            
            Get pbUseCData To bUseCData
            If bUseCData Begin
                Get AddElementNS of hoRow sNamespace sTag "" to hoNode
                Send AddCDataSection Of hoNode sField
                Send Destroy Of hoNode
            End
            Else Begin
                Send AddElementNS of hoRow sNamespace sTag sField
            End
        End_Procedure
        
        // For each Order, output all fields. If related parent fields exist
        // get that record and out its data. This method will get called recursively
        // by itself to process the parent fields.
        Procedure OutputRow Handle hoNode Integer iTable String sNamespace
            Integer iField iFields iRelTable iType
            String sTag sField sTable
            Handle hoRow hoField
            
            Get_Attribute DF_FILE_LOGICAL_NAME Of iTable To sTable
            Get AddElementNS of hoNode sNamespace sTable "" to hoRow
            Get_Attribute DF_FILE_NUMBER_FIELDS Of iTable To iFields
            Relate iTable
            For iField From 1 To iFields
                Get_Field_Value iTable iField To sField
                Move (Trim(sField)) To sfield
                Get_Attribute DF_FIELD_NAME Of iTable iField To sTag
                Get_Attribute DF_FIELD_RELATED_FILE Of iTable iField To iRelTable
                If iRelTable Begin
                    // If a parent exist, call same routine with parent data
                    Send OutPutRow hoRow iRelTable sNamespace
                End
                Else Begin
                    Get_Attribute DF_FIELD_TYPE Of iTable iField To iType
                    If (iType<>DF_OVERLAP) Begin
                        Send AddRowData hoRow sTag sField sNamespace
                    End
                End
            Loop
            // If this was called with order, now ouput all child detail data
            If (iTable=Orderhea.File_number) Begin
                Send OutputDetailItems hoRow iTable sNamespace
            End
            Send Destroy Of hoRow
        End_Procedure
        
        // For all related detail items, find the record and the
        // output the data by calling OutPutChildTable
        Procedure OutputDetailItems Handle hoNode Integer iTable String sNamespace
            Handle hoDtlsNode
            
            Get AddElementNS of hoNode sNamespace "ORDERDTLLIST" "" to hoDtlsNode
            Clear OrderDtl
            Attach Orderdtl
            Find Gt OrderDtl by 1
            While ( (Found) And (OrderDtl.Order_Number=OrderHea.Order_Number))
                Send OutPutChildTable hoDtlsNode iTable OrderDtl.File_Number sNamespace
                Find Gt OrderDtl by 1
            Loop
            Send Destroy Of hoDtlsNode
        End_Procedure
        
        // Output child data. Note that is is also called recursively.
        Procedure OutPutChildTable Handle hoNode Integer iPFile Integer iTable String sNamespace
            Integer iField iFields iRelTable iType
            String sTag sField sTable
            Handle hoRow hoField
            
            Get_Attribute DF_FILE_LOGICAL_NAME Of iTable To sTable
            Get AddElementNS of hoNode sNamespace sTable "" to hoRow
            Get_Attribute DF_FILE_NUMBER_FIELDS Of iTable To iFields
            Relate iTable
            For iField From 1 To iFields
                Get_Field_Value iTable iField To sField
                Move (Trim(sField)) To sfield
                Get_Attribute DF_FIELD_NAME Of iTable iField To sTag
                Get_Attribute DF_FIELD_RELATED_FILE Of iTable iField To iRelTable
                // if a related parent and that related parent is NOT the related parent
                // that caused this procedure to be called, then output the parent.
                // By checking the related parent, we prevent infinite recursion
                If (iRelTable And iRelTable<>iPFile) Begin
                    Send OutPutChildTable hoRow iPFile iRelTable sNamespace
                End
                Else Begin
                    Get_Attribute DF_FIELD_TYPE Of iTable iField To iType
                    If (iType<>DF_OVERLAP) Begin
                        Send AddRowData hoRow sTag sField sNamespace
                    End
                End
            Loop
            Send Destroy Of hoRow
        End_Procedure
        
    End_Object
    
    Object oWrite3_tb is a Textbox
        Set Label to "Write related files to XML"
        Set Location to 221 348
        Set Size to 10 84
        Set FontWeight to FW_Bold
        Set peAnchors to anBottomRight
    End_Object
    
    Object oUseCData3 is a CheckBox
        Set Label to "Write data as CData"
        Set Size to 10 81
        Set Location to 235 354
        Set peAnchors to anBottomRight
        
        Procedure OnChange
            Set pbUseCData Of oBPOXMLWrite3 To (Checked_State(Self))
        End_Procedure
        
    End_Object
    
    Object oDelete3 is a Button
        Set Label to "Delete XML File "
        Set Size to 14 82
        Set Location to 248 354
        Set peAnchors to anBottomRight
        
        Procedure OnClick
            String sPath
            
            Get psDataPath Of (phoWorkspace(ghoApplication)) To sPath
            Get PathAtIndex Of (phoWorkspace(ghoApplication)) sPath 1 To sPath
            
            EraseFile (sPath+"\records-1.xml")
            Send Info_Box "XML File has been deleted"
        End_Procedure
        
    End_Object
    
    Object oWriteXml3 is a Button
        Set Label to "Write Tables to XML "
        Set Size to 14 82
        Set Location to 264 354
        Set peAnchors to anBottomRight
        
        Procedure OnClick
            Send DoProcess Of oBPOXMLWrite3
        End_Procedure
        
    End_Object
    
    Object oViewXML3 is a Button
        Set Label to "View XML File"
        Set Size to 14 82
        Set Location to 281 354
        Set peAnchors to anBottomRight
        
        Procedure OnClick
            String sPath
            
            Get psDataPath Of (phoWorkspace(ghoApplication)) To sPath
            Get PathAtIndex Of (phoWorkspace(ghoApplication)) sPath 1 To sPath
            
            Send ComNavigate of oWebBrowser1 (sPath+"\records-3.xml") 0 0 0 0 0
            Send DisplayMessage of oMessage ("View the XML file" * spath + "\records-3.xml")
        End_Procedure
        
    End_Object
    
    Object oDocme is a Button
        Set Label to "What does this sample do?"
        Set Size to 14 178
        Set Location to 300 149
        Set peAnchors to anBottomLeftRight
        
        Procedure OnClick
            String sPath
            
            Get psHelpPath Of (phoWorkspace(ghoApplication)) To sPath
            Get PathAtIndex Of (phoWorkspace(ghoApplication)) sPath 1 To sPath
            
            Send ComNavigate of oWebBrowser1 (sPath+"\Sample-4-help.html") 0 0 0 0 0
            Send DisplayMessage of oMessage ("View the help HTML file for this application:" * (sPath+"\Sample-4-help.html"))
        End_Procedure
        
    End_Object
    
    Object oMessage is a cTextEdit
        Set Size to 22 465
        Set Location to 190 6
        Set Color to clBtnFace
        Set peAnchors to anBottomLeftRight
        Set Read_Only_State to True
        
        Procedure DisplayMessage String sMsg
            Set Value to sMsg
        End_Procedure
        
    End_Object
    
End_Object

