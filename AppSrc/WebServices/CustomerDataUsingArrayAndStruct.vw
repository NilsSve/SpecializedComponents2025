Use WebClientHelper.vw
Use dfClient.pkg
Use Windows.pkg
Use dfSpnFrm.pkg
Use WebServices\cWSCustomerAndOrderInfo.pkg
Use cTextEdit.pkg
Use cCJGrid.pkg
Use cCJGridColumn.pkg

Activate_View Activate_oCustomerDataUsingArrayAndStruct for oCustomerDataUsingArrayAndStruct
Object oCustomerDataUsingArrayAndStruct is a dbView

    On_Key kCancel Send Request_Cancel

    Set Label to "Customer Data from Server using Array and Struct"
    Set Location to 1 1
    Set Size to 303 317

    Object oCustomerInfo is a TabDialog
        Set Size to 210 297
        Set Location to 60 11
        Set peAnchors to anBottomLeft
        Object oCustomerListPage is a TabPage
            Set Label to "Customer List"

            Object oCustomerGrid is a cCJGrid
                Set Size to 159 280
                Set Location to 6 4
                Set pbShowRowFocus to True
                Set Color to clInfoBk
                Set pbFocusSubItems to False
                Set pbReadOnly to True

                Object oNameColumn is a cCJGridColumn
                    Set piWidth to 215
                    Set psCaption to "Name"
                End_Object

                Object oNumberColumn is a cCJGridColumn
                    Set piWidth to 77
                    Set psCaption to "Number"
                End_Object

                Object oStateColumn is a cCJGridColumn
                    Set piWidth to 61
                    Set psCaption to "State"
                End_Object

                Object oZipColumn is a cCJGridColumn
                    Set piWidth to 67
                    Set psCaption to "ZIP"
                End_Object
 
            End_Object
            

            Object oLoadCustList is a Button
                Set Label to "Load Customer Data"
                Set Size to 14 75
                Set Location to 172 207

                Procedure OnClick
                    Boolean bOk
                    
                    Send Cursor_Wait of Cursor_Control
                    Delegate Get DoRequestCustomerList to bOk
                    Send Cursor_Ready of Cursor_Control
                End_Procedure // OnClick

            End_Object    // oLoadCustList

        End_Object    // oCustomerListPage

        Object oNewCustomerPage is a TabPage
            Set Label to "New Customer"
            Object oName is a Form
                Set Label to "1st/M/Last Name"
                Set Size to 13 73
                Set Location to 14 68
            End_Object    // oName

            Object oMName is a Form
                Set Size to 13 27
                Set Location to 14 149
            End_Object    // oMName

            Object oLName is a Form
                Set Size to 13 96
                Set Location to 14 182
            End_Object    // oLName

            Object oCustAddress is a Form
                Set Label to "Address"
                Set Size to 13 210
                Set Location to 31 68
            End_Object    // oCustAddress

            Object oCity is a Form
                Set Label to "City/State/Zip"
                Set Size to 13 91
                Set Location to 49 68
            End_Object    // oCity

            Object oState is a Form
                Set Size to 13 23
                Set Location to 49 168
            End_Object    // oState

            Object oZip is a Form
                Set Size to 13 77
                Set Location to 49 201
            End_Object    // oZip

            Object oPhone is a Form
                Set Label to "Phone Number"
                Set Size to 13 78
                Set Location to 70 68
                Set form_mask 0 to "(###) ###-####"
            End_Object    // oPhone

            Object oFax is a Form
                Set Label to "Fax Number"
                Set Size to 13 78
                Set Location to 70 200
                Set Label_Col_Offset to 45
                Set form_mask 0 to "(###) ###-####"
            End_Object    // oFax

            Object oEmail is a Form
                Set Label to "Email Address"
                Set Size to 13 210
                Set Location to 87 68
            End_Object    // oEmail

            Object oCreateNewCustBtn is a Button
                Set Label to "Create New Customer"
                Set Size to 14 84
                Set Location to 105 195

                Procedure OnClick
                    tWStNewCustomer CustEntered
                    Integer iSaved
                    Integer iCustNum iLastObject
                
                    Get value of oName  to CustEntered.sFirstName
                    Get value of oMName to CustEntered.sMiddleName
                    Get value of oLName to CustEntered.sLastName
                
                    If ( (CustEntered.sFirstName = "") Or (CustEntered.sLastName = "") ) Begin
                        Send stop_box "You need to enter First and Last Name in order to save a new Customer."
                        Procedure_Return
                    End
                
                    // Populate the structure with other values entered
                    Get value of oCustAddress   to CustEntered.Address.sCustAddress
                    Get value of oCity          to CustEntered.Address.sCity
                    Get value of oState         to CustEntered.Address.sState
                    Get value of oZip           to CustEntered.Address.sZip
                
                    Get value of oPhone         to CustEntered.sPhoneNumber
                    Get value of oFax           to CustEntered.sFaxNumber
                    Get value of oEmail         to CustEntered.sEmailAddress
                
                    // Save new customer
                    Get wsCreateNewCustomer of oWSCustomerAndOrderInfo CustEntered to iSaved
                
                    If (iSaved = -1) ;
                        Send stop_box  "New Customer not created."
                    Else Begin
                        Send Info_Box ("New Customer number" * String(iSaved) * "successfully created!")
                
                        // Display last Customer created
                        Set Value of (oGeneratedCustNum(oLastCustCreatedGrp)) to iSaved
                        Set Value of (oLastCName(oLastCustCreatedGrp))        to CustEntered.sFirstName
                        Set Value of (oLastCMName(oLastCustCreatedGrp))       to CustEntered.sMiddleName
                        Set Value of (oLastCLName(oLastCustCreatedGrp))       to CustEntered.sLastName
                
                        // Clear new customer forms
                        send ClearNewCustForms of oNewCustomerPage
                
                        // Place Cursor in 1st form
                        Send Activate of oName
                    End
                End_Procedure // OnClick

            End_Object    // oCreateNewCustBtn

            Object oLastCustCreatedGrp is a Group
                Set Size to 57 279
                Set Location to 128 6
                Set Label to "Last Customer Created"
                Object oGeneratedCustNum is a Form
                    Set Label to "Customer Number"
                    Set Size to 13 85
                    Set Location to 15 114
                    Set Color to clBtnFace
                    Set TextColor to clNavy
                    Set Focus_Mode to nonfocusable
                    Set Entry_State 0 to False
                End_Object    // oGeneratedCustNum

                Object oLastCName is a Form
                    Set Label to "1st/M/Last Name"
                    Set Size to 13 73
                    Set Location to 33 65
                    Set Color to clBtnFace
                    Set TextColor to clNavy
                    Set entry_state 0 to False
                End_Object    // oLastCName

                Object oLastCMName is a Form
                    Set Size to 13 27
                    Set Location to 33 143
                    Set Color to clBtnFace
                    Set TextColor to clNavy
                    Set entry_state 0 to False
                End_Object    // oLastCMName

                Object oLastCLName is a Form
                    Set Size to 13 96
                    Set Location to 33 174
                    Set Color to clBtnFace
                    Set TextColor to clNavy
                    Set entry_state 0 to False
                End_Object    // oLastCLName

                Procedure ClearForms
                    Broadcast Set Value to ""
                End_Procedure

            End_Object    // oLastCustCreatedGrp

            Procedure ClearNewCustForms
                    // Clear new customer forms
                    Set Value of oName          to ""
                    Set Value of oMName         to ""
                    Set Value of oLName         to ""
                    Set Value of oCustAddress   to ""
                    Set Value of oCity        to ""
                    Set Value of oState       to ""
                    Set Value of oZip         to ""
                    Set Value of oPhone       to ""
                    Set Value of oFax         to ""
                    Set Value of oEmail       to ""
            End_Procedure

            Procedure ClearLastCustForms
                send ClearForms of oLastCustCreatedGrp
            End_Procedure

        End_Object    // oNewCustomerPage

        Object oChageAddrPage is a TabPage
            Set Label to "New Address"
            Object oCustomerNumSpin is a SpinForm
                Set Label to "Customer Number"
                Set Size to 13 57
                Set Location to 14 78
                Set Minimum_Position to 1

                Procedure OnChange
                    tWStCustomerInfo ACustomer
                    integer iCustNumber
                
                    get value to iCustNumber
                
                    if (iCustNumber <> 0) begin
                        get wsGetCustomerInfo of oWSCustomerAndOrderInfo iCustNumber to ACustomer
                
                        if (ACustomer.iCustNumber <> -1) begin
                            // Display Customer Name
                            set value of oCustNameTxt to ACustomer.sName
                
                            // Display Customer Address
                            set value of oCurAddress  to ACustomer.sCustAddress
                            set value of oCurCity     to ACustomer.sCity
                            set value of oCurState    to ACustomer.sState
                            Set value of oCurZip      to ACustomer.sZip
                        end
                        else begin
                            // Display message
                            set value of oCustNameTxt to ">> Customer not found <<"
                            send ClearForms of oCurAddressGrp
                        end
                    end
                    else begin
                        set value of oCustNameTxt to "Customer Name will be displayed here"
                        send ClearForms of oCurAddressGrp
                    end
                
                End_Procedure

            End_Object    // oCustomerNumSpin

            Object oCustNameTxt is a Textbox
                Set Label to "Customer Name will be displayed here"
                Set Auto_Size_State to FALSE
                Set TextColor to clNavy
                Set Location to 16 152
                Set Size to 10 123
                Set Justification_Mode to jMode_Left
            End_Object    // oCustNameTxt

            Object oCurAddressGrp is a Group
                Set Size to 61 266
                Set Location to 36 12
                Set Label to "Current Address"
                
                Object oCurAddress is a Form
                    Set Label to "Address"
                    Set Size to 13 193
                    Set Location to 18 59
                    Set Color to clBtnFace
                    Set TextColor to clNavy
                    Set Label_Col_Offset to 50
                    Set entry_state 0 to False
                End_Object    // oCurAddress

                Object oCurCity is a Form
                    Set Label to "City/State/Zip"
                    Set Size to 13 85
                    Set Location to 34 59
                    Set Color to clBtnFace
                    Set TextColor to clNavy
                    Set Label_Col_Offset to 50
                    Set entry_state 0 to False
                End_Object    // oCurCity

                Object oCurState is a Form
                    Set Size to 13 27
                    Set Location to 34 156
                    Set Color to clBtnFace
                    Set TextColor to clNavy
                    Set entry_state 0 to False
                End_Object    // oCurState

                Object oCurZip is a Form
                    Set Size to 13 57
                    Set Location to 34 195
                    Set Color to clBtnFace
                    Set TextColor to clNavy
                    Set entry_state 0 to False
                End_Object    // oCurZip

                Procedure ClearForms
                    Broadcast Set value to ""
                End_Procedure

            End_Object    // oCurAddressGrp

            Object oMoveCurAddrBtn is a Button
                Set Label to "Copy Current Address to New"
                Set Size to 14 102
                Set Location to 100 175

                Procedure OnClick
                    String sCurAddr sCurCity sCurState sCurZip
                
                    Get value of oCurAddress to sCurAddr
                    Get value of oCurCity    to sCurCity
                    Get value of oCurState   to sCurState
                    Get value of oCurZip     to sCurZip
                
                    Set value of oNewAddress to sCurAddr
                    Set value of oNewCity    to sCurCity
                    Set value of oNewState   to sCurState
                    Set value of oNewZip     to sCurZip
                
                End_Procedure // OnClick

            End_Object    // oMoveCurAddrBtn

            Object oNewAddressTxt is a Textbox
                Set Label to "Enter the New Address"
                Set Location to 114 12
                Set Size to 10 74
                Set FontWeight to FW_BOLD
            End_Object    // oNewAddressTxt

            Object oNewAddress is a Form
                Set Label to "New Address"
                Set Size to 13 214
                Set Location to 132 63
                Set Label_Col_Offset to 50
            End_Object    // oNewAddress

            Object oNewCity is a Form
                Set Label to "City/State/Zip"
                Set Size to 13 95
                Set Location to 148 63
                Set Label_Col_Offset to 50
            End_Object    // oNewCity

            Object oNewState is a Form
                Set Size to 13 27
                Set Location to 148 169
            End_Object    // oNewState

            Object oNewZip is a Form
                Set Size to 13 72
                Set Location to 148 205
            End_Object    // oNewZip

            Object oChangeAddrBtn is a Button
                Set Label to "Change Address"
                Set Size to 14 84
                Set Location to 169 193

                Procedure OnClick
                    tWStCustAddress NewAddress
                    Integer iCustNum
                    Boolean bAddrChanged
                
                    Get value of oCustomerNumSpin to iCustNum
                
                    Get value of oNewAddress  to NewAddress.sCustAddress
                    Get value of oNewCity     to NewAddress.sCity
                    Get value of oNewState    to NewAddress.sState
                    Get value of oNewZip      to NewAddress.sZip
                
                    Get wsChangeCustomerAddress of oWSCustomerAndOrderInfo iCustNum NewAddress to bAddrChanged
                
                    If (bAddrChanged) Begin
                        Send info_box ("Address for Customer Number" * String(iCustNum) * "successfully changed!")
                        Set value of oCurAddress  to NewAddress.sCustAddress
                        Set value of oCurCity     to NewAddress.sCity
                        Set value of oCurState    to NewAddress.sState
                        Set value of oCurZip      to NewAddress.sZip
                
                        Set value of oNewAddress  to ""
                        Set value of oNewCity     to ""
                        Set value of oNewState    to ""
                        Set value of oNewZip      to ""
                    End
                    Else;
                        Send stop_box ("Address for Customer Number" * String(iCustNum) * "not changed.")
                
                    // Place cursor back in Customer Number
                    Send activate of oCustomerNumSpin

                End_Procedure // OnClick

            End_Object    // oChangeAddrBtn

        End_Object    // oChageAddrPage

    End_Object    // oCustomerInfo

    Object oDebugMode is a CheckBox
        Set Label to "Activate Debug Mode"
        Set Size to 10 85
        Set Location to 282 11
        Set peAnchors to anBottomLeft

        Procedure OnChange
            Boolean bChecked
        
            Get Checked_State To bChecked
            if (bChecked) begin
                Set phoSoapClientHelper of oWSCustomerAndOrderInfo to oClientWSHelper
            end
            else begin
                Set phoSoapClientHelper of oWSCustomerAndOrderInfo to 0
            end
        End_Procedure // OnChange

    End_Object    // oDebugMode

    Object oDisplayDebug is a Button
        Set Label to "Display Debug Information"
        Set Size to 14 96
        Set Location to 280 101
        Set peAnchors to anBottomLeft

        Procedure OnClick
            send Popup of oClientWSHelper
        End_Procedure // OnClick

    End_Object    // oDisplayDebug

    Object oWSCustomerAndOrderInfo is a cWSCustomerAndOrderInfo

        // Web Service Class is defined in cWSCustomerAndOrderInfo.pkg
        // Interface:
        // Function wsGetOrdersForCustomer integer lliCustNum returns integer[]
        // Function wsChangeCustomerAddress integer lliCustNum tWStCustAddress llNewCustomerAddress returns boolean
        // Function wsCreateNewCustomer tWStNewCustomer llNewCustomer returns integer
        // Function wsGetCustomerInfo integer lliCustNum returns tWStCustomerInfo
        // Function wsGetCustomerInfoList returns tWStCustomerInfo[]
        // Function wsGetOrderSummaryForCustomer integer lliCustNum returns tWStOrderSummary[]
        // Function wsGetOrderInfo integer lliOrdNum returns tWStOrder

        // phoSoapClientHelper
        //     Setting this property will pop up a view that provides information
        //     about the Soap (xml) data transfer. This can be useful in debugging.
        //     If you use this you must make sure you USE the test view at the top
        //     of your program/view by adding:   Use WebClientHelper.vw // oClientWSHelper
        //Set phoSoapClientHelper to oClientWSHelper

    End_Object    // oWSCustomerAndOrderInfo

    // Fill the grid with customer information passed in an array of struct
    Function FillCustomerList tWStCustomerInfo[] ArrayOfCustomers Returns Integer
        Handle hoCustomerGrid
        Integer iCount iItems 
        tDataSourceRow[] DataSource
    
        move oCustomerGrid to hoCustomerGrid  // object ID of VDF grid
    
        move (SizeOfArray(ArrayOfCustomers)) to iItems
        for iCount from 0 to (iItems - 1)
            Move (trim(ArrayOfCustomers[iCount].sName)) to DataSource[iCount].sValue[0]
            Move ArrayOfCustomers[iCount].iCustNumber to DataSource[iCount].sValue[1]
            Move ArrayOfCustomers[iCount].sState to DataSource[iCount].sValue[2]
            Move ArrayOfCustomers[iCount].sZip to DataSource[iCount].sValue[3]
        Loop
        
        Send InitializeData of hoCustomerGrid DataSource
    
        Function_Return 1
    End_Function

    //  Get the customer list from server and fill the grid with data
    Function DoRequestCustomerList Returns Integer
        tWStCustomerInfo[] ArrayOfCustomers
        boolean bOk
    
        // make the web service call. Will return the customer list as an array of struct
        get wsGetCustomerInfoList of oWSCustomerAndOrderInfo to ArrayOfCustomers
        if (SizeOfArray(ArrayOfCustomers) > 0) begin
            Get FillCustomerList ArrayOfCustomers to bOk
        end
    
        Function_Return bOk
    End_Function

    Object oInfoTextEdit is a cTextEdit
        Set Size to 43 296
        Set Location to 9 11
        Set Read_Only_State to True
        Set Enabled_State to False
        Set Color to clBtnFace
        Set TextColor to clMaroon
        
        Procedure Activating
            Forward Send Activating
            
            Set Value to "This sample will show on the first tab how to retrieve the contents from the Order Sample Customer file through a web service that returns an array of structs. The second tab demonstrates how to add a new record to a file by passing a struct to a web service. The third tab shows how to update data of a record in a table using a web service."
            //Set Value to "This sample will retrieve the contents from the Order Sample Customer file through a web service. It uses the array of structs returned by the service to fill out the grid."
        End_Procedure
    End_Object

End_Object
