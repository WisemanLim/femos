// Fouler.cpp : Defines the class behaviors for the application.
//

#include "stdafx.h"
#include "Fouler.h"

#include "MainFrm.h"
#include "ChildFrm.h"
#include "FoulerDoc.h"
#include "LeftView.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CFoulerApp

BEGIN_MESSAGE_MAP(CFoulerApp, CWinApp)
	//{{AFX_MSG_MAP(CFoulerApp)
	ON_COMMAND(ID_APP_ABOUT, OnAppAbout)
		// NOTE - the ClassWizard will add and remove mapping macros here.
		//    DO NOT EDIT what you see in these blocks of generated code!
	//}}AFX_MSG_MAP
	// Standard file based document commands
	ON_COMMAND(ID_FILE_NEW, CWinApp::OnFileNew)
//	ON_COMMAND(ID_FILE_OPEN, CWinApp::OnFileOpen)
	// Standard print setup command
	ON_COMMAND(ID_FILE_PRINT_SETUP, CWinApp::OnFilePrintSetup)
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CFoulerApp construction

CFoulerApp::CFoulerApp()
{
	srand( (unsigned)time( NULL ) );
}

/////////////////////////////////////////////////////////////////////////////
// The one and only CFoulerApp object

CFoulerApp theApp;

/////////////////////////////////////////////////////////////////////////////
// CFoulerApp initialization

BOOL CFoulerApp::InitInstance()
{
#ifndef _DEBUG
	CSplash splash;
	splash.ShowWindow(SW_SHOW);
	splash.UpdateWindow();
#endif
	AfxEnableControlContainer();

	// Standard initialization
	// If you are not using these features and wish to reduce the size
	//  of your final executable, you should remove from the following
	//  the specific initialization routines you do not need.

#ifdef _AFXDLL
	Enable3dControls();			// Call this when using MFC in a shared DLL
#else
	Enable3dControlsStatic();	// Call this when linking to MFC statically
#endif

	// Change the registry key under which our settings are stored.
	// TODO: You should modify this string to be something appropriate
	// such as the name of your company or organization.
	SetRegistryKey(_T("NUSCOL"));
	LoadStdProfileSettings();  // Load standard INI file options (including MRU)
	// Register the application's document templates.  Document templates
	//  serve as the connection between documents, frame windows and views.
#ifndef _DEBUG
	splash.m_progress.SetRange( 0, 30 );
	for( int i=0 ; i<31 ; i++ )
	{
		Sleep( rand()%300 );
		splash.m_progress.SetPos( i );
		if( i < 5 ) splash.m_static.SetWindowText( "Loading Interface..." );
		else if( i < 14 ) splash.m_static.SetWindowText( "Loading Graphic Module..." );
		else if( i < 22 ) splash.m_static.SetWindowText( "Loading Data Manager..." );
		else if( i < 30 ) splash.m_static.SetWindowText( "Loading Statistical Methodology..." );
		else splash.m_static.SetWindowText( "Loading Complete..." );
	}
	Sleep(1500);
#endif
	CMultiDocTemplate* pDocTemplate;
	pDocTemplate = new CMultiDocTemplate(
		IDR_FOULERTYPE,
		RUNTIME_CLASS(CFoulerDoc),
		RUNTIME_CLASS(CChildFrame), // custom MDI child frame
		RUNTIME_CLASS(CLeftView));
	AddDocTemplate(pDocTemplate);
	CMainFrame* pMainFrame = new CMainFrame;
	if (!pMainFrame->LoadFrame(IDR_MAINFRAME)) return FALSE;
	m_pMainWnd = pMainFrame;
	CCommandLineInfo cmdInfo;
	ParseCommandLine(cmdInfo);
	if (!ProcessShellCommand(cmdInfo)) return FALSE;
/*#ifndef _DEBUG
	splash.DestroyWindow();
#endif*/
	pMainFrame->ShowWindow(m_nCmdShow | SW_SHOWMAXIMIZED);
	pMainFrame->UpdateWindow();
	return TRUE;
}

/////////////////////////////////////////////////////////////////////////////
// CAboutDlg dialog used for App About

class CAboutDlg : public CDialog
{
public:
	CAboutDlg();

// Dialog Data
	//{{AFX_DATA(CAboutDlg)
	enum { IDD = IDD_ABOUTBOX };
	//}}AFX_DATA

	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CAboutDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:
	//{{AFX_MSG(CAboutDlg)
	afx_msg void OnButtonHomepage();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

CAboutDlg::CAboutDlg() : CDialog(CAboutDlg::IDD)
{
	//{{AFX_DATA_INIT(CAboutDlg)
	//}}AFX_DATA_INIT
}

void CAboutDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CAboutDlg)
	//}}AFX_DATA_MAP
}

BEGIN_MESSAGE_MAP(CAboutDlg, CDialog)
	//{{AFX_MSG_MAP(CAboutDlg)
	ON_BN_CLICKED(IDC_BUTTON_HOMEPAGE, OnButtonHomepage)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

// App command to run the dialog
void CFoulerApp::OnAppAbout()
{
	CAboutDlg aboutDlg;
	aboutDlg.DoModal();
}

/////////////////////////////////////////////////////////////////////////////
// CFoulerApp message handlers

void CAboutDlg::OnButtonHomepage() 
{
	CString strURL;
	strURL.Format( "http://nuscol.kaist.ac.kr" );
	ShellExecute(NULL, _T("open"), strURL, NULL,NULL, SW_SHOWMAXIMIZED);
}
