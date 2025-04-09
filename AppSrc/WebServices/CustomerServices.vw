Use WebClientHelper.vw
Use gFormatNumbers.pkg
Use dfClient.pkg
Use WebServices\cWSTestService.pkg
Use WebServices\cWSCustomerAndOrderInfo.pkg
Use Windows.pkg
Use dfSpnFrm.pkg
Use dfbitmap.pkg
Use cRichEdit.pkg
Use cCJGrid.pkg
Use cCJGridColumn.pkg

Deferred_View Activate_oCustServicesView for ;
;
Object oCustServicesView is a dbView

    On_Key kCancel Send Request_Cancel

    Set Label to "Customer Services"
    Set Location to 1 2
    Set Size to 351 295

    Object oWSTestService is a cWSTestService

        // Web Service Class is defined in cWSTestService.pkg
        // Interface:
        // Function wsSayHello string llsName returns string
        // Function wsEcho string llechoString returns string
        // Function wsAddNumber real llnumber1 real llnumber2 returns real
        // Function wsPriceQuote string llitemID returns decimal
        // Function wsEstimatedOrderDeliveryDate integer llcustomerNumber integer llorderNumber returns date
        // Function wsItemsSoldToDate string llitemID returns integer

        // phoSoapClientHelper
        //     Setting this property will pop up a view that provides information
        //     about the Soap (xml) data transfer. This can be useful in debugging.
        //     If you use this you must make sure you USE the test view at the top
        //     of your program/view by adding:   Use WebClientHelper2.vw // oClientWSHelper2
        //Set phoSoapClientHelper to oClientWSHelper2

    End_Object    // oWSTestService

    Object oWSCustomerAndOrderInfo is a cWSCustomerAndOrderInfo

        set pbSuppressLastError to true         // errors returned by the service will not display

        // Web Service Class is defined in cWSCustomerAndOrderInfo.pkg
        //
        // Interface:
        //
        // Function wsGetCustomerInfo integer lliCustNum returns tWStCustomerInfo
        // Function wsGetOrderInfo integer lliOrdNum returns tWStOrder
        // Function wsGetOrdersForCustomer integer lliCustNum returns integer[]
        // Function wsGetOrderSummaryForCustomer integer lliCustNum returns tWStOrderSummary[]
        // Function wsCreateNewCustomer tWStNewCustomer llNewCustomer returns integer
        // Function wsChangeCustomerAddress integer lliCustNum tWStCustAddress llNewCustomerAddress returns boolean
        // Function wsCustomerList returns tWStCustomer[]
        // Function wsDelCustomersFromList tWStCustomerToRemove[] llArrayOfCustToRemove returns tWStCustomer[]

        // phoSoapClientHelper
        //     Setting this property will pop up a view that provides information
        //     about the Soap (xml) data transfer. This can be useful in debugging.
        //     If you use this you must make sure you USE the test view at the top
        //     of your program/view by adding:   Use WebClientHelper2.vw // oClientWSHelper2
        //Set phoSoapClientHelper to oClientWSHelper2

    End_Object    // oWSCustomerAndOrderInfo

    Object oName is a Form
        Set Label to "Type your name here"
        Set Size to 13 139
        Set Location to 57 89
        Set Label_Col_Offset to 80
        Set peAnchors to anBottomLeft
    End_Object    // oName

    Object oGreeting is a Textbox
        Set Auto_Size_State to FALSE
        Set TextColor to clNavy
        Set Location to 84 9
        Set Size to 12 279
        Set Border_Style to Border_StaticEdge
        Set Justification_Mode to jMode_Center
        Set peAnchors to anBottomLeft
    End_Object    // oGreeting

    Object oAccessBtn is a Button
        Set Label to "Get Access"
        Set Location to 57 237
        Set peAnchors to anBottomLeft

        Procedure OnClick
            string sName sGreeting
        
            get Value of oName to sName
            move (trim(sName)) to sName
        
            if (sName <> "") Begin
                get wsSayHello of oWSTestService sName to sGreeting
                set Value of oGreeting to sGreeting
        
                if (sGreeting <> "") begin
                    // Enable tab dialog
                    set Enabled_State of oCSTabDialog to True
                end
            end
            else begin
                send Stop_Box "You need to type in your name before you can gain access to the system." "Customer Services"
                set Value of oGreeting to ""
        
                // Disable tab dialog
                set Enabled_State of oCSTabDialog to False
            end
        End_Procedure // OnClick

    End_Object    // oAccessBtn

    Object oCSTabDialog is a TabDialog
        Set Size to 218 281
        Set Location to 106 8
        Set Enabled_State to False
        Set peAnchors to anBottomLeft
        
        Object oPriceQuotePage is a TabPage
            Set Label to "Price Quote"
            Object oItems is a ComboForm
                Set Label to "Select One of the  Available Items"
                Set Size to 13 90
                Set Location to 15 138
                Set Form_Border to 0
                Set Label_Col_Offset to 120
                Set Entry_State to False

                // Combo_Fill_List is called when the list needs filling
                Procedure Combo_Fill_List
                    // Fill the combo list with Send Combo_Add_Item
                    Send Combo_Add_Item "BEARS"
                    Send Combo_Add_Item "BRIDGE"
                    Send Combo_Add_Item "CASE"
                    Send Combo_Add_Item "CITIES"
                    Send Combo_Add_Item "CUA"
                    Send Combo_Add_Item "DATES"
                    Send Combo_Add_Item "FLEX-O-MAT"
                    Send Combo_Add_Item "GOLD"
                    Send Combo_Add_Item "MAPS"
                    Send Combo_Add_Item "MODEMS"
                    Send Combo_Add_Item "OBM"
                    Send Combo_Add_Item "OFFICE-1"
                    Send Combo_Add_Item "POOL"
                    Send Combo_Add_Item "POPUP"
                    Send Combo_Add_Item "REPORTS"
                    Send Combo_Add_Item "RUNMTR"
                    Send Combo_Add_Item "RUNMTR2"
                    Send Combo_Add_Item "STARTREK"
                    Send Combo_Add_Item "TABLE"
                    Send Combo_Add_Item "TEXT-1"
                    Send Combo_Add_Item "TEXT-3"
                    Send Combo_Add_Item "UNIXGUIDE"
                    Send Combo_Add_Item "VINO-LM"
                End_Procedure // Combo_Fill_List

            End_Object    // oItems

            Object oQty is a SpinForm
                Set Label to "Quantity (1-100)"
                Set Size to 13 58
                Set Location to 32 138
                Set Label_Col_Offset to 63
                Set Maximum_Position to 100
                Set Minimum_Position to 1

                Procedure Activating
                    set Value to 1
                End_Procedure
                
                Procedure Entering Returns Integer
                    Integer iRetval
                
                    Forward Get Msg_Entering To iRetval
                    If (iRetval = 0) Begin
                        Send DoCorrectValueToMinMaxValues
                    End
                    Procedure_Return iRetval
                End_Procedure // Entering
                
                Procedure Exiting Returns Integer
                    Integer iRetval
                
                    Forward Get Msg_Exiting To iRetval
                    If (iRetval = 0) Begin
                        Send DoCorrectValueToMinMaxValues
                    End
                    Procedure_Return iRetval
                End_Procedure // Exiting
                
                Procedure DoCorrectValueToMinMaxValues
                    Integer iQty iMinimumPosition iMaximumPosition
                
                    Get Value To iQty
                    Get Minimum_Position To iMinimumPosition
                    Get Maximum_Position To iMaximumPosition
                    Move ((iQty Max iMinimumPosition) Min iMaximumPosition) To iQty
                    Set Value To iQty
                End_Procedure // DoCorrectValueToMinMaxValues

            End_Object    // oQty

            Object oPriceQuoteBtn is a Button
                Set Label to "Price Quote"
                Set Location to 32 215

                Procedure OnClick
                    String sItemCode
                    Integer iQty i
                    Decimal dPrice
                    Real rUnit rTotal
                
                    get Value of oQty to iQty
                    get Value of oItems to sItemCode
                
                    Send Cursor_Wait of Cursor_Control
                
                    // Get price for the selected item
                    Get wsPriceQuote of oWSTestService sItemCode to dPrice
                
                    Move dPrice to rUnit
                    Set Value of oUnitPrice to rUnit
                    Move rUnit to rTotal
                
                    // In order to demonstrate the use of wsAddNumber, we created the following loop
                    For i From 2 to iQty
                        Get wsAddNumber of oWSTestService rTotal rUnit to rTotal
                    Loop
                
                    Set Value of oTotalPrice to rTotal
                
                    Send Cursor_Ready of Cursor_Control
                End_Procedure // OnClick

            End_Object    // oPriceQuoteBtn

            Object oUnitPrice is a Form
                Set Label to "Quoted Unit Price"
                Set Size to 13 45
                Set Location to 66 69
                Set Color to clInfoBk
                Set Form_Border 0 to Border_Normal
                Set Form_DataType to mask_currency_window
                Set Entry_State to False
                Set Form_Mask to "#,###,###.00"
            End_Object    // oUnitPrice

            Object oTotalPrice is a Form
                Set Label to "Total Quoted Price"
                Set Size to 13 64
                Set Location to 66 201
                Set Color to clInfoBk
                Set Form_Border 0 to Border_Normal
                Set Label_Col_Offset to 65
                Set Form_DataType to mask_currency_window
                Set Entry_State to False
                Set Form_Mask to "#,###,###.00"
            End_Object    // oTotalPrice

            Object oAnnouncementGrp is a Group
                Set Size to 88 261
                Set Location to 97 7
                Object oSpecialPromo is a BitmapContainer
                    Set Size to 79 255
                    Set Location to 7 3
                    Set Bitmap to "FastandFreeDelivery.bmp"
                    Set Transparent_State to True
                    Set Bitmap_Style to Bitmap_Stretch
                End_Object    // oSpecialPromo

            End_Object    // oAnnouncementGrp

        End_Object    // oPriceQuotePage

        Object oOrderInfoPage is a TabPage
            Set Label to "Order Information"
            Object oCustNumInfo is a Form
                Set Label to "Enter the Customer Number"
                Set Size to 13 57
                Set Location to 13 121
                Set Label_Col_Offset to 95
                Set Form_DataType to 0

                Procedure Entering Returns Integer
                    Integer iRetVal
                
                    Forward Get Msg_Entering to iRetVal
                    if (iRetVal = 0) begin
                        // Delete order numbers from combo and order information from text
                        Send Combo_Delete_Data of oOrderNum
                        Send Delete_Data of oRichOutput
                        Set Value of oDeliveryDate to ""
                    End
                
                    Procedure_Return iRetVal
                End_Procedure  // Entering
                
                Procedure Exiting Returns Integer
                    Integer iRetVal iStatus
                    Integer iCust iNumOrders iCount
                    Integer[] iArrayOfOrdNums
                    String sErrorMsg
                
                    Forward Get Msg_Exiting to iRetVal
                    If (iRetVal = 0) Begin
                        Get Value of oCustNumInfo to iCust
                
                        If (iCust <> 0) Begin
                            // Get order for customers
                            Get wsGetOrdersForCustomer of oWSCustomerAndOrderInfo iCust to iArrayOfOrdNums
                    
                            Get peTransferStatus of oWSCustomerAndOrderInfo to iStatus
                            
                            If (iStatus = wssOk) Begin
                                If (SizeOfArray(iArrayOfOrdNums) > 0) Begin
                                    Move (SizeOfArray(iArrayOfOrdNums)) to iNumOrders
                                    For iCount from 0 to (iNumOrders - 1)
                                        // Populate combo with order numbers
                                        Send AddOrderToList of oOrderNum (String(iArrayOfOrdNums[iCount]))
                                    Loop
                                End
                                Else Begin
                                    Set value of oOrderNum to ""
                                End
                            End
                            Else Begin
                                Get TransferErrorDescription of oWSCustomerAndOrderInfo iStatus to sErrorMsg
                                Send Stop_Box sErrorMsg "Customer Services"
                            End
                        End
                    End
                
                    Procedure_Return iRetVal
                End_Procedure  // Exiting

            End_Object    // oCustNumInfo

            Object oOrderNum is a ComboForm
                Set Label to "Select the Order Number"
                Set Size to 13 57
                Set Location to 30 121
                Set Color to clInfoBk
                Set Form_Border to 0
                Set Label_Col_Offset to 83
                Set Form_DataType to 0
                Set Entry_State to False

                Procedure AddOrderToList String sItem
                    Send Combo_Add_Item sItem
                End_Procedure  // AddOrderToList
                
                Procedure Combo_Item_Changed
                    tWStOrder AnOrder
                    Integer iOrderNum iNumDetails iCount
                    Integer iStatus
                    String sMsg
                
                    Get Value of oOrderNum to iOrderNum
                    Get wsGetOrderInfo of oWSCustomerAndOrderInfo iOrderNum to AnOrder
                
                    // clear text object
                    Send Delete_Data of oRichOutput
                
                    Get peTransferStatus of oWSCustomerAndOrderInfo to iStatus
                    If (iStatus = wssOk) Begin                
                        // display order number
                        Send AddText of oRichOutput True False True 2 ("Order " + String(AnOrder.iOrderNumber))
                
                        // display Customer Number
                        Send AddText of oRichOutput True False False 0 "Customer Number:  "
                        Send AddText of oRichOutput False False False 1 (String(AnOrder.iCustNumber))
                
                        // display Order Date
                        Send AddText of oRichOutput True False False 0 "Order Date:  "
                        Send AddText of oRichOutput False False False 1 AnOrder.dOrdDate
                
                        // display Terms
                        Send AddText of oRichOutput True False False 0 "Terms:  "
                        Send AddText of oRichOutput False False False 1 AnOrder.sTerms
                
                        // display Ship_Via
                        Send AddText of oRichOutput True False False 0 "Ship Via:  "
                        Send AddText of oRichOutput False False False 1 AnOrder.sShipVia
                
                        // display OrderedBy
                        Send AddText of oRichOutput True False False 0 "Ordered By:  "
                        Send AddText of oRichOutput False False False 1 AnOrder.sOrderedBy
                
                        // display SalesPerson
                        Send AddText of oRichOutput True False False 0 "Sales Person:  "
                        Send AddText of oRichOutput False False False 1 AnOrder.sSalesPerson
                
                        // display OrderTotal
                        Send AddText of oRichOutput True False False 0 "OrderTotal:  "
                        Send AddText of oRichOutput False False False 2 (FormatCurrency(AnOrder.rOrderTotal, 2))
                
                        // display order details
                        Send AddText of oRichOutput True False False 1 "Detail Information"
                
                        Move (SizeOfArray(AnOrder.ArrayOfDetails)) to iNumDetails
                        For iCount From 0 to (iNumDetails - 1)
                            // Add Item bullet
                            Set peBullets of oRichOutput to buBullets
                            Send AddText of oRichOutput False False False 1 ("Item:" * AnOrder.ArrayOfDetails[iCount].sItemID)
                            Set peBullets of oRichOutput to buNone
                
                            // Add detail information
                            Send AddText of oRichOutput False False False 1 ("Qty:" * String(AnOrder.ArrayOfDetails[iCount].iQty))
                            Send AddText of oRichOutput False False False 1 ("Unit Price:" * (FormatCurrency(AnOrder.ArrayOfDetails[iCount].rUnitPrice, 2)))
                            Send AddText of oRichOutput False False False 2 ("Price:" * (FormatCurrency(AnOrder.ArrayOfDetails[iCount].rPrice, 2)))
                        Loop
                        
                        Send Beginning_of_Data of oRichOutput
                    End
                    Else Begin
                        Send AddText of oRichOutput True False True 2 ("Error retrieving Order" * String(iOrderNum))
                    End
                
                End_Procedure  // Combo_Item_Changed

            End_Object    // oOrderNum

            Object oRichOutput is a cRichEdit
                Set Label to "Order Details"
                Set Size to 105 230
                Set Location to 60 24
                Set Color to clInfoBk
                Set Read_Only_State to TRUE

                Procedure AddText Boolean bBold Boolean bItalics Boolean bUnderline Integer iNumLines String sText
                    Integer iLine
                    String sNewLine
                    Boolean bPrevBold bPrevUnderline bPrevItalics
                
                    Move (Character(10)) to sNewLine
                
                    // Save current settings
                    Get pbBold to bPrevBold
                    Get pbUnderline to bPrevUnderline
                    Get pbItalics to bPrevItalics
                
                    // Set to new style
                    Set pbBold to bBold
                    Set pbUnderline to bUnderline
                    Set pbItalics to bItalics
                
                    // Add text to edit control
                    Send AppendText sText
                
                    // Add new lines
                    For iLine From 1 to iNumLines
                        Send AppendText sNewLine
                    Loop
                
                    // Restore settings
                    Set pbBold to bPrevBold
                    Set pbUnderline to bPrevUnderline
                    Set pbItalics to bPrevItalics
                End_Procedure  // AddText

            End_Object    // oRichOutput

            Object oDeliveryDate is a Form
                Set Label to "Estimated Delivery Date"
                Set Size to 13 57
                Set Location to 177 121
                Set Color to clInfoBk
                Set Form_Border 0 to Border_Normal
                Set Label_Col_Offset to 85
                Set Form_DataType to Date_Window
                Set Entry_State to False
            End_Object    // oDeliveryDate

            Object oCalculateDDate is a Button
                Set Label to "Calculate Delivery"
                Set Size to 14 63
                Set Location to 177 191

                Procedure OnClick
                    Integer iCust iOrder
                    Date dDvryDate
                    Integer iStatus
                    String sErrorMsg
                
                    Get Value of oCustNumInfo to iCust
                    Get Value of oOrderNum    to iOrder
                
                    If ((iCust <> 0) And (iOrder <> 0)) Begin
                        Send Cursor_Wait of Cursor_Control
                
                        // Get estimated delivery date for the customer/order entered
                        get wsEstimatedOrderDeliveryDate of oWSTestService iCust iOrder to dDvryDate
                
                        Get peTransferStatus of oWSCustomerAndOrderInfo to iStatus
                        If (iStatus = wssOk) Begin
                            Set Value of oDeliveryDate to dDvryDate
                        End
                        Else Begin
                            Get TransferErrorDescription of oWSCustomerAndOrderInfo iStatus to sErrorMsg
                            Send Stop_Box sErrorMsg "Customer Services"
                            Set Value of oDeliveryDate to ""
                        End
                
                        Send Cursor_Ready of Cursor_Control
                    End
                    Else Begin
                        Send Stop_Box "You need to enter a Customer number and an Order number." "Customer Services"
                    End
                End_Procedure  // OnClick

            End_Object    // oCalculateDDate

        End_Object    // oOrderInfoPage

        Object oOrderHistoryPage is a TabPage
            Set Label to "Order History"
            Object oCustNumHist is a Form
                Set Label to "Customer Number"
                Set Size to 13 51
                Set Location to 17 79
                Set Form_DataType to 0

                Procedure Entering Returns Integer
                    Integer iRetval
                
                    Forward Get Msg_Entering to iRetval
                    If (iRetval = 0) Begin
                        // Delete orders from grid
                        Send ResetGrid of oOrderHistoryGrid
                    End
                
                    Procedure_Return iRetval
                End_Procedure  // Entering
                
                Procedure OnChange
                    tWStCustomerInfo ACustomer
                    Integer iCustNumber iStatus
                
                    Get Value to iCustNumber
                
                    If (iCustNumber <> 0) Begin
                        Get wsGetCustomerInfo of oWSCustomerAndOrderInfo iCustNumber to ACustomer
                
                        Get peTransferStatus of oWSCustomerAndOrderInfo to iStatus
                        If (iStatus = wssOk) Begin
                            // Display Customer name
                            Set Value of oCustNameTxt to ACustomer.sName
                        End
                        Else Begin
                            // Display message
                            Set Value of oCustNameTxt to ">> Customer not found <<"
                        End
                    End
                    Else Begin
                        Set Value of oCustNameTxt to "Customer Name will display here"
                    End
                End_Procedure  // OnChange

            End_Object    // oCustNumHist

            Object oCustNameTxt is a Textbox
                Set Label to "Customer Name will be displayed here"
                Set Auto_Size_State to False
                Set TextColor to clNavy
                Set Location to 19 138
                Set Size to 10 129
                Set Justification_Mode to jMode_Left
            End_Object    // oCustNameTxt

            Object oGetOrderHistCustBtn is a Button
                Set Label to "List Customer's Orders"
                Set Size to 14 95
                Set Location to 44 133

                Procedure OnClick
                    tWStOrderSummary[] ArrayOfOrdersSummary
                    Integer iCustNumber iNumOrders iCount
                    Integer iStatus
                    String sErrorMsg
                    tDataSourceRow[] DataSource
                
                    Get Value of oCustNumHist to iCustNumber
                    Get wsGetOrderSummaryForCustomer of oWSCustomerAndOrderInfo iCustNumber to ArrayOfOrdersSummary
                
                    Get peTransferStatus of oWSCustomerAndOrderInfo to iStatus
                    If (iStatus = wssOk) Begin
                
                        If (SizeOfArray(ArrayOfOrdersSummary) > 0) Begin
                            
                            // display orders
                            Move (SizeOfArray(ArrayOfOrdersSummary)) to iNumOrders
                            For iCount from 0 to (iNumOrders - 1)
                                Move (String(ArrayOfOrdersSummary[iCount].iOrderNumber)) to DataSource[iCount].sValue[0]
                                Move (String(ArrayOfOrdersSummary[iCount].dOrderDate)) to DataSource[iCount].sValue[1]
                                //Move (String(ArrayOfOrdersSummary[iCount].rOrderTotal)) to DataSource[iCount].sValue[2]
                                Move (FormatCurrency(ArrayOfOrdersSummary[iCount].rOrderTotal, 2)) to DataSource[iCount].sValue[2]
                            Loop
                            
                            Send InitializeData of oOrderHistoryGrid DataSource
                        End
                        Else Begin
                            Send Stop_Box  ("No Orders found for Customer number" * String(iCustNumber))
                        End                
                    End
                    Else Begin
                        Get TransferErrorDescription of oWSCustomerAndOrderInfo iStatus to sErrorMsg
                        Send Stop_Box sErrorMsg "Customer Services"
                    End

                End_Procedure // OnClick

            End_Object    // oGetOrderHistCustBtn

            Object oOrderHistoryGrid is a cCJGrid
                Set Size to 100 187
                Set Location to 74 40
                Set Color to clInfoBk
                Set pbShowRowFocus to True
                Set pbAllowColumnRemove to False
                Set pbFocusSubItems to False
                Set pbReadOnly to True

                Object oOrderNumberColumn is a cCJGridColumn
                    Set piWidth to 93
                    Set psCaption to "Order Number"
                    Set pbEditable to False
                End_Object

                Object oOrderDateColumn is a cCJGridColumn
                    Set piWidth to 93
                    Set psCaption to "Order Date"
                    Set pbEditable to False
                End_Object

                Object oOrderTotalColumn is a cCJGridColumn
                    Set piWidth to 94
                    Set psCaption to "Order Total"
                    Set peTextAlignment to xtpAlignmentRight
                    Set peDataType to Mask_Currency_Window
                    Set psMask to "US$###,###.00"
                End_Object
            End_Object

        End_Object    // oOrderHistoryPage

    End_Object    // oCSTabDialog

    Object oDebugMode is a CheckBox
        Set Label to "Activate Debug Mode"
        Set Size to 10 85
        Set Location to 334 8
        Set peAnchors to anBottomLeft

        Procedure OnChange
            Boolean bChecked
        
            Get Checked_State To bChecked
        
            If (bChecked) Begin
                // Activates the debug information for the services used
                // Leave uncommented the line for the service you would like to see information on
                //Set phoSoapClientHelper of oWSTestService to oClientWSHelper
                Set phoSoapClientHelper of oWSCustomerAndOrderInfo to oClientWSHelper
            End
            Else Begin
                //Set phoSoapClientHelper of oWSTestService to 0
                Set phoSoapClientHelper of oWSCustomerAndOrderInfo to 0
            End
        End_Procedure // OnChange

    End_Object    // oDebugMode

    Object oDisplayDebug is a Button
        Set Label to "Display Debug Information"
        Set Size to 14 96
        Set Location to 332 99
        Set peAnchors to anBottomLeft

        Procedure OnClick
            Send Popup of oClientWSHelper
        End_Procedure // OnClick

    End_Object    // oDisplayDebug

    Object oInfoEdit is a cTextEdit
        Set Size to 35 283
        Set Location to 7 6
        Set Color to clBtnFace
        Set TextColor to clMaroon
        Set Read_Only_State to True
        Set piMaxChars to 320
        Set Enabled_State to False
        
        Set Value of oInfoEdit ;
            to "Various web services are used in this sample and many return struct or array of struct values. This sample also checks the status of the call made to the web services in order to determine how to proceed after the call. "

    End_Object    // oInfoEdit

CD_End_Object    // oCustServicesView
