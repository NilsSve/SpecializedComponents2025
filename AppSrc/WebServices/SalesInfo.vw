Use WebClientHelper.vw
Use dfClient.pkg
Use WebServices\cWSTestService.pkg
Use Windows.pkg

DEFERRED_VIEW Activate_oSalesInfoView FOR ;
;
Object oSalesInfoView is a dbView

    On_Key kCancel Send Request_Cancel

    Set Label to "Sales Information"
    Set Location to 2 2
    Set Size to 158 290

    Object oWSTestService is a cWSTestService

        // Web Service Class is defined in cWSTestService.pkg
        // Interface:
        // Function wsSayHello string sName returns string
        // Function wsEcho string echoString returns string
        // Function wsAddNumber real number1 real number2 returns real
        // Function wsPriceQuote string itemID returns decimal
        // Function wsEstimatedOrderDeliveryDate integer customerNumber integer orderNumber returns date
        // Function wsItemsSoldToDate string itemID returns integer

        // phoSoapClientHelper
        //     Setting this property will pop up a view that provides information
        //     about the Soap (xml) data transfer. This can be useful in debugging.
        //     If you use this you must make sure you USE the test view at the top
        //     of your program/view by adding:
        //         Use WebClientHelper.vw // oClientWSHelper
        //Set phoSoapClientHelper to oClientWSHelper

    End_Object    // oWSTestService

    Object oItems is a ComboForm
        Set Label to "Select One of the  Available Items"
        Set Size to 13 90
        Set Location to 54 129
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

    Object oCheckSalesBtn is a Button
        Set Label to "Check Sales"
        Set Location to 54 228

        Procedure OnClick
            String sMessage sMessageEcho sItem
            integer iQtySold
        
            get Value of oItems to sItem
            move "" to sMessage
        
            Send Cursor_Wait of Cursor_Control
        
            // Calls the web service to get number of items sold
            get wsItemsSoldToDate of oWSTestService sItem to iQtySold
            set Value of oQtySold to iQtySold
        
            if (iQtySold=0) begin
                move "Too bad... no items sold." to sMessage
            end
            else if ((iQtySold > 0) and (iQtySold <= 75)) begin
                move (string(iQtySold) + " items sold. That is promissing!") to sMessage
            end
            else if ((iQtySold > 75) and (iQtySold < 100)) begin
                move "Way to go! Keep up the good sales!" to sMessage
            end
            else if (iQtySold >= 100) begin
                Move "Excellent!!! Very nice results!" to sMessage
            end
        
            // Just to demonstrate the use of wsEcho
            get wsEcho of oWSTestService sMessage to sMessageEcho
            set Value of oMessage to sMessageEcho
        
            Send Cursor_Ready of Cursor_Control
        End_Procedure  // OnClick

    End_Object    // oCheckSalesBtn

    Object oQtySold is a Form
        Set Label to "Quantity Sold to Date"
        Set Size to 13 61
        Set Location to 81 144
        Set Color to clInfoBk
        Set Form_Border to Border_Normal
        Set Label_Col_Offset to 75
        Set Form_DataType to Mask_Numeric_Window
        set Entry_State to False
        Set Form_Mask to "#,###,##0"
    End_Object    // oQtySold

    Object oMessage is a Textbox
        Set Auto_Size_State to False
        Set TextColor to clNavy
        Set Location to 100 27
        Set Size to 12 233
        Set Border_Style to Border_Normal
        Set Justification_Mode to jMode_Center
    End_Object    // oMessage

    Object oDebugMode is a CheckBox
        Set Label to "Activate Debug Mode"
        Set Size to 10 85
        Set Location to 133 15
        Set peAnchors to anBottomLeft

        Procedure OnChange
            Boolean bChecked
        
            Get Checked_State To bChecked
        
            if (bChecked) begin
                Set phoSoapClientHelper of oWSTestService to oClientWSHelper
            end
            else begin
                Set phoSoapClientHelper of oWSTestService to ""
            end
        End_Procedure // OnChange

    End_Object    // oDebugMode

    Object oDisplayDebug is a Button
        Set Label to "Display Debug Information"
        Set Size to 14 96
        Set Location to 131 118
        Set peAnchors to anBottomLeft

        Procedure OnClick
            Send Popup of oClientWSHelper
        End_Procedure // OnClick

    End_Object    // oDisplayDebug

    Object oInfoEdit is a cTextEdit
        Set Size to 32 277
        Set Location to 7 6
        Set Color to clBtnFace
        Set TextColor to clMaroon
        Set Read_Only_State to True
        Set piMaxChars to 320
        Set Enabled_State to False
        
        Set Value of oInfoEdit ;
            to "This sample uses two web services: one to get the number of items sold for the selected product and the other solely to get the string that will be diplayed as a message on the screen. "

    End_Object    // oInfoEdit

CD_End_Object    // oSalesInfoView
