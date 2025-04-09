Use Windows.pkg
Use DFClient.pkg
Use cCJGrid.pkg
Use cCJGridColumn.pkg

Use Collate\ICUFunctions.pkg

Deferred_View Activate_oListOfLocales for ;
Object oListOfLocales is a dbView

    Set Border_Style to Border_Thick
    Set Size to 196 282
    Set Location to 2 2
    Set Label to "List of Available Locales"
    Set piMinSize to 196 282

    Object oLocaleList is a cCJGrid
        Set Size to 182 266
        Set Location to 11 8
        Set pbReadOnly to True
        Set pbSelectionEnable to True 
        Set peAnchors to anAll

        Object oRowNumberCol is a cCJGridColumn
            Set piWidth to 25
            Set psCaption to ""
        End_Object

        Object oLocaleCodeCol is a cCJGridColumn
            Set piWidth to 40
            Set psCaption to "Locale Code"
        End_Object

        Object oLocaleNameCol is a cCJGridColumn
            Set piWidth to 100
            Set psCaption to "Locale Display Name"
        End_Object
    
        Procedure LoadLocales 
            tDataSourceRow[] TheData
            Integer iRow iCode iName
            tLocales[] ListOfLocales
            Integer iNumLocales iLocaleRow 
            
            // Get the datasource indexes of the various columns
            Get piColumnId of oRowNumberCol to iRow
            Get piColumnId of oLocaleCodeCol to iCode
            Get piColumnId of oLocaleNameCol to iName
            
            // Load all data into the datasource array
            Get ListOfLocalesForDefaultLgg to ListOfLocales
            Move (SizeOfArray(ListOfLocales)) to iNumLocales
            For iLocaleRow from 0 to (iNumLocales - 1)
                Move (iLocaleRow + 1) to TheData[iLocaleRow].sValue[iRow]
                Move ListOfLocales[iLocaleRow].sLocaleCode to TheData[iLocaleRow].sValue[iCode]
                Move ListOfLocales[iLocaleRow].sLocalDisplayName to TheData[iLocaleRow].sValue[iName]
            Loop
            
            // Initialize Grid with new data
            Send InitializeData TheData
            Send MovetoFirstRow
        End_Procedure
    
        Procedure Activating
            Forward Send Activating
            Send LoadLocales
        End_Procedure
    End_Object

Cd_End_Object
