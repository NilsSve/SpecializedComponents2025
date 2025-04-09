Use FleXML.pkg
Use DFClient.pkg
Use cComWebBrowser.pkg
Use Windows.pkg
Use cTextEdit.pkg

ACTIVATE_VIEW Activate_oXMLSample5 FOR oXMLSample5

Object oXMLSample5 is a dbView
    
    // This sample will read in an existing XML file, and apply an XSL
    // transformation to it. The resulting transformation will be an
    // HTML document which will be displayed in the embedded browser.
    
    Set Border_Style to Border_Thick
    Set Label to "XML - Example 5"
    Set Location to 7 5
    Set Size to 254 407
    Set piMinSize to 254 407
    
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
        
        Set Size to 198 393
        Set Location to 7 7
        Set peAnchors to anAll
        
        Procedure OnCreate
        End_Procedure
        
    End_Object
    
    Object oViewOriginalXML is a Button
        Set Label to "View Original XML File"
        Set Size to 14 129
        Set Location to 236 8
        Set peAnchors to anBottomLeft
        
        Procedure OnClick
            string sPath
            
            Get psDataPath of (phoWorkspace(ghoApplication)) To sPath
            Get PathAtIndex of (phoWorkspace(ghoApplication)) sPath 1 To sPath
            
            Send ComNavigate of oWebBrowser1 (sPath+"\Customer.xml") 0 0 0 0 0
            Send DisplayMessage of oMessage ("View XMl Document" * sPath+"\Customer.xml")
        End_Procedure
        
    End_Object
    
    Object oTransformXML is a Button
        Set Label to "XSL transformation to HTML"
        Set Size to 14 129
        Set Location to 236 139
        Set peAnchors to anBottomLeftRight
        
        Procedure OnClick
            string sPath
            
            Send ProcessXMLDoc
            Get psDataPath of (phoWorkspace(ghoApplication)) To sPath
            Get PathAtIndex of (phoWorkspace(ghoApplication)) sPath 1 To sPath
            
            Send ComNavigate of oWebBrowser1 (sPath+"\NewCustomer.html") 0 0 0 0 0
            Send DisplayMessage of oMessage ("View transformed XML Document" * sPath+"\NewCustomer.html")
        End_Procedure
        
    End_Object
    
    Object oDocme is a Button
        Set Label to "What does this sample do?"
        Set Size to 14 129
        Set Location to 236 271
        Set peAnchors to anBottomRight
        
        Procedure OnClick
            string sPath
            
            Get psHelpPath of (phoWorkspace(ghoApplication)) To sPath
            Get PathAtIndex of (phoWorkspace(ghoApplication)) sPath 1 To sPath
            
            Send ComNavigate of oWebBrowser1 (sPath+"\Sample-5-help.html") 0 0 0 0 0
            Send DisplayMessage of oMessage ("View the help HTML file for this application:" * (sPath+"\Sample-5-help.html"))
        End_Procedure
        
    End_Object
    
    // XSL is a large and important XML related topic. An XSL file, which is
    // itself defined using XML, is applied to a node in an XML document. If that
    // node is the root element, the XSL document (sometimes called a style-sheet)
    // is applied to the entire XML. XSL is a template based transformation
    // language. The XSL document determines how the XML file will be transformed.
    // Typically, an XML transformation results in another XML document or an HTML
    // document. In this case, our XSL file (look at data\customer.xsl) transforms
    // our data into HTML.
    
    Procedure ProcessXMLDoc
        handle hoXML hoRoot hoList hoCust hoXSL
        Integer iItems i
        Boolean bOK
        String sPath sHtmlData sNamespace
        
        Showln "Transform XML document to HTML using XSL"
        
        // ghoApplicationis the id of the Global Application object. It contains the Workspace object
        Get psDataPath of (phoWorkspace(ghoApplication)) To sPath
        Get PathAtIndex of (phoWorkspace(ghoApplication)) sPath 1 To sPath
        
        // --- 1. Load the XML document ----
        
        Get Create (RefClass(cXMLDOMDocument)) to hoXML
        
        // Set the name of the document
        Set psDocumentName of hoXML to (sPath - "\customer.xml")
        
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
        Get LoadXMLDocument of hoXML to bOK
        If not bOK Begin
            // this will print out a basic error report.
            Send BasicParseErrorReport Of hoXml
            Send Destroy to hoXML
            Procedure_Return
        End
        // we will need to work from the root node of the XML file
        Get DocumentElement of hoXML to hoRoot
        
        showln 'XML Document loaded'
        
        // --- 2. Load the XSL document ----
        
        Get Create (RefClass(cXMLDOMDocument)) to hoXSL
        
        // Set the name of the document
        Set psDocumentName of hoXSL to (sPath - "\customer.xsl")
        
        // Load the XML document and return an error flag.
        Get LoadXMLDocument of hoXSL to bOK
        If not bOK Begin
            // this will print out a basic error report.
            Send BasicParseErrorReport Of hoXSL
            Send Destroy to hoXSL
            Send Destroy to hoXML
            Procedure_Return
        End
        showln 'XSL Document loaded'
        
        // --- 3. Apply XSL transformation to XML document ----
        
        Get XSLTransformation of hoRoot hoXSL to sHTMLData
        Direct_Output Channel 0 (sPath - "\NewCustomer.html")
        WriteLn Channel 0 sHTMLData
        Close_Output Channel 0
        showln 'XML transformed to HTML and saved'
        
        Send Destroy to hoXSL
        send Destroy of hoXML
    End_Procedure
    
    Object oMessage is a cTextEdit
        Set Size to 22 394
        Set Location to 209 6
        Set Color to clBtnFace
        Set peAnchors to anBottomLeftRight
        Set Read_Only_State to True
        
        Procedure DisplayMessage String sMsg
            Set Value to sMsg
        End_Procedure
        
    End_Object
    
End_Object

