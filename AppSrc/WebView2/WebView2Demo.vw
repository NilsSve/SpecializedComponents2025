Use Windows.pkg
Use DFClient.pkg
Use DFTabDlg.pkg
Use cWebView2Browser.pkg
Use cSplitterContainer.pkg
Use cRichEdit.pkg
Use cTextEdit.pkg
Use cCJStandardCommandBarSystem.pkg
Use cCJCommandBarSystem.pkg
Use cJsonObject.pkg
Use WebView2\WebView2PopupView.vw
Use WebView2\WebView2CustomScriptDialog.dg
Use File_dlg.pkg

Activate_View Activate_oWebView2Demo for oWebView2Demo
Object oWebView2Demo is a dbView
    Set Label to "Demonstration of the cWebView2Browser Control"
    Set Size to 359 780
    Set Location to 2 10
    Set Border_Style to Border_Thick
    Set Maximize_Icon to True
    Set pbAutoActivate to True

    Object oSplitterContainer1 is a cSplitterContainer
        Set piSplitterLocation to 596
        Object oSplitterContainerChild1 is a cSplitterContainerChild
            Object oCJCommandBarSystem1 is a cCJCommandBarSystem
                Object oCJToolbar1 is a cCJToolbar
                    Object oMenuItemBack is a cCJMenuItem
                        Set psCaption to "< Back"
                        Set pbEnabled to False

                        Procedure OnExecute Variant vCommandBarControl
                            Send GoBack of oWebView2BrowserCtrl
                        End_Procedure
                    End_Object

                    Object oMenuItemForward is a cCJMenuItem
                        Set psCaption to "Forward >"
                        Set pbEnabled to False

                        Procedure OnExecute Variant vCommandBarControl
                            Send GoForward of oWebView2BrowserCtrl
                        End_Procedure
                    End_Object

                    Object oMenuItemReload is a cCJMenuItem
                        Set psCaption to "Reload"
                        Set pbEnabled to False

                        Procedure OnExecute Variant vCommandBarControl
                            Send Reload of oWebView2BrowserCtrl
                        End_Procedure
                        
                    End_Object

                    Object oMenuItemStop is a cCJMenuItem
                        Set psCaption to "Stop"
                        Set pbEnabled to False

                        Procedure OnExecute Variant vCommandBarControl
                            Send Stop of oWebView2BrowserCtrl
                        End_Procedure
                        
                        
                    End_Object

                    Object oMenuItemUrl is a cCJMenuItem
                        Set peControlType to xtpControlEdit
                        Set psCaption to "Url"
                        
                        Procedure OnCreateControl Handle hoEditor
                            Set ComWidth of hoEditor to 300
                            Set ComText of hoEditor to "https://support.dataaccess.com"
                        End_Procedure
                        
                        Function CreateFirstProxyControl Returns Handle
                            Variant vControl
                            Handle hoControl
                            Get FindFirstControl to vControl
                            If (not(IsNullComObject(vControl))) Begin
                            Get CreateProxyControl vControl to hoControl
                            End
                            Function_Return hoControl
                        End_Function
                        
                        
                        Function FetchUrl Returns String
                            String sText
                            Handle hoEdit
                            Get CreateFirstProxyControl to hoEdit
                            If hoEdit Begin
                                Get comText of hoEdit to sText
                                Send destroy of hoEdit
                            End
                            
                            Function_Return sText
                        End_Function
                        
                        Procedure UpdateUrl String sValue
                            Handle hoEdit
                            Get CreateFirstProxyControl to hoEdit
                            If hoEdit Begin
                                Set ComText of hoEdit to sValue
                                Send destroy of hoEdit
                            End
                            
                        End_Procedure
                    End_Object

                    Object oMenuItemGo is a cCJMenuItem
                        Set psCaption to "Go!"

                        Procedure OnExecute Variant vCommandBarControl
                            Forward Send OnExecute vCommandBarControl
                            
                            String sUrl
                            Get FetchUrl of oMenuItemUrl to sUrl
                            
                            Send NavigateUrl sUrl
                        End_Procedure
                    End_Object
                End_Object
            End_Object
        
            Object oWebView2BrowserCtrl is a cWebView2Browser
                Set Size to 241 586
                Set Location to 19 4
                Set peAnchors to anAll
                Set TextColor to clBlue
                
                Procedure OnCreate
                    String sPath
                    
                    Forward Send OnCreate
                    
                    Get psAppHtmlPath of (phoWorkspace(ghoApplication)) to sPath
                    
                    Send SetVirtualHostNameToFolderMapping "localdemo.asset" sPath OLECOREWEBVIEW2_HOST_RESOURCE_ACCESS_KIND_ALLOW

                    Set psLocationURL to "https://localdemo.asset/DemoWebView2.html"
                    
                    //  Set a filter to enable OnWebResourceRequested for these urls
                    Send AddWebResourceRequestedFilter "https://memresource.asset/*" OLECOREWEBVIEW2_WEB_RESOURCE_CONTEXT_ALL
                End_Procedure
        
                Procedure OnNavigationStarting UBigInt iNavigationId String sUrl Boolean bIsRedirected Boolean bIsUserInitiated Boolean  ByRef bCancelnavigation
                    Send DoLog "OnNavigationStarting" iNavigationId sUrl bIsRedirected bIsUserInitiated bCancelnavigation
                    
                    Set pbEnabled of (oMenuItemStop(oCJToolbar1(oCJCommandBarSystem1))) to True
                    
                    Send UpdateUrl sUrl
                End_Procedure
        
                Procedure OnContentLoading UBigInt iNavigationId String sUrl Boolean bIsErrorPage
                    Send DoLog "OnContentLoading" iNavigationId sUrl bIsErrorPage
                End_Procedure
        
                Procedure OnSourceChanged String sUrl Boolean bIsNewDocument
                    Send DoLog "OnSourceChanged" sUrl bIsNewDocument
                End_Procedure

                Procedure OnHistoryChanged String sUrl Boolean bCanGoBack Boolean bCanGoForward
                    Send DoLog "OnHistoryChanged" sUrl bCanGoBack bCanGoForward
                    Handle hoObj
                    
                    Send UpdateUrl sUrl
                    
                    Move (oMenuItemBack(oCJToolbar1(oCJCommandBarSystem1))) to hoObj
                    Set pbEnabled of hoObj to bCanGoBack
                    Set pbEnabled of (oMenuItemForward(oCJToolbar1(oCJCommandBarSystem1))) to bCanGoForward
                End_Procedure

                Procedure OnNavigationCompleted UBigInt iNavigationId String sUrl Boolean bIsSuccess OLECOREWEBVIEW2_WEB_ERROR_STATUS eWebErrorStatus
                    Send DoLog "OnNavigationCompleted" iNavigationId sUrl bIsSuccess eWebErrorStatus
                    
                    Set pbEnabled of (oMenuItemStop(oCJToolbar1(oCJCommandBarSystem1))) to False
                    Set pbEnabled of (oMenuItemReload(oCJToolbar1(oCJCommandBarSystem1))) to True
                    
                    Send UpdateUrl sUrl
                End_Procedure

                Procedure OnExecuteScriptFinished UBigInt iExecutionId Integer iErrorCode String sResult
                    Send DoLog "OnExecuteScriptFinished" iExecutionId iErrorCode sResult
                End_Procedure

                Procedure OnWebMessageReceived String sUrl String sMessageAsJson String sMessageAsString
                    Send DoLog "OnWebMessageReceived" sUrl sMessageAsJson sMessageAsString
                End_Procedure

                Procedure OnDocumentTitleChanged String sTitle
                    Send DoLog "OnDocumentTitleChanged" sTitle
                End_Procedure

                Procedure OnNewWindowRequested String sUrl Boolean bUserInitiated Boolean  ByRef bHandled tWebView2_WindowFeatures requestedFeatures Handle  ByRef hoNewWindow
                    String sStyle
                    
                    Send DoLog "OnNewWindowRequested" sUrl bUserInitiated
                    
                    Get Value of oPopupStyleCombo to sStyle
                    
                    If (sStyle = "Custom Popups") Begin
                        Get CreateCustomPopupView requestedFeatures to hoNewWindow
                    End
                    Else If (sStyle = "No Popups") Begin
                        Move True to bHandled
                    End
                End_Procedure

                Procedure OnScriptDialogOpening String sUrl OLECOREWEBVIEW2_SCRIPT_DIALOG_KIND eKind String sMessage String sDefaultText String  ByRef sResultText Boolean  ByRef bAccept
                    Send DoLog "OnScriptDialogOpening" sUrl eKind sMessage sDefaultText sResultText bAccept
                    
                    If (eKind = OLECOREWEBVIEW2_SCRIPT_DIALOG_KIND_ALERT) Begin
                        Send ScriptAlert of oWebView2CustomScriptDialog sMessage
                    End
                    If (eKind = OLECOREWEBVIEW2_SCRIPT_DIALOG_KIND_CONFIRM or eKind = OLECOREWEBVIEW2_SCRIPT_DIALOG_KIND_BEFOREUNLOAD) Begin
                        Get ScriptConfirm of oWebView2CustomScriptDialog sMessage to bAccept
                    End
                    If (eKind = OLECOREWEBVIEW2_SCRIPT_DIALOG_KIND_PROMPT) Begin
                        Get ScriptPrompt of oWebView2CustomScriptDialog sMessage sDefaultText to sResultText
                        Move True to bAccept
                    End
                End_Procedure

                Procedure OnPermissionRequested String sUrl OLECOREWEBVIEW2_PERMISSION_KIND eKind Boolean isUserInitiated OLECOREWEBVIEW2_PERMISSION_STATE ByRef eState
                    String sQuestion 
                    Integer eConfirm
                    
                    Send DoLog "OnPermissionRequested" sUrl eKind isUserInitiated eState
                    
                    If (eState <> OLECOREWEBVIEW2_PERMISSION_STATE_DENY and eKind <> OLECOREWEBVIEW2_PERMISSION_KIND_UNKNOWN_PERMISSION) Begin
                        Case Begin
                            Case (eKind = OLECOREWEBVIEW2_PERMISSION_KIND_MICROPHONE)
                                Move "Allow website to access your microphone?" to sQuestion
                                Break
                            Case (eKind = OLECOREWEBVIEW2_PERMISSION_KIND_CAMERA)
                                Move "Allow website access your camera?" to sQuestion
                                Break
                            Case (eKind = OLECOREWEBVIEW2_PERMISSION_KIND_GEOLOCATION)
                                Move "Share your location with the website?" to sQuestion
                                Break
                            Case (eKind = OLECOREWEBVIEW2_PERMISSION_KIND_NOTIFICATIONS)
                                Move "Allow website to send notifications?" to sQuestion
                                Break
                            Case (eKind = OLECOREWEBVIEW2_PERMISSION_KIND_OTHER_SENSORS)
                                Move "Allow website to access sensors?" to sQuestion
                                Break
                            Case (eKind = OLECOREWEBVIEW2_PERMISSION_KIND_CLIPBOARD_READ)
                                Move "Allow website to access the clipboard?" to sQuestion
                                Break
                        Case End
                        
                        Get Confirm sQuestion to eConfirm
                        If (Not(eConfirm)) Begin
                            Move OLECOREWEBVIEW2_PERMISSION_STATE_ALLOW to eState
                        End
                        Else Begin
                            Move OLECOREWEBVIEW2_PERMISSION_STATE_DENY to eState
                        End
                    End
                End_Procedure

                Procedure OnZoomFactorChanged Real rZoomFactor
                    Send DoLog "OnZoomFactorChanged" rZoomFactor
                    
                    Set Value of oZoomFactorFrm to rZoomFactor
                End_Procedure
                
                //  This demonstrates that DataFlex accelerator keys work and do cancel the default browser behavior
                Procedure OnF3Key 
                    Send DoLog "Handled f3 key!"
                End_Procedure
                On_Key Key_F3 Send OnF3Key
                
                //  Fires after CapturePreview is called with the image data, we show a dialog and save it do disk.
                Procedure OnCapturePreviewCompleted OLECOREWEBVIEW2_CAPTURE_PREVIEW_IMAGE_FORMAT eImageFormat UChar[]  ByRef ucImageData
                    Boolean bOk
                    String sPath
                    Integer iChnl
                    
                    Set File_Title of oSaveAsDialog to "Screenshot"
                    
                    If (eImageFormat = OLECOREWEBVIEW2_CAPTURE_PREVIEW_IMAGE_FORMAT_PNG) ;
                        Set Filter_Index of oSaveAsDialog to 1
                    Else ;
                        Set Filter_Index of oSaveAsDialog to 2
                        
                    Get Show_Dialog of oSaveAsDialog to bOk
                    If (bOk) Begin
                        Get File_Name of oSaveAsDialog to sPath
                        
                        Move (Seq_New_Channel()) to iChnl
                        Direct_Output channel iChnl ("binary:" + sPath)
                        Write channel iChnl ucImageData
                        Close_Output channel iChnl
                        Send Seq_Release_Channel iChnl
                        
                        Runprogram Shell Background sPath
                    End
                    
                End_Procedure
                
                //  Fires when a resource is requested that matches the set filter (AddWebResourceRequestedFilter).
                Procedure OnWebResourceRequested String sUrl String sMethod OLECOREWEBVIEW2_WEB_RESOURCE_CONTEXT eContext
                    UChar[] ucRequest
                    String sUserAgent
                    
                    Send DoLog "OnWebResourceRequested" sUrl sMethod eContext
                    Get WebResourceRequestHeader "User-Agent" to sUserAgent
                    Send DoLog "User-Agent:" ('"' + sUserAgent + '"')
                    
                    Get WebResourceRequestContent to ucRequest
                    Send DoLog "Request body:" ('"' + UCharArrayToString(ucRequest) + '"')
                    
                    //  Generate a response
                    Send WebResourceResponseSet 200 "OK" "text/plain" (StringToUCharArray("Hello" * sUrl - "!")) 
                    Send WebResourceResponseSetHeader "Access-Control-Allow-Origin" "https://localdemo.asset"   // This header is needed
                End_Procedure
            End_Object

            Object oSaveAsDialog is a SaveAsDialog
                Set Filter_String to "Image PNG (.png)|*.png|Image JPEG (.jpg)|*.jpg"
            End_Object

            Object oMsgEdit is a cTextEdit
                Set Size to 44 85
                Set Location to 262 6
                Set peAnchors to anBottomLeft
                
                Set Value to 'Message directly via PostMessage'
            End_Object

            Object oMsgPost is a Button
                Set Size to 44 52
                Set Location to 262 94
                Set Label to 'Post Message'
                Set peAnchors to anBottomLeft
            
                // fires when the button is clicked
                Procedure OnClick
                    String sMsg
                    
                    Get Value of oMsgEdit to sMsg
                    
                    Send PostWebMessageAsString of oWebView2BrowserCtrl sMsg
                End_Procedure
            
            End_Object

            Object oMsgPostJson is a Button
                Set Size to 44 52
                Set Location to 262 147
                Set Label to 'Post JSON'
                Set peAnchors to anBottomLeft
            
                // fires when the button is clicked
                Procedure OnClick
                    String sMsg
                    Handle hoJson
                    
                    Get Value of oMsgEdit to sMsg
                    
                    Get Create (RefClass(cJsonObject)) to hoJson
                    Send InitializeJsonType of hoJson jsonTypeObject
                    
                    Send SetMemberValue of hoJson "sVal" jsonTypeString sMsg
                    Send SetMemberValue of hoJson "iVal" jsonTypeInteger 32
                    Send SetMemberValue of hoJson "bVal" jsonTypeBoolean True
                    
                    Send PostWebMessageAsJsonHandle of oWebView2BrowserCtrl hoJson
                    
                    Send Destroy of hoJson
                End_Procedure
            
            End_Object

            Object oNavigateToStringBtn is a Button
                Set Size to 14 84
                Set Location to 262 200
                Set Label to 'NavigateToString'
                Set peAnchors to anBottomLeft
            
                // fires when the button is clicked
                Procedure OnClick
                    String sHtml
                    
                    Append sHtml ('<!' + ' DOCTYPE html>')
                    Append sHtml '<html>    '
                    Append sHtml '    <head>'
                    Append sHtml '        <title>Generated from Df Code</title>'
                    Append sHtml '        <style>'
                    Append sHtml '        body{'
                    Append sHtml '            color: #000000;'
                    Append sHtml '            font-family: "Segoe UI", arial;'
                    Append sHtml '            font-size: 12px;'
                    Append sHtml '            background-color: #F6F6F6;'
                    Append sHtml '        }'
                    Append sHtml '        h1 {'
                    Append sHtml '            font-size:30px;'
                    Append sHtml '            font-weight: lighter;'
                    Append sHtml '            margin: 5px 0px;'
                    Append sHtml '            color: #0078CF;'
                    Append sHtml '        }'
                    Append sHtml '        section{'
                    Append sHtml '            background-color: #FFFFFF;'
                    Append sHtml '            display: inline-block;'
                    Append sHtml '            padding: 15px;'
                    Append sHtml '            }'
                    Append sHtml '        </style>'
                    Append sHtml '    </head>'
                    Append sHtml '    <body>'
                    Append sHtml '        <section>'
                    Append sHtml '            <h1>Generated from DataFlex</h1>'
                    Append sHtml '            <p>This page is generated from DataFlex.</p>            '
                    Append sHtml '        </section>'
                    Append sHtml '    </body>'
                    Append sHtml '</html>'
                    
                    Send NavigateToString of oWebView2BrowserCtrl sHtml
                End_Procedure
            
            End_Object

            Object oReadPropertiesBtn is a Button
                Set Size to 14 84
                Set Location to 277 200
                Set Label to 'Read Properties'
                Set peAnchors to anBottomLeft
            
                // fires when the button is clicked
                Procedure OnClick
                    String sVal
                    Boolean bVal
                    Integer iVal
                    
                    Get psUserDataFolder of oWebView2BrowserCtrl to sVal
                    Send DoLog "psUserDataFolder" sVal
                    
                    Get psUserAgent of oWebView2BrowserCtrl to sVal
                    Send DoLog "psUserAgent: " sVal
                    
                    Get psLocationURL of oWebView2BrowserCtrl to sVal
                    Send DoLog "psLocationUrl: " sVal
                    
                    Get psDocumentTitle of oWebView2BrowserCtrl to sVal
                    Send DoLog "psDocumentTitle: " sVal
                    
                    Get pbCanGoBack of oWebView2BrowserCtrl to bVal
                    Send DoLog "pbCanGoBack: " bVal
                    
                    Get pbCanGoForward of oWebView2BrowserCtrl to bVal
                    Send DoLog "pbCanGoForward: " bVal
                    
                    Get piBrowserProcessId of oWebView2BrowserCtrl to iVal
                    Send DoLog "piBrowserProcessId: " iVal
                    
                    Get pbAreBrowserAcceleratorKeysEnabled of oWebView2BrowserCtrl to bVal
                    Send DoLog "pbAreBrowserAcceleratorKeysEnabled: " bVal
                    
                    Get pbAreDefaultContextMenusEnabled of oWebView2BrowserCtrl to bVal
                    Send DoLog "pbAreDefaultContextMenusEnabled: " bVal
                    
                    Get pbAreDefaultScriptDialogsEnabled of oWebView2BrowserCtrl to bVal
                    Send DoLog "pbAreDefaultScriptDialogsEnabled: " bVal
                    
                    Get pbAreDevToolsEnabled of oWebView2BrowserCtrl to bVal
                    Send DoLog "pbAreDevToolsEnabled: " bVal
                    
                    Get pbAreHostObjectsAllowed of oWebView2BrowserCtrl to bVal
                    Send DoLog "pbAreHostObjectsAllowed: " bVal
                    
                    Get pbIsBuiltInErrorPageEnabled of oWebView2BrowserCtrl to bVal
                    Send DoLog "pbIsBuiltInErrorPageEnabled: " bVal
                    
                    Get pbIsScriptEnabled of oWebView2BrowserCtrl to bVal
                    Send DoLog "pbIsScriptEnabled: " bVal
                    
                    Get pbIsStatusBarEnabled of oWebView2BrowserCtrl to bVal
                    Send DoLog "pbIsStatusBarEnabled: " bVal
                    
                    Get pbIsWebMessageEnabled of oWebView2BrowserCtrl to bVal
                    Send DoLog "pbIsWebMessageEnabled: " bVal
                    
                    Get pbIsZoomControlEnabled of oWebView2BrowserCtrl to bVal
                    Send DoLog "pbIsZoomControlEnabled: " bVal
                    
                    Real rVal
                    Get ComZoomFactor of oWebView2BrowserCtrl to rVal
                    Send DoLog "ZoomFactor: " rVal
                End_Procedure
            
            End_Object

            Object oOpenDevTools_Btn is a Button
                Set Size to 14 84
                Set Location to 292 200
                Set Label to 'Open Developer Tools'
                Set peAnchors to anBottomLeft
            
                // fires when the button is clicked
                Procedure OnClick
                    Send OpenDevToolsWindow of oWebView2BrowserCtrl
                End_Procedure
            
            End_Object

            Object oJSEdit is a cTextEdit
                Set Size to 44 218
                Set Location to 262 304
                Set peAnchors to anBottomLeftRight
                
                Set Value to 'doLog("Message directly via ExecuteScript!");'
            End_Object

            Object oJSExecBtn is a Button
                Set Size to 44 67
                Set Location to 262 524
                Set Label to 'Exec'
                Set peAnchors to anBottomRight
            
                // fires when the button is clicked
                Procedure OnClick
                    UBigInt iExecId
                    String sJS
                    
                    Get Value of oJSEdit to sJS
                    
                    Get ExecuteScript of oWebView2BrowserCtrl sJS to iExecId
                    
                    Send DoLog 'ExecuteScript' iExecId
                End_Procedure
            
            End_Object

            Object oExecuteScriptOnStartupChk is a CheckBox
                Set Size to 10 50
                Set Location to 309 6
                Set Label to 'Init script 1'
                
                Property UBigInt piScriptId 0

                Set peAnchors to anBottomLeft
            
                // Fires whenever the value of the control is changed
                Procedure OnChange
                    Boolean bChecked
                    UBigInt iScriptId
                
                    Get Checked_State to bChecked
                    
                    If (bChecked) Begin
                        Get AddScriptToExecuteOnDocumentCreated of oWebView2BrowserCtrl 'document.addEventListener("DOMContentLoaded", function(event) { calledOnInitialization(); });' to iScriptId
                        Set piScriptId to iScriptId
                    End
                    Else Begin
                        Get piScriptId to iScriptId
                        If (iScriptId > 0) Begin
                            Send RemoveScriptToExecuteOnDocumentCreated of oWebView2BrowserCtrl iScriptId
                            Set piScriptId to 0
                        End
                    End
                    
                End_Procedure
            
            End_Object
           

        
            Object oExecuteScriptOnStartupChk2 is a CheckBox
                Set Size to 10 50
                Set Location to 319 6
                Set Label to 'Init script 2'
                
                Property UBigInt piScriptId 0

                Set peAnchors to anBottomLeft
            
                // Fires whenever the value of the control is changed
                Procedure OnChange
                    Boolean bChecked
                    UBigInt iScriptId
                
                    Get Checked_State to bChecked
                    
                    If (bChecked) Begin
                        Get AddScriptToExecuteOnDocumentCreated of oWebView2BrowserCtrl 'document.addEventListener("DOMContentLoaded", function(event) { doLog("Init Script 2"); });' to iScriptId
                        Set piScriptId to iScriptId
                    End
                    Else Begin
                        Get piScriptId to iScriptId
                        If (iScriptId > 0) Begin
                            Send RemoveScriptToExecuteOnDocumentCreated of oWebView2BrowserCtrl iScriptId
                            Set piScriptId to 0
                        End
                    End
                    
                End_Procedure
            
            End_Object

            Object oBorderVisibleChk is a CheckBox
                Set Size to 10 50
                Set Location to 329 6
                Set Label to 'BorderVisible'
                Set peAnchors to anBottomLeft
            
                // Fires whenever the value of the control is changed
                Procedure OnChange
                    Boolean bChecked
                
                    Get Checked_State to bChecked
                    
                    Set pbBorderVisible of oWebView2BrowserCtrl to bChecked
                End_Procedure
                
                Set Checked_State to True
            End_Object

            Object oEnabled_State_chk is a CheckBox
                Set Size to 10 50
                Set Location to 309 89
                Set Label to 'Enabled_State'
                Set peAnchors to anBottomLeft
            
                // Fires whenever the value of the control is changed
                Procedure OnChange
                    Boolean bChecked
                    
                    Get Checked_State to bChecked
                    
                    Set Enabled_State of oWebView2BrowserCtrl to bChecked
                End_Procedure
                Set Checked_State to True
            End_Object

            Object oAreDefaultScriptDialogsEnabled_chk is a CheckBox
                Set Size to 10 50
                Set Location to 309 180
                Set Label to 'pbAreDefaultScriptDialogsEnabled'
                Set peAnchors to anBottomLeft
                Set psToolTip to "Reload to activate change."
            
                // Fires whenever the value of the control is changed
                Procedure OnChange
                    Boolean bChecked
                
                    Get Checked_State to bChecked
                    
                    Set pbAreDefaultScriptDialogsEnabled of oWebView2BrowserCtrl to bChecked
                End_Procedure
                
                Set Checked_State to False
            End_Object

            Object oAreDevToolsEnabled_chk is a CheckBox
                Set Size to 10 50
                Set Location to 319 180
                Set Label to 'pbAreDevToolsEnabled'
                Set peAnchors to anBottomLeft
                Set psToolTip to "Reload to activate change."
            
                // Fires whenever the value of the control is changed
                Procedure OnChange
                    Boolean bChecked
                
                    Get Checked_State to bChecked
                    
                    Set pbAreDevToolsEnabled of oWebView2BrowserCtrl to bChecked
                End_Procedure
                
                Set Checked_State to False
            End_Object

            Object oIsBuiltInErrorPageEnabled_Chk is a CheckBox
                Set Size to 10 50
                Set Location to 329 180
                Set Label to 'pbIsBuiltInErrorPageEnabled'
                Set peAnchors to anBottomLeft
                Set psToolTip to "Reload to activate change."
            
                // Fires whenever the value of the control is changed
                Procedure OnChange
                    Boolean bChecked
                
                    Get Checked_State to bChecked
                    
                    Set pbIsBuiltInErrorPageEnabled of oWebView2BrowserCtrl to bChecked
                End_Procedure
                
                Set Checked_State to True
            End_Object

            Object oIsWebMessageEnabled_Chk is a CheckBox
                Set Size to 10 50
                Set Location to 309 336
                Set Label to 'pbIsWebMessageEnabled'
                Set peAnchors to anBottomLeft
                Set psToolTip to "Reload to activate change."
            
                // Fires whenever the value of the control is changed
                Procedure OnChange
                    Boolean bChecked
                
                    Get Checked_State to bChecked
                    
                    Set pbIsWebMessageEnabled of oWebView2BrowserCtrl to bChecked
                End_Procedure
                
                Set Checked_State to True
            End_Object

            Object oIsZoomControlEnabled_chk is a CheckBox
                Set Size to 10 50
                Set Location to 319 336
                Set Label to 'pbIsZoomControlEnabled'
                Set peAnchors to anBottomLeft
                Set psToolTip to "Reload to activate change."
            
                // Fires whenever the value of the control is changed
                Procedure OnChange
                    Boolean bChecked
                
                    Get Checked_State to bChecked
                    
                    Set pbIsZoomControlEnabled of oWebView2BrowserCtrl to bChecked
                End_Procedure
                
                Set Checked_State to True
            End_Object
            
            Object oAreHostObjectsAllowed_Chk is a CheckBox
                Set Size to 10 50
                Set Location to 329 336
                Set Label to 'pbAreHostObjectsAllowed'
                Set peAnchors to anBottomLeft
                Set psToolTip to "Reload to activate change."
            
                // Fires whenever the value of the control is changed
                Procedure OnChange
                    Boolean bChecked
                
                    Get Checked_State to bChecked
                    
                    Set pbAreHostObjectsAllowed of oWebView2BrowserCtrl to bChecked
                End_Procedure
                
                Set Checked_State to True
            End_Object

            Object oIsScriptEnabled_Chk is a CheckBox
                Set Size to 10 50
                Set Location to 309 463
                Set Label to 'pbIsScriptEnabled'
                Set peAnchors to anBottomLeft
                Set psToolTip to "Reload to activate change."
            
                // Fires whenever the value of the control is changed
                Procedure OnChange
                    Boolean bChecked
                
                    Get Checked_State to bChecked
                    
                    Set pbIsScriptEnabled of oWebView2BrowserCtrl to bChecked
                End_Procedure
                
                Set Checked_State to True
            End_Object

            Object oAreDefaultContextMenusEnabled_Chk is a CheckBox
                Set Size to 10 50
                Set Location to 319 463
                Set Label to 'pbAreDefaultContextMenusEnabled'
                Set peAnchors to anBottomLeft
                Set psToolTip to "Reload to activate change."
            
                // Fires whenever the value of the control is changed
                Procedure OnChange
                    Boolean bChecked
                
                    Get Checked_State to bChecked
                    
                    Set pbAreDefaultContextMenusEnabled of oWebView2BrowserCtrl to bChecked
                End_Procedure
                
                Set Checked_State to True
            End_Object

            Object oIsStatusBarEnabled_Chk is a CheckBox
                Set Size to 10 50
                Set Location to 329 463
                Set Label to 'pbIsStatusBarEnabled'
                Set peAnchors to anBottomLeft
                Set psToolTip to "Reload to activate change."
            
                // Fires whenever the value of the control is changed
                Procedure OnChange
                    Boolean bChecked
                
                    Get Checked_State to bChecked
                    
                    Set pbIsStatusBarEnabled of oWebView2BrowserCtrl to bChecked
                End_Procedure
                
                Set Checked_State to True
            End_Object
            
            Object oAreBrowserAcceleratorKeysEnabled_Chk is a CheckBox
                Set Size to 10 50
                Set Location to 339 463
                Set Label to 'pbAreBrowserAcceleratorKeysEnabled'
                Set peAnchors to anBottomLeft
                Set psToolTip to "Reload to activate change."
            
                // Fires whenever the value of the control is changed
                Procedure OnChange
                    Boolean bChecked
                
                    Get Checked_State to bChecked
                    
                    Set pbAreBrowserAcceleratorKeysEnabled of oWebView2BrowserCtrl to bChecked
                End_Procedure
                
                Set Checked_State to True
            End_Object

            Object oPopupStyleCombo is a ComboForm
                Set Size to 12 77
                Set Location to 320 84
                Set Value to "Custom Popup"
                Set peAnchors to anBottomLeft
                Set Entry_State to False
            
                // Combo_Fill_List is called when the list needs filling
                Procedure Combo_Fill_List
                    // Fill the combo list with Send Combo_Add_Item
                    Send Combo_Add_Item "Standard Popups"
                    Send Combo_Add_Item "No Popups"
                    
                    Send Combo_Add_Item "Custom Popups"
                End_Procedure
            
            End_Object

            Object oZoomFactorFrm is a Form
                Set Size to 13 56
                Set Location to 338 66
                Set Value to 1
                Set Form_Datatype to Mask_Numeric_Window
                Set Form_Mask to "*#.##"
                Set Prompt_Button_Mode to PB_PromptOn
                Set Prompt_Button_Value to "Set"
                Set Label to "Zoom factor:"
                Set peAnchors to anBottomLeft

                Procedure Prompt
                    Real rVal
                    
                    Get Value to rVal
                    
                    Set prZoomFactor of oWebView2BrowserCtrl to rVal
                End_Procedure
                
            End_Object

            Object oSaveAsPngBtn is a Button
                Set Size to 14 68
                Set Location to 338 124
                Set Label to 'Save screen as PNG'
                Set peAnchors to anBottomLeft
            
                // fires when the button is clicked
                Procedure OnClick
                    Send CapturePreview of oWebView2BrowserCtrl OLECOREWEBVIEW2_CAPTURE_PREVIEW_IMAGE_FORMAT_PNG
                End_Procedure
            
            End_Object
            
            Object oSaveAsPngBtn is a Button
                Set Size to 14 68
                Set Location to 338 193
                Set Label to 'Save screen as JPG'
                Set peAnchors to anBottomLeft
            
                // fires when the button is clicked
                Procedure OnClick
                    Send CapturePreview of oWebView2BrowserCtrl OLECOREWEBVIEW2_CAPTURE_PREVIEW_IMAGE_FORMAT_JPEG
                End_Procedure
            
            End_Object
           
            
        End_Object

        Object oSplitterContainerChild2 is a cSplitterContainerChild
            Object oClearLogBtn is a Button
                Set Size to 14 176
                Set Location to 4 3
                Set Label to 'Clear Log'
                Set peAnchors to anTopLeftRight
            
                // fires when the button is clicked
                Procedure OnClick
                    Set Value of oLogWindow to ""
                End_Procedure
            
            End_Object

            Object oLogWindow is a cTextEdit
                Set Size to 334 176
                Set Location to 20 3
                Set peAnchors to anAll
                
                Procedure WriteLog String sLog
                    Send AppendTextLn sLog
                End_Procedure
            End_Object
        End_Object
    End_Object

    Procedure OnF1Key 
        Send DoLog "Handled f1 key!"
    End_Procedure
    
    On_Key Key_F1 Send OnF1Key
    
    Procedure DoLog String s1 String s2 String s3 String s4 String s5 String s6 String s7 String s8 String s9
        String sLog sParam
        Integer iArg
        
        Send WriteLog of oLogWindow s1
        
        For iArg from 2 to Num_Arguments
            Move iArg& to sParam
            Move (sLog * sParam) to sLog
        Loop
        
        Send WriteLog of oLogWindow sLog
    End_Procedure
    
    Procedure UpdateUrl String sValue
        Send UpdateUrl of (oMenuItemUrl(oCJToolbar1(oCJCommandBarSystem1(oSplitterContainerChild1(oSplitterContainer1))))) sValue        
    End_Procedure
    
    Procedure NavigateUrl String sUrl
        If (not(sUrl contains "://")) Begin
            Move ("https://" + sUrl) to sUrl
        End
        
        Send Navigate of oWebView2BrowserCtrl sUrl
    End_Procedure
End_Object
