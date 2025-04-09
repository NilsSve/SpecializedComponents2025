Use FleXML.pkg
Use Customer.dd
Use DFClient.pkg
Use BatchDD.pkg
Use cComWebBrowser.pkg
Use Windows.pkg
Use cTextEdit.pkg

ACTIVATE_VIEW Activate_oXMLSample2 FOR oXMLSample2

Object oXMLSample2 is a dbView
    Set Border_Style to Border_Thick
    Set Label to "XML - Example 2"
    Set Location to 7 5
    Set Size to 286 405
    Set piMinSize to 286 405
    
    Procedure Activating
        Send DisplayMessage of oMessage ""
    End_Procedure
    
    Object oSaveCustomertoXML is a BusinessProcess
        
        // In this sample we will read all data from the Customer data file and write it
        // to an XML file. We will do all of this within a BPO. Before studying the code here
        // you should look at XML sample 1. Comments in that sample are not repeated here.
        
        Property Boolean pbAllowDuplicates False
        
        Set Status_Panel_State to FALSE
        
        // We will use this DD to get the data
        Object Customer_DD Is A Customer_DataDictionary
        End_Object
        
        Procedure OnProcess
            Handle hoXML hoRoot hoList hoCust hoDD
            Integer iItems i bErr bOk
            Boolean bAllowDuplicates
            String sDataPath
            String sNamespace
            
            Get pbAllowDuplicates to bAllowDuplicates
            
            // Create the XML Document
            Get Create (RefClass(cXMLDOMDocument)) To hoXML
            
            Get psDataPath of (phoWorkspace(ghoApplication)) to sDataPath
            Get PathAtIndex Of (phoWorkspace(ghoApplication)) sDataPath 1 To sDataPath
            
            // path is sibling of datapath
            Set psDocumentName Of hoXML To (sDatapath - "\Mycustomer.xml")
            Set pbValidateOnParse Of hoXML To True
            
            // Namespace to be used
            Move "http://www.dataaccess.com/Customers" to sNamespace
            
            // psSelectionNamespaces must contain a prefix for each namespace it stores
            // This has to be set in order to use FindNode and FindNodeList
            Set psSelectionNamespaces of hoXML to ("xmlns:cust='" - sNamespace - "'")
            
            // Load the XML document and return an error flag.
            Get LoadXMLDocument Of hoXML To bOK
            
            // We might be creating a new document or we may be adding to an existing
            // document. If document element exists, we are adding to existing,
            // if not, we must create the root element
            Get DocumentElement Of hoXML To hoRoot
            If not hoRoot Begin
                Get CreateDocumentElementNS of hoXML sNamespace "Customers" to hoRoot
            End
            
            // this loop finds all customers in the file
            Move Customer_DD To hoDD // handle to Customer DD
            Send Clear Of hoDD
            Send Find Of hoDD Gt 1
            While (Found)
                Send AddCustomer hoRoot bAllowDuplicates sNamespace
                Send Find Of hoDD Gt 1
            Loop
            Send Destroy Of hoRoot
            
            Get SaveXMLDocument Of hoXML To bErr
            
            Send Destroy Of hoXML
        End_Procedure
        
        // If we do not allow duplicates we will add this customer only if needed.
        // We will search the xml document to see if we already have a customer
        // id attribute that matches our custsomer. If we do,
        // we will not add this again. If we do not, add it
        Procedure AddCustomer Handle hoRoot Boolean bAllowDuplicates String sNamespace
            Handle hoCust hoAdd hoEle
            String sQuery
            
            // The XML Dom model supports all kinds of pattern searches. This is a powerful
            // feature and there is a lot to this. You are advised to find some sources
            // on the XML DOM model and read up on this. Whatever is supported by this
            // model is supported by VDF.
            //
            // We are looking for a Customer Element that contains an attribute named
            // Customer-Id that matches our customer number (note that the search is
            // case sensitive (that's the way XML is).
            If not bAllowDuplicates Begin
                // When using namespaces, FindNode must include a prefix
                // that identifies the namespace in use
                Move ("cust:Customer[@Customer-Id='"+Trim(Customer.Customer_Number)+"']") to sQuery
                // Find a node that matches this. If found, return an object handle to it
                Get  FindNode Of hoRoot sQuery To hoCust
                If hoCust Begin
                    // if found, we do no more. So, destroy the node and return
                    Send Destroy Of hoCust
                    Procedure_Return
                End
            End
            // This is a new customer. Add a new Customer node. We are creating an XML
            // structure like this:
            //  Customer (element)
            //     Customer-Id = id (attribute)
            //     Name = name(element)
            //     Address (element)
            //         Street = street (element)
            //         Ciyt = city (element)
            //         State = state (element)
            //         Zip = zip (element)
            //     Telephone = phone (element)
            //
            // Notice that there is not a one-to-one match of Customer Fields and
            // XML data. There rarely will be a one-to-one match. The purpose of an
            // XML file it to transfer data in an agreed format between processes. There
            // is no reason to expect that the process that uses this file will be a
            // VDF program or is the least bit interested in how we store our data.
            // DO NOT think of XML as a replacement or a copy of database data.
            //
            Get  AddElementNS of hoRoot sNamespace "Customer" "" to hoCust
            Send AddAttributeNS of hoCust "" "Customer-Id" (Trim(Customer.Customer_Number))
            Send AddElementNS of hoCust sNamespace "Name" (Trim(Customer.Name))
            Get  AddElementNS of hoCust sNamespace "Address" "" to hoAdd
            Send AddElementNS of hoAdd sNamespace "Street" (Trim(Customer.Address))
            Send AddElementNS of hoAdd sNamespace "City" (Trim(Customer.City))
            Send AddElementNS of hoAdd sNamespace "State" (Trim(Customer.State))
            Send AddElementNS of hoAdd sNamespace "Zip" (Trim(Customer.Zip))
            Send Destroy of hoAdd
            
            Send AddElementNS   of hoCust sNamespace "Telephone" (Trim(Customer.Phone_Number))
            Send Destroy Of hoCust
            // notice how we destroy all nodes that we create.
        End_Procedure
        
    End_Object
    
    Object oWebBrowser1 is a cComWebBrowser
        
        // WARNING: Do NOT modify this code.
        // The Embed_ActiveX_Resource...End_Embed_ActiveX_Resource code block
        // is generated and maintained by the Studio.
        Embed_ActiveX_Resource
        TAAAAOA8AADeIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAATAAAAAAAAAAAAAAAAQAAAODQVwBzNc8RrmkIACsuEmIIAAAAAAAAAEwAAAABFAIAAAAAAMAAAAAAAABG
        gAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAAA.
        End_Embed_ActiveX_Resource
        
        Set Size to 200 393
        Set Location to 7 7
        Set peAnchors to anAll
        
        Procedure OnCreate
        End_Procedure
        
    End_Object
    
    Object oDeleteXMLFile is a Button
        Set Label to "Delete Existing  XML File"
        Set Size to 14 95
        Set Location to 248 7
        Set peAnchors to anBottomLeft
        
        Procedure OnClick
            String sPath
            
            Get psDataPath Of (phoWorkspace(ghoApplication)) To sPath
            Get PathAtIndex Of (phoWorkspace(ghoApplication)) sPath 1 To sPath
            
            EraseFile (sPath+"\MyCustomer.xml")
            Send Info_Box "XML File has been deleted"
        End_Procedure
        
    End_Object
    
    Object oAllowDuplicates is a CheckBox
        Set Label to "Allow Duplicate Records"
        Set Size to 10 94
        Set Location to 251 110
        Set peAnchors to anBottomLeft
        
        Procedure OnChange
            Set pbAllowDuplicates Of oSaveCustomertoXML To (Checked_State(Self))
        End_Procedure
        
    End_Object
    
    Object oWriteCustomertoXML is a Button
        Set Label to "Write Customer to XML file"
        Set Size to 14 91
        Set Location to 248 208
        Set peAnchors to anBottomLeftRight
        
        Procedure OnClick
            // you send the message DoProcess to run a BPO. This in turn prepares
            // the BPO and calls OnProcess which is where all of your custom go belongs
            Send DoProcess Of oSaveCustomertoXML
            Send Info_Box "XML File has been Created"
        End_Procedure
        
    End_Object
    
    Object oViewXML is a Button
        Set Label to "View XML File"
        Set Size to 14 91
        Set Location to 248 309
        Set peAnchors to anBottomRight
        
        Procedure OnClick
            String sPath
            
            Get psDataPath Of (phoWorkspace(ghoApplication)) To sPath
            Get PathAtIndex Of (phoWorkspace(ghoApplication)) sPath 1 To sPath
            
            Send ComNavigate of oWebBrowser1 (sPath+"\MyCustomer.xml") 0 0 0 0 0
            Send DisplayMessage of oMessage ("View the XML file" * spath + "\MyCustomer.xml")
        End_Procedure
        
    End_Object
    
    Object oDocme is a Button
        Set Label to "What does this sample do?"
        Set Size to 14 129
        Set Location to 267 139
        Set peAnchors to anBottomLeftRight
        
        Procedure OnClick
            String sPath
            
            Get psHelpPath Of (phoWorkspace(ghoApplication)) To sPath
            Get PathAtIndex Of (phoWorkspace(ghoApplication)) sPath 1 To sPath
            
            Send ComNavigate of oWebBrowser1 (sPath+"\Sample-2-help.html") 0 0 0 0 0
            Send DisplayMessage of oMessage ("View the help HTML file for this application:" * (sPath+"\Sample-2-help.html"))
        End_Procedure
        
    End_Object
    
    Object oMessage is a cTextEdit
        Set Size to 22 394
        Set Location to 214 6
        Set Color to clBtnFace
        Set peAnchors to anBottomLeftRight
        Set Read_Only_State to True
        
        Procedure DisplayMessage String sMsg
            Set Value to sMsg
        End_Procedure
        
    End_Object
    
End_Object

