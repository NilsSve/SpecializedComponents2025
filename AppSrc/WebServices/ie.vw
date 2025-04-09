// This sample shows how to use Microsoft Internet Explorer ActiveX control.
//
// The control was selected and imported using the IDE's import
// ActiveX feature. We created a non-data aware control and placed it in the
// workspaces local area. No changes were made to the imported class.
//
// This might have been a good classing for trimming (i.e. going into the class and
// removing all of the methods that are not needed). Most of this interface is not
// needed. To keep this simple we have not done this.

Use dfClient.pkg
Use Windows.pkg
Use cComWebBrowser.pkg
Use cToolbar.pkg

ACTIVATE_VIEW Activate_oMSIEExplorerVw FOR oMSIEExplorerVw

Object oMSIEExplorerVw is a dbView

    On_Key kCancel Send Request_Cancel
    
    // Create messages for the most commonly used browser features. This allows us
    // to create buttons that send these messages. In all cases, these messages are
    // passed directly on to IE control. Note that none of these messages should be sent
    // if the IE control is not active.
    
    // Get the value from the URL form window and point the browser to it.
    
    Procedure Navigate
        String sURL
        Get Value of oURL To sURL
        Send ComNavigate of oWebBrowser sURL 0 0 0 0
    End_Procedure
    
    // Browse forward
    Procedure GoForward
        Send ComGoForward of oWebBrowser
    End_Procedure
    
    // Browse back
    Procedure GoBack
        Send ComGoBack of oWebBrowser
    End_Procedure
    
    // Search
    Procedure GoSearch
        Send ComGoSearch of oWebBrowser
    End_Procedure
    
    // goto Home page
    Procedure GoHome
        Send ComGoHome of oWebBrowser
    End_Procedure
    
    // Refresh contents
    Procedure Refresh
        Send ComRefresh of oWebBrowser
    End_Procedure
    
    // Stop
    Procedure Stop
        Send ComStop of oWebBrowser
    End_Procedure
    
    // Create a tool bar that supports the various browser options.
    Object oInternetToolBar is a cToolBar
        Set pbInMdiPanel to False  // Not used with MDI, must set this to false
        set peAnchors to anTopLeftRight
    
        // define an image list for the toolbar
        Object oImages is a cImageList
            Set piMaxImages To 7
            Procedure OnCreate
                Integer iVoid
                Get AddTransparentImage "ieHome.bmp"  clLtGray  To iVoid // 0
                Get AddTransparentImage "ieRef.bmp"   clLtGray  To iVoid // 1
                Get AddTransparentImage "ieNext.bmp"  clLtGray  To iVoid // 2
                Get AddTransparentImage "ieBack.bmp"  clLtGray  To iVoid // 3
                Get AddTransparentImage "ieStop.bmp"  clLtGray  To iVoid // 4
                Get AddTransparentImage "Find16.bmp"  clFuchsia To iVoid // 5
            End_Procedure
        End_Object
    
        Set phoImageList To oImages // connect imagelist to toobar
    
        // Add the various buttons
        Object oPrev is a cToolbarButton
            Set psTooltip To "Previous page"
            Set piImage To 3
            Set pbEnabled to False
            Procedure OnClick
                Delegate Send GoBack
            End_Procedure
    
        End_Object
    
        Object oNext is a cToolbarButton
            Set psTooltip To "Next page"
            Set piImage To 2
            Set pbEnabled to False
            Procedure OnClick
                Delegate Send GoForward
            End_Procedure
        End_Object
    
        Object oStop is a cToolbarButton
            Set psTooltip To "Stop"
            Set piImage To 4
            Procedure OnClick
                Delegate Send Stop
            End_Procedure
        End_Object
    
        Object oRefresh is a cToolbarButton
            Set psTooltip To "Refresh"
            Set piImage To 1
            Procedure OnClick
                Send Refresh
            End_Procedure
        End_Object
    
        Object oHome is a cToolbarButton
            Set psTooltip To "Home page"
            Set piImage To 0
            Procedure OnClick
                Send GoHome
            End_Procedure
        End_Object
    
        Object oSearch is a cToolbarButton
            Set psTooltip To "Search"
            Set piImage To 5
            Procedure OnClick
                Send GoSearch
            End_Procedure
        End_Object
    
        // enable and disable various buttons. These will be sent
        // by events triggered in the browser object
        Procedure EnableStop Boolean bEnabled
            Set pbEnabled of oStop to bEnabled
        End_Procedure
    
        Procedure EnableNext boolean bEnabled
            Set pbEnabled of oNext to bEnabled
        End_Procedure
    
        Procedure EnablePrev boolean bEnabled
            Set pbEnabled of oPrev to bEnabled
        End_Procedure
    
    End_Object  // oInternetToolBar

    Set Border_Style to Border_Thick
    Set Label to "Microsoft Internet Explorer"
    Set Location to 1 1
    Set Size to 337 633
    Set piMinSize to 100 200

    Object oURL is a Form
        Set Label to "Address:"
        Set Size to 14 527
        Set Location to 18 32
        Set peAnchors to anTopLeftRight
        Set Label_Col_Offset to 0
        Set Label_Justification_Mode to jMode_Right

        On_Key KEnter Send Navigate
        
        Procedure Combo_Edit_Change
            send AddToHistory
        End_Procedure
        
        Procedure AddToHistory
            Integer iPos
            String sAddr
        
            Get Value of oURL to sAddr
            Get Combo_Item_Matching sAddr to iPos
            // if it does not exist, add it
            If (iPos=-1) Begin
                Send Combo_Insert_Item iPos sAddr
            End
        End_Procedure

    End_Object    // oURL

    Object oGo is a Button
        Set Label to "Go"
        Set Size to 14 55
        Set Location to 18 561
        Set peAnchors to anTopRight
        Set Bitmap to "GoGreen.bmp /t"

        Procedure OnClick
            String sName
        
            Get Value of oUrl to sName
            If (sName <> "") Begin
                Send Navigate
            End
        End_Procedure // OnClick

    End_Object    // oGo

    Object oWebBrowser is a cComWebBrowser
        set Focus_Mode to NonFocusable
        On_Key Key_Tab Send Default_Key

        Set Size to 264 607
        Set Location to 34 10
        Set peAnchors to anAll

        // When the control is created, point to a default web site
        Procedure OnCreate
            forward send OnCreate
            Send ComNavigate "www.geomonster.com/Cp/Login.aspx?ReturnUrl=%2fCp%2fRequestTrialKey.aspx" 0 0 0 0
        End_Procedure // Activating
        
        // Document title changed.
        Procedure OnComTitleChange String lText
             Set Value of oINFO To lText
        End_Procedure
        
        // Statusbar text changed.
        Procedure OnComStatusTextChange String lText
            Set Value of oINFO To lText
        End_Procedure
        
        // Fired when a new hyperlink is being navigated to.
        // Procedure OnComBeforeNavigate String lURL DWORD lFlags String lTargetFrameName ;
        //    OLEVariant lPostData String lHeaders Boolean lCancel
        Procedure OnComBeforeNavigate String llURL Integer llFlags String llTargetFrameName ;
            Variant llPostData String llHeaders Variant llCancel
        
            String sInfo
            
            Move "" To sInfo
            Move ("Connecting to" * llURL) to sInfo
            Set Value of oINFO To sInfo
            Send EnableStop of oInternetToolbar True
        End_Procedure
        
        // Fired when a new hyperlink is being navigated to.
        Procedure OnComNavigateComplete String lURL
        End_Procedure
        
        // Download of page complete.
        Procedure OnComDownloadComplete
        //    Send EnableStop of oInternetToolbar False
        End_Procedure
        
        // The enabled state of a command changed
        //Procedure OnComCommandStateChange DWORD lCommand Boolean lEnable
        Procedure OnComCommandStateChange Integer llCommand Boolean llEnable
            If (llCommand=OLECSC_NAVIGATEFORWARD) Begin
                Send EnableNext Of oInternetToolbar (If(llEnable,True,False))
            End
            If (llCommand=OLECSC_NAVIGATEBACK) Begin
                Send EnablePrev of oInternetToolbar (If(llEnable,True,False))
            End
        End_Procedure

    End_Object    // oWebBrowser

    Object oINFO is a Form
        Set Enabled_State to False
        set Focus_Mode to NonFocusable
        Set Size to 13 607
        Set Location to 302 9
        Set peAnchors to anBottomLeftRight
        Set Label_Col_Offset to 0
        Set Label_Justification_Mode to jMode_Right
    End_Object    // oINFO

End_Object    // oMSIEExplorerVw
