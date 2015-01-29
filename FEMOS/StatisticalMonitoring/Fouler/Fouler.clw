; CLW file contains information for the MFC ClassWizard

[General Info]
Version=1
LastClass=CAnalysis
LastTemplate=CPropertySheet
NewFileInclude1=#include "stdafx.h"
NewFileInclude2=#include "Fouler.h"
LastPage=0

ClassCount=14
Class1=CFoulerApp
Class2=CFoulerDoc
Class3=CFoulerView
Class4=CMainFrame
Class7=CAboutDlg

ResourceCount=16
Resource1=IDD_ABOUTBOX
Resource2=IDR_PLAYER
Class5=CChildFrame
Class6=CLeftView
Resource3=IDR_FOULERTYPE
Class8=CNewData
Resource4=IDR_MAINFRAME
Class9=CSplash
Resource5=IDD_DIALOG_NEWDATA
Resource6=IDD_SPLASH
Resource7=IDD_DIALOG_NEWDATA (English (U.S.))
Resource8=IDD_DIALOG1 (English (U.S.))
Resource9=IDD_ABOUTBOX (English (U.S.))
Resource10=IDD_SPLASH (English (U.S.))
Resource11=IDR_FOULERTYPE (English (U.S.))
Resource12=IDD_DIALOG_OPTION_GENERAL (English (U.S.))
Class10=CAnalysis
Resource13=IDD_DIALOG_ANALYSIS (English (U.S.))
Class11=CFieldSelect
Resource14=IDD_DIALOG_FIELDSELECT (English (U.S.))
Resource15=IDR_MAINFRAME (English (U.S.))
Class12=COptionColor
Class13=COptionGeneral
Class14=COption
Resource16=IDD_DIALOG_OPTION_COLOR (English (U.S.))

[CLS:CFoulerApp]
Type=0
HeaderFile=Fouler.h
ImplementationFile=Fouler.cpp
Filter=N
BaseClass=CWinApp
VirtualFilter=AC
LastObject=CFoulerApp

[CLS:CFoulerDoc]
Type=0
HeaderFile=FoulerDoc.h
ImplementationFile=FoulerDoc.cpp
Filter=N
BaseClass=CDocument
VirtualFilter=DC
LastObject=ID_EDIT_CUT

[CLS:CFoulerView]
Type=0
HeaderFile=FoulerView.h
ImplementationFile=FoulerView.cpp
Filter=C
BaseClass=CScrollView
VirtualFilter=VWC
LastObject=CFoulerView


[CLS:CMainFrame]
Type=0
HeaderFile=MainFrm.h
ImplementationFile=MainFrm.cpp
Filter=T
LastObject=CMainFrame
BaseClass=CMDIFrameWnd
VirtualFilter=fWC


[CLS:CChildFrame]
Type=0
HeaderFile=ChildFrm.h
ImplementationFile=ChildFrm.cpp
Filter=M
LastObject=CChildFrame
BaseClass=CMDIChildWnd
VirtualFilter=mfWC

[CLS:CLeftView]
Type=0
HeaderFile=LeftView.h
ImplementationFile=LeftView.cpp
Filter=T
LastObject=CLeftView
BaseClass=CListView
VirtualFilter=VWC

[CLS:CAboutDlg]
Type=0
HeaderFile=Fouler.cpp
ImplementationFile=Fouler.cpp
Filter=D
LastObject=IDC_BUTTON_HOMEPAGE
BaseClass=CDialog
VirtualFilter=dWC

[DLG:IDD_ABOUTBOX]
Type=1
Class=CAboutDlg
ControlCount=2
Control1=IDC_BUTTON_HOMEPAGE,button,1342242827
Control2=IDC_STATIC,static,1342177294

[MNU:IDR_MAINFRAME]
Type=1
Class=CMainFrame
Command1=ID_FILE_NEW
Command2=ID_FILE_OPEN
Command3=ID_FILE_PRINT_SETUP
Command4=ID_FILE_MRU_FILE1
Command5=ID_APP_EXIT
Command6=ID_VIEW_TOOLBAR
Command7=ID_VIEW_STATUS_BAR
Command8=ID_TOOL_OPTION
Command9=ID_APP_ABOUT
CommandCount=9

[TB:IDR_MAINFRAME]
Type=1
Class=CMainFrame
Command1=ID_EDIT_NEWDATA
Command2=ID_FILE_OPEN
Command3=ID_FILE_SAVE
Command4=ID_FILE_PRINT
Command5=ID_EDIT_PLAY
Command6=ID_EDIT_PAUSE
Command7=ID_APP_ABOUT
CommandCount=7

[MNU:IDR_FOULERTYPE]
Type=1
Class=CFoulerView
Command1=ID_FILE_NEW
Command2=ID_FILE_OPEN
Command3=ID_FILE_CLOSE
Command4=ID_FILE_SAVE
Command5=ID_FILE_SAVE_AS
Command6=ID_FILE_PRINT
Command7=ID_FILE_PRINT_PREVIEW
Command8=ID_FILE_PRINT_SETUP
Command9=ID_FILE_MRU_FILE1
Command10=ID_APP_EXIT
Command11=ID_EDIT_NEWDATA
Command12=ID_EDIT_PLAY
Command13=ID_EDIT_PAUSE
Command14=ID_VIEW_TOOLBAR
Command15=ID_VIEW_STATUS_BAR
Command16=ID_VIEW_HISTOGRAM
Command17=ID_VIEW_SHEWART
Command18=ID_VIEW_CUSUM
Command19=ID_VIEW_SPRT
Command20=ID_TOOL_OPTION
Command21=ID_WINDOW_NEW
Command22=ID_WINDOW_CASCADE
Command23=ID_WINDOW_TILE_HORZ
Command24=ID_WINDOW_ARRANGE
Command25=ID_APP_ABOUT
CommandCount=25

[ACL:IDR_MAINFRAME]
Type=1
Class=CMainFrame
Command1=ID_VIEW_HISTOGRAM
Command2=ID_VIEW_SHEWART
Command3=ID_VIEW_CUSUM
Command4=ID_VIEW_SPRT
Command5=ID_EDIT_SELECT_ALL
Command6=ID_EDIT_COPY
Command7=ID_EDIT_NEWDATA
Command8=ID_FILE_OPEN
Command9=ID_FILE_PRINT
Command10=ID_FILE_SAVE
Command11=ID_EDIT_PASTE
Command12=ID_EDIT_UNDO
Command13=ID_EDIT_CUT
Command14=ID_NEXT_PANE
Command15=ID_PREV_PANE
Command16=ID_EDIT_COPY
Command17=ID_EDIT_PASTE
Command18=ID_EDIT_CUT
Command19=ID_EDIT_UNDO
CommandCount=19

[DLG:IDD_DIALOG_NEWDATA]
Type=1
Class=CNewData
ControlCount=22
Control1=IDOK,button,1342242817
Control2=IDCANCEL,button,1342242816
Control3=IDC_EDIT_DATANO,edit,1350631552
Control4=IDC_EDIT_AVERAGE,edit,1350631552
Control5=IDC_EDIT_DEVIATION,edit,1350631552
Control6=IDC_EDIT_MOVERATE,edit,1350631552
Control7=IDC_EDIT_K_CUSUM,edit,1350631552
Control8=IDC_EDIT_H_CUSUM,edit,1350631552
Control9=IDC_EDIT_THETAZERO,edit,1350631552
Control10=IDC_EDIT_THETAONE,edit,1350631552
Control11=IDC_EDIT_ALPHA,edit,1350631552
Control12=IDC_EDIT_BETA,edit,1350631552
Control13=IDC_STATIC,static,1342308354
Control14=IDC_STATIC,static,1342308354
Control15=IDC_STATIC,static,1342308354
Control16=IDC_STATIC,static,1342308354
Control17=IDC_STATIC,static,1342308354
Control18=IDC_STATIC,static,1342308354
Control19=IDC_STATIC,static,1342308354
Control20=IDC_STATIC,static,1342308354
Control21=IDC_STATIC,static,1342308354
Control22=IDC_STATIC,static,1342308354

[CLS:CNewData]
Type=0
HeaderFile=NewData.h
ImplementationFile=NewData.cpp
BaseClass=CDialog
Filter=D
VirtualFilter=dWC
LastObject=CNewData

[DLG:IDD_SPLASH]
Type=1
Class=CSplash
ControlCount=2
Control1=IDC_PROGRESS1,msctls_progress32,1342177281
Control2=IDC_STATIC,static,1342177294

[CLS:CSplash]
Type=0
HeaderFile=Splash.h
ImplementationFile=Splash.cpp
BaseClass=CDialog
Filter=D
LastObject=CSplash
VirtualFilter=dWC

[TB:IDR_PLAYER]
Type=1
Class=?
Command1=ID_EDIT_PLAY
Command2=ID_EDIT_PAUSE
CommandCount=2

[DLG:IDD_ABOUTBOX (English (U.S.))]
Type=1
Class=CAboutDlg
ControlCount=2
Control1=IDC_BUTTON_HOMEPAGE,button,1342242827
Control2=IDC_STATIC,static,1342177294

[TB:IDR_MAINFRAME (English (U.S.))]
Type=1
Class=?
Command1=ID_FILE_NEW
Command2=ID_FILE_OPEN
Command3=ID_FILE_SAVE
Command4=ID_EDIT_CUT
Command5=ID_EDIT_COPY
Command6=ID_EDIT_PASTE
Command7=ID_FILE_PRINT
Command8=ID_EDIT_PLAY
Command9=ID_EDIT_PAUSE
Command10=ID_APP_ABOUT
CommandCount=10

[MNU:IDR_MAINFRAME (English (U.S.))]
Type=1
Class=CMainFrame
Command1=ID_FILE_NEW
Command2=ID_FILE_OPEN
Command3=ID_FILE_PRINT_SETUP
Command4=ID_FILE_MRU_FILE1
Command5=ID_APP_EXIT
Command6=ID_VIEW_TOOLBAR
Command7=ID_VIEW_STATUS_BAR
Command8=ID_TOOL_OPTION
Command9=ID_APP_ABOUT
CommandCount=9

[MNU:IDR_FOULERTYPE (English (U.S.))]
Type=1
Class=CFoulerView
Command1=ID_FILE_NEW
Command2=ID_FILE_OPEN
Command3=ID_FILE_CLOSE
Command4=ID_FILE_SAVE
Command5=ID_FILE_SAVE_AS
Command6=ID_FILE_PRINT
Command7=ID_FILE_PRINT_PREVIEW
Command8=ID_FILE_PRINT_SETUP
Command9=ID_FILE_MRU_FILE1
Command10=ID_APP_EXIT
Command11=ID_EDIT_NEWDATA
Command12=ID_EDIT_PLAY
Command13=ID_EDIT_PAUSE
Command14=ID_EDIT_CLEAR_ALL
Command15=ID_EDIT_ANALYSIS
Command16=ID_VIEW_TOOLBAR
Command17=ID_VIEW_STATUS_BAR
Command18=ID_VIEW_CHANGEFONT
Command19=ID_VIEW_HISTOGRAM
Command20=ID_VIEW_SHEWART
Command21=ID_VIEW_CUSUM
Command22=ID_VIEW_SPRT
Command23=ID_TOOL_OPTION
Command24=ID_WINDOW_CASCADE
Command25=ID_WINDOW_TILE_HORZ
Command26=ID_WINDOW_ARRANGE
Command27=ID_APP_ABOUT
CommandCount=27

[ACL:IDR_MAINFRAME (English (U.S.))]
Type=1
Class=?
Command1=ID_EDIT_INCREASE_SPEED
Command2=ID_EDIT_DECREASE_SPEED
Command3=ID_VIEW_HISTOGRAM
Command4=ID_VIEW_SHEWART
Command5=ID_VIEW_CUSUM
Command6=ID_VIEW_SPRT
Command7=ID_EDIT_SELECT_ALL
Command8=ID_EDIT_COPY
Command9=ID_EDIT_NEWDATA
Command10=ID_FILE_NEW
Command11=ID_FILE_OPEN
Command12=ID_FILE_PRINT
Command13=ID_FILE_SAVE
Command14=ID_EDIT_PASTE
Command15=ID_EDIT_UNDO
Command16=ID_EDIT_CUT
Command17=ID_NEXT_PANE
Command18=ID_PREV_PANE
Command19=ID_EDIT_COPY
Command20=ID_EDIT_PASTE
Command21=ID_EDIT_CUT
Command22=ID_EDIT_UNDO
CommandCount=22

[DLG:IDD_DIALOG_NEWDATA (English (U.S.))]
Type=1
Class=CNewData
ControlCount=13
Control1=IDC_EDIT_DATANO,edit,1350631552
Control2=IDC_SPIN_DATANO,msctls_updown32,1342177462
Control3=IDC_EDIT_AVERAGE,edit,1350631552
Control4=IDC_EDIT_DEVIATION,edit,1350631552
Control5=IDC_EDIT_MOVERATE,edit,1350631552
Control6=IDC_COMBO_DISTRIBUTION,combobox,1344339971
Control7=IDOK,button,1342242817
Control8=IDCANCEL,button,1342242816
Control9=IDC_STATIC,static,1342308354
Control10=IDC_STATIC,static,1342308354
Control11=IDC_STATIC,static,1342308354
Control12=IDC_STATIC,static,1342308354
Control13=IDC_STATIC,static,1342308354

[DLG:IDD_SPLASH (English (U.S.))]
Type=1
Class=CSplash
ControlCount=3
Control1=IDC_PROGRESS1,msctls_progress32,1350565888
Control2=IDC_STATIC,static,1342177294
Control3=IDC_STATIC_SPLASH,static,1342308352

[DLG:IDD_DIALOG1 (English (U.S.))]
Type=1
Class=?
ControlCount=2
Control1=IDOK,button,1342242817
Control2=IDCANCEL,button,1342242816

[DLG:IDD_DIALOG_ANALYSIS (English (U.S.))]
Type=1
Class=CAnalysis
ControlCount=17
Control1=IDC_EDIT_THETAZERO,edit,1350631552
Control2=IDC_EDIT_DEVIATION,edit,1350631552
Control3=IDC_EDIT_K_CUSUM,edit,1350631552
Control4=IDC_EDIT_H_CUSUM,edit,1350631552
Control5=IDC_EDIT_ALPHA,edit,1350631552
Control6=IDC_EDIT_BETA,edit,1350631552
Control7=IDC_EDIT_SUBGROUPSIZE,edit,1350631552
Control8=IDC_SPIN_SUBGROUP,msctls_updown32,1342177462
Control9=IDOK,button,1342242817
Control10=IDCANCEL,button,1342242816
Control11=IDC_STATIC,static,1342308354
Control12=IDC_STATIC,static,1342308354
Control13=IDC_STATIC,static,1342308354
Control14=IDC_STATIC,static,1342308354
Control15=IDC_STATIC,static,1342308354
Control16=IDC_STATIC,static,1342308354
Control17=IDC_STATIC,static,1342308354

[CLS:CAnalysis]
Type=0
HeaderFile=Analysis.h
ImplementationFile=Analysis.cpp
BaseClass=CDialog
Filter=D
LastObject=CAnalysis
VirtualFilter=dWC

[DLG:IDD_DIALOG_FIELDSELECT (English (U.S.))]
Type=1
Class=CFieldSelect
ControlCount=21
Control1=IDC_LIST_FIELD,listbox,1352728835
Control2=IDOK,button,1342242817
Control3=IDCANCEL,button,1342242816
Control4=IDC_STATIC,static,1342308352
Control5=IDC_EDIT_FIELD0,edit,1350633600
Control6=IDC_STATIC,static,1342308352
Control7=IDC_STATIC,static,1342308352
Control8=IDC_EDIT_CONSTANT,edit,1350631552
Control9=IDC_STATIC,static,1342308352
Control10=IDC_STATIC,static,1342308352
Control11=IDC_EDIT_FIELD1,edit,1350633600
Control12=IDC_EDIT_CO1,edit,1350633600
Control13=IDC_STATIC,static,1342308352
Control14=IDC_STATIC,static,1342308352
Control15=IDC_EDIT_FIELD2,edit,1350633600
Control16=IDC_EDIT_CO2,edit,1350633600
Control17=IDC_STATIC,static,1342308352
Control18=IDC_STATIC,static,1342308352
Control19=IDC_EDIT_FIELD3,edit,1350633600
Control20=IDC_EDIT_CO3,edit,1350633600
Control21=IDC_STATIC,static,1342308352

[CLS:CFieldSelect]
Type=0
HeaderFile=FieldSelect.h
ImplementationFile=FieldSelect.cpp
BaseClass=CDialog
Filter=D
VirtualFilter=dWC
LastObject=CFieldSelect

[DLG:IDD_DIALOG_OPTION_COLOR (English (U.S.))]
Type=1
Class=COptionColor
ControlCount=19
Control1=IDC_BUTTON_BACKGROUND,button,1342242816
Control2=IDC_BUTTON_COLOR1,button,1342242816
Control3=IDC_BUTTON_COLOR2,button,1342242816
Control4=IDC_BUTTON_COLOR3,button,1342242816
Control5=IDC_BUTTON_COLOR4,button,1342242816
Control6=IDC_BUTTON_COLOR5,button,1342242816
Control7=IDC_BUTTON_COLOR6,button,1342242816
Control8=IDC_BUTTON_COLOR7,button,1342242816
Control9=IDC_BUTTON_COLOR8,button,1342242816
Control10=IDC_STATIC_BACKGROUND,static,1342308352
Control11=IDC_STATIC_COLOR1,static,1342308352
Control12=IDC_STATIC_COLOR2,static,1342308352
Control13=IDC_STATIC_COLOR3,static,1342308352
Control14=IDC_STATIC_COLOR4,static,1342308352
Control15=IDC_STATIC_COLOR5,static,1342308352
Control16=IDC_STATIC_COLOR6,static,1342308352
Control17=IDC_STATIC_COLOR7,static,1342308352
Control18=IDC_STATIC_COLOR8,static,1342308352
Control19=IDC_BUTTON_COLOR_DEFAULT,button,1342242816

[CLS:COptionColor]
Type=0
HeaderFile=option.h
ImplementationFile=option.cpp
BaseClass=CPropertyPage
Filter=D
VirtualFilter=idWC
LastObject=IDC_BUTTON_COLOR_DEFAULT

[DLG:IDD_DIALOG_OPTION_GENERAL (English (U.S.))]
Type=1
Class=COptionGeneral
ControlCount=0

[CLS:COptionGeneral]
Type=0
HeaderFile=Option.h
ImplementationFile=Option.cpp
BaseClass=CPropertyPage
Filter=D
LastObject=COptionGeneral

[CLS:COption]
Type=0
HeaderFile=Option.h
ImplementationFile=Option.cpp
BaseClass=CPropertySheet
Filter=W
LastObject=COption

