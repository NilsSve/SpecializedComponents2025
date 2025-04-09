Use Windows.pkg
Use DFClient.pkg
Use statALog.pkg
Use BatchDD.pkg
Use dfSpnFrm.pkg

Use Flexml.pkg
Use FlexCOM20.pkg
Use cCJGrid.pkg
Use cCJGridColumnRowIndicator.pkg
Use cCJGridColumn.pkg

Use Customer.DD
Use SalesP.DD
Use OrderHea.DD
Use Vendor.DD
Use Invt.DD
Use OrderDtl.DD

Define Locale_User_Default for |CI$0400

// From the http://www.dataaccess.com/kbasepublic/KBPrint.asp?ArticleID=1075 knowledgebase article
Define LOCALE_SDAYNAME1 for |CI$0000002A // long name for Monday
Define LOCALE_SDAYNAME2 for |CI$0000002B // long name for Tuesday
Define LOCALE_SDAYNAME3 for |CI$0000002C // long name for Wednesday
Define LOCALE_SDAYNAME4 for |CI$0000002D // long name for Thursday
Define LOCALE_SDAYNAME5 for |CI$0000002E // long name for Friday
Define LOCALE_SDAYNAME6 for |CI$0000002F // long name for Saturday
Define LOCALE_SDAYNAME7 for |CI$00000030 // long name for Sunday

// Documentation: http://msdn.microsoft.com/en-us/library/windows/desktop/bb773621(v=vs.85).aspx
External_Function WinAPI_PathIsDirectory "PathIsDirectoryA" SHLWAPI.DLL Pointer lpszPath Returns Integer

Struct tToBeUsedInvtData
    RowID riInvt
    Integer iMinPrice
    Integer iMaxPrice
End_Struct

Define OLEStreamTypeEnum for Integer
Define OLEadTypeBinary for 1
Define OLEConnectModeEnum for Integer
Define OLEadModeUnknown for 0
Define OLEStreamOpenOptionsEnum for Integer
Define OLEadOpenStreamUnspecified for -1
Define OLESaveOptionsEnum for Integer
Define OLEadSaveCreateOverWrite for 2

// Namespace should be blank to work!
Define C_OrdersGeneratorNS for ''

Activate_View Activate_oOrdersGeneratorView for oOrdersGeneratorView
Object oOrdersGeneratorView is a dbView
    Set Label to "Random Order Generator"
    Set Size to 181 357
    Set Location to 2 2
    // Make the view resizable, min and max size are set in Activating event
    Set Border_Style to Border_Thick
    // Do not store size and location of this view
    Set pbDisableSaveEnvironment to True
    Set pbAutoActivate to True
    
    Object oSettingsHandler is a cObject
        // Have a FleXML object for reading and storing of the
        // preference information in XML
        Object oXMLDocument is a cXMLDOMDocument
        End_Object
        
        // Object for formatting the XML data in human readable format
        Object oXMLReader60 is a cComAutomationObject
            // Set the value of a property.
            Procedure ComPutProperty String llstrName Variant llvarValue
                Handle hDispatchDriver
                Get phDispatchDriver to hDispatchDriver
                Send PrepareParams to hDispatchDriver 2
                Send DefineParam to hDispatchDriver OLE_VT_BSTR llstrName
                Send DefineParam to hDispatchDriver OLE_VT_VARIANT llvarValue
                Send InvokeComMethod to hDispatchDriver 1285 OLE_VT_VOID
            End_Procedure
            
            // Allow an application to register a content event handler or look up the current content event handler.
            { MethodType=Property DesignTime=False }
            Procedure Set ComContentHandler Variant value
                Handle hDispatchDriver
                Get phDispatchDriver to hDispatchDriver
                Send PrepareParams to hDispatchDriver 1
                Set ComProperty of hDispatchDriver 1287 OLE_VT_DISPATCH to value
            End_Procedure
            
            // Allow an application to register a DTD event handler or look up the current DTD event handler.
            { MethodType=Property DesignTime=False }
            Procedure Set ComDtdHandler Variant value
                Handle hDispatchDriver
                Get phDispatchDriver to hDispatchDriver
                Send PrepareParams to hDispatchDriver 1
                Set ComProperty of hDispatchDriver 1288 OLE_VT_DISPATCH to value
            End_Procedure
            
            // Allow an application to register an error event handler or look up the current error event handler.
            { MethodType=Property DesignTime=False }
            Procedure Set ComErrorHandler Variant value
                Handle hDispatchDriver
                Get phDispatchDriver to hDispatchDriver
                Send PrepareParams to hDispatchDriver 1
                Set ComProperty of hDispatchDriver 1289 OLE_VT_DISPATCH to value
            End_Procedure
            
            // Parse an XML document from a system identifier (URI).
            Procedure ComParseURL String llstrURL
                Handle hDispatchDriver
                Get phDispatchDriver to hDispatchDriver
                Send PrepareParams to hDispatchDriver 1
                Send DefineParam to hDispatchDriver OLE_VT_BSTR llstrURL
                Send InvokeComMethod to hDispatchDriver 1293 OLE_VT_VOID
            End_Procedure
            
            Set psProgID to "{88D96A0C-F192-11D4-A65F-0040963251E5}"
            Set peAutoCreate to acNoAutoCreate
        End_Object
        
        // Writer object for formatting the XML data in human readable format
        Object oXMLWriter60 is a cComAutomationObject
            // Set or get the output.
            { MethodType=Property DesignTime=False }
            Procedure Set ComOutput Variant value
                Handle hDispatchDriver
                Get phDispatchDriver to hDispatchDriver
                Send PrepareParams to hDispatchDriver 1
                Set ComProperty of hDispatchDriver 1385 OLE_VT_VARIANT to value
            End_Procedure
            
            // Set or get the output encoding.
            { MethodType=Property DesignTime=False }
            Procedure Set ComEncoding String value
                Handle hDispatchDriver
                Get phDispatchDriver to hDispatchDriver
                Send PrepareParams to hDispatchDriver 1
                Set ComProperty of hDispatchDriver 1387 OLE_VT_BSTR to value
            End_Procedure
            
            // Determine whether or not to write the byte order mark
            { MethodType=Property DesignTime=False }
            Procedure Set ComByteOrderMark Boolean value
                Handle hDispatchDriver
                Get phDispatchDriver to hDispatchDriver
                Send PrepareParams to hDispatchDriver 1
                Set ComProperty of hDispatchDriver 1388 OLE_VT_BOOL to value
            End_Procedure
            
            // Enable or disable auto indent mode.
            { MethodType=Property DesignTime=False }
            Procedure Set ComIndent Boolean value
                Handle hDispatchDriver
                Get phDispatchDriver to hDispatchDriver
                Send PrepareParams to hDispatchDriver 1
                Set ComProperty of hDispatchDriver 1389 OLE_VT_BOOL to value
            End_Procedure
            
            // Set or get the standalone document declaration.
            { MethodType=Property DesignTime=False }
            Procedure Set ComStandalone Boolean value
                Handle hDispatchDriver
                Get phDispatchDriver to hDispatchDriver
                Send PrepareParams to hDispatchDriver 1
                Set ComProperty of hDispatchDriver 1390 OLE_VT_BOOL to value
            End_Procedure
            
            // Determine whether or not to omit the XML declaration.
            { MethodType=Property DesignTime=False }
            Procedure Set ComOmitXMLDeclaration Boolean value
                Handle hDispatchDriver
                Get phDispatchDriver to hDispatchDriver
                Send PrepareParams to hDispatchDriver 1
                Set ComProperty of hDispatchDriver 1391 OLE_VT_BOOL to value
            End_Procedure
            
            Set psProgID to "{88D96A0F-F192-11D4-A65F-0040963251E5}"
            Set peAutoCreate to acNoAutoCreate
        End_Object
        
        // To avoid string limitations and OEM conversions write the XML
        // information directly via this stream object
        Object oADOStream is a cComAutomationObject
            { MethodType=Property DesignTime=False }
            Procedure Set ComType OLEStreamTypeEnum value
                Handle hDispatchDriver
                Get phDispatchDriver to hDispatchDriver
                Send PrepareParams to hDispatchDriver 1
                Set ComProperty of hDispatchDriver 4 OLE_VT_I4 to value
            End_Procedure
            
            Procedure ComOpen Variant llSource OLEConnectModeEnum llMode OLEStreamOpenOptionsEnum llOptions String llUserName String llPassword
                Handle hDispatchDriver
                Get phDispatchDriver to hDispatchDriver
                Send PrepareParams to hDispatchDriver 5
                Send DefineParam to hDispatchDriver OLE_VT_VARIANT llSource
                Send DefineParam to hDispatchDriver OLE_VT_I4 llMode
                Send DefineParam to hDispatchDriver OLE_VT_I4 llOptions
                Send DefineParam to hDispatchDriver OLE_VT_BSTR llUserName
                Send DefineParam to hDispatchDriver OLE_VT_BSTR llPassword
                Send InvokeComMethod to hDispatchDriver 10 OLE_VT_VOID
            End_Procedure
            
            Procedure ComClose
                Handle hDispatchDriver
                Get phDispatchDriver to hDispatchDriver
                Send InvokeComMethod to hDispatchDriver 11 OLE_VT_VOID
            End_Procedure
            
            Procedure ComSaveToFile String llFileName OLESaveOptionsEnum llOptions
                Handle hDispatchDriver
                Get phDispatchDriver to hDispatchDriver
                Send PrepareParams to hDispatchDriver 2
                Send DefineParam to hDispatchDriver OLE_VT_BSTR llFileName
                Send DefineParam to hDispatchDriver OLE_VT_I4 llOptions
                Send InvokeComMethod to hDispatchDriver 17 OLE_VT_VOID
            End_Procedure
            
            Set psProgID to "{00000566-0000-0010-8000-00AA006D2EA4}"
            Set peAutoCreate to acNoAutoCreate
        End_Object
        
        // Returns the document root handle. Creates one if it did not
        // exist yet.
        Function OrdersGeneratorSettings Returns Handle
            String sFileName sDataPath sHomeFolder
            Handle hoWorkspace hoRoot
            Boolean bOk
            Integer iPaths iPath
            
            Get DocumentElement of oXMLDocument to hoRoot
            If (hoRoot <> 0) Begin
                Function_Return hoRoot
            End
            
            // Find this file in the paths of DF_OPEN_PATH. If found the filename
            // contains name and path. If not found the filename will be empty
            Get_File_Path "OrdersGenerator.XML" to sFileName
            If (sFileName = "") Begin
                // If filename is empty create a new file
                Get phoWorkspace of ghoApplication to hoWorkspace
                Get psDataPath of hoWorkspace to sDataPath
                Get CountOfPaths of hoWorkspace sDataPath to iPaths
                // Find the first folder in the path that is a valid directory
                For iPath from 1 to iPaths
                    Get PathAtIndex of hoWorkspace sDataPath 1 to sDataPath
                    If (Right (sDataPath, 1) <> Sysconf (SYSCONF_DIR_SEPARATOR)) Begin
                        Move (sDataPath - Sysconf (SYSCONF_DIR_SEPARATOR)) to sDataPath
                    End
                    Move (WinAPI_PathIsDirectory (AddressOf (sDataPath))) to bOk
                    If (bOk) ;
                        Break
                Loop
                If (bOk) Begin
                    Move (sDataPath + "OrdersGenerator.XML") to sFileName
                End
                Else Begin
                    // If no valid folders in the datapath use the home folder!
                    Get psHome of hoWorkspace to sHomeFolder
                    If (Right (sHomeFolder, 1) <> Sysconf (SYSCONF_DIR_SEPARATOR)) Begin
                        Move (sHomeFolder - Sysconf (SYSCONF_DIR_SEPARATOR)) to sHomeFolder
                    End
                    Move (sHomeFolder + "OrdersGenerator.XML") to sFileName
                End
                Set psDocumentName of oXMLDocument to sFileName
                Get CreateDocumentElementNS of oXMLDocument C_OrdersGeneratorNS 'GeneratorData' to hoRoot
                If (hoRoot <> 0) Begin
                    Function_Return hoRoot
                End
            End
            Else Begin
                Set psDocumentName of oXMLDocument to sFileName
                Get LoadXMLDocument of oXMLDocument to bOk
                If (bOk) Begin
                    Get DocumentElement of oXMLDocument to hoRoot
                    Function_Return hoRoot
                End
            End
            
            Function_Return 0
        End_Function
        
        // First save the XML file using the FleXML object that collects all the
        // settings and then use the XML formatter objects declared above and
        // described in the http://support.dataaccess.com/Forums/entry.php?170-How-to-make-an-XML-file-look-nice blog
        Function SaveXMLDocument Returns Integer
            Integer iResult
            String sFile
            Variant vWriter vStream
            
            Get SaveXMLDocument of oXMLDocument to iResult
            If (iResult = 0) Begin
                Get psDocumentName of oXMLDocument to sFile
                
                Send CreateComObject of oADOStream
                Get pvComObject of oADOStream to vStream
                
                Send ComOpen of oADOStream Nothing OLEadModeUnknown OLEadOpenStreamUnspecified '' ''
                Set ComType of oADOStream to OLEadTypeBinary
                
                Send CreateComObject of oXMLReader60
                
                Send CreateComObject of oXMLWriter60
                Get pvComObject of oXMLWriter60 to vWriter
                
                Set ComStandalone of oXMLWriter60 to True
                Set ComByteOrderMark of oXMLWriter60 to False
                Set ComEncoding of oXMLWriter60 to "utf-8"
                Set ComIndent of oXMLWriter60 to True
                Set ComOmitXMLDeclaration of oXMLWriter60 to True
                
                Set ComContentHandler of oXMLReader60 to vWriter
                Set ComDtdHandler of oXMLReader60 to vWriter
                Set ComErrorHandler of oXMLReader60 to vWriter
                
                Send ComPutProperty of oXMLReader60 "http://xml.org/sax/properties/lexical-handler" vWriter
                Send ComPutProperty of oXMLReader60 "http://xml.org/sax/properties/declaration-handler" vWriter
                
                Set ComOutput of oXMLWriter60 to vStream
                
                Send ComParseURL of oXMLReader60 sFile
                Send ComSaveToFile of oADOStream sFile OLEadSaveCreateOverWrite
                Send ComClose of oADOStream
                
                Send ReleaseComObject of oADOStream
                Send ReleaseComObject of oXMLWriter60
                Send ReleaseComObject of oXMLReader60
            End
            
            Function_Return iResult
        End_Function
    End_Object
    
    // The reset (delete) process requires different filters and different business rules
    // around update and backout than the creation process. That's why there are two
    // BusinessProcess objects in this view.
    Object oResetBPO is a BusinessProcess
        Object oVendor_DD is a Vendor_DataDictionary
        End_Object
        
        Object oInvt_DD is a Invt_DataDictionary
            Set DDO_Server to oVendor_DD
        End_Object
        
        Object oSalesP_DD is a SalesP_DataDictionary
        End_Object
        
        Object oCustomer_DD is a Customer_DataDictionary
            // Remove the displayonly flag to make updating of the values possible
            Set Field_Option Field Customer.Balance DD_DISPLAYONLY to False
            Set Field_Option Field Customer.Purchases DD_DISPLAYONLY to False
            // Not all customers have a valid e-mail address
            Set Field_Validate_msg Field Customer.EMail_Address to 0
        End_Object
        
        Object oOrderHea_DD is a OrderHea_DataDictionary
            Set Constrain_file to Customer.File_number
            Set DDO_Server to oSalesP_DD
            Set DDO_Server to oCustomer_DD
            
            // Cancelled, no updates or running totals
            Procedure Update
            End_Procedure
            
            Procedure Backout
            End_Procedure
            
            // Do not as in the class attempt to change the last order number
            Procedure Deleting
            End_Procedure
        End_Object
        
        Object oOrderDtl_DD is a OrderDtl_DataDictionary
            Set Constrain_file to OrderHea.File_number
            Set DDO_Server to oInvt_DD
            Set DDO_Server to oOrderHea_DD
            
            // Cancelled, no updates or running totals
            Procedure Update
            End_Procedure
            
            Procedure Backout
            End_Procedure
        End_Object
        
        Set Main_DD to oCustomer_DD
        Set Process_Title to "Resetting the System"
        Set Process_Caption to "Random Order Generator"
        
        Procedure UpdateMessageText String sMessageText
            Handle hoStatusPanel
            
            Get Status_Panel_Id to hoStatusPanel
            If (hoStatusPanel <> 0) Begin
                Set Message_Text of hoStatusPanel to sMessageText
            End
        End_Procedure
        
        Procedure OnProcess
            Boolean bErr
            Integer eOpenMode
            
            Send UpdateMessageText "Reset Last Used OrderNumber"
            
            Reread
            Move 0 to DFLastID.Order_Number
            SaveRecord DFLastID
            Unlock
            
            Close Orderhea
            Open OrderHea Mode DF_EXCLUSIVE
            Get_Attribute DF_FILE_OPEN_MODE of OrderHea.File_Number to eOpenMode
            If (eOpenMode = DF_EXCLUSIVE) Begin
                ZeroFile OrderHea
                Close Orderhea
                Open Orderhea
                
                Close OrderDtl
                Open OrderDtl Mode DF_EXCLUSIVE
                Get_Attribute DF_FILE_OPEN_MODE of OrderDtl.File_Number to eOpenMode
                If (eOpenMode = DF_EXCLUSIVE) Begin
                    ZeroFile OrderDtl
                    Close OrderDtl
                    Open OrderDtl
                    
                    Send UpdateCustomerTotals
                    Procedure_Return
                End
            End
            
            // If zerofile was succesfull the code will not reach this loop
            Send Clear of oCustomer_DD
            Send Find of oCustomer_DD FIRST_RECORD 1
            While (Found)
                Send Find of oOrderHea_DD FIRST_RECORD 1
                Send Update_Status ("Deleting Order:" * String (OrderHea.Order_Number))
                While (Found)
                    Send Find of oOrderDtl_DD FIRST_RECORD 1
                    While (Found)
                        Send Request_Delete of oOrderDtl_DD
                        Send Find of oOrderDtl_DD NEXT_RECORD 1
                    Loop
                    Send Request_Delete of oOrderHea_DD
                    Send Find of oOrderHea_DD NEXT_RECORD 1
                Loop
                Set Field_Changed_Value of oCustomer_DD Field Customer.Purchases to 0
                Set Field_Changed_Value of oCustomer_DD Field Customer.Balance to 0
                Get Request_Validate of oCustomer_DD to bErr
                If (not (bErr)) Begin
                    Send Request_Save of oCustomer_DD
                End
                Send Find of oCustomer_DD NEXT_RECORD 1
            Loop
        End_Procedure
        
        // Gets only called when the zerofile of orderhea and orderdtl worked fine.
        // The code sets the purchases and balance values to 0.
        Procedure UpdateCustomerTotals
            Boolean bErr
            
            Send Clear of oCustomer_DD
            Send Find of oCustomer_DD FIRST_RECORD 1
            While (Found)
                Send UpdateMessageText ("Customer:" * Customer.Name)
                Set Field_Changed_Value of oCustomer_DD Field Customer.Purchases to 0
                Set Field_Changed_Value of oCustomer_DD Field Customer.Balance to 0
                Get Request_Validate of oCustomer_DD to bErr
                If (not (bErr)) Begin
                    Send Request_Save of oCustomer_DD
                End
                Send Find of oCustomer_DD NEXT_RECORD 1
            Loop
        End_Procedure
    End_Object
    
    Object oOrdersGeneratorBPO is a BusinessProcess
        Object oVendor_DD is a Vendor_DataDictionary
        End_Object
        
        Object oInvt_DD is a Invt_DataDictionary
            Set DDO_Server to oVendor_DD
        End_Object
        
        Object oSalesP_DD is a SalesP_DataDictionary
        End_Object
        
        Object oCustomer_DD is a Customer_DataDictionary
            // Not all customers have a valid e-mail address
            Set Field_Validate_msg Field Customer.EMail_Address to 0
            // Remove the NO_PUT value to be able to update the value at the end of order creation
            Set Field_Option Field Customer.Balance DD_NOPUT to False
        End_Object
        
        Object oOrderHea_DD is a OrderHea_DataDictionary
            Set DDO_Server to oSalesP_DD
            Set DDO_Server to oCustomer_DD
        End_Object
        
        Object oOrderDtl_DD is a OrderDtl_DataDictionary
            Set Constrain_file to OrderHea.File_number
            Set DDO_Server to oInvt_DD
            Set DDO_Server to oOrderHea_DD
            
            // Overwritten to not update the invt on hand value. Do not forward send this event.
            Procedure Adjust_Balances Number Qty Number Amt
                Add Amt to OrderHea.Order_Total
            End_Procedure
        End_Object
        
        Object oStatusLog is a StatusAsciiLog
            // To avoid the log file is not fully written to disk when shown at the
            // end of the process close the file each time data is logged. It will slow down the
            // logging a little bit but it should not be really measurable.
            Set Close_Always_State to True
        End_Object
        
        Set Main_DD to oOrderHea_DD
        Set Process_Title to "Creating Orders"
        Set Process_Caption to "Random Order Generator"
        Set Allow_Cancel_State to True
        Set Status_Log_Id to oStatusLog
        
        // The BusinessProcess class does not contain a function to update the message text of the statuspanel
        Procedure UpdateMessageText String sMessageText
            Handle hoStatusPanel
            
            Get Status_Panel_Id to hoStatusPanel
            If (hoStatusPanel <> 0) Begin
                Set Message_Text of hoStatusPanel to sMessageText
            End
        End_Procedure
        
        // Self written function to compare two ROWID values, used in the InvtDataAvailable function.
        Function Compare2RowIds RowID riFromArray RowID riToBeFound Returns Integer
            If (IsSameRowID (riFromArray, riToBeFound)) Begin
                Function_Return (EQ)
            End
            
            Function_Return (NE)
        End_Function
        
        // The operator can set the weight of an INVT item which makes that item appear more times in the
        // array. But when ONE order should not contain the same INVT item twice it needs to be removed
        // from the array of available INVT items when used. If the INVT is used it is not permanently removed
        // but only here.
        Function InvtDataAvailable tToBeUsedInvtData[] AvailableInvtData RowID[] riUsedInvt Returns Boolean
            Integer iElements iElement iFoundElement
            Boolean bAvailable
            
            Move (SizeOfArray (AvailableInvtData)) to iElements
            If (iElements > 0) Begin
                // First remove duplicates
                Decrement iElements
                For iElement from 0 to iElements
                    Move (SearchArray (AvailableInvtData[iElement].riInvt, riUsedInvt, Self, (RefFunc (Compare2RowIds)))) to iFoundElement
                    If (iFoundElement <> -1 and iFoundElement <> iElement) Begin
                        Move (RemoveFromArray (AvailableInvtData, iFoundElement)) to AvailableInvtData
                        Decrement iElements
                    End
                Loop
                Move (SizeOfArray (AvailableInvtData) > 1) to bAvailable
            End
            
            Function_Return bAvailable
        End_Function
        
        
        // Generates dates to be used in new orders
        Function GenerateNewOrderDate Date[] dSelectedDateRange Integer iOrders Date dLastDateUsed Integer[] iWeekDays Returns Date
            Date dOrderDate dNewOrderDate
            Integer iNumDays iWeekDaysItems iDayOfWeekFromVariation iDayOfWeek
            Boolean bDateOK
            Integer iMaxGap
            
            Move 5 to iMaxGap // max gap desired between order dates
            
            // current gap between initial date and end date
            Move (Integer (dSelectedDateRange[1]) - Integer (dLastDateUsed)) to iNumDays
            // adjust gap if there are not that many days between dates
            If (iNumDays < iMaxGap) Begin
                Move iNumDays to iMaxGap
            End
            
            Move (SizeOfArray(iWeekDays)) to iWeekDaysItems
            
            // generate order date
            Move (dLastDateUsed + (Random (iMaxGap))) to dOrderDate
            
            Move (iWeekDays[Random (iWeekDaysItems)]) to iDayOfWeekFromVariation
            Move (DateGetDayOfWeek (dOrderDate)) to iDayOfWeek
            If (iDayOfWeek <> iDayOfWeekFromVariation) Begin
                If (iDayOfWeek > iDayOfWeekFromVariation) Begin
                    Repeat
                        // Subtract a number of days
                        Move (dOrderDate - (iDayOfWeek - iDayOfWeekFromVariation)) to dNewOrderDate
                        // Date cannot be before the startdate
                        While (dNewOrderDate < dLastDateUsed)
                            Move (dLastDateUsed + Random (iMaxGap)) to dNewOrderDate
                        Loop
                        // Determine if the new weekday number of the new date is in the list of days for
                        // which orders should be generated. If not repeat the new order date selection
                        // again.
                        Move (DateGetDayOfWeek (dNewOrderDate)) to iDayOfWeek
                        If (SearchArray (iDayOfWeek, iWeekDays) = -1) Begin
                            Move (iWeekDays[Random (iWeekDaysItems)]) to iDayOfWeekFromVariation
                            Move False to bDateOk
                        End
                        Else Begin
                            Move True to bDateOk
                        End
                    Until (bDateOk)
                    Move dNewOrderDate to dOrderDate
                End
                Else Begin
                    Repeat
                        // Add a number of days
                        Move (dOrderDate + (iDayOfWeekFromVariation - iDayOfWeek)) to dNewOrderDate
                        // Avoid the date is after the enddate
                        While (dNewOrderDate > dSelectedDateRange[1])
                            Move (dSelectedDateRange[1] - Random (iMaxGap)) to dNewOrderDate
                        Loop
                        // Determine if the new weekday number of the new date is in the list of days for
                        // which orders should be generated. If not repeat the new order date selection
                        // again.
                        Move (DateGetDayOfWeek (dNewOrderDate)) to iDayOfWeek
                        If (SearchArray (iDayOfWeek, iWeekDays) = -1) Begin
                            Move (iWeekDays[Random (iWeekDaysItems)]) to iDayOfWeekFromVariation
                            Move False to bDateOk
                        End
                        Else Begin
                            Move True to bDateOk
                        End
                    Until (bDateOk)
                    Move dNewOrderDate to dOrderDate
                End
            End
            
            Function_Return dOrderDate
        End_Function
        
        
        
        Procedure OnProcess
            Date[] dRange
            Date dOrderDate dLastOrderDateUsed
            Integer iChoice iOrdersToGenerate iOrderCount
            Integer iCustomerElement iCustomerElements iWeight iRows iRow
            Integer iSalesPersonElement iSalesPersonElements
            Integer iInvtElement iInvtElements iStateElements iOrderedByNames
            Integer iShipViaItems iTermsItems iOrderDetailCount iOrderDetailLinesToGenerate
            Integer iDays iDayOfWeek iQty iPricePercentage iWeekDaysItems
            Integer[] iOrderDetailLines iQTYVariations iCustomerNumbers iWeekDays
            Boolean bErr bStopProcess bDuplicatesAllowed bAvailable bDateOk
            String[] sSalesPersons sTermsCodes sShipViaCodes sStatesCodes sOrderedByNames
            tToBeUsedInvtData[] ToBeUsedInvtData AvailableInvtData
            Number nUnitPrice
            RowID[] riUsedInvt
            Variant[][] vOrderDates
            
            // Find out if the operator wants to create orders in a date range, a year or want to use
            // a table with ordernumbers per quarter.
            Get Current_Radio of oDateRangeHelperGroup to iChoice
            Case Begin
                Case (iChoice = 0)
                    Get Value of oFromDateForm to dRange[0]
                    Get Value of oToDateForm to dRange[1]
                    // Make sure the from date is the first value
                    Move (SortArray (dRange)) to dRange
                    Get Value of oNumberOfOrdersForm to iOrdersToGenerate
                    Send Log_Status "Selected date distribution: Date Range"
                    Case Break
                Case (iChoice = 1)
                    Get Value of oYearFromDateForm to dRange[0]
                    Get Value of oYearToDateForm to dRange[1]
                    // Make sure the from date is the first value
                    Move (SortArray (dRange)) to dRange
                    Get Value of oYearNumberOfOrdersForm to iOrdersToGenerate
                    Send Log_Status "Selected date distribution: Year"
                    Case Break
                Case (iChoice = 1)
                    Send Log_Status "Selected date distribution: Quarter range"
                    Case Break
            Case End
            
            
            // This call returns an array with weekday numbers where the weight specified
            // in the input makes a weekday number appear 0-N times. The number of elements
            // in the array is stored in iWeekDaysItems
            Get ToBeUsedWeekDays of oWeekDayVariationGrid (&iWeekDays) to iWeekDaysItems
            Send Log_Status ("Constructing list of weekdays finished; set of" * String (iWeekDaysItems) * "elements created")
            
            // Can ONE order have multiple order detail lines with the same INVT item?
            Get Checked_State of oInvtItemDuplicatesCheckBox to bDuplicatesAllowed
            If (bDuplicatesAllowed) Begin
                Send Log_Status "Two or more order detail lines with the same INVT item are allowed"
            End
            Else Begin
                Send Log_Status "Two or more order detail lines with the same INVT item are NOT allowed"
            End
            
            // This function returns an array of INVT items. Each element of the variable contains
            // a ROWID and a minimum / maximum price range. The weight of the INVT item makes it
            // appearing 0-N times in the array. The unique number of INVT items to be used is
            // stored in iInvtElements
            Get ToBeUsedInvt of oInventoryGrid (&ToBeUsedInvtData) bDuplicatesAllowed to iInvtElements
            Send Log_Status ("Constructing list of invt items finished; set of" * String (iInvtElements) * "elements (invt * weight) created")
            
            // How many order detail lines should be generated. A min/max value can be
            // set by the operator and a number between min and max is randomly selected
            // for each order.
            Get Value of oMinOrderDetailLinesForm to iOrderDetailLines[0]
            Get Value of oMaxOrderDetailLinesForm to iOrderDetailLines[1]
            // If the operator entered the min max values in the wrong order (high first)
            // the sorting takes care of that.
            Move (SortArray (iOrderDetailLines)) to iOrderDetailLines
            // Cannot have more order detail lines than there are invt rows
            Move (iInvtElements min iOrderDetailLines[1]) to iOrderDetailLinesToGenerate
            Send Log_Status ("Minimum number of order detail lines:" * String (iOrderDetailLines[0]) * "; maximum:" * String (iOrderDetailLinesToGenerate))
            
            // How many articles should be used for ONE order detail line? The operator
            // specfies the range and the code randomly selects a value between the minimum
            // and maximum values
            Get Value of oMinQTYVariationForm to iQTYVariations[0]
            Get Value of oMaxQTYVariationForm to iQTYVariations[1]
            // If the operator entered the min max values in the wrong order (high first)
            // the sorting takes care of that.
            Move (SortArray (iQTYVariations)) to iQTYVariations
            Send Log_Status ("QTY variation between:" * String (iQTYVariations[0]) * "and" * String (iQTYVariations[1]))
            
            // This function returns an array of states where the weight determines how important
            // a state is. A higher weight puts more state codes in the array. The number of
            // elements in the array is stored in iStateElements
            Get ToBeUsedStates of oStatesGrid (&sStatesCodes) to iStateElements
            Send Log_Status ("Constructing list of states finished; set of" * String (iStateElements) * "elements created")
            
            // Reading the customer table. Depending on the weight of the state the customer
            // appears more often in the array of customers to select from when an order is
            // created.
            Send UpdateMessageText "Reading Customers"
            Send Clear of oCustomer_DD
            Send Request_Read of oCustomer_DD FIRST_RECORD Customer.File_Number 1
            While (Found)
                Send Update_Status ("Name:" * Customer.Name)
                Move (CountArray (Customer.State, sStatesCodes)) to iWeight
                While (iWeight > 0)
                    Move Customer.Customer_Number to iCustomerNumbers[iCustomerElement]
                    Increment iCustomerElement
                    Decrement iWeight
                Loop
                Send Locate_Next of oCustomer_DD
            Loop
            Send Log_Status ("Reading customers finished; set of" * String (iCustomerElement) * "elements (customer * weight) created")
            
            // A little more random by first randomize the array
            Move (ShuffleArray (iCustomerNumbers)) to iCustomerNumbers
            Move (SizeOfArray (iCustomerNumbers)) to iCustomerElements
            
            // This function returns an array of sales persons where again the weight determines
            // how many times the salesperson ID is stored in the array. That makes the choice of
            // the sales person more random. The number of elements in the array is stored in
            // iSalesPersonElements. The function itself shuffles the array values.
            Get ToBeUsedSalesPersons of oSalesPersonGrid (&sSalesPersons) to iSalesPersonElements
            Send Log_Status ("Constructing list of sales people finished; set of" * String (iSalesPersonElements) * "elements (Salespersons * Weight) created")
            
            // This function returns an array of Term codes where the weight determines how
            // often a value appears in the array. The number of array elements is stored in iTermItems
            Get ToBeUsedTerms of oTermsGrid (&sTermsCodes) to iTermsItems
            Send Log_Status ("Constructing list of term values finished; set of" * String (iTermsItems) * "elements (Terms * Weight) created")
            
            // This function returns an array of ShipVia codes where the weight determines how
            // often a value appears in the array. The number of array elements is stored in iShipViaItems
            Get ToBeUsedShipViaCodes of oShipViaGrid (&sShipViaCodes) to iShipViaItems
            Send Log_Status ("Constructing list of ShipVia values finished; set of" * String (iShipViaItems) * "elements (ShipVia * Weight) created")
            
            // This function returns an array of OrderedBy names where the weight determines how
            // often a value appears in the array. The number of array elements is stored in iOrderedByNames
            Get ToBeUsedOrderedBy of oOrderedByGrid (&sOrderedByNames) to iOrderedByNames
            Send Log_Status ("Constructing list of ordered by names finished; set of" * String (iOrderedByNames) * "elements (Orderby * Weight) created")
            
            If (iChoice < 2) Begin
                // Only one set of orderheaders to be created
                Move 0 to iRows
            End
            Else Begin
                // Collect a table with order date ranges in a 2 dimensional array
                Get ToBeCreatedOrders of oOrdersGrid to vOrderDates
                Move (SizeOfArray (vOrderDates)) to iRows
                Decrement iRows
            End
            
            For iRow from 0 to iRows
                // Start a new transaction
                Begin_Transaction
                
                If (iChoice = 2) Begin
                    // Get the next set of order dates
                    Move vOrderDates[iRow][2] to iOrdersToGenerate
                    Move vOrderDates[iRow][0] to dRange[0]
                    Move vOrderDates[iRow][1] to dRange[1]
                End
                
                // How many days between begin and end of the period?
                Move (Integer (dRange[1]) - Integer (dRange[0])) to iDays
                Send Log_Status ("Generating" * String (iOrdersToGenerate) * "orders from" * String (dRange[0]) * "to" * String (dRange[1]) * "(" * String (iDays) * "days)")
                
                // set dLastOrderDateUsed to be the same as initial date selected to seed the first date generation
                Move dRange[0] to dLastOrderDateUsed
                
                For iOrderCount from 1 to iOrdersToGenerate
                    Get Cancel_Check to bStopProcess
                    If (bStopProcess) Begin
                        // If the user clicked the cancel button abort both loops
                        Move iOrdersToGenerate to iOrderCount
                        Move iRows to iRow
                    End
                    Else Begin
                        // Inform the user about the status
                        If (iRows > 0) Begin
                            Send UpdateMessageText ("Creating Order" * String (iOrderCount) * "of" * String (iOrdersToGenerate) * ". Set" * String (iRow + 1) * "of" * String (iRows + 1))
                        End
                        Else Begin
                            Send UpdateMessageText ("Creating Order" * String (iOrderCount) * "of" * String (iOrdersToGenerate))
                        End
                        
                        // Clear orderheader and all parent tables. Clears orderdtl as it is constrained
                        Send Clear of oOrderHea_DD
                        
                        // Randomly select a customer
                        Move iCustomerNumbers[(Random (iCustomerElements))] to Customer.Customer_Number
                        Send Find of oCustomer_DD EQ 1
                        
                        // Randomly select a salesperson
                        Move sSalesPersons[(Random (iSalesPersonElements))] to SalesP.ID
                        Send Find of oSalesP_DD EQ 1
                        
                        // Randomly set a ordered by name
                        Set Field_Changed_Value of oOrderHea_DD Field OrderHea.Ordered_By to sOrderedByNames[Random (iOrderedByNames)]
                        
                        // Randomly select an order date and correct the date if the weekday
                        // is not within the weight range of weekdays
                        Get GenerateNewOrderDate dRange iOrdersToGenerate dLastOrderDateUsed iWeekDays to dOrderDate
                        
                        // Store the created orderdate
                        Set Field_Changed_Value of oOrderHea_DD Field OrderHea.Order_Date to dOrderDate
                        // save the last order date actually used in an order
                        Move dOrderDate to dLastOrderDateUsed
                        
                        // Pick from the available ship via codes
                        Set Field_Changed_Value of oOrderHea_DD Field OrderHea.Ship_Via to sShipViaCodes[Random (iShipViaItems)]
                        // Pick from the available term codes
                        Set Field_Changed_Value of oOrderHea_DD Field OrderHea.Terms to sTermsCodes[Random (iTermsItems)]
                        
                        // Check if the order header record or any of its parents is OK with the save
                        Get Request_Validate of oOrderHea_DD to bErr
                        If (not (bErr)) Begin
                            Send Request_Save of oOrderHea_DD
                            Move (Err) to bErr
                            If (not (bErr)) Begin
                                // Start generating order detail lines
                                // The AvailableInvtData will be changed during this process; start with a original set
                                Move ToBeUsedInvtData to AvailableInvtData
                                // Randomly select a number of order detail lines but avoid that more order detail
                                // lines are created than there are invt rows
                                Move ((Random (iOrderDetailLines[1]) max iOrderDetailLines[0]) min iInvtElements) to iOrderDetailLinesToGenerate
                                // Reset the array of used INVT ROWIDs
                                Move (ResizeArray (riUsedInvt, 0)) to riUsedInvt
                                
                                For iOrderDetailCount from 1 to iOrderDetailLinesToGenerate
                                    Send Clear of oOrderDtl_DD
                                    
                                    Send Update_Status ("Creating Order Detail" * String (iOrderDetailCount) * "of" * String (iOrderDetailLinesToGenerate))
                                    
                                    // Find an INVT item to be used. If 2 or more details lines with the same INVT item
                                    // are not allowed and the selected INVT item is chosen before, select a different
                                    Move (SizeOfArray (AvailableInvtData)) to iInvtElements
                                    Move (Random (iInvtElements)) to iInvtElement
                                    If (not (bDuplicatesAllowed)) Begin
                                        Get InvtDataAvailable AvailableInvtData riUsedInvt to bAvailable
                                        If (bAvailable) Begin
                                            While (SearchArray (AvailableInvtData[iInvtElement].riInvt, riUsedInvt, Self, (RefFunc (Compare2RowIds))) <> -1)
                                                Move (Random (iInvtElements)) to iInvtElement
                                            Loop
                                        End
                                        Else Begin
                                            Move iOrderDetailLinesToGenerate to iOrderDetailCount
                                        End
                                    End
                                    
                                    // This condition can be false if there are no more INVT items available
                                    If (iOrderDetailCount <> iOrderDetailLinesToGenerate) Begin
                                        // Find the INVT row
                                        Send FindByRowId of oInvt_DD Invt.File_Number AvailableInvtData[iInvtElement].riInvt
                                        
                                        // Randomly select a number of items ordered and set it in the local buffer
                                        Move (Random (iQTYVariations[1] - iQTYVariations[0]) max 1) to iQty
                                        Set Field_Changed_Value of oOrderDtl_DD Field OrderDtl.Qty_Ordered to iQty
                                        
                                        // Randomly make a sales price based on the price of the INVT row and the
                                        // percentage min and max. This way you can have INVT items added that
                                        // are sold with a "discount" and also sold with a "profit"
                                        Move (Random (Abs (AvailableInvtData[iInvtElement].iMaxPrice - AvailableInvtData[iInvtElement].iMinPrice)) + AvailableInvtData[iInvtElement].iMinPrice) to iPricePercentage
                                        Get Field_Current_Value of oInvt_DD Field Invt.Unit_Price to nUnitPrice
                                        Move (nUnitPrice + (nUnitPrice / 100.0 * iPricePercentage)) to nUnitPrice
                                        Set Field_Changed_Value of oOrderDtl_DD Field OrderDtl.Price to nUnitPrice
                                        
                                        // Check if the order detail row is ready to be created
                                        Get Request_Validate of oOrderDtl_DD to bErr
                                        If (not (bErr)) Begin
                                            Send Request_Save of oOrderDtl_DD
                                            Move (Err) to bErr
                                            If (not (bErr)) Begin
                                                // Add the used INVT ROWId to the array of used ROWIDs
                                                Move AvailableInvtData[iInvtElement].riInvt to riUsedInvt[SizeOfArray (riUsedInvt)]
                                                // Remove the selected INVT element from the array of available INVT items
                                                Move (RemoveFromArray (AvailableInvtData, iInvtElement)) to AvailableInvtData
                                            End
                                        End
                                        If (bErr) Begin
                                            If (LastErr <> DFERR_NUMBER_TOO_LARGE) Begin
                                                // If the row could not be created just retry with another itemid
                                                Decrement iOrderDetailCount
                                            End
                                        End
                                    End
                                Loop
                            End
                            Else Begin
                                // In case of an error just try to create another order
                                Decrement iOrderCount
                            End
                        End
                        Else Begin
                            // In case of an error just try to create another order
                            Decrement iOrderCount
                        End
                    End
                Loop
                
                // Close this set transaction
                End_Transaction
            Loop
            
            // Correct balance due
            Send AdjustBalanceDue
            // Correct credit limit is desired
            Send AdjustCreditLimit
        End_Procedure
        
        Procedure AdjustCreditLimit
            Boolean bAdjustCreditLimit bErr
            Handle hTable
            Integer iQuarter iPreviousQuarter
            Number nPurchases nMaxPurchases
            
            // If the user wants a different credit limit
            Get Checked_State of oCreditLimitCheckBox to bAdjustCreditLimit
            If (bAdjustCreditLimit) Begin
                // Constrain the orderheader rows to a customer and remember the
                // previous setting (which is/should be ZERO).
                Get Constrain_File of oOrderHea_DD to hTable
                Set Constrain_File of oOrderHea_DD to Customer.File_Number
                Send Rebuild_Constraints of oOrderHea_DD
                
                Send UpdateMessageText "Changing Customer Credit Limit"
                Send Clear of oCustomer_DD
                Send Find of oCustomer_DD FIRST_RECORD 1
                While (Found)
                    // For each customer find the purchases sum per quarter. The max sum
                    // will be the new credit limit.
                    Move 0 to iPreviousQuarter
                    Move 0 to nMaxPurchases
                    Send Request_Read of oOrderHea_DD FIRST_RECORD OrderHea.File_Number 2
                    If (Found) Begin
                        While (Found)
                            Move (4 min (DateGetMonth (OrderHea.Order_Date) / 3 + 1)) to iQuarter
                            If (iQuarter <> iPreviousQuarter) Begin
                                Move (nPurchases max nMaxPurchases) to nMaxPurchases
                                Move 0 to nPurchases
                            End
                            Move (nPurchases + OrderHea.Order_Total) to nPurchases
                            Send Locate_Next of oOrderHea_DD
                        Loop
                        
                        Send Update_Status ("Credit Limit from" * String (Customer.Credit_Limit) * "to" * String (nMaxPurchases))
                        Set Field_Changed_Value of oCustomer_DD Field Customer.Credit_Limit to nMaxPurchases
                        Send Log_Status ("Credit Limit change for" * Trim (Customer.Name) * "from" * String (Customer.Credit_Limit) * "to" * String (nMaxPurchases))
                        Get Request_Validate of oCustomer_DD to bErr
                        If (not (bErr)) Begin
                            Send Request_Save of oCustomer_DD
                        End
                    End
                    
                    Send Find of oCustomer_DD NEXT_RECORD 1
                Loop
                
                // Reset contraints
                Set Constrain_File of oOrderHea_DD to hTable
                Send Rebuild_Constraints of oOrderHea_DD
            End
        End_Procedure
        
        // Customer balance is normally increased or decreased by the same value as
        // the purchases. This is OK but it should be decreased if an order is final and payed
        // To simulate this a random percentage is taken from the customer balance.
        Procedure AdjustBalanceDue
            Integer iBalanceCorrectionPercentage
            Number nNewBalance
            Boolean bErr
            
            Get Value of oBalanceDueCorrectionForm to iBalanceCorrectionPercentage
            
            Send UpdateMessageText "Changing Customer Balances"
            Send Clear of oCustomer_DD
            Send Find of oCustomer_DD FIRST_RECORD 1
            While (Found)
                Move (Customer.Balance - (Customer.Balance / 100.0 * (Random (iBalanceCorrectionPercentage)))) to nNewBalance
                Send Update_Status ("Balance from" * String (Customer.Balance) * "to" * String (nNewBalance))
                Send Log_Status ("Balance change for" * Trim (Customer.Name) * "from" * String (Customer.Balance) * "to" * String (nNewBalance))
                Set Field_Changed_Value of oCustomer_DD Field Customer.Balance to nNewBalance
                Get Request_Validate of oCustomer_DD to bErr
                If (not (bErr)) Begin
                    Send Request_Save of oCustomer_DD
                End
                Send Find of oCustomer_DD NEXT_RECORD 1
            Loop
        End_Procedure
        
        // This message is the start of the order generation process. The code starts with an
        // attempt to retrieve a free seq I/O channel and assignment of a log file. The log
        // file will be created in the first folder of the workspace datapath (no test if the
        // folder is valid or not).
        Procedure DoProcess
            Integer iChannel iErrors iPaths iPath
            Handle hoWorkspace
            String sDataPath sFileName sHomeFolder
            Boolean bOk
            
            Move (Seq_New_Channel ()) to iChannel
            If (iChannel >= 0) Begin
                Set Log_Channel of oStatusLog to iChannel
                Get phoWorkspace of ghoApplication to hoWorkspace
                Get psDataPath of hoWorkspace to sDataPath
                Get CountOfPaths of hoWorkspace sDataPath to iPaths
                // Find the first folder in the path that is a valid directory
                For iPath from 1 to iPaths
                    Get PathAtIndex of hoWorkspace sDataPath 1 to sDataPath
                    If (Right (sDataPath, 1) <> Sysconf (SYSCONF_DIR_SEPARATOR)) Begin
                        Move (sDataPath - Sysconf (SYSCONF_DIR_SEPARATOR)) to sDataPath
                    End
                    Move (WinAPI_PathIsDirectory (AddressOf (sDataPath))) to bOk
                    If (bOk) ;
                        Break
                Loop
                If (bOk) ;
                    Begin
                    Move (sDataPath - "OrdersGenerator.Log") to sFileName
                End
                Else Begin
                    // If no valid folders in the datapath use the home folder!
                    Get psHome of hoWorkspace to sHomeFolder
                    If (Right (sHomeFolder, 1) <> Sysconf (SYSCONF_DIR_SEPARATOR)) Begin
                        Move (sHomeFolder - Sysconf (SYSCONF_DIR_SEPARATOR)) to sHomeFolder
                    End
                    Move (sHomeFolder + "OrdersGenerator.Log") to sFileName
                End
                Set Log_Name of oStatusLog to sFileName
                Set Status_Log_State to True
            End
            
            Forward Send DoProcess
            
            // if logging could be done close the channel and see if errors have
            // been generated. If so open an editor to show the file.
            If (iChannel >= 0) Begin
                Send Seq_Release_Channel iChannel
                Set Status_Log_State to False
                
                Get Error_Count to iErrors
                If (iErrors > 0) Begin
                    Runprogram Background "notepad.exe" sFileName
                End
            End
        End_Procedure
    End_Object
    
    Object oSpecsTabDialog is a TabDialog
        Set Size to 158 348
        Set Location to 5 4
        Set peAnchors to anAll
        
        // Used to find out if all the specifications are OK and
        // order generation should be allowed.
        { DesignTime = False }
        Property Boolean pbSpecsOk
        
        Object oOrderHeaderTabPage is a TabPage
            Set Label to "OrderHeader"
            
            Object oVariationTabDialog is a TabDialog
                Set Size to 135 333
                Set Location to 5 5
                Set peAnchors to anAll
                
                Object oGeneralTabPage is a TabPage
                    Set Label to "General"
                    
                    Object oRemoveExistingDataCheckBox is a CheckBox
                        Set Size to 10 50
                        Set Location to 5 5
                        Set Label to "Remove Existing Data"
                        Set Checked_State to False
                    End_Object
                    
                    Object oExplanationTextBox is a TextBox
                        Set Auto_Size_State to False
                        Set Size to 102 217
                        Set Location to 5 106
                        Set Label to "Tick the checkbox to remove existing data. Then choose in all other tab-pages from the available options how to generate the orders."
                        Set Justification_Mode to jMode_Left
                        Set peAnchors to anTopBottomLeft
                    End_Object
                End_Object
                
                Object oOrderAmountTabPage is a TabPage
                    Set Label to "Date Distribution"
                    
                    // The user can select between the following three values
                    Object oDateRangeHelperGroup is a RadioGroup
                        Set Size to 27 197
                        Set Location to 5 5
                        Set Label to "Selector:"
                        Set peAnchors to anTopLeftRight
                        
                        Object oFromToRadio is a Radio
                            Set Size to 10 41
                            Set Location to 11 23
                            Set Label to "From / To"
                        End_Object
                        
                        Object oYearRadio is a Radio
                            Set Size to 10 25
                            Set Location to 11 90
                            Set Label to "Year"
                        End_Object
                        
                        Object oQuarterRadio is a Radio
                            Set Size to 10 35
                            Set Location to 11 140
                            Set Label to "Quarter"
                        End_Object
                        
                        Procedure Notify_Select_State Integer iNewId Integer iOldId
                            Forward Send Notify_Select_State iNewId iOldId
                            
                            // Depending on the current radio make one of the containers
                            // available
                            Set Visible_State of oQuarterContainer to (iNewId = 2)
                            Set Visible_State of oYearContainer to (iNewId = 1)
                            Set Visible_State of oDateRangeContainer to (iNewId = 0)
                            Set Enabled_State of oQuarterContainer to (iNewId = 2)
                            Set Enabled_State of oYearContainer to (iNewId = 1)
                            Set Enabled_State of oDateRangeContainer to (iNewId = 0)
                        End_Procedure
                        
                        Procedure StoreToXMLData
                            Handle hoRoot hoData
                            Integer iChoice
                            
                            Get OrdersGeneratorSettings of oSettingsHandler to hoRoot
                            If (hoRoot <> 0) Begin
                                // Delete an existing XML node with this name if any
                                Get ChildElementNS of hoRoot C_OrdersGeneratorNS "DateRangeChoice" to hoData
                                If (hoData <> 0) Begin
                                    Get RemoveNode of hoRoot hoData to hoData
                                    If (hoData <> 0) Begin
                                        Send Destroy of hoData
                                    End
                                End
                                // Add a node for the DateRangeChoice and its value as attribute
                                Get AddElementNS of hoRoot C_OrdersGeneratorNS "DateRangeChoice" '' to hoData
                                If (hoData <> 0) Begin
                                    Get Current_Radio to iChoice
                                    Send AddAttribute of hoData "Choice" iChoice
                                    Send Destroy of hoData
                                End
                                Send Destroy of hoRoot
                            End
                        End_Procedure
                        
                        Procedure ReadFromXMLData
                            Handle hoRoot hoData
                            Integer iChoice
                            
                            // Preset the current radio to 0; maybe replaced by the XML value
                            Set Current_Radio to 0
                            
                            Get OrdersGeneratorSettings of oSettingsHandler to hoRoot
                            If (hoRoot <> 0) Begin
                                // See if there is a previous choice stored.
                                Get ChildElementNS of hoRoot C_OrdersGeneratorNS "DateRangeChoice" to hoData
                                If (hoData <> 0) Begin
                                    Get AttributeValue of hoData "Choice" to iChoice
                                    Set Current_Radio to iChoice
                                    Send Destroy of hoData
                                End
                                Send Destroy of hoRoot
                            End
                        End_Procedure
                    End_Object
                    
                    Object oDateRangeContainer is a Group
                        Set Size to 75 197
                        Set Location to 34 5
                        Set peAnchors to anTopLeftRight
                        
                        Object oFromDateForm is a Form
                            Set Size to 13 50
                            Set Location to 11 39
                            Set Form_Datatype to Mask_Date_Window
                            Set Label_Col_Offset to 2
                            Set Label_Justification_Mode to JMode_Right
                            Set Label to "From:"
                            Set psToolTip to "Start date for orders creation"
                        End_Object
                        
                        Object oToDateForm is a Form
                            Set Size to 13 50
                            Set Location to 26 39
                            Set Form_Datatype to Mask_Date_Window
                            Set Label_Col_Offset to 2
                            Set Label_Justification_Mode to JMode_Right
                            Set Label to "To:"
                            Set psToolTip to "End date for orders creation"
                        End_Object
                        
                        Object oNumberOfOrdersForm is a Form
                            Set Size to 13 50
                            Set Location to 41 39
                            Set Label to "Orders:"
                            Set Label_Col_Offset to 2
                            Set Form_Datatype to 0
                            Set Label_Justification_Mode to JMode_Right
                            Set psToolTip to "Number of orders to generate in this period"
                            
                            Procedure ValidateSpecs
                                Integer iChoice iValue
                                
                                Get Current_Radio of oDateRangeHelperGroup to iChoice
                                If (iChoice = 0) Begin
                                    Get Value to iValue
                                    
                                    If (iValue < 10) Begin
                                        Send Stop_Box "Minimum Number of Orders to Generate Should be Larger than 10"
                                        Set pbSpecsOk to False
                                    End
                                End
                            End_Procedure
                        End_Object
                        
                        Procedure ReadFromXMLData
                            Handle hoRoot hoData
                            Variant vData
                            Date dToday
                            
                            // Init the controls by taking the current date and
                            // subtract 720 days from that. Set the number of orders to 1000.
                            // The values maybe overwritten by the XML settings
                            Sysdate dToday
                            Set Value of oNumberOfOrdersForm to 1000
                            Set Value of oFromDateForm to (dToday - 720)
                            Set Value of oToDateForm to dToday
                            
                            Get OrdersGeneratorSettings of oSettingsHandler to hoRoot
                            If (hoRoot <> 0) Begin
                                // See if there is stored information for the date range available
                                Get ChildElementNS of hoRoot C_OrdersGeneratorNS "DateRangeSalesData" to hoData
                                If (hoData <> 0) Begin
                                    Get AttributeValue of hoData "FromDate" to vData
                                    Set Value of oFromDateForm to vData
                                    
                                    Get AttributeValue of hoData "ToDate" to vData
                                    Set Value of oToDateForm to vData
                                    
                                    Get AttributeValue of hoData "NumberOfOrders" to vData
                                    Set Value of oNumberOfOrdersForm to vData
                                    
                                    Send Destroy of hoData
                                End
                                Send Destroy of hoRoot
                            End
                        End_Procedure
                        
                        Procedure StoreToXMLData
                            Handle hoRoot hoData
                            Variant vData
                            
                            Get OrdersGeneratorSettings of oSettingsHandler to hoRoot
                            If (hoRoot <> 0) Begin
                                // If there is an element with the name DateRangeSalesData; remove it
                                Get ChildElementNS of hoRoot C_OrdersGeneratorNS "DateRangeSalesData" to hoData
                                If (hoData <> 0) Begin
                                    Get RemoveNode of hoRoot hoData to hoData
                                    If (hoData <> 0) Begin
                                        Send Destroy of hoData
                                    End
                                End
                                // Add the date range information to XML structure, start-, enddate and number
                                // of orders as attributes
                                Get AddElementNS of hoRoot C_OrdersGeneratorNS "DateRangeSalesData" '' to hoData
                                If (hoData <> 0) Begin
                                    Get Value of oFromDateForm to vData
                                    Send AddAttribute of hoData "FromDate" vData
                                    
                                    Get Value of oToDateForm to vData
                                    Send AddAttribute of hoData "ToDate" vData
                                    
                                    Get Value of oNumberOfOrdersForm to vData
                                    Send AddAttribute of hoData "NumberOfOrders" vData
                                    
                                    Send Destroy of hoData
                                End
                                
                                Send Destroy of hoRoot
                            End
                        End_Procedure
                    End_Object
                    
                    Object oYearContainer is a Group
                        Set Size to 75 197
                        Set Location to 34 5
                        Set peAnchors to anTopLeftRight
                        
                        Object oYearSelectionSpinForm is a SpinForm
                            Set Size to 13 40
                            Set Location to 11 39
                            Set Wrap_State to True
                            Set Label to "Year:"
                            Set Label_Col_Offset to 2
                            Set Label_Justification_Mode to JMode_Right
                            Set Numeric_Mask 0 to 4 0 "####"
                            
                            Procedure OnChange
                                Send DisplayDates
                            End_Procedure
                            
                            Function IsValidYear Returns Boolean
                                Integer iYear iMinYear iMaxYear
                                Boolean bCorrectYear
                                
                                Get Value to iYear
                                Get Minimum_Position to iMinYear
                                Get Maximum_Position to iMaxYear
                                Move (iYear >= iMinYear and iYear <= iMaxYear) to bCorrectYear
                                
                                Function_Return bCorrectYear
                            End_Function
                            
                            // Set the year to the passed year number and
                            // limit the spin values to 100 year before and after
                            Procedure InitRange Integer iDisplayYear
                                Set Value to iDisplayYear
                                Set Maximum_Position to (iDisplayYear + 100)
                                Set Minimum_Position to (iDisplayYear - 100)
                                Send DisplayDates
                            End_Procedure
                        End_Object
                        
                        Procedure DisplayDates
                            Integer iYear
                            Date dDate
                            Boolean bIsValid
                            
                            Get Value of oYearSelectionSpinForm to iYear
                            // Check if the year is not outside 'normal' ranges
                            Get IsValidYear of oYearSelectionSpinForm to bIsValid
                            If (not (bIsValid)) Begin
                                Procedure_Return
                            End
                            
                            // Get the current date from the forms and change it
                            // Note that first day and month are set before the year
                            // and that this is different for the end date.
                            Get Value of oYearFromDateForm to dDate
                            If (not (IsNullDateTime (dDate)) and IsDateValid (dDate)) Begin
                                Move (DateSetDay (dDate, 1)) to dDate
                                Move (DateSetMonth (dDate, 1)) to dDate
                                Move (DateSetYear (dDate, iYear)) to dDate
                                Set Value of oYearFromDateForm to dDate
                            End
                            
                            Get Value of oYearToDateForm to dDate
                            If (not (IsNullDateTime (dDate)) and IsDateValid (dDate)) Begin
                                Move (DateSetYear (dDate, iYear)) to dDate
                                Move (DateSetMonth (dDate, 12)) to dDate
                                Move (DateSetDay (dDate, 31)) to dDate
                                Set Value of oYearToDateForm to dDate
                            End
                        End_Procedure
                        
                        Object oYearFromDateForm is a Form
                            Set Size to 13 50
                            Set Location to 26 39
                            Set Enabled_State to False
                            Set Form_Datatype to Mask_Date_Window
                            Set Label_Col_Offset to 2
                            Set Label_Justification_Mode to JMode_Right
                            Set Label to "From:"
                            Set psToolTip to "Start date for orders creation"
                        End_Object
                        
                        Object oYearToDateForm is a Form
                            Set Size to 13 50
                            Set Location to 41 39
                            Set Enabled_State to False
                            Set Form_Datatype to Mask_Date_Window
                            Set Label_Col_Offset to 2
                            Set Label_Justification_Mode to JMode_Right
                            Set Label to "To:"
                            Set psToolTip to "End date for orders creation"
                        End_Object
                        
                        Object oYearNumberOfOrdersForm is a Form
                            Set Size to 13 50
                            Set Location to 56 39
                            Set Label to "Orders:"
                            Set Label_Col_Offset to 2
                            Set Form_Datatype to 0
                            Set Label_Justification_Mode to JMode_Right
                            Set psToolTip to "Number of orders to generate in this period (minimum = 10)"
                            
                            Procedure ValidateSpecs
                                Integer iValue iChoice
                                
                                Get Current_Radio of oDateRangeHelperGroup to iChoice
                                If (iChoice = 1) Begin
                                    Get Value to iValue
                                    
                                    If (iValue < 10) Begin
                                        Send Stop_Box "Minimum Number of Orders to Generate Should be Larger than 10"
                                        Set pbSpecsOk to False
                                    End
                                End
                            End_Procedure
                        End_Object
                        
                        Procedure ReadFromXMLData
                            Handle hoRoot hoData
                            Variant vData
                            Date dToday
                            Integer iYear
                            
                            // Set the year to the current year and initialize the date
                            // range by calling the InitRange method
                            Sysdate dToday
                            Move (DateGetYear (dToday)) to iYear
                            Set Value of oYearNumberOfOrdersForm to 1000
                            Send InitRange of oYearSelectionSpinForm iYear
                            
                            Get OrdersGeneratorSettings of oSettingsHandler to hoRoot
                            If (hoRoot <> 0) Begin
                                Get ChildElementNS of hoRoot C_OrdersGeneratorNS "YearSalesData" to hoData
                                If (hoData <> 0) Begin
                                    Get AttributeValue of hoData "FromDate" to vData
                                    Set Value of oYearFromDateForm to vData
                                    
                                    Get AttributeValue of hoData "ToDate" to vData
                                    Set Value of oYearToDateForm to vData
                                    
                                    Get AttributeValue of hoData "NumberOfOrders" to vData
                                    Set Value of oYearNumberOfOrdersForm to vData
                                    
                                    Get AttributeValue of hoData "Year" to vData
                                    Set Value of oYearSelectionSpinForm to vData
                                    
                                    Send Destroy of hoData
                                End
                                Send Destroy of hoRoot
                            End
                        End_Procedure
                        
                        Procedure StoreToXMLData
                            Handle hoRoot hoData
                            Variant vData
                            
                            Get OrdersGeneratorSettings of oSettingsHandler to hoRoot
                            If (hoRoot <> 0) Begin
                                // Delete an existing YearSalesData node
                                Get ChildElementNS of hoRoot C_OrdersGeneratorNS "YearSalesData" to hoData
                                If (hoData <> 0) Begin
                                    Get RemoveNode of hoRoot hoData to hoData
                                    If (hoData <> 0) Begin
                                        Send Destroy of hoData
                                    End
                                End
                                // Add a node with the year date information as attributes
                                Get AddElementNS of hoRoot C_OrdersGeneratorNS "YearSalesData" '' to hoData
                                If (hoData <> 0) Begin
                                    Get Value of oYearSelectionSpinForm to vData
                                    Send AddAttribute of hoData "Year" vData
                                    
                                    Get Value of oYearFromDateForm to vData
                                    Send AddAttribute of hoData "FromDate" vData
                                    
                                    Get Value of oYearToDateForm to vData
                                    Send AddAttribute of hoData "ToDate" vData
                                    
                                    Get Value of oYearNumberOfOrdersForm to vData
                                    Send AddAttribute of hoData "NumberOfOrders" vData
                                    
                                    Send Destroy of hoData
                                End
                                
                                Send Destroy of hoRoot
                            End
                        End_Procedure
                    End_Object
                    
                    Object oQuarterContainer is a Container3d
                        Set Size to 82 200
                        Set Location to 34 5
                        Set peAnchors to anAll
                        Set Border_Style to Border_None
                        
                        Object oOrdersGrid is a cCJGrid
                            Set Size to 62 197
                            Set Location to 0 0
                            Set peAnchors to anAll
                            Set pbUseAlternateRowBackgroundColor to True
                            Set pbAllowColumnRemove to False
                            Set pbAllowColumnReorder to False
                            
                            Object oGridColumnRowIndicator is a cCJGridColumnRowIndicator
                                Set piWidth to 22
                            End_Object
                            
                            Object oUseColumn is a cCJGridColumn
                                Set piWidth to 33
                                Set psCaption to "Use"
                                Set pbCheckbox to True
                            End_Object
                            
                            Procedure OnRowChanged Integer iOldRow Integer iNewSelectedRow
                                Forward Send OnRowChanged iOldRow iNewSelectedRow
                                Send InitYear of oYearColumn iNewSelectedRow
                            End_Procedure
                            
                            Object oYearColumn is a cCJGridColumn
                                Set piWidth to 53
                                Set psCaption to "Year"
                                Set peDataType to Mask_Numeric_Window
                                Set psMask to "####"
                                
                                // Display a year one higher than in the previous row
                                Procedure InitYear Integer iRow
                                    Integer iYear
                                    
                                    If (iRow >= 1) Begin
                                        Get RowValue iRow to iYear
                                        If (iYear = 0) Begin
                                            Get RowValue (iRow - 1) to iYear
                                            Send UpdateCurrentValue (iYear + 1)
                                        End
                                    End
                                End_Procedure
                            End_Object
                            
                            Object oQ1Column is a cCJGridColumn
                                Set piWidth to 58
                                Set psCaption to "Q1"
                                Set peDataType to Mask_Numeric_Window
                                Set psMask to "####0"
                                
                                // Display a zero in a new row
                                Function InitialValue Returns String
                                    Function_Return 0
                                End_Function
                            End_Object
                            
                            Object oQ2Column is a cCJGridColumn
                                Set piWidth to 59
                                Set psCaption to "Q2"
                                Set peDataType to Mask_Numeric_Window
                                Set psMask to "####0"
                                
                                // Display a zero in a new row
                                Function InitialValue Returns String
                                    Function_Return 0
                                End_Function
                            End_Object
                            
                            Object oQ3Column is a cCJGridColumn
                                Set piWidth to 59
                                Set psCaption to "Q3"
                                Set peDataType to Mask_Numeric_Window
                                Set psMask to "####0"
                                
                                // Display a zero in a new row
                                Function InitialValue Returns String
                                    Function_Return 0
                                End_Function
                            End_Object
                            
                            Object oQ4Column is a cCJGridColumn
                                Set piWidth to 60
                                Set psCaption to "Q4"
                                Set peDataType to Mask_Numeric_Window
                                Set psMask to "####0"
                                
                                // Display a zero in a new row
                                Function InitialValue Returns String
                                    Function_Return 0
                                End_Function
                            End_Object
                            
                            // Collect the to be created orders in a variant array. A variant array as the
                            // element types will not be the same in each dimension. Notice that the returns
                            // uses one set of square brackets and the variable declaration two. Two date
                            // values and one amount.
                            Function ToBeCreatedOrders Returns Variant[]
                                Handle hoDataSource
                                tDataSourceRow[] SalesData
                                Integer iElements iElement
                                Integer iYearColumn iQ1Column iQ2Column iQ3Column iQ4Column
                                Integer iRow iUseColumn
                                Date dDate
                                Variant[][] vOrdersData
                                Boolean bIsComObjectCreated
                                
                                // There will be no data if the grid was not activated yet; activate
                                // the grid if the COM object created function returns false
                                Get IsComObjectCreated to bIsComObjectCreated
                                If (not (bIsComObjectCreated)) Begin
                                    Send Activate
                                End
                                
                                Get phoDataSource to hoDataSource
                                Get DataSource of hoDataSource to SalesData
                                Move (SizeOfArray (SalesData)) to iElements
                                If (iElements > 0) Begin
                                    // Randomize the input array to get a different variation
                                    // for the record numbers in the orderhea table. Orders will
                                    // not be created in sequence
                                    Move (ShuffleArray (SalesData)) to SalesData
                                    
                                    Get piColumnId of oUseColumn to iUseColumn
                                    Get piColumnId of oYearColumn to iYearColumn
                                    Get piColumnId of oQ1Column to iQ1Column
                                    Get piColumnId of oQ2Column to iQ2Column
                                    Get piColumnId of oQ3Column to iQ3Column
                                    Get piColumnId of oQ4Column to iQ4Column
                                    
                                    Decrement iElements
                                    For iElement from 0 to iElements
                                        If (SalesData[iElement].sValue[iUseColumn] and SalesData[iElement].sValue[iYearColumn] > 0) Begin
                                            Sysdate dDate
                                            Move (DateSetDay (dDate, 1)) to dDate
                                            If (SalesData[iElement].sValue[iQ1Column] > 0) Begin
                                                // Make a date for the 1st day in the 1th month
                                                Move (DateSetMonth (dDate, 1)) to dDate
                                                Move (DateSetYear (dDate, SalesData[iElement].sValue[iYearColumn])) to dDate
                                                Move dDate to vOrdersData[iRow][0]
                                                // Make a date for the last day in the 3rd month by creating the 1st day
                                                // in the 4th month and subtracting one day
                                                Move (DateSetMonth (dDate, 4)) to dDate
                                                Move (Date (dDate - 1)) to vOrdersData[iRow][1]
                                                Move SalesData[iElement].sValue[iQ1Column] to vOrdersData[iRow][2]
                                                Increment iRow
                                            End
                                            If (SalesData[iElement].sValue[iQ2Column] > 0) Begin
                                                // Make a date for the 1st day in the 4th month
                                                Move (DateSetMonth (dDate, 4)) to dDate
                                                Move (DateSetYear (dDate, SalesData[iElement].sValue[iYearColumn])) to dDate
                                                Move dDate to vOrdersData[iRow][0]
                                                // Make a date for the last day in the 6th month by creating the 1st day
                                                // in the 7th month and subtracting one day
                                                Move (DateSetMonth (dDate, 7)) to dDate
                                                Move (Date (dDate - 1)) to vOrdersData[iRow][1]
                                                Move SalesData[iElement].sValue[iQ2Column] to vOrdersData[iRow][2]
                                                Increment iRow
                                            End
                                            If (SalesData[iElement].sValue[iQ3Column] > 0) Begin
                                                // Make a date for the 1st day in the 7th month
                                                Move (DateSetMonth (dDate, 7)) to dDate
                                                Move (DateSetYear (dDate, SalesData[iElement].sValue[iYearColumn])) to dDate
                                                Move dDate to vOrdersData[iRow][0]
                                                // Make a date for the last day in the 9th month by creating the 1st day
                                                // in the 10th month and subtracting one day
                                                Move (DateSetMonth (dDate, 10)) to dDate
                                                Move (Date (dDate - 1)) to vOrdersData[iRow][1]
                                                Move SalesData[iElement].sValue[iQ3Column] to vOrdersData[iRow][2]
                                                Increment iRow
                                            End
                                            If (SalesData[iElement].sValue[iQ4Column] > 0) Begin
                                                // Make a date for the 1st day in the 10th month
                                                Move (DateSetMonth (dDate, 10)) to dDate
                                                Move (DateSetYear (dDate, SalesData[iElement].sValue[iYearColumn])) to dDate
                                                Move dDate to vOrdersData[iRow][0]
                                                // Make a date for the last day in the 12th month
                                                Move (DateSetMonth (dDate, 12)) to dDate
                                                Move (DateSetDay (dDate, 31)) to dDate
                                                Move dDate to vOrdersData[iRow][1]
                                                Move SalesData[iElement].sValue[iQ4Column] to vOrdersData[iRow][2]
                                                Increment iRow
                                            End
                                        End
                                    Loop
                                End
                                
                                // Randomize the array data for a better spread of rows through the database
                                Move (ShuffleArray (vOrdersData)) to vOrdersData
                                
                                Function_Return vOrdersData
                            End_Function
                            
                            Procedure FillGridFromXMLData
                                Handle hoRoot hoData hoYearData
                                String sFileName
                                tDataSourceRow[] SalesData
                                Integer iYearColumn iQ1Column iQ2Column iQ3Column iQ4Column
                                Integer iRow iUseColumn
                                Boolean bOk
                                
                                Get piColumnId of oUseColumn to iUseColumn
                                Get piColumnId of oYearColumn to iYearColumn
                                Get piColumnId of oQ1Column to iQ1Column
                                Get piColumnId of oQ2Column to iQ2Column
                                Get piColumnId of oQ3Column to iQ3Column
                                Get piColumnId of oQ4Column to iQ4Column
                                
                                Get OrdersGeneratorSettings of oSettingsHandler to hoRoot
                                If (hoRoot <> 0) Begin
                                    // Check if there are Quarter sales data stored
                                    Get ChildElementNS of hoRoot C_OrdersGeneratorNS "QuarterSalesData" to hoData
                                    If (hoData <> 0) Begin
                                        Get ChildElementNS of hoData C_OrdersGeneratorNS "Year" to hoYearData
                                        While (hoYearData <> 0)
                                            // Create a new row in the grid data
                                            Move (ResizeArray (SalesData, iRow + 1)) to SalesData
                                            // Create the column information for one row; this way there is a value for all
                                            // columns in the grid
                                            Move (ResizeArray (SalesData[iRow].sValue, iQ4Column + 1)) to SalesData[iRow].sValue
                                            Get AttributeValue of hoYearData "Nr" to SalesData[iRow].sValue[iYearColumn]
                                            Get AttributeValue of hoYearData "ToBeUsed" to SalesData[iRow].sValue[iUseColumn]
                                            Get AttributeValue of hoYearData "Q1" to SalesData[iRow].sValue[iQ1Column]
                                            Get AttributeValue of hoYearData "Q2" to SalesData[iRow].sValue[iQ2Column]
                                            Get AttributeValue of hoYearData "Q3" to SalesData[iRow].sValue[iQ3Column]
                                            Get AttributeValue of hoYearData "Q4" to SalesData[iRow].sValue[iQ4Column]
                                            Increment iRow
                                            Get NextNode of hoYearData to hoYearData
                                        Loop
                                        Send Destroy of hoData
                                    End
                                    Send Destroy of hoRoot
                                End
                                
                                // If no stored information is available make a random set
                                If (SizeOfArray (SalesData) = 0) Begin
                                    Send FillGrid
                                End
                                Else Begin
                                    Send InitializeData SalesData
                                    Send SortGridByColumn oYearColumn False
                                End
                            End_Procedure
                            
                            Procedure Activating
                                Forward Send Activating
                                Send FillGridFromXMLData
                            End_Procedure
                            
                            // Create a new 5 year date matrix
                            Procedure FillGrid
                                Integer iCurrentYear iYear iRow iUseColumn
                                Integer iYearColumn iQ1Column iQ2Column iQ3Column iQ4Column
                                tDataSourceRow[] SalesData
                                
                                Get piColumnId of oUseColumn to iUseColumn
                                Get piColumnId of oYearColumn to iYearColumn
                                Get piColumnId of oQ1Column to iQ1Column
                                Get piColumnId of oQ2Column to iQ2Column
                                Get piColumnId of oQ3Column to iQ3Column
                                Get piColumnId of oQ4Column to iQ4Column
                                
                                Move (DateGetYear (CurrentDateTime ())) to iCurrentYear
                                Move (iCurrentYear - 5) to iYear
                                While (iYear <= iCurrentYear)
                                    Move True to SalesData[iRow].sValue[iUseColumn]
                                    Move iYear to SalesData[iRow].sValue[iYearColumn]
                                    Move (Random (1000)) to SalesData[iRow].sValue[iQ1Column]
                                    Move (Random (1000)) to SalesData[iRow].sValue[iQ2Column]
                                    Move (Random (1000)) to SalesData[iRow].sValue[iQ3Column]
                                    Move (Random (1000)) to SalesData[iRow].sValue[iQ4Column]
                                    Increment iYear
                                    Increment iRow
                                Loop
                                
                                Send InitializeData SalesData
                            End_Procedure
                            
                            Procedure StoreToXMLData
                                String sFileName
                                tDataSourceRow[] SalesData
                                Integer iYearColumn iQ1Column iQ2Column iQ3Column iQ4Column
                                Integer iUseColumn iElements iElement
                                Handle hoRoot hoDataSource hoData hoYear hoXML
                                Boolean bErr
                                
                                Get phoDataSource to hoDataSource
                                Get DataSource of hoDataSource to SalesData
                                Move (SizeOfArray (SalesData)) to iElements
                                If (iElements > 0) Begin
                                    Get OrdersGeneratorSettings of oSettingsHandler to hoRoot
                                    If (hoRoot <> 0) Begin
                                        Get piColumnId of oUseColumn to iUseColumn
                                        Get piColumnId of oYearColumn to iYearColumn
                                        Get piColumnId of oQ1Column to iQ1Column
                                        Get piColumnId of oQ2Column to iQ2Column
                                        Get piColumnId of oQ3Column to iQ3Column
                                        Get piColumnId of oQ4Column to iQ4Column
                                        
                                        // Remove existing Quarter sales data if present
                                        Get ChildElementNS of hoRoot C_OrdersGeneratorNS "QuarterSalesData" to hoData
                                        If (hoData <> 0) Begin
                                            Get RemoveNode of hoRoot hoData to hoData
                                            If (hoData <> 0) Begin
                                                Send Destroy of hoData
                                            End
                                        End
                                        // Add Quarter sales data for each row in the grid where the year number
                                        // is larger than 1900
                                        Get AddElementNS of hoRoot C_OrdersGeneratorNS "QuarterSalesData" '' to hoData
                                        If (hoData <> 0) Begin
                                            Decrement iElements
                                            For iElement from 0 to iElements
                                                If (SalesData[iElement].sValue[iYearColumn] > 1900) Begin
                                                    Get AddElementNS of hoData C_OrdersGeneratorNS "Year" '' to hoYear
                                                    Send AddAttribute of hoYear "Nr" SalesData[iElement].sValue[iYearColumn]
                                                    Send AddAttribute of hoYear "ToBeUsed" SalesData[iElement].sValue[iUseColumn]
                                                    Send AddAttribute of hoYear "Q1" SalesData[iElement].sValue[iQ1Column]
                                                    Send AddAttribute of hoYear "Q2" SalesData[iElement].sValue[iQ2Column]
                                                    Send AddAttribute of hoYear "Q3" SalesData[iElement].sValue[iQ3Column]
                                                    Send AddAttribute of hoYear "Q4" SalesData[iElement].sValue[iQ4Column]
                                                    Send Destroy of hoYear
                                                End
                                            Loop
                                            Send Destroy of hoData
                                        End
                                        Send Destroy of hoRoot
                                    End
                                End
                            End_Procedure
                        End_Object
                        
                        Object oFillButton is a Button
                            Set Location to 64 147
                            Set Label to "Fill Grid"
                            Set peAnchors to anBottomRight
                            Set psToolTip to "Fill the grid with random values for 5 years back in time from the current year"
                            
                            Procedure OnClick
                                Send FillGrid of oOrdersGrid
                            End_Procedure
                        End_Object
                    End_Object
                    
                    Object oExplanationTextBox is a TextBox
                        Set Auto_Size_State to False
                        Set Size to 102 114
                        Set Location to 10 209
                        Set Label to "Selection between date range, a full year or a quarter spread over multiple years is possible here."
                        Set Justification_Mode to JMode_Left
                        Set peAnchors to anTopBottomRight
                    End_Object
                End_Object
                
                Object oWeekDayVariationTabPage is a TabPage
                    Set Label to "Weekday Variation"
                    
                    Object oWeekDayVariationGrid is a cCJGrid
                        Set Size to 94 163
                        Set Location to 5 5
                        Set pbAllowAppendRow to False
                        Set pbAllowColumnRemove to False
                        Set pbAllowColumnReorder to False
                        Set pbAllowDeleteRow to False
                        Set pbAllowInsertRow to False
                        Set peAnchors to anTopLeftRight
                        Set pbUseAlternateRowBackgroundColor to True
                        Set pbHeaderReorders to True
                        Set pbHeaderTogglesDirection to True
                        
                        Object oRowIndicator is a cCJGridColumnRowIndicator
                            Set piWidth to 37
                        End_Object
                        
                        Object oWeekDayColumn is a cCJGridColumn
                            Set piWidth to 159
                            Set psCaption to "Weekday"
                            Set pbEditable to False
                        End_Object
                        
                        Object oWeightColumn is a cCJGridColumn
                            Set piWidth to 89
                            Set psCaption to "Weight"
                            Set peDataType to Mask_Numeric_Window
                            Set psMask to "##0"
                            
                            Function OnValidating Returns Boolean
                                Integer iWeight
                                Boolean bValueNotOk
                                
                                Get SelectedRowValue to iWeight
                                Move (iWeight < 0) to bValueNotOk
                                If (bValueNotOk) Begin
                                    Error DFERR_OPERATOR "Weight Value Must be 0 or Higher!"
                                End
                                
                                Function_Return bValueNotOk
                            End_Function
                        End_Object
                        
                        Procedure Activating
                            Forward Send Activating
                            Send ReadWeekDays
                        End_Procedure
                        
                        // Let the Windows API return the localized name of the weekday
                        Function NameOfWeekDay Integer iDay Returns String
                            WString wsDayName
                            Integer iLength
                            
                            // This call is to get the required length for the string
                            Move (GetLocaleInfoW (LOCALE_USER_DEFAULT, iDay, 0, 0)) to iLength
                            // Make space for the dayname
                            Move (ZeroString (iLength)) to wsDayName
                            // Get the dayname
                            Move (GetLocaleInfoW (LOCALE_USER_DEFAULT, iDay, AddressOf (wsDayName), iLength)) to iLength
                            
                            Function_Return (CString (wsDayName))
                        End_Function
                        
                        Procedure ReadWeekDays
                            tDataSourceRow[] WeekDaysData
                            Integer iWeekDayColumn iWeightColumn iDay iRow iDayNr
                            Handle hoRoot hoData hoNode
                            Boolean bIsWeekDayElement
                            
                            Get OrdersGeneratorSettings of oSettingsHandler to hoRoot
                            If (hoRoot <> 0) Begin
                                // See if there is weekday information stored in the XML object
                                Get ChildElementNS of hoRoot C_OrdersGeneratorNS "WeekDaysData" to hoData
                            End
                            
                            Get piColumnId of oWeekDayColumn to iWeekDayColumn
                            Get piColumnId of oWeightColumn to iWeightColumn
                            
                            // Different block for Sunday as the first day in the grid is sunday (daynumber 1 in DataFlex)
                            Get NameOfWeekDay LOCALE_SDAYNAME7 to WeekDaysData[0].sValue[iWeekDayColumn]
                            // Initialize to zero (sunday); value may be overwritten from XML
                            Move 0 to WeekDaysData[0].sValue[iWeightColumn]
                            Move 1 to WeekDaysData[0].vTag
                            If (hoData <> 0) Begin
                                Get FirstChild of hoData to hoNode
                                While (hoNode <> 0)
                                    Get IsElementNS of hoNode C_OrdersGeneratorNS 'Day' to bIsWeekDayElement
                                    If (bIsWeekDayElement) Begin
                                        Get AttributeValue of hoNode 'Nr' to iDayNr
                                        If (iDayNr = 1) Begin
                                            Get AttributeValue of hoNode 'Weight' to WeekDaysData[0].sValue[iWeightColumn]
                                            Send Destroy of hoNode
                                            Move 0 to hoNode
                                        End
                                    End
                                    If (hoNode <> 0) Begin
                                        Get NextNode of hoNode to hoNode
                                    End
                                Loop
                            End
                            
                            For iDay from LOCALE_SDAYNAME1 to LOCALE_SDAYNAME6
                                Move (iDay - LOCALE_SDAYNAME1 + 1) to iRow
                                Move (iRow + 1) to WeekDaysData[iRow].vTag
                                Get NameOfWeekDay iDay to WeekDaysData[iRow].sValue[iWeekDayColumn]
                                If (iDay < LOCALE_SDAYNAME6) Begin
                                    // Initialize with a random weight
                                    Move (Random (10) + 1) to WeekDaysData[iRow].sValue[iWeightColumn]
                                End
                                Else Begin
                                    // For Saturday set weight to 0 like is done for Sunday
                                    Move 0 to WeekDaysData[iRow].sValue[iWeightColumn]
                                End
                                If (hoData <> 0) Begin
                                    Get FirstChild of hoData to hoNode
                                    While (hoNode <> 0)
                                        Get IsElementNS of hoNode C_OrdersGeneratorNS 'Day' to bIsWeekDayElement
                                        If (bIsWeekDayElement) Begin
                                            Get AttributeValue of hoNode 'Nr' to iDayNr
                                            If (iDayNr = WeekDaysData[iRow].vTag) Begin
                                                Get AttributeValue of hoNode 'Weight' to WeekDaysData[iRow].sValue[iWeightColumn]
                                                Send Destroy of hoNode
                                                Move 0 to hoNode
                                            End
                                        End
                                        If (hoNode <> 0) Begin
                                            Get NextNode of hoNode to hoNode
                                        End
                                    Loop
                                End
                            Loop
                            
                            // Cleanup; hoData cannot be destroyed until this point
                            If (hoRoot <> 0) Begin
                                If (hoData <> 0) Begin
                                    Send Destroy of hoData
                                End
                                Send Destroy of hoRoot
                            End
                            
                            Send InitializeData WeekDaysData
                        End_Procedure
                        
                        Procedure SetRandomWeights Integer iMax
                            Handle hoDataSource
                            tDataSourceRow[] GridData
                            Integer iWeightColumn iElements iElement
                            
                            Get piColumnId of oWeightColumn to iWeightColumn
                            
                            Get phoDataSource to hoDataSource
                            Get DataSource of hoDataSource to GridData
                            Move (SizeOfArray (GridData)) to iElements
                            Decrement iElements
                            For iElement from 0 to iElements
                                Move (Random (iMax) + 1) to GridData[iElement].sValue[iWeightColumn]
                            Loop
                            
                            Send InitializeData GridData
                        End_Procedure
                        
                        Procedure StoreToXMLData
                            Handle hoDataSource hoRoot hoData hoNode
                            tDataSourceRow[] WeekDaysData
                            Integer iWeightColumn iElements iElement
                            
                            Get phoDataSource to hoDataSource
                            Get DataSource of hoDataSource to WeekDaysData
                            Move (SizeOfArray (WeekDaysData)) to iElements
                            If (iElements > 0) Begin
                                Get OrdersGeneratorSettings of oSettingsHandler to hoRoot
                                If (hoRoot <> 0) Begin
                                    // Remove previously stored weekdays data if any
                                    Get ChildElementNS of hoRoot C_OrdersGeneratorNS "WeekDaysData" to hoData
                                    If (hoData <> 0) Begin
                                        Get RemoveNode of hoRoot hoData to hoData
                                        If (hoData <> 0) Begin
                                            Send Destroy of hoData
                                        End
                                    End
                                    Get AddElementNS of hoRoot C_OrdersGeneratorNS "WeekDaysData" '' to hoData
                                    If (hoData <> 0) Begin
                                        Get piColumnId of oWeightColumn to iWeightColumn
                                        
                                        Decrement iElements
                                        For iElement from 0 to iElements
                                            // Add an XML element for each day with its daynumber and weight
                                            // as attributes
                                            Get AddElementNS of hoData C_OrdersGeneratorNS "Day" '' to hoNode
                                            If (hoNode <> 0) Begin
                                                Send AddAttribute of hoNode "Nr" WeekDaysData[iElement].vTag
                                                Send AddAttribute of hoNode "Weight" WeekdaysData[iElement].sValue[iWeightColumn]
                                                Send Destroy of hoNode
                                            End
                                        Loop
                                        Send Destroy of hoData
                                    End
                                    Send Destroy of hoRoot
                                End
                            End
                        End_Procedure
                        
                        Function ToBeUsedWeekDays Integer[] ByRef iWeekDays Returns Integer
                            Boolean bIsComObjectCreated
                            Handle hoDataSource
                            tDataSourceRow[] WeekDaysData
                            Integer iWeekDayColumn iWeightColumn iElements iElement iCount iWeekDayElement
                            
                            // Before data can be returned the grid needs to be filled with data which is
                            // done during activation. The instruction to activate will be given if the
                            // user did not open the tab-page yet.
                            Get IsComObjectCreated to bIsComObjectCreated
                            If (not (bIsComObjectCreated)) Begin
                                Send Activate
                            End
                            
                            Get phoDataSource to hoDataSource
                            Get DataSource of hoDataSource to WeekDaysData
                            
                            Get piColumnId of oWeekDayColumn to iWeekDayColumn
                            Get piColumnId of oWeightColumn to iWeightColumn
                            
                            Move (SizeOfArray (WeekDaysData)) to iElements
                            Decrement iElements
                            For iElement from 0 to iElements
                                If (WeekDaysData[iElement].sValue[iWeightColumn] > 0) Begin
                                    For iCount from 1 to WeekDaysData[iElement].sValue[iWeightColumn]
                                        Move WeekDaysData[iElement].vTag to iWeekDays[iWeekDayElement]
                                        Increment iWeekDayElement
                                        // Randomize the array values
                                        Move (ShuffleArray (iWeekDays)) to iWeekDays
                                    Loop
                                End
                            Loop
                            
                            // Randomize the weekdays array again
                            Move (ShuffleArray (iWeekDays)) to iWeekDays
                            
                            Function_Return iWeekDayElement
                        End_Function
                    End_Object
                    
                    Object oExplanationTextBox is a TextBox
                        Set Auto_Size_State to False
                        Set Size to 92 129
                        Set Location to 5 178
                        Set Label to "Setting the weight means how many times a weekday will be used. Increasing the weight should lead to more orders at this weekday."
                        Set Justification_Mode to JMode_Left
                        Set peAnchors to anTopBottomRight
                    End_Object
                    
                    Object oRandomWeightsButton is a Button
                        Set Size to 14 62
                        Set Location to 104 105
                        Set Label to 'Random Weights'
                        Set psToolTip to "Take a random weight for each weekday"
                        Set peAnchors to anTopRight
                        
                        Procedure OnClick
                            Send SetRandomWeights of oWeekDayVariationGrid 10
                        End_Procedure
                    End_Object
                    
                    Object oResetWeightsButton is a Button
                        Set Size to 14 62
                        Set Location to 104 39
                        Set Label to "Reset Weights"
                        Set psToolTip to "Set the weight for each weekday to 1"
                        Set peAnchors to anTopRight
                        
                        Procedure OnClick
                            Send SetRandomWeights of oWeekDayVariationGrid 1
                        End_Procedure
                    End_Object
                End_Object
                
                Object oSalesPersonTabPage is a TabPage
                    Set Label to "Sales Persons"
                    
                    Object oSalesPersonGrid is a cCJGrid
                        Set Size to 94 253
                        Set Location to 5 5
                        Set pbAllowAppendRow to False
                        Set pbAllowColumnRemove to False
                        Set pbAllowColumnReorder to False
                        Set pbAllowDeleteRow to False
                        Set pbAllowInsertRow to False
                        Set peAnchors to anAll
                        Set pbUseAlternateRowBackgroundColor to True
                        Set pbHeaderReorders to True
                        Set pbHeaderTogglesDirection to True
                        
                        Object oRowIndicator is a cCJGridColumnRowIndicator
                            Set piWidth to 22
                        End_Object
                        
                        Object oIdColumn is a cCJGridColumn
                            Set piWidth to 75
                            Set psCaption to "ID"
                            Set pbEditable to False
                        End_Object
                        
                        Object oNameColumn is a cCJGridColumn
                            Set piWidth to 251
                            Set psCaption to "Name"
                            Set pbEditable to False
                        End_Object
                        
                        Object oWeightColumn is a cCJGridColumn
                            Set piWidth to 94
                            Set psCaption to "Weight"
                            Set peDataType to Mask_Numeric_Window
                            Set psMask to "###"
                            
                            Function OnValidating Returns Boolean
                                Integer iWeight
                                Boolean bValueNotOk
                                
                                Get SelectedRowValue to iWeight
                                Move (iWeight < 0) to bValueNotOk
                                If (bValueNotOk) Begin
                                    Error DFERR_OPERATOR "Weight Value Must be 0 or Higher!"
                                End
                                
                                Function_Return bValueNotOk
                            End_Function
                        End_Object
                        
                        Procedure Activating
                            Forward Send Activating
                            Send ReadSalesPersons
                        End_Procedure
                        
                        Procedure ReadSalesPersons
                            tDataSourceRow[] SalesPersonData
                            Integer iIDColumn iNameColumn iWeightColumn iRow
                            Handle hoSalesPersonDD hoRoot hoData hoNode
                            Boolean bIsSalesPersonElement
                            String sName
                            
                            Get OrdersGeneratorSettings of oSettingsHandler to hoRoot
                            If (hoRoot <> 0) Begin
                                // See if there is stored SalesPerson data in the XML stream
                                Get ChildElementNS of hoRoot C_OrdersGeneratorNS "SalesPersonsData" to hoData
                            End
                            
                            Get piColumnId of oIdColumn to iIDColumn
                            Get piColumnId of oNameColumn to iNameColumn
                            Get piColumnId of oWeightColumn to iWeightColumn
                            
                            Move (oSalesP_DD (oOrdersGeneratorBPO)) to hoSalesPersonDD
                            Send Clear of hoSalesPersonDD
                            Send Request_Read of hoSalesPersonDD FIRST_RECORD SalesP.File_Number 1
                            While (Found)
                                Move (Trim (SalesP.ID)) to SalesPersonData[iRow].sValue[iIDColumn]
                                Move (Trim (SalesP.Name)) to SalesPersonData[iRow].sValue[iNameColumn]
                                // Assign a random weight value which might be overwritten by the XML value a couple
                                // of lines below
                                Move (Random (10) + 1) to SalesPersonData[iRow].sValue[iWeightColumn]
                                // If there are stored SalesPerson XML values; look them up
                                If (hoData <> 0) Begin
                                    // Enumerate the child elements to find an element with the same Id as the
                                    // current salesperson row from the database
                                    Get FirstChild of hoData to hoNode
                                    While (hoNode)
                                        Get IsElementNS of hoNode C_OrdersGeneratorNS 'Person' to bIsSalesPersonElement
                                        If (bIsSalesPersonElement) Begin
                                            Get AttributeValue of hoNode 'Id' to sName
                                            If (sName = SalesPersonData[iRow].sValue[iIdColumn]) Begin
                                                Get AttributeValue of hoNode 'Weight' to SalesPersonData[iRow].sValue[iWeightColumn]
                                                Send Destroy of hoNode
                                                Move 0 to hoNode
                                            End
                                        End
                                        If (hoNode <> 0) Begin
                                            Get NextNode of hoNode to hoNode
                                        End
                                    Loop
                                End
                                Increment iRow
                                Send Locate_Next of hoSalesPersonDD
                            Loop
                            
                            If (hoRoot <> 0) Begin
                                If (hoData <> 0) Begin
                                    Send Destroy of hoData
                                End
                                Send Destroy of hoRoot
                            End
                            
                            Send InitializeData SalesPersonData
                        End_Procedure
                        
                        Procedure SetRandomWeights Integer iMax
                            Handle hoDataSource
                            tDataSourceRow[] GridData
                            Integer iWeightColumn iElements iElement
                            
                            Get piColumnId of oWeightColumn to iWeightColumn
                            
                            Get phoDataSource to hoDataSource
                            Get DataSource of hoDataSource to GridData
                            Move (SizeOfArray (GridData)) to iElements
                            Decrement iElements
                            For iElement from 0 to iElements
                                Move (Random (iMax) + 1) to GridData[iElement].sValue[iWeightColumn]
                            Loop
                            
                            Send InitializeData GridData
                        End_Procedure
                        
                        Procedure StoreToXMLData
                            Handle hoDataSource hoRoot hoData hoSalesPersonElement
                            tDataSourceRow[] SalesPersonsData
                            Integer iIDColumn iWeightColumn iElements iElement
                            
                            Get phoDataSource to hoDataSource
                            Get DataSource of hoDataSource to SalesPersonsData
                            Move (SizeOfArray (SalesPersonsData)) to iElements
                            If (iElements > 0) Begin
                                Get OrdersGeneratorSettings of oSettingsHandler to hoRoot
                                If (hoRoot <> 0) Begin
                                    // Remove previous stored salesperson data if present
                                    Get ChildElementNS of hoRoot C_OrdersGeneratorNS "SalesPersonsData" to hoData
                                    If (hoData <> 0) Begin
                                        Get RemoveNode of hoRoot hoData to hoData
                                        If (hoData <> 0) Begin
                                            Send Destroy of hoData
                                        End
                                    End
                                    Get AddElementNS of hoRoot C_OrdersGeneratorNS "SalesPersonsData" '' to hoData
                                    If (hoData <> 0) Begin
                                        Get piColumnId of oIdColumn to iIDColumn
                                        Get piColumnId of oWeightColumn to iWeightColumn
                                        
                                        Decrement iElements
                                        For iElement from 0 to iElements
                                            // Add each salesperson as an XML node with its ID and Weight as attributes
                                            Get AddElementNS of hoData C_OrdersGeneratorNS 'Person' '' to hoSalesPersonElement
                                            If (hoSalesPersonElement <> 0) Begin
                                                Send SetAttributeValue of hoSalesPersonElement 'Id' SalesPersonsData[iElement].sValue[iIDColumn]
                                                Send SetAttributeValue of hoSalesPersonElement 'Weight' SalesPersonsData[iElement].sValue[iWeightColumn]
                                                Send Destroy of hoSalesPersonElement
                                            End
                                        Loop
                                        Send Destroy of hoData
                                    End
                                    Send Destroy of hoRoot
                                End
                            End
                        End_Procedure
                        
                        Function ToBeUsedSalesPersons String[] ByRef sSalesPersons Returns Integer
                            Boolean bIsComObjectCreated
                            Handle hoDataSource
                            tDataSourceRow[] SalesPersonData
                            Integer iIDColumn iWeightColumn iElements iElement iCount iSalesPersonElement
                            
                            // In order to get information from the grid it needs to be activated first
                            // upon activation the sales person data is read and merged with XML if present
                            Get IsComObjectCreated to bIsComObjectCreated
                            If (not (bIsComObjectCreated)) Begin
                                Send Activate
                            End
                            
                            Get phoDataSource to hoDataSource
                            Get DataSource of hoDataSource to SalesPersonData
                            
                            Get piColumnId of oIdColumn to iIDColumn
                            Get piColumnId of oWeightColumn to iWeightColumn
                            
                            Move (SizeOfArray (SalesPersonData)) to iElements
                            Decrement iElements
                            For iElement from 0 to iElements
                                If (SalesPersonData[iElement].sValue[iWeightColumn] > 0) Begin
                                    For iCount from 1 to SalesPersonData[iElement].sValue[iWeightColumn]
                                        Move SalesPersonData[iElement].sValue[iIDColumn] to sSalesPersons[iSalesPersonElement]
                                        Increment iSalesPersonElement
                                        // Already randomize the array
                                        Move (ShuffleArray (sSalesPersons)) to sSalesPersons
                                    Loop
                                End
                            Loop
                            
                            // Randomize the array once more
                            Move (ShuffleArray (sSalesPersons)) to sSalesPersons
                            
                            Function_Return iSalesPersonElement
                        End_Function
                    End_Object
                    
                    Object oRandomWeightsButton is a Button
                        Set Size to 14 62
                        Set Location to 101 196
                        Set Label to 'Random Weights'
                        Set psToolTip to "Take a random weight for each salesperson"
                        Set peAnchors to anBottomRight
                        
                        Procedure OnClick
                            Send SetRandomWeights of oSalesPersonGrid 10
                        End_Procedure
                    End_Object
                    
                    Object oResetWeightsButton is a Button
                        Set Size to 14 62
                        Set Location to 101 132
                        Set Label to "Reset Weights"
                        Set psToolTip to "Set the weight for each salesperson to 1"
                        Set peAnchors to anBottomRight
                        
                        Procedure OnClick
                            Send SetRandomWeights of oSalesPersonGrid 1
                        End_Procedure
                    End_Object
                    
                    Object oExplanationTextBox is a TextBox
                        Set Auto_Size_State to False
                        Set Size to 111 62
                        Set Location to 5 263
                        Set Label to "Setting the weight means how many times the sales person ID will be made available in the array to pick from. Increasing the weight should lead to more orders with this sales person."
                        Set Justification_Mode to JMode_Left
                        Set peAnchors to anTopBottomRight
                    End_Object
                End_Object
                
                Object oShipViaTabPage is a TabPage
                    Set Label to "Ship Via"
                    
                    Object oShipViaGrid is a cCJGrid
                        Set Size to 93 253
                        Set Location to 5 5
                        Set pbAllowAppendRow to False
                        Set pbAllowColumnRemove to False
                        Set pbAllowColumnReorder to False
                        Set pbAllowDeleteRow to False
                        Set pbAllowInsertRow to False
                        Set peAnchors to anAll
                        Set pbUseAlternateRowBackgroundColor to True
                        Set pbHeaderReorders to True
                        Set pbHeaderTogglesDirection to True
                        
                        Object oRowIndicator is a cCJGridColumnRowIndicator
                            Set piWidth to 22
                        End_Object
                        
                        Object oCodeColumn is a cCJGridColumn
                            Set piWidth to 75
                            Set psCaption to "Code"
                            Set pbEditable to False
                        End_Object
                        
                        Object oDescriptionColumn is a cCJGridColumn
                            Set piWidth to 251
                            Set psCaption to "Description"
                            Set pbEditable to False
                        End_Object
                        
                        Object oWeightColumn is a cCJGridColumn
                            Set piWidth to 94
                            Set psCaption to "Weight"
                            Set peDataType to Mask_Numeric_Window
                            Set psMask to "###"
                            
                            Function OnValidating Returns Boolean
                                Integer iWeight
                                Boolean bValueNotOk
                                
                                Get SelectedRowValue to iWeight
                                Move (iWeight < 0) to bValueNotOk
                                If (bValueNotOk) Begin
                                    Error DFERR_OPERATOR "Weight Value Must be 0 or Higher!"
                                End
                                
                                Function_Return bValueNotOk
                            End_Function
                        End_Object
                        
                        Procedure Activating
                            Forward Send Activating
                            Send ReadShipVia
                        End_Procedure
                        
                        Procedure ReadShipVia
                            tDataSourceRow[] ShipViaData
                            Integer iCodeColumn iDescrColumn iWeightColumn iRow
                            Integer iShipViaElements iShipViaElement
                            Handle hoShipVia hoRoot hoData hoNode
                            Variant[][] vShipViaData
                            Boolean bIsShipViaElement
                            String sShipViaCode
                            
                            Get OrdersGeneratorSettings of oSettingsHandler to hoRoot
                            If (hoRoot <> 0) Begin
                                Get ChildElementNS of hoRoot C_OrdersGeneratorNS "ShipViaData" to hoData
                            End
                            
                            Get piColumnId of oCodeColumn to iCodeColumn
                            Get piColumnId of oDescriptionColumn to iDescrColumn
                            Get piColumnId of oWeightColumn to iWeightColumn
                            
                            // Get the ship via information from the validation table connected to the ship_via column
                            // in the orderhea DDO.
                            Get Field_Table_Object of (oOrderHea_DD (oOrdersGeneratorBPO)) Field OrderHea.Ship_Via to hoShipVia
                            Get TableData of hoShipVia to vShipViaData
                            Move (SizeOfArray (vShipViaData)) to iShipViaElements
                            Decrement iShipViaElements
                            For iShipViaElement from 0 to iShipViaElements
                                Move vShipViaData[iShipViaElement][0] to ShipViaData[iRow].sValue[iCodeColumn]
                                Move vShipViaData[iShipViaElement][1] to ShipViaData[iRow].sValue[iDescrColumn]
                                // Assign a random weight value, might be overwritten by the XML data
                                Move (Random (10) + 1) to ShipViaData[iRow].sValue[iWeightColumn]
                                // If there is no XML data for ShipVia the following block will be skipped
                                If (hoData <> 0) Begin
                                    // The code needs to look for an element whose ID attribute equals to the current salesperson ID
                                    Get FirstChild of hoData to hoNode
                                    While (hoNode <> 0)
                                        Get IsElementNS of hoNode C_OrdersGeneratorNS 'ShipVia' to bIsShipViaElement
                                        If (bIsShipViaElement) Begin
                                            Get AttributeValue of hoNode 'Id' to sShipViaCode
                                            If (sShipViaCode = vShipViaData[iShipViaElement][0]) Begin
                                                Get AttributeValue of hoNode 'Weight' to ShipViaData[iRow].sValue[iWeightColumn]
                                                Send Destroy of hoNode
                                                Move 0 to hoNode
                                            End
                                            Else Begin
                                                Get NextNode of hoNode to hoNode
                                            End
                                        End
                                        Else Begin
                                            Get NextNode of hoNode to hoNode
                                        End
                                    Loop
                                End
                                Increment iRow
                            Loop
                            
                            If (hoRoot <> 0) Begin
                                If (hoData <> 0) Begin
                                    Send Destroy of hoData
                                End
                                Send Destroy of hoRoot
                            End
                            
                            Send InitializeData ShipViaData
                        End_Procedure
                        
                        Procedure SetRandomWeights Integer iMax
                            Handle hoDataSource
                            tDataSourceRow[] GridData
                            Integer iWeightColumn iElements iElement
                            
                            Get piColumnId of oWeightColumn to iWeightColumn
                            
                            Get phoDataSource to hoDataSource
                            Get DataSource of hoDataSource to GridData
                            Move (SizeOfArray (GridData)) to iElements
                            Decrement iElements
                            For iElement from 0 to iElements
                                Move (Random (iMax) + 1) to GridData[iElement].sValue[iWeightColumn]
                            Loop
                            
                            Send InitializeData GridData
                        End_Procedure
                        
                        Procedure StoreToXMLData
                            Handle hoDataSource hoRoot hoData hoShipViaElement
                            tDataSourceRow[] ShipViaData
                            Integer iCodeColumn iWeightColumn iElements iElement
                            
                            Get phoDataSource to hoDataSource
                            Get DataSource of hoDataSource to ShipViaData
                            Move (SizeOfArray (ShipViaData)) to iElements
                            If (iElements > 0) Begin
                                Get OrdersGeneratorSettings of oSettingsHandler to hoRoot
                                If (hoRoot <> 0) Begin
                                    // Remove a previous ShipViaData node if present
                                    Get ChildElementNS of hoRoot C_OrdersGeneratorNS "ShipViaData" to hoData
                                    If (hoData <> 0) Begin
                                        Get RemoveNode of hoRoot hoData to hoData
                                        If (hoData <> 0) Begin
                                            Send Destroy of hoData
                                        End
                                    End
                                    Get AddElementNS of hoRoot C_OrdersGeneratorNS "ShipViaData" '' to hoData
                                    If (hoData <> 0) Begin
                                        Get piColumnId of oCodeColumn to iCodeColumn
                                        Get piColumnId of oWeightColumn to iWeightColumn
                                        
                                        Decrement iElements
                                        For iElement from 0 to iElements
                                            // Add an XML node for each ShipVia code with code and weight as attributes
                                            Get AddElementNS of hoData C_OrdersGeneratorNS 'ShipVia' '' to hoShipViaElement
                                            If (hoShipViaElement <> 0) Begin
                                                Send AddAttribute of hoShipViaElement 'Id' ShipViaData[iElement].sValue[iCodeColumn]
                                                Send AddAttribute of hoShipViaElement 'Weight' ShipViaData[iElement].sValue[iWeightColumn]
                                                Send Destroy of hoShipViaElement
                                            End
                                        Loop
                                        Send Destroy of hoData
                                    End
                                    Send Destroy of hoRoot
                                End
                            End
                        End_Procedure
                        
                        Function ToBeUsedShipViaCodes String[] ByRef sShipViaCodes Returns Integer
                            Boolean bIsComObjectCreated
                            Handle hoDataSource
                            tDataSourceRow[] ShipViaData
                            Integer iCodeColumn iWeightColumn iElements iElement iCount iShipViaElement
                            
                            // If the grid is not active there is no data, so first activate to get
                            // data from validation table and XML and then return this information
                            Get IsComObjectCreated to bIsComObjectCreated
                            If (not (bIsComObjectCreated)) Begin
                                Send Activate
                            End
                            
                            Get phoDataSource to hoDataSource
                            Get DataSource of hoDataSource to ShipViaData
                            
                            Get piColumnId of oCodeColumn to iCodeColumn
                            Get piColumnId of oWeightColumn to iWeightColumn
                            
                            Move (SizeOfArray (ShipViaData)) to iElements
                            Decrement iElements
                            For iElement from 0 to iElements
                                If (ShipViaData[iElement].sValue[iWeightColumn] > 0) Begin
                                    For iCount from 1 to ShipViaData[iElement].sValue[iWeightColumn]
                                        Move ShipViaData[iElement].sValue[iCodeColumn] to sShipViaCodes[iShipViaElement]
                                        Increment iShipViaElement
                                        // Already randomize the array values
                                        Move (ShuffleArray (sShipViaCodes)) to sShipViaCodes
                                    Loop
                                End
                            Loop
                            
                            // Randomize the array again
                            Move (ShuffleArray (sShipViaCodes)) to sShipViaCodes
                            
                            Function_Return iShipViaElement
                        End_Function
                    End_Object
                    
                    Object oRandomWeightsButton is a Button
                        Set Size to 14 62
                        Set Location to 101 196
                        Set Label to 'Random Weights'
                        Set psToolTip to "Take a random weight for each ShipVia"
                        Set peAnchors to anBottomRight
                        
                        Procedure OnClick
                            Send SetRandomWeights of oShipViaGrid 10
                        End_Procedure
                    End_Object
                    
                    Object oResetWeightsButton is a Button
                        Set Size to 14 62
                        Set Location to 101 132
                        Set Label to "Reset Weights"
                        Set psToolTip to "Set the weight for each ShipVia to 1"
                        Set peAnchors to anBottomRight
                        
                        Procedure OnClick
                            Send SetRandomWeights of oShipViaGrid 1
                        End_Procedure
                    End_Object
                    
                    Object oExplanationTextBox is a TextBox
                        Set Auto_Size_State to False
                        Set Size to 111 62
                        Set Location to 5 263
                        Set Label to "Setting the weight means how many times the ship via value will be made available in the array to pick from. Increasing the weight should lead to more orders with this ship via value."
                        Set Justification_Mode to JMode_Left
                        Set peAnchors to anTopBottomRight
                    End_Object
                End_Object
                
                Object oTermsTabPage is a TabPage
                    Set Label to "Terms"
                    
                    Object oTermsGrid is a cCJGrid
                        Set Size to 92 253
                        Set Location to 5 5
                        Set pbAllowAppendRow to False
                        Set pbAllowColumnRemove to False
                        Set pbAllowColumnReorder to False
                        Set pbAllowDeleteRow to False
                        Set pbAllowInsertRow to False
                        Set peAnchors to anAll
                        Set pbUseAlternateRowBackgroundColor to True
                        Set pbHeaderReorders to True
                        Set pbHeaderTogglesDirection to True
                        
                        Object oRowIndicator is a cCJGridColumnRowIndicator
                            Set piWidth to 22
                        End_Object
                        
                        Object oCodeColumn is a cCJGridColumn
                            Set piWidth to 75
                            Set psCaption to "Code"
                            Set pbEditable to False
                        End_Object
                        
                        Object oDescriptionColumn is a cCJGridColumn
                            Set piWidth to 251
                            Set psCaption to "Description"
                            Set pbEditable to False
                        End_Object
                        
                        Object oWeightColumn is a cCJGridColumn
                            Set piWidth to 94
                            Set psCaption to "Weight"
                            Set peDataType to Mask_Numeric_Window
                            Set psMask to "###"
                            
                            Function OnValidating Returns Boolean
                                Integer iWeight
                                Boolean bValueNotOk
                                
                                Get SelectedRowValue to iWeight
                                Move (iWeight < 0) to bValueNotOk
                                If (bValueNotOk) Begin
                                    Error DFERR_OPERATOR "Weight Value Must be 0 or Higher!"
                                End
                                
                                Function_Return bValueNotOk
                            End_Function
                        End_Object
                        
                        Procedure Activating
                            Forward Send Activating
                            Send ReadTerms
                        End_Procedure
                        
                        Procedure ReadTerms
                            tDataSourceRow[] TermsData
                            Integer iCodeColumn iDescrColumn iWeightColumn iRow
                            Integer iTermsElements iTermsElement
                            Handle hoTerms hoRoot hoData hoNode
                            Variant[][] vTermsData
                            Boolean bIsTermsElement
                            String sCodeValue
                            
                            Get piColumnId of oCodeColumn to iCodeColumn
                            Get piColumnId of oDescriptionColumn to iDescrColumn
                            Get piColumnId of oWeightColumn to iWeightColumn
                            
                            Get OrdersGeneratorSettings of oSettingsHandler to hoRoot
                            If (hoRoot <> 0) Begin
                                // Lookup in the XML object if there is a node with the name TermsData
                                Get ChildElementNS of hoRoot C_OrdersGeneratorNS "TermsData" to hoData
                            End
                            
                            // Collect the terms information from the validation table connected to the orderhea.terms
                            // column in the Orderhea DDO.
                            Get Field_Table_Object of (oOrderHea_DD (oOrdersGeneratorBPO)) Field OrderHea.Terms to hoTerms
                            Get TableData of hoTerms to vTermsData
                            Move (SizeOfArray (vTermsData)) to iTermsElements
                            Decrement iTermsElements
                            For iTermsElement from 0 to iTermsElements
                                Move vTermsData[iTermsElement][0] to TermsData[iRow].sValue[iCodeColumn]
                                Move vTermsData[iTermsElement][1] to TermsData[iRow].sValue[iDescrColumn]
                                // Assign a random weight value, might be overwritten by information from
                                // XML if any
                                Move (Random (10) + 1) to TermsData[iRow].sValue[iWeightColumn]
                                // If there is an existing data set hoData will not be 0
                                If (hoData <> 0) Begin
                                    // Lookup an element with an attribute Code identical to the current Terms
                                    // code value. If exists get the weight value
                                    Get FirstChild of hoData to hoNode
                                    While (hoNode <> 0)
                                        Get IsElementNS of hoNode C_OrdersGeneratorNS "Terms" to bIsTermsElement
                                        If (bIsTermsElement) Begin
                                            Get AttributeValue of hoNode "Code" to sCodeValue
                                            If (sCodeValue = TermsData[iRow].sValue[iCodeColumn]) Begin
                                                Get AttributeValue of hoNode "Weight" to TermsData[iRow].sValue[iWeightColumn]
                                                Send Destroy of hoNode
                                                Move 0 to hoNode
                                            End
                                        End
                                        If (hoNode <> 0) Begin
                                            Get NextNode of hoNode to hoNode
                                        End
                                    Loop
                                End
                                Increment iRow
                            Loop
                            
                            If (hoRoot <> 0) Begin
                                If (hoData <> 0) Begin
                                    Send Destroy of hoData
                                End
                                Send Destroy of hoRoot
                            End
                            
                            Send InitializeData TermsData
                        End_Procedure
                        
                        Procedure SetRandomWeights Integer iMax
                            Handle hoDataSource
                            tDataSourceRow[] GridData
                            Integer iWeightColumn iElements iElement
                            
                            Get piColumnId of oWeightColumn to iWeightColumn
                            
                            Get phoDataSource to hoDataSource
                            Get DataSource of hoDataSource to GridData
                            Move (SizeOfArray (GridData)) to iElements
                            Decrement iElements
                            For iElement from 0 to iElements
                                Move (Random (iMax) + 1) to GridData[iElement].sValue[iWeightColumn]
                            Loop
                            
                            Send InitializeData GridData
                        End_Procedure
                        
                        // Store the user's choice into the XML stream
                        Procedure StoreToXMLData
                            Handle hoDataSource hoRoot hoData hoTermsElement
                            tDataSourceRow[] TermsData
                            Integer iCodeColumn iWeightColumn iElements iElement
                            
                            Get phoDataSource to hoDataSource
                            Get DataSource of hoDataSource to TermsData
                            Move (SizeOfArray (TermsData)) to iElements
                            If (iElements > 0) Begin
                                Get OrdersGeneratorSettings of oSettingsHandler to hoRoot
                                If (hoRoot <> 0) Begin
                                    // If there is a previous termsdata element remove it first
                                    Get ChildElementNS of hoRoot C_OrdersGeneratorNS "TermsData" to hoData
                                    If (hoData <> 0) Begin
                                        Get RemoveNode of hoRoot hoData to hoData
                                        If (hoData <> 0) Begin
                                            Send Destroy of hoData
                                        End
                                    End
                                    Get AddElementNS of hoRoot C_OrdersGeneratorNS "TermsData" '' to hoData
                                    If (hoData <> 0) Begin
                                        Get piColumnId of oCodeColumn to iCodeColumn
                                        Get piColumnId of oWeightColumn to iWeightColumn
                                        
                                        Decrement iElements
                                        For iElement from 0 to iElements
                                            // Add terms elements with their code and weight as attributes
                                            Get AddElementNS of hoData C_OrdersGeneratorNS "Terms" '' to hoTermsElement
                                            If (hoTermsElement <> 0) Begin
                                                Send AddAttribute of hoTermsElement "Code" TermsData[iElement].sValue[iCodeColumn]
                                                Send AddAttribute of hoTermsElement "Weight" TermsData[iElement].sValue[iWeightColumn]
                                                Send Destroy of hoTermsElement
                                            End
                                        Loop
                                        Send Destroy of hoData
                                    End
                                    Send Destroy of hoRoot
                                End
                            End
                        End_Procedure
                        
                        Function ToBeUsedTerms String[] ByRef sTermsCodes Returns Integer
                            Boolean bIsComObjectCreated
                            Handle hoDataSource
                            tDataSourceRow[] TermsData
                            Integer iCodeColumn iWeightColumn iElements iElement iCount iTermsElement
                            
                            // If the grid is not active there will be no data so first activate and
                            // read data from table and XML and return this.
                            Get IsComObjectCreated to bIsComObjectCreated
                            If (not (bIsComObjectCreated)) Begin
                                Send Activate
                            End
                            
                            Get phoDataSource to hoDataSource
                            Get DataSource of hoDataSource to TermsData
                            
                            Get piColumnId of oCodeColumn to iCodeColumn
                            Get piColumnId of oWeightColumn to iWeightColumn
                            
                            Move (SizeOfArray (TermsData)) to iElements
                            Decrement iElements
                            For iElement from 0 to iElements
                                If (TermsData[iElement].sValue[iWeightColumn] > 0) Begin
                                    For iCount from 1 to TermsData[iElement].sValue[iWeightColumn]
                                        Move TermsData[iElement].sValue[iCodeColumn] to sTermsCodes[iTermsElement]
                                        Increment iTermsElement
                                        // Already randomize the array
                                        Move (ShuffleArray (sTermsCodes)) to sTermsCodes
                                    Loop
                                End
                            Loop
                            
                            // Randomize the array again
                            Move (ShuffleArray (sTermsCodes)) to sTermsCodes
                            
                            Function_Return iTermsElement
                        End_Function
                    End_Object
                    
                    Object oRandomWeightsButton is a Button
                        Set Size to 14 62
                        Set Location to 101 196
                        Set Label to 'Random Weights'
                        Set psToolTip to "Take a random weight for each Term"
                        Set peAnchors to anBottomRight
                        
                        Procedure OnClick
                            Send SetRandomWeights of oTermsGrid 10
                        End_Procedure
                    End_Object
                    
                    Object oResetWeightsButton is a Button
                        Set Size to 14 62
                        Set Location to 101 132
                        Set Label to "Reset Weights"
                        Set psToolTip to "Set the weight for each Term to 1"
                        Set peAnchors to anBottomRight
                        
                        Procedure OnClick
                            Send SetRandomWeights of oTermsGrid 1
                        End_Procedure
                    End_Object
                    
                    Object oExplanationTextBox is a TextBox
                        Set Auto_Size_State to False
                        Set Size to 111 62
                        Set Location to 5 263
                        Set Label to "Setting the weight means how many times a terms value will be made available in the array to pick from. Increasing the weight should lead to more orders with this terms value."
                        Set Justification_Mode to JMode_Left
                        Set peAnchors to anTopBottomRight
                    End_Object
                End_Object
                
                Object oOrderedByTabPage is a TabPage
                    Set Label to "Ordered by"
                    
                    Object oOrderedByGrid is a cCJGrid
                        Set Size to 93 223
                        Set Location to 5 5
                        Set pbAllowColumnRemove to False
                        Set pbAllowColumnReorder to False
                        Set peAnchors to anAll
                        Set pbUseAlternateRowBackgroundColor to True
                        Set pbHeaderReorders to True
                        Set pbHeaderTogglesDirection to True
                        
                        Object oRowIndicator is a cCJGridColumnRowIndicator
                            Set piWidth to 22
                        End_Object
                        
                        Object oNameColumn is a cCJGridColumn
                            Set piWidth to 267
                            Set psCaption to "Name"
                        End_Object
                        
                        Object oWeightColumn is a cCJGridColumn
                            Set piWidth to 101
                            Set psCaption to "Weight"
                            Set peDataType to Mask_Numeric_Window
                            Set psMask to "###"
                            
                            Function OnValidating Returns Boolean
                                Integer iWeight
                                Boolean bValueNotOk
                                
                                Get SelectedRowValue to iWeight
                                Move (iWeight < 0) to bValueNotOk
                                If (bValueNotOk) Begin
                                    Error DFERR_OPERATOR "Weight Value Must be 0 or Higher!"
                                End
                                
                                Function_Return bValueNotOk
                            End_Function
                        End_Object
                        
                        Procedure Activating
                            Forward Send Activating
                            Send CreateOrderedByNames
                        End_Procedure
                        
                        Procedure CreateOrderedByNames
                            tDataSourceRow[] OrderedByData
                            Integer iNameColumn iWeightColumn iRow
                            Handle hoRoot hoData hoNode
                            Boolean bIsOrderedByElement
                            
                            Get piColumnId of oNameColumn to iNameColumn
                            Get piColumnId of oWeightColumn to iWeightColumn
                            
                            Get OrdersGeneratorSettings of oSettingsHandler to hoRoot
                            If (hoRoot <> 0) Begin
                                Get ChildElementNS of hoRoot C_OrdersGeneratorNS "OrderedByData" to hoData
                            End
                            
                            If (hoData <> 0) Begin
                                Get FirstChild of hoData to hoNode
                                While (hoNode <> 0)
                                    Get IsElementNS of hoNode C_OrdersGeneratorNS "OrderedBy" to bIsOrderedByElement
                                    If (bIsOrderedByElement) Begin
                                        Get AttributeValue of hoNode "Name" to OrderedByData[iRow].sValue[iNameColumn]
                                        Get AttributeValue of hoNode "Weight" to OrderedByData[iRow].sValue[iWeightColumn]
                                        Increment iRow
                                    End
                                    Get NextNode of hoNode to hoNode
                                Loop
                            End
                            
                            // There is no table with names (free value in the orderhea table)
                            // so create some names to give the user variation.
                            If (SizeOfArray (OrderedByData) = 0) Begin
                                Move "John" to OrderedByData[0].sValue[iNameColumn]
                                Move (Random (10) + 1) to OrderedByData[0].sValue[iWeightColumn]
                                Move "William" to OrderedByData[1].sValue[iNameColumn]
                                Move (Random (10) + 1) to OrderedByData[1].sValue[iWeightColumn]
                                Move "Peter" to OrderedByData[2].sValue[iNameColumn]
                                Move (Random (10) + 1) to OrderedByData[2].sValue[iWeightColumn]
                                Move "Mike" to OrderedByData[3].sValue[iNameColumn]
                                Move (Random (10) + 1) to OrderedByData[3].sValue[iWeightColumn]
                            End
                            
                            If (hoRoot <> 0) Begin
                                If (hoData <> 0) Begin
                                    Send Destroy of hoData
                                End
                                Send Destroy of hoRoot
                            End
                            
                            Send InitializeData OrderedByData
                        End_Procedure
                        
                        // Assign a new random value to the grid between 0 and iMax
                        Procedure SetRandomWeights Integer iMax
                            Handle hoDataSource
                            tDataSourceRow[] GridData
                            Integer iWeightColumn iElements iElement
                            
                            Get piColumnId of oWeightColumn to iWeightColumn
                            
                            Get phoDataSource to hoDataSource
                            Get DataSource of hoDataSource to GridData
                            Move (SizeOfArray (GridData)) to iElements
                            Decrement iElements
                            For iElement from 0 to iElements
                                Move (Random (iMax) + 1) to GridData[iElement].sValue[iWeightColumn]
                            Loop
                            
                            Send InitializeData GridData
                        End_Procedure
                        
                        Procedure StoreToXMLData
                            Handle hoDataSource hoRoot hoData hoOrderedByElement
                            tDataSourceRow[] OrderedByData
                            Integer iNameColumn iWeightColumn iElements iElement
                            
                            Get phoDataSource to hoDataSource
                            Get DataSource of hoDataSource to OrderedByData
                            Move (SizeOfArray (OrderedByData)) to iElements
                            If (iElements > 0) Begin
                                Get OrdersGeneratorSettings of oSettingsHandler to hoRoot
                                If (hoRoot <> 0) Begin
                                    // If there was a node with ordered by names and weights; remove them
                                    Get ChildElementNS of hoRoot C_OrdersGeneratorNS "OrderedByData" to hoData
                                    If (hoData <> 0) Begin
                                        Get RemoveNode of hoRoot hoData to hoData
                                        If (hoData <> 0) Begin
                                            Send Destroy of hoData
                                        End
                                    End
                                    Get AddElementNS of hoRoot C_OrdersGeneratorNS "OrderedByData" '' to hoData
                                    If (hoData <> 0) Begin
                                        Get piColumnId of oNameColumn to iNameColumn
                                        Get piColumnId of oWeightColumn to iWeightColumn
                                        
                                        Decrement iElements
                                        For iElement from 0 to iElements
                                            // Add ordered by information as element with attributes for name and weight
                                            Get AddElementNS of hoData C_OrdersGeneratorNS "OrderedBy" '' to hoOrderedByElement
                                            If (hoOrderedByElement <> 0) Begin
                                                Send AddAttribute of hoOrderedByElement "Name" OrderedByData[iElement].sValue[iNameColumn]
                                                Send AddAttribute of hoOrderedByElement "Weight" OrderedByData[iElement].sValue[iWeightColumn]
                                                Send Destroy of hoOrderedByElement
                                            End
                                        Loop
                                        Send Destroy of hoData
                                    End
                                    Send Destroy of hoRoot
                                End
                            End
                        End_Procedure
                        
                        Function ToBeUsedOrderedBy String[] ByRef sOrderedByNames Returns Integer
                            Boolean bIsComObjectCreated
                            Handle hoDataSource
                            tDataSourceRow[] OrderedByData
                            Integer iNameColumn iWeightColumn iElements iElement iCount iOrderedByElement
                            
                            // If the grid was not active no data will be returned, so first activate the
                            // grid to get data and then return the information.
                            Get IsComObjectCreated to bIsComObjectCreated
                            If (not (bIsComObjectCreated)) Begin
                                Send Activate
                            End
                            
                            Get phoDataSource to hoDataSource
                            Get DataSource of hoDataSource to OrderedByData
                            
                            Get piColumnId of oNameColumn to iNameColumn
                            Get piColumnId of oWeightColumn to iWeightColumn
                            
                            Move (SizeOfArray (OrderedByData)) to iElements
                            Decrement iElements
                            For iElement from 0 to iElements
                                If (OrderedByData[iElement].sValue[iWeightColumn] > 0 and OrderedByData[iElement].sValue[iNameColumn] <> '') Begin
                                    For iCount from 1 to OrderedByData[iElement].sValue[iWeightColumn]
                                        Move OrderedByData[iElement].sValue[iNameColumn] to sOrderedByNames[iOrderedByElement]
                                        Increment iOrderedByElement
                                        // Randomize the array
                                        Move (ShuffleArray (sOrderedByNames)) to sOrderedByNames
                                    Loop
                                End
                            Loop
                            
                            // Another randomize of the array
                            Move (ShuffleArray (sOrderedByNames)) to sOrderedByNames
                            
                            Function_Return iOrderedByElement
                        End_Function
                    End_Object
                    
                    Object oRandomWeightsButton is a Button
                        Set Size to 14 62
                        Set Location to 101 166
                        Set Label to 'Random Weights'
                        Set psToolTip to "Take a random weight for each ordered by person"
                        Set peAnchors to anBottomRight
                        
                        Procedure OnClick
                            Send SetRandomWeights of oOrderedByGrid 10
                        End_Procedure
                    End_Object
                    
                    Object oResetWeightsButton is a Button
                        Set Size to 14 62
                        Set Location to 101 100
                        Set Label to "Reset Weights"
                        Set psToolTip to "Set the weight for each ordered by person to 1"
                        Set peAnchors to anBottomRight
                        
                        Procedure OnClick
                            Send SetRandomWeights of oOrderedByGrid 1
                        End_Procedure
                    End_Object
                    
                    Object oExplanationTextBox is a TextBox
                        Set Auto_Size_State to False
                        Set Size to 111 93
                        Set Location to 5 233
                        Set Label to "Setting the weight means how many times the person will be made available in the array to pick from. Increasing the weight should lead to more orders ordered by this person. There are no names in a database; the list is free editable, add more if you like."
                        Set Justification_Mode to JMode_Left
                        Set peAnchors to anTopBottomRight
                    End_Object
                End_Object
            End_Object
        End_Object
        
        Object oOrderDtlTabPage is a TabPage
            Set Label to 'Order Details'
            
            Object oOrderDtlTabDialog is a TabDialog
                Set Size to 134 334
                Set Location to 5 5
                Set peAnchors to anAll
                
                Object oNumbersTabPage is a TabPage
                    Set Label to "Numbers"
                    
                    Object oQTYVariationGroup is a Group
                        Set Size to 44 91
                        Set Location to 5 5
                        Set Label to "QTY Variation"
                        
                        Object oMaxQTYVariationForm is a Form
                            Set Size to 13 40
                            Set Location to 26 45
                            Set Label to "To:"
                            Set Form_Datatype to 0
                            Set Label_Col_Offset to 2
                            Set Label_Justification_Mode to JMode_Right
                            
                            Procedure ValidateSpecs
                                Integer iValue
                                
                                Get Value to iValue
                                
                                If (iValue < 1) Begin
                                    Send Stop_Box "Maximum QTY Variation Should be larger than 1"
                                    Set pbSpecsOk to False
                                End
                            End_Procedure
                        End_Object
                        
                        Object oMinQTYVariationForm is a Form
                            Set Size to 13 40
                            Set Location to 11 45
                            Set Label to "From:"
                            Set Form_Datatype to 0
                            Set Label_Col_Offset to 2
                            Set Label_Justification_Mode to JMode_Right
                            
                            Procedure ValidateSpecs
                                Integer iValue
                                
                                Get Value to iValue
                                
                                If (iValue < 1) Begin
                                    Send Stop_Box "Minimum QTY Variation Should be larger than 1"
                                    Set pbSpecsOk to False
                                End
                            End_Procedure
                        End_Object
                    End_Object
                    
                    Object oLinesGroup is a Group
                        Set Size to 44 91
                        Set Location to 51 5
                        Set Label to "Lines#"
                        
                        Object oMinOrderDetailLinesForm is a Form
                            Set Size to 13 40
                            Set Location to 11 45
                            Set Label to "From:"
                            Set Form_Datatype to 0
                            Set Label_Col_Offset to 2
                            Set Label_Justification_Mode to JMode_Right
                            
                            Procedure ValidateSpecs
                                Integer iValue
                                
                                Get Value to iValue
                                
                                If (iValue < 1 or iValue > 100) Begin
                                    Send Stop_Box "Minimum Order Detail Lines Should be Between 1 and 100"
                                    Set pbSpecsOk to False
                                End
                            End_Procedure
                        End_Object
                        
                        Object oMaxOrderDetailLinesForm is a Form
                            Set Size to 13 40
                            Set Location to 26 45
                            Set Label to "To:"
                            Set Form_Datatype to 0
                            Set Label_Col_Offset to 2
                            Set Label_Justification_Mode to JMode_Right
                            
                            Procedure ValidateSpecs
                                Integer iValue
                                
                                Get Value to iValue
                                
                                If (iValue < 1 or iValue > 100) Begin
                                    Send Stop_Box "Maximum Order Detail Lines Should be Between 1 and 100"
                                    Set pbSpecsOk to False
                                End
                            End_Procedure
                        End_Object
                    End_Object
                    
                    Procedure ReadFromXMLData
                        Handle hoRoot hoData
                        Integer iVariation
                        
                        Get OrdersGeneratorSettings of oSettingsHandler to hoRoot
                        If (hoRoot <> 0) Begin
                            Get ChildElementNS of hoRoot C_OrdersGeneratorNS "OrderDtlNumbersData" to hoData
                            If (hoData <> 0) Begin
                                Get ChildElementValueNS of hoData C_OrdersGeneratorNS "MinQTYVariation" to iVariation
                                Set Value of oMinQTYVariationForm to iVariation
                                
                                Get ChildElementValueNS of hoData C_OrdersGeneratorNS "MaxQTYVariation" to iVariation
                                Set Value of oMaxQTYVariationForm to iVariation
                                
                                Get ChildElementValueNS of hoData C_OrdersGeneratorNS "MinLinesVariation" to iVariation
                                Set Value of oMinOrderDetailLinesForm to iVariation
                                
                                Get ChildElementValueNS of hoData C_OrdersGeneratorNS "MaxLinesVariation" to iVariation
                                Set Value of oMaxOrderDetailLinesForm to iVariation
                                
                                Send Destroy of hoData
                            End
                            Else Begin
                                Set Value of oMinOrderDetailLinesForm to 2
                                Set Value of oMaxOrderDetailLinesForm to 10
                                Set Value of oMinQTYVariationForm to 1
                                Set Value of oMaxQTYVariationForm to 10
                            End
                            
                            Send Destroy of hoRoot
                        End
                    End_Procedure
                    
                    Procedure StoreToXMLData
                        Handle hoRoot hoData
                        Integer iVariation
                        
                        Get OrdersGeneratorSettings of oSettingsHandler to hoRoot
                        If (hoRoot <> 0) Begin
                            Get ChildElementNS of hoRoot C_OrdersGeneratorNS "OrderDtlNumbersData" to hoData
                            If (hoData <> 0) Begin
                                Get RemoveNode of hoRoot hoData to hoData
                                If (hoData <> 0) Begin
                                    Send Destroy of hoData
                                End
                            End
                            Get AddElementNS of hoRoot C_OrdersGeneratorNS "OrderDtlNumbersData" '' to hoData
                            If (hoData <> 0) Begin
                                Get Value of oMinQTYVariationForm to iVariation
                                Send AddElementNS of hoData C_OrdersGeneratorNS "MinQTYVariation" iVariation
                                
                                Get Value of oMaxQTYVariationForm to iVariation
                                Send AddElementNS of hoData C_OrdersGeneratorNS "MaxQTYVariation" iVariation
                                
                                Get Value of oMinOrderDetailLinesForm to iVariation
                                Send AddElementNS of hoData C_OrdersGeneratorNS "MinLinesVariation" iVariation
                                
                                Get Value of oMaxOrderDetailLinesForm to iVariation
                                Send AddElementNS of hoData C_OrdersGeneratorNS "MaxLinesVariation" iVariation
                                
                                Send Destroy of hoData
                            End
                            
                            Send Destroy of hoRoot
                        End
                    End_Procedure
                End_Object
                
                Object oInventoryTabPage is a TabPage
                    Set Label to "Inventory"
                    
                    Object oInventoryGrid is a cCJGrid
                        Set Size to 96 247
                        Set Location to 5 5
                        Set pbAllowAppendRow to False
                        Set pbAllowColumnRemove to False
                        Set pbAllowColumnReorder to False
                        Set pbAllowDeleteRow to False
                        Set pbAllowInsertRow to False
                        Set peAnchors to anAll
                        Set pbUseAlternateRowBackgroundColor to True
                        Set pbHeaderReorders to True
                        Set pbHeaderTogglesDirection to True
                        
                        Object oRowIndicator is a cCJGridColumnRowIndicator
                            Set piWidth to 18
                        End_Object
                        
                        Object oCodeColumn is a cCJGridColumn
                            Set piWidth to 54
                            Set psCaption to "Code"
                            Set pbEditable to False
                        End_Object
                        
                        Object oDescriptionColumn is a cCJGridColumn
                            Set piWidth to 180
                            Set psCaption to "Description"
                            Set pbEditable to False
                        End_Object
                        
                        Object oPriceColumn is a cCJGridColumn
                            Set piWidth to 45
                            Set psCaption to "Price"
                            Set peDataType to Mask_Numeric_Window
                            Set psMask to "######.#0"
                            Set pbEditable to False
                        End_Object
                        
                        Object oWeightColumn is a cCJGridColumn
                            Set piWidth to 45
                            Set psCaption to "Weight"
                            Set peDataType to Mask_Numeric_Window
                            Set psMask to "###"
                            
                            Function OnValidating Returns Boolean
                                Integer iWeight
                                Boolean bValueNotOk
                                
                                Get SelectedRowValue to iWeight
                                Move (iWeight < 0) to bValueNotOk
                                If (bValueNotOk) Begin
                                    Error DFERR_OPERATOR "Weight Value Must be 0 or Higher!"
                                End
                                
                                Function_Return bValueNotOk
                            End_Function
                        End_Object
                        
                        Object oPriceMinColumn is a cCJGridColumn
                            Set piWidth to 45
                            Set psCaption to "Min %"
                            Set peDataType to Mask_Numeric_Window
                            Set psMask to "##"
                        End_Object
                        
                        Object oPriceMaxColumn is a cCJGridColumn
                            Set piWidth to 45
                            Set psCaption to "Max %"
                            Set peDataType to Mask_Numeric_Window
                            Set psMask to "##"
                        End_Object
                        
                        Procedure Activating
                            Forward Send Activating
                            Send ReadInvt
                        End_Procedure
                        
                        Procedure ReadInvt
                            tDataSourceRow[] InvtData
                            Integer iCodeColumn iDescrColumn iPriceColumn iWeightColumn
                            Integer iPriceMinColumn iPriceMaxColumn iRow
                            Handle hoInvtDD hoRoot hoData hoNode
                            Variant[][] vShipViaData
                            Boolean bIsInvtElement
                            String sCodeValue sAllowDuplicates
                            
                            Get piColumnId of oCodeColumn to iCodeColumn
                            Get piColumnId of oDescriptionColumn to iDescrColumn
                            Get piColumnId of oPriceColumn to iPriceColumn
                            Get piColumnId of oWeightColumn to iWeightColumn
                            Get piColumnId of oPriceMinColumn to iPriceMinColumn
                            Get piColumnId of oPriceMaxColumn to iPriceMaxColumn
                            
                            Get OrdersGeneratorSettings of oSettingsHandler to hoRoot
                            If (hoRoot <> 0) Begin
                                Get ChildElementNS of hoRoot C_OrdersGeneratorNS "InvtData" to hoData
                            End
                            
                            If (hoData <> 0) Begin
                                Get AttributeValue of hoData "DuplicatesAllowed" to sAllowDuplicates
                                Set Checked_State of oInvtItemDuplicatesCheckBox to (sAllowDuplicates = 'Y')
                            End
                            
                            Move (oInvt_DD (oOrdersGeneratorBPO)) to hoInvtDD
                            Send Clear of hoInvtDD
                            Send Request_Read of hoInvtDD FIRST_RECORD Invt.File_Number 1
                            While (Found)
                                Move (GetRowID (Invt.File_Number)) to InvtData[iRow].riID
                                Move (Trim (Invt.Item_ID)) to InvtData[iRow].sValue[iCodeColumn]
                                Move (Trim (Invt.Description)) to InvtData[iRow].sValue[iDescrColumn]
                                Move Invt.Unit_Price to InvtData[iRow].sValue[iPriceColumn]
                                Move (Random (10) + 1) to InvtData[iRow].sValue[iWeightColumn]
                                Move -10 to InvtData[iRow].sValue[iPriceMinColumn]
                                Move 10 to InvtData[iRow].sValue[iPriceMaxColumn]
                                If (hoData <> 0) Begin
                                    Get FirstChild of hoData to hoNode
                                    While (hoNode <> 0)
                                        Get IsElementNS of hoNode C_OrdersGeneratorNS "Invt" to bIsInvtElement
                                        If (bIsInvtElement) Begin
                                            Get AttributeValue of hoNode "Code" to sCodeValue
                                            If (sCodeValue = InvtData[iRow].sValue[iCodeColumn]) Begin
                                                Get AttributeValue of hoNode "Weight" to InvtData[iRow].sValue[iWeightColumn]
                                                Get AttributeValue of hoNode "Min" to InvtData[iRow].sValue[iPriceMinColumn]
                                                Get AttributeValue of hoNode "Max" to InvtData[iRow].sValue[iPriceMaxColumn]
                                                Send Destroy of hoNode
                                                Move 0 to hoNode
                                            End
                                        End
                                        If (hoNode <> 0) Begin
                                            Get NextNode of hoNode to hoNode
                                        End
                                    Loop
                                End
                                Increment iRow
                                Send Locate_Next of hoInvtDD
                            Loop
                            
                            If (hoRoot <> 0) Begin
                                If (hoData <> 0) Begin
                                    Send Destroy of hoData
                                End
                                Send Destroy of hoRoot
                            End
                            
                            Send InitializeData InvtData
                        End_Procedure
                        
                        Procedure SetRandomValues Integer iMax
                            Handle hoDataSource
                            tDataSourceRow[] GridData
                            Integer iWeightColumn iElements iElement
                            Integer iPriceMinColumn iPriceMaxColumn
                            
                            Get piColumnId of oWeightColumn to iWeightColumn
                            Get piColumnId of oPriceMinColumn to iPriceMinColumn
                            Get piColumnId of oPriceMaxColumn to iPriceMaxColumn
                            
                            Get phoDataSource to hoDataSource
                            Get DataSource of hoDataSource to GridData
                            Move (SizeOfArray (GridData)) to iElements
                            Decrement iElements
                            For iElement from 0 to iElements
                                Move (Random (iMax) + 1) to GridData[iElement].sValue[iWeightColumn]
                                If (iMax > 1) Begin
                                    Move (Random (iMax) + 1 * -1) to GridData[iElement].sValue[iPriceMinColumn]
                                    Move (Random (iMax) + 1) to GridData[iElement].sValue[iPriceMaxColumn]
                                End
                                Else Begin
                                    Move -10 to GridData[iElement].sValue[iPriceMinColumn]
                                    Move 10 to GridData[iElement].sValue[iPriceMaxColumn]
                                End
                            Loop
                            
                            Send InitializeData GridData
                        End_Procedure
                        
                        Procedure StoreToXMLData
                            Handle hoDataSource hoRoot hoData hoInvtElement
                            tDataSourceRow[] InvtData
                            Integer iCodeColumn iWeightColumn iElements iElement
                            Integer iPriceMinColumn iPriceMaxColumn
                            Boolean bAllowDuplicates
                            
                            Get phoDataSource to hoDataSource
                            Get DataSource of hoDataSource to InvtData
                            Move (SizeOfArray (InvtData)) to iElements
                            If (iElements > 0) Begin
                                Get OrdersGeneratorSettings of oSettingsHandler to hoRoot
                                If (hoRoot <> 0) Begin
                                    // If there are any previous values stored for InvtData delete them first
                                    Get ChildElementNS of hoRoot C_OrdersGeneratorNS "InvtData" to hoData
                                    If (hoData <> 0) Begin
                                        Get RemoveNode of hoRoot hoData to hoData
                                        If (hoData <> 0) Begin
                                            Send Destroy of hoData
                                        End
                                    End
                                    Get AddElementNS of hoRoot C_OrdersGeneratorNS "InvtData" '' to hoData
                                    If (hoData <> 0) Begin
                                        Get piColumnId of oCodeColumn to iCodeColumn
                                        Get piColumnId of oWeightColumn to iWeightColumn
                                        Get piColumnId of oPriceMinColumn to iPriceMinColumn
                                        Get piColumnId of oPriceMaxColumn to iPriceMaxColumn
                                        
                                        // Add an attribute that tells if duplicate INVT items are allowed
                                        // wanted to not.
                                        Get Checked_State of oInvtItemDuplicatesCheckBox to bAllowDuplicates
                                        If (bAllowDuplicates) Begin
                                            Send AddAttribute of hoData "DuplicatesAllowed" 'Y'
                                        End
                                        Else Begin
                                            Send AddAttribute of hoData "DuplicatesAllowed" 'N'
                                        End
                                        
                                        Decrement iElements
                                        For iElement from 0 to iElements
                                            Get AddElementNS of hoData C_OrdersGeneratorNS "Invt" '' to hoInvtElement
                                            If (hoInvtElement <> 0) Begin
                                                // Store the INVT information as attributes of the new Invt node.
                                                Send AddAttribute of hoInvtElement "Code" InvtData[iElement].sValue[iCodeColumn]
                                                Send AddAttribute of hoInvtElement "Weight" InvtData[iElement].sValue[iWeightColumn]
                                                Send AddAttribute of hoInvtElement "Min" InvtData[iElement].sValue[iPriceMinColumn]
                                                Send AddAttribute of hoInvtElement "Max" InvtData[iElement].sValue[iPriceMaxColumn]
                                                Send Destroy of hoInvtElement
                                            End
                                        Loop
                                        Send Destroy of hoData
                                    End
                                    Send Destroy of hoRoot
                                End
                            End
                        End_Procedure
                        
                        Function ToBeUsedInvt tToBeUsedInvtData[] ByRef ToBeUsedInvtData Boolean bDuplicatesAllowed Returns Integer
                            Boolean bIsComObjectCreated
                            Handle hoDataSource
                            tDataSourceRow[] InvtData
                            Integer iWeightColumn iPriceMinColumn iPriceMaxColumn iElements iElement
                            Integer iCount iInvtElement iUniqueInvtItems
                            
                            // If the grid was not activated before activate it to retrieve data from INVT
                            // table and XML (weights) and return it to the caller.
                            Get IsComObjectCreated to bIsComObjectCreated
                            If (not (bIsComObjectCreated)) Begin
                                Send Activate
                            End
                            
                            Get phoDataSource to hoDataSource
                            Get DataSource of hoDataSource to InvtData
                            
                            Get piColumnId of oWeightColumn to iWeightColumn
                            Get piColumnId of oPriceMinColumn to iPriceMinColumn
                            Get piColumnId of oPriceMaxColumn to iPriceMaxColumn
                            
                            Move (SizeOfArray (InvtData)) to iElements
                            Decrement iElements
                            For iElement from 0 to iElements
                                If (InvtData[iElement].sValue[iWeightColumn] > 0) Begin
                                    For iCount from 1 to InvtData[iElement].sValue[iWeightColumn]
                                        Move InvtData[iElement].riID to ToBeUsedInvtData[iInvtElement].riInvt
                                        // Avoid that min and max value are reversed.
                                        Move (InvtData[iElement].sValue[iPriceMinColumn] min InvtData[iElement].sValue[iPriceMaxColumn]) to ToBeUsedInvtData[iInvtElement].iMinPrice
                                        Move (InvtData[iElement].sValue[iPriceMinColumn] max InvtData[iElement].sValue[iPriceMaxColumn]) to ToBeUsedInvtData[iInvtElement].iMaxPrice
                                        Increment iInvtElement
                                    Loop
                                    // Make the array already randomized
                                    Move (ShuffleArray (ToBeUsedInvtData)) to ToBeUsedInvtData
                                    Increment iUniqueInvtItems
                                End
                            Loop
                            
                            // Make the array again randomized
                            Move (ShuffleArray (ToBeUsedInvtData)) to ToBeUsedInvtData
                            
                            If (bDuplicatesAllowed) Begin
                                Function_Return iInvtElement
                            End
                            
                            Function_Return iUniqueInvtItems
                        End_Function
                    End_Object
                    
                    Object oRandomValuesButton is a Button
                        Set Size to 14 62
                        Set Location to 103 190
                        Set Label to 'Random Values'
                        Set psToolTip to "Take a random weight and random price ranges for each invt item"
                        Set peAnchors to anBottomRight
                        
                        Procedure OnClick
                            Send SetRandomValues of oInventoryGrid 10
                        End_Procedure
                    End_Object
                    
                    Object oResetValuesButton is a Button
                        Set Size to 14 62
                        Set Location to 103 125
                        Set Label to "Reset Values"
                        Set psToolTip to "Set the weight for each invt item to 1, price range from -10 to 10"
                        Set peAnchors to anBottomRight
                        
                        Procedure OnClick
                            Send SetRandomValues of oInventoryGrid 1
                        End_Procedure
                    End_Object
                    
                    Object oExplanationTextBox is a TextBox
                        Set Auto_Size_State to False
                        Set Size to 111 62
                        Set Location to 5 257
                        Set Label to ("Setting the weight means how many times the invt item will be made available in the array to pick from. Increasing the weight should lead to more orders with this invt." + Character (10) + Character (13) + "Min and Max are for price variations.")
                        Set Justification_Mode to JMode_Left
                        Set peAnchors to anTopBottomRight
                    End_Object
                    
                    Object oInvtItemDuplicatesCheckBox is a CheckBox
                        Set Auto_Size_State to False
                        Set Size to 13 111
                        Set Location to 103 5
                        Set Label to "Allow duplicates in ONE order"
                        Set psToolTip to "If checked ONE INVT item can be used multiple times in ONE order. Default is false."
                        Set peAnchors to anBottomLeft
                    End_Object
                End_Object
            End_Object
        End_Object
        
        Object oCustomersTabPage is a TabPage
            Set Label to "Customers"
            
            Object oCustomerDataTabDialog is a TabDialog
                Set Size to 134 334
                Set Location to 5 5
                Set peAnchors to anAll
                
                Object oStatesTabPage is a TabPage
                    Set Label to "States"
                    
                    Object oStatesGrid is a cCJGrid
                        Set Size to 93 253
                        Set Location to 5 5
                        Set pbAllowAppendRow to False
                        Set pbAllowColumnRemove to False
                        Set pbAllowColumnReorder to False
                        Set pbAllowDeleteRow to False
                        Set pbAllowInsertRow to False
                        Set peAnchors to anAll
                        Set pbUseAlternateRowBackgroundColor to True
                        Set pbHeaderTogglesDirection to True
                        Set pbHeaderReorders to True
                        
                        Object oRowIndicator is a cCJGridColumnRowIndicator
                            Set piWidth to 22
                        End_Object
                        
                        Object oStateColumn is a cCJGridColumn
                            Set piWidth to 75
                            Set psCaption to "State"
                            Set pbEditable to False
                        End_Object
                        
                        Object oNameColumn is a cCJGridColumn
                            Set piWidth to 251
                            Set psCaption to "Name"
                            Set pbEditable to False
                        End_Object
                        
                        Object oWeightColumn is a cCJGridColumn
                            Set piWidth to 94
                            Set psCaption to "Weight"
                            Set peDataType to Mask_Numeric_Window
                            Set psMask to "###"
                            
                            Function OnValidating Returns Boolean
                                Integer iWeight
                                Boolean bValueNotOk
                                
                                Get SelectedRowValue to iWeight
                                Move (iWeight < 0) to bValueNotOk
                                If (bValueNotOk) Begin
                                    Error DFERR_OPERATOR "Weight Value Must be 0 or Higher!"
                                End
                                
                                Function_Return bValueNotOk
                            End_Function
                        End_Object
                        
                        Procedure Activating
                            Forward Send Activating
                            Send ReadStates
                        End_Procedure
                        
                        Procedure ReadStates
                            tDataSourceRow[] StatesData
                            Integer iStateColumn iNameColumn iWeightColumn iRow
                            Integer iStatesElements iStatesElement
                            Handle hoStates hoRoot hoData hoNode
                            Variant[][] vStatesData
                            Boolean bIsStateElement
                            String sCodeValue
                            
                            Get piColumnId of oStateColumn to iStateColumn
                            Get piColumnId of oNameColumn to iNameColumn
                            Get piColumnId of oWeightColumn to iWeightColumn
                            
                            Get OrdersGeneratorSettings of oSettingsHandler to hoRoot
                            If (hoRoot <> 0) Begin
                                // See if there is an element with the name StatesData so that
                                // we can restore information from XML
                                Get ChildElementNS of hoRoot C_OrdersGeneratorNS "StatesData" to hoData
                            End
                            
                            Get Field_Table_Object of (oCustomer_DD (oOrdersGeneratorBPO)) Field Customer.State to hoStates
                            Get TableData of hoStates to vStatesData
                            Move (SizeOfArray (vStatesData)) to iStatesElements
                            Decrement iStatesElements
                            For iStatesElement from 0 to iStatesElements
                                Move vStatesData[iStatesElement][0] to StatesData[iRow].sValue[iStateColumn]
                                Move vStatesData[iStatesElement][1] to StatesData[iRow].sValue[iNameColumn]
                                // Assign a random value to the weight column. Might be overwritten from XML
                                // a couple of lines down.
                                Move (Random (10) + 1) to StatesData[iRow].sValue[iWeightColumn]
                                If (hoData <> 0) Begin
                                    // Search for an element named State but its attribute Code identical to the current
                                    // state row.
                                    Get FirstChild of hoData to hoNode
                                    While (hoNode <> 0)
                                        Get IsElementNS of hoNode C_OrdersGeneratorNS "State" to bIsStateElement
                                        If (bIsStateElement) Begin
                                            Get AttributeValue of hoNode "Code" to sCodeValue
                                            If (sCodeValue = StatesData[iRow].sValue[iStateColumn]) Begin
                                                Get AttributeValue of hoNode "Weight" to StatesData[iRow].sValue[iWeightColumn]
                                                Send Destroy of hoNode
                                                Move 0 to hoNode
                                            End
                                        End
                                        If (hoNode <> 0) Begin
                                            Get NextNode of hoNode to hoNode
                                        End
                                    Loop
                                End
                                Increment iRow
                            Loop
                            
                            If (hoRoot <> 0) Begin
                                If (hoData <> 0) Begin
                                    Send Destroy of hoData
                                End
                                Send Destroy of hoRoot
                            End
                            
                            Send InitializeData StatesData
                        End_Procedure
                        
                        // Assign a random value between 0 and iMax to each of the grid items
                        Procedure SetRandomWeights Integer iMax
                            Handle hoDataSource
                            tDataSourceRow[] GridData
                            Integer iWeightColumn iElements iElement
                            
                            Get piColumnId of oWeightColumn to iWeightColumn
                            
                            Get phoDataSource to hoDataSource
                            Get DataSource of hoDataSource to GridData
                            Move (SizeOfArray (GridData)) to iElements
                            Decrement iElements
                            For iElement from 0 to iElements
                                Move (Random (iMax) + 1) to GridData[iElement].sValue[iWeightColumn]
                            Loop
                            
                            Send InitializeData GridData
                        End_Procedure
                        
                        // Store the code and weight values into the XML stream.
                        Procedure StoreToXMLData
                            Handle hoDataSource hoRoot hoData hoStateElement
                            tDataSourceRow[] StatesData
                            Integer iStateColumn iWeightColumn iElements iElement
                            
                            Get phoDataSource to hoDataSource
                            Get DataSource of hoDataSource to StatesData
                            Move (SizeOfArray (StatesData)) to iElements
                            If (iElements > 0) Begin
                                Get OrdersGeneratorSettings of oSettingsHandler to hoRoot
                                If (hoRoot <> 0) Begin
                                    // First remove all previous stored information if any
                                    Get ChildElementNS of hoRoot C_OrdersGeneratorNS "StatesData" to hoData
                                    If (hoData <> 0) Begin
                                        Get RemoveNode of hoRoot hoData to hoData
                                        If (hoData <> 0) Begin
                                            Send Destroy of hoData
                                        End
                                    End
                                    // Add all state codes with the entered weight number to the XML stream
                                    Get AddElementNS of hoRoot C_OrdersGeneratorNS "StatesData" '' to hoData
                                    If (hoData <> 0) Begin
                                        Get piColumnId of oStateColumn to iStateColumn
                                        Get piColumnId of oWeightColumn to iWeightColumn
                                        
                                        Decrement iElements
                                        For iElement from 0 to iElements
                                            Get AddElementNS of hoData C_OrdersGeneratorNS "State" '' to hoStateElement
                                            If (hoStateElement <> 0) Begin
                                                Send AddAttribute of hoStateElement "Code" StatesData[iElement].sValue[iStateColumn]
                                                Send AddAttribute of hoStateElement "Weight" StatesData[iElement].sValue[iWeightColumn]
                                                Send Destroy of hoStateElement
                                            End
                                        Loop
                                        Send Destroy of hoData
                                    End
                                    Send Destroy of hoRoot
                                End
                            End
                        End_Procedure
                        
                        // Returns a list of states where the weight determines how often
                        // a state is used in the array. Does not need to be shuffled because
                        // it is used to make the list of customers to pick from larger. That
                        // array will be shuffled.
                        Function ToBeUsedStates String[] ByRef sStateCodes Returns Integer
                            Boolean bIsComObjectCreated
                            Handle hoDataSource
                            tDataSourceRow[] StatesData
                            Integer iStateColumn iWeightColumn iElements iElement iCount iStatesElement
                            
                            // If the grid was not activated before make it active, it reads in data and XML
                            // and get the values to be used.
                            Get IsComObjectCreated to bIsComObjectCreated
                            If (not (bIsComObjectCreated)) Begin
                                Send Activate
                            End
                            
                            Get phoDataSource to hoDataSource
                            Get DataSource of hoDataSource to StatesData
                            
                            Get piColumnId of oStateColumn to iStateColumn
                            Get piColumnId of oWeightColumn to iWeightColumn
                            
                            Move (SizeOfArray (StatesData)) to iElements
                            Decrement iElements
                            For iElement from 0 to iElements
                                If (StatesData[iElement].sValue[iWeightColumn] > 0) Begin
                                    For iCount from 1 to StatesData[iElement].sValue[iWeightColumn]
                                        Move StatesData[iElement].sValue[iStateColumn] to sStateCodes[iStatesElement]
                                        Increment iStatesElement
                                    Loop
                                End
                            Loop
                            
                            Function_Return iStatesElement
                        End_Function
                    End_Object
                    
                    Object oRandomWeightsButton is a Button
                        Set Size to 14 62
                        Set Location to 101 196
                        Set Label to 'Random Weights'
                        Set psToolTip to "Take a random weight for each State"
                        Set peAnchors to anBottomRight
                        
                        Procedure OnClick
                            Send SetRandomWeights of oStatesGrid 10
                        End_Procedure
                    End_Object
                    
                    Object oResetWeightsButton is a Button
                        Set Size to 14 62
                        Set Location to 101 132
                        Set Label to "Reset Weights"
                        Set psToolTip to "Set the weight for each State to 1"
                        Set peAnchors to anBottomRight
                        
                        Procedure OnClick
                            Send SetRandomWeights of oStatesGrid 1
                        End_Procedure
                    End_Object
                    
                    Object oExplanationTextBox is a TextBox
                        Set Auto_Size_State to False
                        Set Size to 111 62
                        Set Location to 5 263
                        Set Label to "Setting the weight means how many times customers within the state will be made available in the array to pick from. Increasing the weight should lead to more orders for customers in the selected states."
                        Set Justification_Mode to JMode_Left
                        Set peAnchors to anTopBottomRight
                    End_Object
                End_Object
                
                Object oCorrectionsTabPage is a TabPage
                    Set Label to "Corrections"
                    
                    Object oBalanceDueCorrectionForm is a Form
                        Set Size to 13 30
                        Set Location to 6 70
                        Set Label to "Max. Balance Due:"
                        Set Label_Col_Offset to 2
                        Set Label_Justification_Mode to JMode_Right
                        Set Form_Datatype to 0
                        
                        // Check if the value is between 1 and 100. Setting it to 1 means no correction as
                        // the random function later will use a value between 0 and 1 which means it is always zero.
                        Procedure ValidateSpecs
                            Integer iValue
                            
                            Get Value to iValue
                            
                            If (iValue < 1 or iValue > 100) Begin
                                Send Stop_Box "The Balance Due Correction Percentage Should be Between 1 and 100"
                                Set pbSpecsOk to False
                            End
                        End_Procedure
                    End_Object
                    
                    Object oPercentageTextBox is a TextBox
                        Set Auto_Size_State to False
                        Set Size to 13 77
                        Set Location to 6 109
                        Set Label to "% (Randomized usage)"
                    End_Object
                    
                    Object oCreditLimitCheckBox is a CheckBox
                        Set Size to 13 50
                        Set Location to 21 27
                        Set Checked_State to True
                        Set Label to "Credit Limit:"
                        // Set the alignment with a label on the left hand side
                        Set AlignmentMode to taLeftJustify
                    End_Object
                    
                    Object oExplanationTextBox is a TextBox
                        Set Auto_Size_State to False
                        Set Size to 111 114
                        Set Location to 5 211
                        Set Label to "The Balance Due value get increased and decreased by each order per DD rule. The percentage value is used to make random variation. The Balance Due will be decreased by a random percentage between 0 and the entered value. The Credit Limit can be changed to the sum of the purchases in best quarter."
                        Set Justification_Mode to JMode_Left
                        Set peAnchors to anTopBottomRight
                    End_Object
                    
                    // Read the previously stored information if present.
                    Procedure ReadFromXMLData
                        Handle hoRoot hoData
                        Variant vData
                        
                        Get OrdersGeneratorSettings of oSettingsHandler to hoRoot
                        If (hoRoot <> 0) Begin
                            // See if there is a branch with customers data
                            Get ChildElementNS of hoRoot C_OrdersGeneratorNS "CustomersData" to hoData
                            If (hoData <> 0) Begin
                                Get ChildElementValueNS of hoData C_OrdersGeneratorNS "BalanceDueCorrection" to vData
                                Set Value of oBalanceDueCorrectionForm to vData
                                
                                Get ChildElementValueNS of hoData C_OrdersGeneratorNS "CreditLimitCorrection" to vData
                                Set Checked_State of oCreditLimitCheckBox to vData
                                
                                Send Destroy of hoData
                            End
                            Else Begin
                                // Set a random due correction percentage between 36% and 99%
                                Set Value of oBalanceDueCorrectionForm to (Random (100) max 36)
                            End
                            Send Destroy of hoRoot
                        End
                    End_Procedure
                    
                    // Store the user choice into the XML structure
                    Procedure StoreToXMLData
                        Handle hoRoot hoData
                        Variant vData
                        
                        Get OrdersGeneratorSettings of oSettingsHandler to hoRoot
                        If (hoRoot <> 0) Begin
                            // Remove the previous CustomersData element if existing
                            Get ChildElementNS of hoRoot C_OrdersGeneratorNS "CustomersData" to hoData
                            If (hoData <> 0) Begin
                                Get RemoveNode of hoRoot hoData to hoData
                                If (hoData <> 0) Begin
                                    Send Destroy of hoData
                                End
                            End
                            // Add a new CustomersData node to XML and add the two single values
                            // on this tab-page as attributes
                            Get AddElementNS of hoRoot C_OrdersGeneratorNS "CustomersData" '' to hoData
                            If (hoData <> 0) Begin
                                Get Value of oBalanceDueCorrectionForm to vData
                                Send AddElementNS of hoData C_OrdersGeneratorNS "BalanceDueCorrection" vData
                                
                                Get Checked_State of oCreditLimitCheckBox to vData
                                Send AddElementNS of hoData C_OrdersGeneratorNS "CreditLimitCorrection" vData
                                
                                Send Destroy of hoData
                            End
                            Send Destroy of hoRoot
                        End
                    End_Procedure
                End_Object
            End_Object
        End_Object
    End_Object
    
    Object oGenerateButton is a Button
        Set Location to 165 303
        Set Label to "Generate"
        Set peAnchors to anBottomRight
        Set psToolTip to "Generate orders based on the set criteria"
        
        Procedure OnClick
            Boolean bSpecsOk bRemoveExistingData
            Integer iAnswer
            
            // First check if we are OK with the current information
            Set pbSpecsOk of oSpecsTabDialog to True
            Broadcast Recursive Send ValidateSpecs of oSpecsTabDialog
            Get pbSpecsOk of oSpecsTabDialog to bSpecsOk
            If (bSpecsOk) Begin
                Get Checked_State of oRemoveExistingDataCheckBox to bRemoveExistingData
                If (bRemoveExistingData) Begin
                    // Lets ask the user if they really want to remove all the existing order data. default answer is NO
                    Move (YesNo_Box ("Re-generate all orders in the system?", "Confirmation", MB_DEFBUTTON2)) to iAnswer
                    If (iAnswer = MBR_Yes) Begin
                        Send DoProcess of oResetBPO
                        Send DoProcess of oOrdersGeneratorBPO
                    End
                End
                Else Begin
                    // Ask the user if they really want to generate new orders to the system
                    Move (YesNo_Box ("Add new orders in the system?", "Confirmation", MB_DEFBUTTON2)) to iAnswer
                    If (iAnswer = MBR_Yes) Begin
                        Send DoProcess of oOrdersGeneratorBPO
                    End
                End
            End
        End_Procedure
    End_Object
    
    // During view opening all previous saved values are restored
    Procedure Activating
        Integer iSize
        
        Forward Send Activating
        
        Broadcast Recursive Send ReadFromXMLData
        
        Get Size to iSize
        // Make the minimum size identical to the current size
        Set piMinSize to (Hi (iSize)) (Low (iSize))
        // Make the maximum size identital to the minimum size + 100 units
        Set piMaxSize to (Hi (iSize) + 100) (Low (iSize) + 100)
    End_Procedure
    
    // During the close of this view the data is collected into a
    // XML file and saved to disk
    Procedure Deactivating
        Boolean bErr
        
        Broadcast Recursive Send StoreToXMLData
        
        Get SaveXMLDocument of oSettingsHandler to bErr
        
        Forward Send Deactivating
    End_Procedure
End_Object

