Use FleXML.pkg
Use DFClient.pkg
Use cComWebBrowser.pkg
Use Windows.pkg
Use cTextEdit.pkg

ACTIVATE_VIEW Activate_oXMLSample1 FOR oXMLSample1

Object oXMLSample1 is a dbView
    
    // This sample will load an existing XML file, and read it.
    // It will change one of the values and write out a new changed file.
    
    // This file uses a schema, so if there are any errors in the file, you will
    // not be able to open it. You can experiment with this by changing the file
    // or changing the schema with an editor.
    
    // This will use all dynamic objects. Objects will be created using the
    // Create message and destroyed using the destroy message. Since these are
    // dynamic, we will use object handles (aka their object ID) to identify them.
    
    Set Border_Style to Border_Thick
    Set Label to "XML - Example 1"
    Set Location to 7 5
    Set Size to 248 405
    Set piMinSize to 248 405
    Set pbAutoActivate to True
    
    Procedure Activating
        Send DisplayMessage of oMessage ""
    End_Procedure
    
    Object oWebBrowser1 is a cComWebBrowser
        
        // WARNING: Do NOT modify this code.
        // The Embed_ActiveX_Resource...End_Embed_ActiveX_Resource code block
        // is generated and maintained by the Studio.
        Embed_ActiveX_Resource
        TAAAAOA8AACOIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAATAAAAAAAAAAAAAAAAQAAAODQVwBzNc8RrmkIACsuEmIIAAAAAAAAAEwAAAABFAIAAAAAAMAAAAAAAABG
        gAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAAA.
        End_Embed_ActiveX_Resource
        
        Set Size to 190 393
        Set Location to 7 7
        Set peAnchors to anAll
        
        Procedure OnCreate
        End_Procedure
        
    End_Object
    
    Object oViewOriginalXML is a Button
        Set Label to "View Original XML File"
        Set Size to 14 129
        Set Location to 231 8
        Set peAnchors to anBottomLeft
        
        Procedure OnClick
            String sPath
            Get psDataPath Of (phoWorkspace(ghoApplication)) To sPath
            Get PathAtIndex Of (phoWorkspace(ghoApplication)) sPath 1 To sPath
            
            Send ComNavigate of oWebBrowser1 (sPath+"\Customer.xml") 0 0 0 0 0
            Send DisplayMessage of oMessage ("View XMl Document" * sPath+"\Customer.xml")
        End_Procedure
        
    End_Object
    
    Object oProcessXMLView is a Button
        Set Label to "Process and View New XML File"
        Set Size to 14 129
        Set Location to 231 139
        Set peAnchors to anBottomLeftRight
        
        Procedure OnClick
            String sPath
            
            Send ProcessXMLDoc
            Get psDataPath Of (phoWorkspace(ghoApplication)) To sPath
            Get PathAtIndex Of (phoWorkspace(ghoApplication)) sPath 1 To sPath
            
            Send ComNavigate of oWebBrowser1 (sPath+"\NewCustomer.xml") 0 0 0 0 0
            Send DisplayMessage of oMessage ("View New Processed XML Document" * sPath+"\NewCustomer.xml")
        End_Procedure
        
    End_Object
    
    Object oDocme is a Button
        Set Label to "What does this sample do?"
        Set Size to 14 129
        Set Location to 231 271
        Set peAnchors to anBottomRight
        
        Procedure OnClick
            String sPath
            
            Get psHelpPath Of (phoWorkspace(ghoApplication)) To sPath
            Get PathAtIndex Of (phoWorkspace(ghoApplication)) sPath 1 To sPath
            
            Send ComNavigate of oWebBrowser1 (sPath+"\Sample-1-help.html") 0 0 0 0 0
            Send DisplayMessage of oMessage ("View the help HTML file for this application:" * (sPath+"\Sample-1-help.html"))
        End_Procedure
        
    End_Object
    
    Object oMessage is a cTextEdit
        Set Size to 22 394
        Set Location to 203 7
        Set Color to clBtnFace
        Set peAnchors to anBottomLeftRight
        Set Read_Only_State to True
        
        Procedure DisplayMessage String sMsg
            Set Value to sMsg
        End_Procedure
        
    End_Object
    
    Procedure ProcessXMLDoc
        Handle hoXML hoRoot hoList hoCust
        Integer iItems i
        String sPath sNamespace
        Boolean bOK bErr
        
        // We will read and write the XML objects to our data directory. Note, when you create
        // XML document names you want to provide the full path name. If you don't, the file will
        // get placed somewhere in your DFPath (but you won't know where that is for sure.)
        // Also note that XML files can be loaded from a URL (sample code provided below). However,
        // XML documents can only be saved to a file name. If you need to move the file to a URL, save it
        // locally and move it elsewhere using the VDF FTP class.
        
        // ghoWorkSpace is the id of the VDF workspace object. It has the datapath name
        Get psDataPath Of (phoWorkspace(ghoApplication)) To sPath
        Get PathAtIndex Of (phoWorkspace(ghoApplication)) sPath 1 To sPath
        
        Showln "Processing XML document"
        
        // This is the standard object create message that will return an object handle.
        Get Create (RefClass(cXMLDOMDocument)) To hoXML
        
        // Set the name of the document
        Set psDocumentName Of hoXML To (sPath - "\customer.xml")
        
        // You could read from a URL. If you did, you must set pbAsync to False
        //Set psDocumentName of hoXML to "http://localhost/xml/customer.xml"
        //Set pbAsync of hoxml To False
        
        // set schema to validate the loaded XML file
        Get AddExternalSchemaFile of hoXML "http://www.dataaccess.com/schemas/Customer" (sPath - "\Customer.xsd") to bOK
        If not bOK Begin
            // this will print out a basic error report.
            Send BasicParseErrorReport of hoXml
            Send Destroy of hoXML
            Procedure_Return
        End
        
        // Set to True, the document is validated against the schema
        Set pbValidateOnParse of hoXML to True
        
        // Namespace to be used
        Move "http://www.dataaccess.com/Customer" to sNamespace
        
        // psSelectionNamespaces must contain a prefix for each namespace it stores
        // This has to be set in order to use FindNode and FindNodeList
        Set psSelectionNamespaces of hoXML to ("xmlns:custList='" - sNamespace - "'")
        
        // Load the XML document and return an error flag.
        Get LoadXMLDocument Of hoXML To bOK
        If Not bOK Begin
            // this will print out a basic error report.
            Send BasicParseErrorReport Of hoXml
            Send Destroy Of hoXML
            Procedure_Return
        End
        
        Showln 'Document loaded'
        
        // you always process an XML document from its Document element.
        Get DocumentElement Of hoXML To hoRoot
        
        
        // Create a collection of all nodes that contain "CUSTOMER". We will then step through
        // the node list one at a time. This is a standard method for parsing xml documents.
        // This is a very simple example of pattern mapping. We ask to see all elements under
        // the document element that has a element name of "CUSTOMER" in the namespace identified
        // by prefix "custList". When using namespaces, FindNodeList must include a prefix
        // that identifies the namespace in use
        Get FindNodeList of hoRoot "custList:CUSTOMER" to hoList
        Get NodeListLength Of hoList To iItems // number of items in our node list.
        Decrement iItems
        For i From 0 To iItems
            // Get each CUSTOMER node in the list. Create the node, process it, destroy it.
            Get CollectionNode Of hoList i To hoCust
            Send ShowCust hoCust sNamespace
            Send Destroy Of hoCust
        Loop
        Send Destroy Of hoList // the node list is no longer needed.
        
        Send Destroy Of hoRoot // we no longer need the root node.
        
        // Note that destroying XML nodes does not desroy the data in the XML document. It just
        // removes the node that served as your access to the document. As a general rule you want to
        // destroy every node that you create.
        
        // We will now save the document under a new name
        Set psDocumentName Of hoXML To (sPath - "\NewCustomer.xml")
        Get SaveXMLDocument Of hoXML To bErr
        If not bErr ;
            Showln "Document Saved"
        
        
        // The last thing we do is destroy the XML document. This will also destroy all child
        // XML nodes if you forgot to destroy them yourself.
        Send Destroy Of hoXML
    End_Procedure
    
    // Process an XML Node.
    // Pass a Customer node, display data from the node and change
    // some of the data values (we will take a state name and convert it to a state ID).
    Procedure ShowCust Handle hoCust String sNameSpace
        String sName sPhone sState
        Handle hoAddress
        
        // Get AttributeValueNS and Get ChildElementValueNS provide an easy
        // way to get data from a node (attributes or child elements) passing
        // the namespace along with the attribute or element name
        // Since this is done so often, simple messages are provided to do this.
        
        // Attributes often have no namespace, and even when a default namespace is
        // used in a document, the namespace does not apply to attributes. In our case,
        // we are following the norm and are NOT using a namespace for this attribute, so
        // we pass a blank namespace as the first argument to AttributeValueNS
        Get AttributeValueNS of hoCust "" "NAME" to sName
        
        // "TELEPHONE" is a child element of "CUSTOMER" so we can get its
        // value using ChildElementValueNS
        Get ChildElementValueNS of hoCust sNameSpace "TELEPHONE"     to sPhone
        
        // As "STATE" is an element of "ADDRESS", and "ADDRESS" is a child node
        // of "CUSTOMER", we have to first get a handle to the child node "ADDRESS"
        // and then get ChildElementValueNS for its child element "STATE"
        Get ChildElementNS of hoCust sNameSpace "ADDRESS" to hoAddress
        Get ChildElementValueNS of hoAddress sNameSpace "STATE" to sState
        
        // Change a data value, replace it and destroy the object handle
        Move (Uppercase(Left(sState,2))) To sState // convert state name to state id
        Send SetChildElementValueNS of hoAddress sNameSpace "STATE" sState // add change back to XML document
        Send Destroy of hoAddress
        
        // show what we've done.
        Showln "Changing Data for " sName ' ' sPhone ' to ' sState
    End_Procedure
    
End_Object

