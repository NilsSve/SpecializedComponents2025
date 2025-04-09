Use Windows.pkg
Use cWebView2Browser.pkg

Class cPopupBrowser is a cWebView2Browser
    Procedure Construct_Object
        Forward Send Construct_Object
        
        Property Handle phoStatusTxt 0
    End_Procedure
    
    Procedure OnCreate
        String sPath
        
        Forward Send OnCreate
        
        Get psAppHtmlPath of (phoWorkspace(ghoApplication)) to sPath
        Send SetVirtualHostNameToFolderMapping "localdemo.asset" sPath OLECOREWEBVIEW2_HOST_RESOURCE_ACCESS_KIND_ALLOW
    End_Procedure

    Procedure OnNavigationCompleted UBigInt iNavigationId String sUrl Boolean bIsSuccess OLECOREWEBVIEW2_WEB_ERROR_STATUS eWebErrorStatus
        If (phoStatusTxt(Self) > 0) ;
            Set Label of (phoStatusTxt(Self)) to sUrl
    End_Procedure

    Procedure OnWindowCloseRequested
        Forward Send OnWindowCloseRequested
        
        Delegate Send Close_Panel
    End_Procedure
    
    Procedure OnDocumentTitleChanged String sTitle
        Delegate Set Label to sTitle
    End_Procedure
End_Class


Function CreateCustomPopupView tWebView2_WindowFeatures requestedFeatures Returns Handle
    Handle hoResult hoView
    
    
    Object oWebView2PopupView is a View
        Set Label to "PopupWindow"
        Set Size to 328 757
        Set Location to 5 7
        Set piMinSize to 100 100
        Set Border_Style to Border_Thick
        
        Move Self to hoView
    
        Object oPopupStatusTxt is a TextBox
            Set Auto_Size_State to False
            Set Size to 10 746
            Set Location to 4 5
            Set Label to '...'
            Set Justification_Mode to JMode_Left
            Set peAnchors to anTopLeftRight
        End_Object
        
        Object oPopupBrowser is a cPopupBrowser
            Set Size to 307 748
            Set Location to 17 4
//            Set peAutoCreate to acAutoCreate
            Set peAnchors to anAll    
    
            Set phoStatusTxt to oPopupStatusTxt
            
            Move Self to hoResult        
        End_Object
    
    End_Object
    
    
    Send Activate_View of hoView
    
    If (requestedFeatures.bHasSize) Begin
        Set GuiSize of hoView to requestedFeatures.iHeight requestedFeatures.iWidth
    End
    Function_Return hoResult
End_Function
