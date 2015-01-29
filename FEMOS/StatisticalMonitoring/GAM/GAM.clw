; CLW file contains information for the MFC ClassWizard

[General Info]
Version=1
LastClass=CGAMView
LastTemplate=CDialog
NewFileInclude1=#include "stdafx.h"
NewFileInclude2=#include "GAM.h"
LastPage=0

ClassCount=17
Class1=CGAMApp
Class2=CGAMDoc
Class3=CGAMView
Class4=CMainFrame

ResourceCount=13
Resource1=IDD_ABOUTBOX
Resource2=IDR_MAINFRAME
Class5=CAboutDlg
Resource3=IDR_MAINFRAME (English (U.S.))
Class6=CSCBar
Class7=CMiniMap
Class8=CDataView
Class9=CGraph
Resource4=IDD_DIALOG_ADDCHILDS
Resource5=IDR_TOOLBAR_FONT (English (U.S.))
Resource6=IDD_DIALOG_LINKPROPER
Resource7=IDD_DIALOG_PROPERTIES
Resource8=IDD_DIALOG_OPTION (English (U.S.))
Resource9=IDD_DIALOG_LINKPROPER (English (U.S.))
Class10=CAddChild
Class11=CLinkProper
Class12=CProperties
Class13=CMyListCtrl
Resource10=IDD_DIALOG_ADDCHILDS (English (U.S.))
Class14=CComboFont
Class15=CResult
Resource11=IDD_DIALOG_PROPERTIES (English (U.S.))
Class16=COptionDialog
Resource12=IDD_ABOUTBOX (English (U.S.))
Class17=CSplash
Resource13=IDD_SPLASH (English (U.S.))

[CLS:CGAMApp]
Type=0
HeaderFile=GAM.h
ImplementationFile=GAM.cpp
Filter=N
LastObject=CGAMApp

[CLS:CGAMDoc]
Type=0
HeaderFile=GAMDoc.h
ImplementationFile=GAMDoc.cpp
Filter=N
LastObject=CGAMDoc
BaseClass=CDocument
VirtualFilter=DC

[CLS:CGAMView]
Type=0
HeaderFile=GAMView.h
ImplementationFile=GAMView.cpp
Filter=C
LastObject=CGAMView
BaseClass=CScrollView
VirtualFilter=VWC


[CLS:CMainFrame]
Type=0
HeaderFile=MainFrm.h
ImplementationFile=MainFrm.cpp
Filter=W
LastObject=CMainFrame
BaseClass=CFrameWnd
VirtualFilter=fWC




[CLS:CAboutDlg]
Type=0
HeaderFile=GAM.cpp
ImplementationFile=GAM.cpp
Filter=D
LastObject=CAboutDlg

[DLG:IDD_ABOUTBOX]
Type=1
ControlCount=4
Control1=IDC_STATIC,static,1342177283
Control2=IDC_STATIC,static,1342308352
Control3=IDC_STATIC,static,1342308352
Control4=IDOK,button,1342373889
Class=CAboutDlg

[MNU:IDR_MAINFRAME]
Type=1
Class=CMainFrame
Command3=ID_FILE_SAVE
Command4=ID_FILE_SAVE_AS
Command5=ID_FILE_PRINT
Command6=ID_FILE_PRINT_PREVIEW
Command7=ID_FILE_PRINT_SETUP
Command8=ID_FILE_MRU_FILE1
Command9=ID_APP_EXIT
Command10=ID_EDIT_UNDO
Command11=ID_EDIT_CUT
Command12=ID_EDIT_COPY
Command13=ID_EDIT_PASTE
Command14=ID_VIEW_TOOLBAR
Command15=ID_VIEW_STATUS_BAR
CommandCount=16
Command1=ID_FILE_NEW
Command2=ID_FILE_OPEN
Command16=ID_APP_ABOUT

[ACL:IDR_MAINFRAME]
Type=1
Class=CMainFrame
Command1=ID_FILE_NEW
Command2=ID_FILE_OPEN
Command3=ID_FILE_SAVE
Command4=ID_FILE_PRINT
Command5=ID_EDIT_UNDO
Command6=ID_EDIT_CUT
Command7=ID_EDIT_COPY
Command8=ID_EDIT_PASTE
Command9=ID_EDIT_UNDO
Command10=ID_EDIT_CUT
Command11=ID_EDIT_COPY
Command12=ID_EDIT_PASTE
CommandCount=14
Command13=ID_NEXT_PANE
Command14=ID_PREV_PANE


[TB:IDR_MAINFRAME (English (U.S.))]
Type=1
Class=?
Command1=ID_FILE_NEW
Command2=ID_FILE_OPEN
Command3=ID_FILE_SAVE
Command4=ID_FILE_PRINT
Command5=ID_FILE_PRINT_PREVIEW
Command6=ID_EDIT_ADDCHILD
Command7=ID_EDIT_ADDCHILDS
Command8=ID_EDIT_ADDLINK
Command9=ID_EDIT_REMOVEITEM
Command10=ID_EDIT_CALCULATE
Command11=ID_VIEW_GRID
Command12=ID_FONT_COMBO
Command13=ID_VIEW_BOLD
Command14=ID_VIEW_ITALIC
Command15=ID_VIEW_UNDERLINE
Command16=ID_APP_ABOUT
CommandCount=16

[MNU:IDR_MAINFRAME (English (U.S.))]
Type=1
Class=?
Command1=ID_FILE_NEW
Command2=ID_FILE_OPEN
Command3=ID_FILE_SAVE
Command4=ID_FILE_SAVE_AS
Command5=ID_FILE_PRINT
Command6=ID_FILE_PRINT_PREVIEW
Command7=ID_FILE_PRINT_SETUP
Command8=ID_FILE_MRU_FILE1
Command9=ID_APP_EXIT
Command10=ID_EDIT_CALCULATE
Command11=ID_EDIT_ADDCHILD
Command12=ID_EDIT_ADDCHILDS
Command13=ID_EDIT_ADDLINK
Command14=ID_EDIT_REMOVEITEM
Command15=ID_EDIT_TEXTEDIT
Command16=ID_EDIT_PROPERTIES
Command17=ID_EDIT_SELECT_ALL
Command18=ID_VIEW_TOOLBAR
Command19=ID_VIEW_STATUS_BAR
Command20=ID_VIEW_GRID
Command21=ID_VIEW_CHANGEFONT
Command22=ID_VIEW_DATA
Command23=ID_VIEW_MINIMAP
Command24=ID_VIEW_RESULT
Command25=ID_VIEW_GRAPH
Command26=ID_VIEW_BOLD
Command27=ID_VIEW_ITALIC
Command28=ID_VIEW_UNDERLINE
Command29=ID_TOOL_OPTION
Command30=ID_APP_ABOUT
CommandCount=30

[ACL:IDR_MAINFRAME (English (U.S.))]
Type=1
Class=?
Command1=ID_FILE_MRU_FILE1
Command2=ID_EDIT_SELECT_ALL
Command3=ID_VIEW_GRID
Command4=ID_FILE_MRU_FILE1
Command5=ID_EDIT_ADDLINK
Command6=ID_FILE_NEW
Command7=ID_FILE_OPEN
Command8=ID_FILE_PRINT
Command9=ID_FILE_SAVE
Command10=ID_EDIT_REMOVEITEM
Command11=ID_EDIT_TEXTEDIT
Command12=ID_EDIT_CALCULATE
Command13=ID_EDIT_ADDCHILD
Command14=ID_EDIT_ADDCHILDS
Command15=ID_EDIT_PROPERTIES
CommandCount=15

[DLG:IDD_ABOUTBOX (English (U.S.))]
Type=1
Class=CAboutDlg
ControlCount=4
Control1=IDC_STATIC,static,1342177283
Control2=IDC_STATIC,static,1342308480
Control3=IDC_STATIC,static,1342308352
Control4=IDOK,button,1342373889

[CLS:CSCBar]
Type=0
HeaderFile=SCBar.h
ImplementationFile=SCBar.cpp
BaseClass=generic CWnd
Filter=W
LastObject=CSCBar

[CLS:CMiniMap]
Type=0
HeaderFile=MiniMap.h
ImplementationFile=MiniMap.cpp
BaseClass=CSCBar
Filter=W
LastObject=CMiniMap

[CLS:CGraph]
Type=0
HeaderFile=Graph.h
ImplementationFile=Graph.cpp
BaseClass=CSCBar
Filter=W
LastObject=CGraph

[CLS:CDataView]
Type=0
HeaderFile=DataView.h
ImplementationFile=DataView.cpp
BaseClass=CSCBar
Filter=W
LastObject=CDataView

[DLG:IDD_DIALOG_ADDCHILDS]
Type=1
Class=CAddChild
ControlCount=0

[DLG:IDD_DIALOG_LINKPROPER]
Type=1
Class=CLinkProper
ControlCount=2
Control1=IDOK,button,1342242817
Control2=IDCANCEL,button,1342242816

[DLG:IDD_DIALOG_PROPERTIES]
Type=1
Class=CProperties
ControlCount=2
Control1=IDOK,button,1342242817
Control2=IDCANCEL,button,1342242816

[DLG:IDD_DIALOG_ADDCHILDS (English (U.S.))]
Type=1
Class=CAddChild
ControlCount=5
Control1=IDC_EDIT_ITEMNO,edit,1350639745
Control2=IDC_SPIN_ITEMNO,msctls_updown32,1342177463
Control3=IDOK,button,1342242817
Control4=IDCANCEL,button,1342242816
Control5=IDC_STATIC,static,1342308352

[DLG:IDD_DIALOG_LINKPROPER (English (U.S.))]
Type=1
Class=CLinkProper
ControlCount=8
Control1=IDC_EDIT_VALUE,edit,1350631553
Control2=IDOK,button,1342242816
Control3=IDCANCEL,button,1342242816
Control4=IDC_EDIT_PARENT_NAME,edit,1350568069
Control5=IDC_EDIT_CHILD_NAME,edit,1350568069
Control6=IDC_STATIC,static,1342308354
Control7=IDC_STATIC,static,1342308354
Control8=IDC_STATIC,static,1342308354

[DLG:IDD_DIALOG_PROPERTIES (English (U.S.))]
Type=1
Class=CProperties
ControlCount=19
Control1=IDOK,button,1342242816
Control2=IDCANCEL,button,1342242816
Control3=IDC_EDIT_NAME,edit,1350631557
Control4=IDC_EDIT_VALUE,edit,1350631553
Control5=IDC_RADIO_ASCENDING,button,1342308361
Control6=IDC_RADIO_DESCENDING,button,1342177289
Control7=IDC_RADIO_ACCELUP,button,1342308361
Control8=IDC_RADIO_ACCELDOWN,button,1342177289
Control9=IDC_EDIT_DEPTH,edit,1350639745
Control10=IDC_SPIN_DEPTH,msctls_updown32,1342177463
Control11=IDC_STATIC,static,1342308354
Control12=IDC_STATIC,static,1342308354
Control13=IDC_STATIC,static,1342308354
Control14=IDC_STATIC,static,1342308354
Control15=IDC_EDIT_ID,edit,1350641793
Control16=IDC_EDIT_LEVEL,edit,1350641793
Control17=IDC_STATIC,button,1342177287
Control18=IDC_STATIC,button,1342177287
Control19=IDC_STATIC,button,1342177287

[CLS:CAddChild]
Type=0
HeaderFile=AddChild.h
ImplementationFile=AddChild.cpp
BaseClass=CDialog
Filter=D
LastObject=CAddChild
VirtualFilter=dWC

[CLS:CLinkProper]
Type=0
HeaderFile=LinkProper.h
ImplementationFile=LinkProper.cpp
BaseClass=CDialog
Filter=D
LastObject=CLinkProper
VirtualFilter=dWC

[CLS:CProperties]
Type=0
HeaderFile=Properties.h
ImplementationFile=Properties.cpp
BaseClass=CDialog
Filter=D
LastObject=CProperties
VirtualFilter=dWC

[CLS:CMyListCtrl]
Type=0
HeaderFile=MyListCtrl.h
ImplementationFile=MyListCtrl.cpp
BaseClass=CListCtrl
Filter=W
LastObject=CMyListCtrl
VirtualFilter=FWC

[TB:IDR_TOOLBAR_FONT (English (U.S.))]
Type=1
Class=?
Command1=ID_FONT_COMBO
Command2=ID_FONT_BOLD
Command3=ID_FONT_ITALIC
Command4=ID_FONT_UNDERLINE
CommandCount=4

[CLS:CComboFont]
Type=0
HeaderFile=ComboFont.h
ImplementationFile=ComboFont.cpp
BaseClass=CComboBox
Filter=W
LastObject=CComboFont
VirtualFilter=cWC

[CLS:CResult]
Type=0
HeaderFile=Result.h
ImplementationFile=Result.cpp
BaseClass=CSCBar
Filter=W
LastObject=CResult

[CLS:COptionDialog]
Type=0
HeaderFile=OptionDialog.h
ImplementationFile=OptionDialog.cpp
BaseClass=CDialog
Filter=D
LastObject=COptionDialog

[DLG:IDD_DIALOG_OPTION (English (U.S.))]
Type=1
Class=COptionDialog
ControlCount=2
Control1=IDOK,button,1342242817
Control2=IDCANCEL,button,1342242816

[DLG:IDD_SPLASH (English (U.S.))]
Type=1
Class=CSplash
ControlCount=3
Control1=IDC_PROGRESS_SPLASH,msctls_progress32,1350565888
Control2=IDC_STATIC_PROGRESS,static,1342308353
Control3=IDC_STATIC,static,1342177294

[CLS:CSplash]
Type=0
HeaderFile=Splash.h
ImplementationFile=Splash.cpp
BaseClass=CDialog
Filter=D
VirtualFilter=dWC
LastObject=CSplash

