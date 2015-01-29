// MainFrm.cpp : implementation of the CMainFrame class
//

#include "stdafx.h"
#include "Fouler.h"

#include "MainFrm.h"
#include "Option.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CMainFrame

IMPLEMENT_DYNAMIC(CMainFrame, CMDIFrameWnd)

BEGIN_MESSAGE_MAP(CMainFrame, CMDIFrameWnd)
	//{{AFX_MSG_MAP(CMainFrame)
	ON_WM_CREATE()
	ON_WM_TIMER()
	ON_COMMAND(ID_EDIT_INCREASE_SPEED, OnEditIncreaseSpeed)
	ON_COMMAND(ID_EDIT_DECREASE_SPEED, OnEditDecreaseSpeed)
	ON_COMMAND(ID_TOOL_OPTION, OnToolOption)
	//}}AFX_MSG_MAP
	ON_CBN_SELCHANGE(ID_COMBO, OnComboSelChange)
END_MESSAGE_MAP()

static UINT indicators[] =
{
	ID_SEPARATOR,           // status line indicator
	ID_ST_DATANO,
	ID_ST_DATANO,
	ID_ST_DATANO,
	ID_ST_SPEED,
	ID_ST_DATE,
	ID_INDICATOR_CAPS,
	ID_INDICATOR_NUM,
	ID_INDICATOR_SCRL,
};

/////////////////////////////////////////////////////////////////////////////
// CMainFrame construction/destruction

CMainFrame::CMainFrame()
{
	//m_rgb0 = RGB(255,255,255);
	m_rgb0 = RGB(  0,  0,  0);
	//m_rgb1 = RGB(255,  0,  0);
	m_rgb1 = RGB(0,  255,  0);
	//m_rgb2 = RGB(  0,255,  0);
	m_rgb2 = RGB(  0,  0,  0);
	m_rgb3 = RGB(  0,  0,255);
	m_rgb4 = RGB(  0,255,255);
	m_rgb5 = RGB(255,  0,255);
	//m_rgb6 = RGB(255,255,  0);
	m_rgb6 = RGB(255,0,  0);
	//m_rgb7 = RGB(  0,  0,  0);
	m_rgb7 = RGB(255,255,255);
	//m_rgb8 = RGB( 200, 200, 200);
	m_rgb8 = RGB( 240, 240, 240);
}

CMainFrame::~CMainFrame()
{
}

int CMainFrame::OnCreate(LPCREATESTRUCT lpCreateStruct)
{
	if (CMDIFrameWnd::OnCreate(lpCreateStruct) == -1)
		return -1;
	
	if (!m_wndToolBar.CreateEx(this, TBSTYLE_FLAT, WS_CHILD | WS_VISIBLE | CBRS_TOP | CBRS_GRIPPER | CBRS_TOOLTIPS | CBRS_FLYBY | CBRS_SIZE_DYNAMIC) || !m_wndToolBar.LoadToolBar(IDR_MAINFRAME))
	{
		TRACE0("Failed to create toolbar\n");
		return -1;// fail to create
	}

	m_wndToolBar.EnableDocking(CBRS_ALIGN_ANY);
	EnableDocking(CBRS_ALIGN_ANY);
	DockControlBar(&m_wndToolBar);
	CRect rect;
	m_wndToolBar.SetWindowText( "Toolbar" );
	EnableDocking(CBRS_ALIGN_ANY);

	m_wndToolBar.SetButtonInfo(10, ID_COMBO, TBBS_SEPARATOR, 115);
	m_wndToolBar.GetItemRect(10,&rect);
	rect.bottom+=100;
	m_Combo.Create(WS_CHILD|WS_VISIBLE|CBS_DROPDOWNLIST, rect, &m_wndToolBar, ID_COMBO);
	m_Combo.AddString("Histogram");
	m_Combo.AddString("Shewart Chart");
	m_Combo.AddString("CUSUM Chart");
	m_Combo.AddString("SPRT Chart");
	m_Combo.SetCurSel( 0 );
	
	m_wndToolBar.SetButtonInfo(13, ID_SLIDER, TBBS_SEPARATOR, 150);
	m_wndToolBar.GetItemRect(13,&rect);
	m_slider.Create(WS_CHILD | WS_VISIBLE| TBS_BOTH | TBS_NOTICKS, rect, &m_wndToolBar, ID_SLIDER);
	m_slider.SetRange( 0, DEF_MAX_SLIDER_POS );

	m_wndToolBar.SetButtonInfo(14, ID_STATIC, TBBS_SEPARATOR, 35);
	m_wndToolBar.GetItemRect(14,&rect);
	rect.top += 2;
	//rect.bottom += 4;
	m_static.Create( "Avg : ", WS_CHILD | WS_VISIBLE , rect, &m_wndToolBar, ID_STATIC);

	m_wndToolBar.SetButtonInfo(15, ID_EDIT, TBBS_SEPARATOR, 100);
	m_wndToolBar.GetItemRect(15,&rect);
	rect.top += 2;
	rect.right-=10;
	rect.bottom-=2;
	m_edit.Create(WS_CHILD | WS_VISIBLE | WS_BORDER | ES_LEFT | WS_EX_STATICEDGE | ES_AUTOHSCROLL | ES_NUMBER, rect, &m_wndToolBar, ID_EDIT);
	m_edit.SetWindowText( "0" );

	if (!m_wndStatusBar.Create(this) || !m_wndStatusBar.SetIndicators(indicators, sizeof(indicators)/sizeof(UINT)))
	{
		TRACE0("Failed to create status bar\n");
		return -1;// fail to create
	}
	m_wndStatusBar.SetPaneInfo(3, ID_ST_DATANO, SBPS_NORMAL, 100);
	m_wndStatusBar.SetPaneInfo(4, ID_ST_SPEED, SBPS_NORMAL, 165);
	m_wndStatusBar.SetPaneInfo(5, ID_ST_DATE, SBPS_NORMAL, 190);
	m_strExcelDriver = GetExcelDriver();
	SetTimer( WM_USER+1, 50, NULL );
	return 0;
}

BOOL CMainFrame::PreCreateWindow(CREATESTRUCT& cs)
{
	if( CMDIFrameWnd::PreCreateWindow(cs) ) return TRUE;
	return FALSE;
}

/////////////////////////////////////////////////////////////////////////////
// CMainFrame diagnostics

#ifdef _DEBUG
void CMainFrame::AssertValid() const
{
	CMDIFrameWnd::AssertValid();
}

void CMainFrame::Dump(CDumpContext& dc) const
{
	CMDIFrameWnd::Dump(dc);
}

#endif //_DEBUG

/////////////////////////////////////////////////////////////////////////////
// CMainFrame message handlers

void CMainFrame::OnComboSelChange()
{
	int n=m_Combo.GetCurSel();
	if(n==CB_ERR) return;
	CString str;
	CFoulerDoc* pDoc = (CFoulerDoc*)(GetActiveFrame()->GetActiveDocument());
	if( pDoc == NULL ) return;
	pDoc->ChangeViewMode( n );
}

void CMainFrame::OnTimer(UINT nIDEvent) 
{
	if( nIDEvent == WM_USER+1 )
	{
		CString str;
		CFoulerDoc* pDoc = (CFoulerDoc*)(GetActiveFrame()->GetActiveDocument());
		if( pDoc != NULL )
		{
			if( pDoc->m_pRightView )
			{
				str.Format( "%d, %d", pDoc->m_pRightView->m_iSizeX, pDoc->m_pRightView->m_iSizeY );
				m_wndStatusBar.SetPaneText( 2, str );
			}
			int iPos = m_slider.GetPos()/3;
			pDoc->m_dSpeed = 0.00001;
			for( int i=0 ; i < iPos ; i++ )
			{
				pDoc->m_dSpeed = pDoc->m_dSpeed * 10;
			}
			switch( m_slider.GetPos()%3 )
			{
			case 0:
				pDoc->m_dSpeed = pDoc->m_dSpeed * 1;
				break;
			case 1:
				pDoc->m_dSpeed = pDoc->m_dSpeed * 2;
				break;
			case 2:
				pDoc->m_dSpeed = pDoc->m_dSpeed * 5;
			}
			str.Format( "Item No : %d", pDoc->m_iNo );
			m_wndStatusBar.SetPaneText(3,str);
			if( pDoc->m_dSpeed < 0.0001 ) str.Format( "Generation Speed : %.2fdata/sec", pDoc->m_dSpeed*1000 );
			else if( pDoc->m_dSpeed < 0.001 ) str.Format( "Generation Speed : %.2fdata/sec", pDoc->m_dSpeed*1000 );
			else str.Format( "Generation Speed : %.0fdata/sec", pDoc->m_dSpeed*1000 );
			m_wndStatusBar.SetPaneText(4,str);
			if( pDoc->m_bPlaying == TRUE )
			{
				m_edit.SetReadOnly(TRUE);
			}
			else
			{
				m_edit.SetReadOnly(FALSE);
			}
		}
		CTime time=CTime::GetCurrentTime();
		str=time.Format("%A, %B %d, %Y   %I:%M:%S %p");
		m_wndStatusBar.SetPaneText(5,str);
	}
	CMDIFrameWnd::OnTimer(nIDEvent);
}

void CMainFrame::OnEditIncreaseSpeed() 
{
	int iPos;
	iPos = m_slider.GetPos();
	iPos++;
	if( iPos > DEF_MAX_SLIDER_POS ) iPos = DEF_MAX_SLIDER_POS;
	m_slider.SetPos( iPos );
}

void CMainFrame::OnEditDecreaseSpeed() 
{
	int iPos;
	iPos = m_slider.GetPos();
	iPos--;
	if( iPos < 0 ) iPos = 0;
	m_slider.SetPos( iPos );
}

CString CMainFrame::GetExcelDriver()
{
	char szBuf[2001];
	WORD cbBufMax = 2000;
	WORD cbBufOut;
	char *pszBuf = szBuf;
	CString sDriver;
	// Get the names of the installed drivers ("odbcinst.h" has to be included )
	if(!SQLGetInstalledDrivers(szBuf,cbBufMax,& cbBufOut)) return "";
	do// Search for the driver...
	{
		if( strstr( pszBuf, "Excel" ) != 0 )
		{
			sDriver = CString( pszBuf );// Found !
			break;
		}
		pszBuf = strchr( pszBuf, '\0' ) + 1;
	}
	while( pszBuf[1] != '\0' );
	return sDriver;
}

void CMainFrame::OnToolOption() 
{
	COption dlg("Option");
	dlg.m_tabColor.m_rgb0 = m_rgb0;
	dlg.m_tabColor.m_rgb1 = m_rgb1;
	dlg.m_tabColor.m_rgb2 = m_rgb2;
	dlg.m_tabColor.m_rgb3 = m_rgb3;
	dlg.m_tabColor.m_rgb4 = m_rgb4;
	dlg.m_tabColor.m_rgb5 = m_rgb5;
	dlg.m_tabColor.m_rgb6 = m_rgb6;
	dlg.m_tabColor.m_rgb7 = m_rgb7;
	dlg.m_tabColor.m_rgb8 = m_rgb8;
	if( dlg.DoModal() == IDOK )
	{
		m_rgb0 = dlg.m_tabColor.m_rgb0;
		m_rgb1 = dlg.m_tabColor.m_rgb1;
		m_rgb2 = dlg.m_tabColor.m_rgb2;
		m_rgb3 = dlg.m_tabColor.m_rgb3;
		m_rgb4 = dlg.m_tabColor.m_rgb4;
		m_rgb5 = dlg.m_tabColor.m_rgb5;
		m_rgb6 = dlg.m_tabColor.m_rgb6;
		m_rgb7 = dlg.m_tabColor.m_rgb7;
		m_rgb8 = dlg.m_tabColor.m_rgb8;
		CFoulerDoc* pDoc = (CFoulerDoc*)(GetActiveFrame()->GetActiveDocument());
		if( pDoc )
		{
			if( pDoc->m_pRightView ) pDoc->m_pRightView->Refresh();
		}
	}
}
