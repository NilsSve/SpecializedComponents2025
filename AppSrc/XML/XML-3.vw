﻿Use FleXML.pkg
Use Customer.dd
Use DFClient.pkg
Use BatchDD.pkg
Use cComWebBrowser.pkg
Use Windows.pkg
Use cTextEdit.pkg

ACTIVATE_VIEW Activate_oXMLSample3 FOR oXMLSample3

Object oXMLSample3 is a dbView
    Set Border_Style to Border_Thick
    Set Label to "XML - Example 3"
    Set Location to 7 5
    Set Size to 254 405
    Set piMinSize to 254 405
    
    Procedure Activating
        Send DisplayMessage of oMessage ""
    End_Procedure
    
    Object oParseCustomerXML is a BusinessProcess
        
        // This is a very simple example, it just reads the xml file that was
        // generated by the XML-2 sample. If you have reviewed XML-1 and XML-2 this
        // sample should appear very simple and make sense
        
        Set Status_Panel_State to FALSE
        
        Procedure OnProcess
            Handle hoXML hoRoot hoList hoCust
            Integer iItems i
            Boolean bOK
            String sDataPath sNamespace
            
            Get Create (RefClass(cXMLDOMDocument)) To hoXML
            Get psDataPath Of (phoWorkspace(ghoApplication)) To sDataPath
            Get PathAtIndex Of (phoWorkspace(ghoApplication)) sDataPath 1 To sDataPath
            
            Set psDocumentName Of hoXML To (sDatapath - "\Mycustomer.xml")
            Set pbValidateOnParse of hoXML to True
            
            // Namespace to be used
            Move "http://www.dataaccess.com/Customers" to sNamespace
            
            // psSelectionNamespaces must contain a prefix for each namespace it stores
            // This has to be set in order to use FindNode and FindNodeList
            Set psSelectionNamespaces of hoXML to ("xmlns:cust='" - sNamespace - "'")
            
            Get LoadXMLDocument Of hoXML To bOK
            
            If Not bOK Begin
                Send BasicParseErrorReport Of hoXml
            End
            Else Begin
                Showln 'loaded'
                Get DocumentElement of hoXML to hoRoot
                
                // create a collection node of all customers
                // When using namespaces, FindNodeList must include a prefix
                // that identifies the namespace in Use
                Get FindNodeList of hoRoot "cust:Customer" to hoList
                Get NodeListLength Of hoList To iItems
                Decrement iItems
                For i From 0 To iItems
                    Get CollectionNode Of hoList i To hoCust
                    Send ShowCust hoCust sNamespace
                    Send Destroy To hoCust
                Loop
                Send Destroy To hoList
            End
            Send Destroy Of hoXML
        End_Procedure
        
        Procedure ShowCust Handle hoCust String sNamespace
            String sId sName sPhone sState
            Handle hoAddress
            
            // If the value was a cDataSection it will be properly translated back
            // to normal text for us.
            Get AttributeValueNS of hoCust "" "Customer-Id" to sId
            Get ChildElementValueNS of hoCust sNamespace "Name" to sName
            Get ChildElementValueNS of hoCust sNamespace "Telephone"     to sPhone
            Get ChildElementNS of hoCust sNamespace "Address" to hoAddress
            Get ChildElementValueNS of hoAddress sNamespace "State" to sState
            Send Destroy of hoAddress
            
            Showln sID ' ' sName ' ' sPhone ' ' sState
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
        
        Set Size to 193 393
        Set Location to 7 7
        Set peAnchors to anAll
        
        Procedure OnCreate
        End_Procedure
        
    End_Object
    
    Object oParseXML is a Button
        Set Label to "Parse the XML file"
        Set Size to 14 129
        Set Location to 236 7
        Set peAnchors to anBottomLeft
        
        Procedure OnClick
            // you send the message DoProcess to run a BPO. This in turn prepares
            // the BPO and calls OnProcess which is where all of your custom go belongs
            Send DoProcess Of oParseCustomerXML
        End_Procedure
        
    End_Object
    
    Object oViewXML is a Button
        Set Label to "View XML File"
        Set Size to 14 129
        Set Location to 236 139
        Set peAnchors to anBottomLeftRight
        
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
        Set Location to 236 271
        Set peAnchors to anBottomRight
        
        Procedure OnClick
            String sPath
            
            Get psHelpPath Of (phoWorkspace(ghoApplication)) To sPath
            Get PathAtIndex Of (phoWorkspace(ghoApplication)) sPath 1 To sPath
            
            Send ComNavigate of oWebBrowser1 (sPath+"\Sample-3-help.html") 0 0 0 0 0
            Send DisplayMessage of oMessage ("View the help HTML file for this application:" * (sPath+"\Sample-3-help.html"))
        End_Procedure
        
    End_Object
    
    Object oMessage is a cTextEdit
        Set Size to 22 394
        Set Location to 206 6
        Set Color to clBtnFace
        Set peAnchors to anBottomLeftRight
        Set Read_Only_State to True
        
        Procedure DisplayMessage String sMsg
            Set Value to sMsg
        End_Procedure
        
    End_Object
    
End_Object

