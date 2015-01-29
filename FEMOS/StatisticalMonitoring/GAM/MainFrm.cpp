// MainFrm.cpp : implementation of the CMainFrame class
//

#include "stdafx.h"
#include "GAM.h"

#include "MainFrm.h"
#include "GAMDoc.h"
#include "OptionDialog.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CMainFrame

IMPLEMENT_DYNCREATE(CMainFrame, CFrameWnd)

BEGIN_MESSAGE_MAP(CMainFrame, CFrameWnd)
	//{{AFX_MSG_MAP(CMainFrame)
	ON_WM_CREATE()
	ON_COMMAND(ID_VIEW_DATA, OnViewData)
	ON_UPDATE_COMMAND_UI(ID_VIEW_DATA, OnUpdateViewData)
	ON_COMMAND(ID_VIEW_GRAPH, OnViewGraph)
	ON_UPDATE_COMMAND_UI(ID_VIEW_GRAPH, OnUpdateViewGraph)
	ON_COMMAND(ID_VIEW_MINIMAP, OnViewMinimap)
	ON_UPDATE_COMMAND_UI(ID_VIEW_MINIMAP, OnUpdateViewMinimap)
	ON_COMMAND(ID_VIEW_BOLD, OnFontBold)
	ON_UPDATE_COMMAND_UI(ID_VIEW_BOLD, OnUpdateFontBold)
	ON_COMMAND(ID_VIEW_ITALIC, OnFontItalic)
	ON_UPDATE_COMMAND_UI(ID_VIEW_ITALIC, OnUpdateFontItalic)
	ON_COMMAND(ID_VIEW_UNDERLINE, OnFontUnderline)
	ON_UPDATE_COMMAND_UI(ID_VIEW_UNDERLINE, OnUpdateFontUnderline)
	ON_COMMAND(ID_VIEW_CHANGEFONT, OnViewChangefont)
	ON_WM_CONTEXTMENU()
	ON_COMMAND(ID_VIEW_RESULT, OnViewResult)
	ON_UPDATE_COMMAND_UI(ID_VIEW_RESULT, OnUpdateViewResult)
	ON_COMMAND(ID_TOOL_OPTION, OnToolOption)
	ON_COMMAND(ID_VIEW_TOOLBAR, OnViewToolbar)
	ON_UPDATE_COMMAND_UI(ID_VIEW_TOOLBAR, OnUpdateViewToolbar)
	ON_WM_MEASUREITEM()
	ON_WM_MENUCHAR()
	ON_WM_INITMENUPOPUP()
	//}}AFX_MSG_MAP
	ON_CBN_SELCHANGE(ID_FONT_COMBO, OnComboSelChange)
END_MESSAGE_MAP()

static UINT indicators[] =
{
	ID_SEPARATOR,
	ID_SEPARATOR,
	ID_SEPARATOR,
	ID_INDICATOR_CAPS,
	ID_INDICATOR_NUM,
	ID_INDICATOR_SCRL,
};

/////////////////////////////////////////////////////////////////////////////
// CMainFrame construction/destruction

CMainFrame::CMainFrame()
{
	m_scr.cx = GetSystemMetrics( SM_CXSCREEN );
	m_scr.cy = GetSystemMetrics( SM_CYSCREEN );
	m_bIsBold = FALSE;
	m_bIsItalic = FALSE;
	m_bIsUnderline = FALSE;
	char cStr[8];
	ZeroMemory( cStr, sizeof(cStr) );
	strcpy( cStr, "System" );
	m_plfCurrent = new LOGFONT;
	m_plfCurrent->lfCharSet = 129;
	m_plfCurrent->lfClipPrecision = 2;
	m_plfCurrent->lfEscapement = 0;
	strcpy( m_plfCurrent->lfFaceName, cStr );
	m_plfCurrent->lfHeight = -16;
	m_plfCurrent->lfItalic = 0;
	m_plfCurrent->lfOrientation = 0;
	m_plfCurrent->lfOutPrecision = 1;
	m_plfCurrent->lfPitchAndFamily = 34;
	m_plfCurrent->lfQuality = 1;
	m_plfCurrent->lfStrikeOut = 0;
	m_plfCurrent->lfUnderline = 0;
	m_plfCurrent->lfWeight = 400;
	m_plfCurrent->lfWidth = 0;
}

CMainFrame::~CMainFrame()
{
	if( m_plfCurrent )
	{
		delete m_plfCurrent;
		m_plfCurrent = NULL;
	}
}


int CMainFrame::OnCreate(LPCREATESTRUCT lpCreateStruct)
{
	RECT rt;
	int iSize;
	iSize = m_scr.cx/4;
	if( iSize < 240 ) iSize = 240;
	if( CFrameWnd::OnCreate(lpCreateStruct) == -1) return -1;

	if( !m_wndToolBar.CreateEx(this, TBSTYLE_FLAT | TBSTYLE_TRANSPARENT, WS_CHILD | WS_VISIBLE | CBRS_TOP | CBRS_GRIPPER | CBRS_TOOLTIPS | CBRS_FLYBY | CBRS_SIZE_DYNAMIC)) return -1;
	if( !m_wndToolBar.LoadToolBar(IDR_MAINFRAME) ) return -1;
	m_wndToolBar.SetWindowText( "Main" );

	if( !m_wndStatusBar.Create(this) ) return -1;
	if( !m_wndStatusBar.SetIndicators(indicators,sizeof(indicators)/sizeof(UINT))) return -1;
	if( !m_wndMiniMap.Create(_T("MiniMap"), this, CSize(iSize, iSize/4), TRUE, AFX_IDW_CONTROLBAR_FIRST+6)) return -1;
    if( !m_wndResult.Create(_T("Result"), this, CSize(iSize, iSize/4), TRUE, AFX_IDW_CONTROLBAR_FIRST+7)) return -1;
    if( !m_wndGraph.Create(_T("Graph"), this, CSize(iSize, iSize/2), TRUE, AFX_IDW_CONTROLBAR_FIRST+8)) return -1;
    if( !m_wndData.Create(_T("Data Viewer"), this, CSize(m_scr.cy, 180), TRUE, AFX_IDW_CONTROLBAR_FIRST+9)) return -1;

    m_wndMiniMap.SetBarStyle(m_wndMiniMap.GetBarStyle() | CBRS_TOOLTIPS | CBRS_FLYBY | CBRS_SIZE_DYNAMIC);
    m_wndResult.SetBarStyle(m_wndMiniMap.GetBarStyle() | CBRS_TOOLTIPS | CBRS_FLYBY | CBRS_SIZE_DYNAMIC);
    m_wndGraph.SetBarStyle(m_wndGraph.GetBarStyle() | CBRS_TOOLTIPS | CBRS_FLYBY | CBRS_SIZE_DYNAMIC);
    m_wndData.SetBarStyle(m_wndData.GetBarStyle() | CBRS_TOOLTIPS | CBRS_FLYBY | CBRS_SIZE_DYNAMIC);
	
	m_wndToolBar.EnableDocking(CBRS_ALIGN_ANY);
//	m_wndMiniMap.EnableDocking(CBRS_ALIGN_LEFT | CBRS_ALIGN_RIGHT);
//	m_wndResult.EnableDocking(CBRS_ALIGN_LEFT | CBRS_ALIGN_RIGHT);
//	m_wndGraph.EnableDocking(CBRS_ALIGN_LEFT | CBRS_ALIGN_RIGHT);
//	m_wndData.EnableDocking(CBRS_ALIGN_TOP | CBRS_ALIGN_BOTTOM);
	m_wndMiniMap.EnableDocking(CBRS_ALIGN_ANY);
	m_wndResult.EnableDocking(CBRS_ALIGN_ANY);
	m_wndGraph.EnableDocking(CBRS_ALIGN_ANY);
	m_wndData.EnableDocking(CBRS_ALIGN_ANY);

	EnableDocking(CBRS_ALIGN_ANY);

	m_wndStatusBar.SetPaneInfo(1, ID_SEPARATOR, SBPS_NORMAL, 100);
	m_wndStatusBar.SetPaneInfo(2, ID_SEPARATOR, SBPS_NORMAL, 50);

	DockControlBar(&m_wndToolBar, AFX_IDW_DOCKBAR_TOP);
	DockControlBar(&m_wndData, AFX_IDW_DOCKBAR_BOTTOM);

	RecalcLayout();
	m_wndToolBar.SetButtonInfo( 15, ID_FONT_COMBO, TBBS_SEPARATOR, 170);
	m_wndToolBar.GetItemRect(15,&rt);
	rt.top -= 1;
	rt.left +=3;
	rt.right -=3;
	rt.bottom+=500;
	m_comboFont.Create( WS_CHILD | WS_VISIBLE | WS_VSCROLL | CBS_AUTOHSCROLL | CBS_DROPDOWNLIST | CBS_HASSTRINGS | CBS_SORT, rt, &m_wndToolBar, ID_FONT_COMBO);
	m_comboFont.SubclassDlgItem(ID_FONT_COMBO,this);
	RecalcLayout();

	DockControlBar(&m_wndGraph, AFX_IDW_DOCKBAR_RIGHT);
	RecalcLayout();
	m_wndGraph.GetWindowRect(&rt);
	DockControlBar(&m_wndResult, AFX_IDW_DOCKBAR_RIGHT, &rt);
	RecalcLayout();
	m_wndResult.GetWindowRect(&rt);
	DockControlBar(&m_wndMiniMap, AFX_IDW_DOCKBAR_RIGHT, &rt);
	RecalcLayout();

	CSCBar::GlobalLoadState(_T("BarState"));
	LoadBarState(_T("BarState"));
	RecalcLayout();
	return 0;
}

/////////////////////////////////////////////////////////////////////////////
// CMainFrame diagnostics

#ifdef _DEBUG
void CMainFrame::AssertValid() const
{
	CFrameWnd::AssertValid();
}

void CMainFrame::Dump(CDumpContext& dc) const
{
	CFrameWnd::Dump(dc);
}

#endif //_DEBUG

/////////////////////////////////////////////////////////////////////////////
// CMainFrame message handlers

BOOL CMainFrame::DestroyWindow() 
{
	CSCBar::GlobalSaveState(_T("BarState"));
    SaveBarState(_T("BarState"));
	return CFrameWnd::DestroyWindow();
}

void CMainFrame::OnViewData() 
{
	BOOL bShow = m_wndData.IsVisible();
	ShowControlBar( &m_wndData, !bShow, FALSE );
}

void CMainFrame::OnUpdateViewData(CCmdUI* pCmdUI) 
{
	pCmdUI->Enable();
	pCmdUI->SetCheck(m_wndData.IsVisible());
}

void CMainFrame::OnViewGraph() 
{
	BOOL bShow = m_wndGraph.IsVisible();
	ShowControlBar( &m_wndGraph, !bShow, FALSE );
}

void CMainFrame::OnUpdateViewGraph(CCmdUI* pCmdUI) 
{
	pCmdUI->Enable();
	pCmdUI->SetCheck(m_wndGraph.IsVisible());
}

void CMainFrame::OnViewMinimap() 
{
	BOOL bShow = m_wndMiniMap.IsVisible();
	ShowControlBar( &m_wndMiniMap, !bShow, FALSE );
}

void CMainFrame::OnUpdateViewMinimap(CCmdUI* pCmdUI) 
{
	pCmdUI->Enable();
	pCmdUI->SetCheck(m_wndMiniMap.IsVisible());
}

void CMainFrame::OnViewResult() 
{
	BOOL bShow = m_wndResult.IsVisible();
	ShowControlBar( &m_wndResult, !bShow, FALSE );
}

void CMainFrame::OnUpdateViewResult(CCmdUI* pCmdUI) 
{
	pCmdUI->Enable();
	pCmdUI->SetCheck(m_wndResult.IsVisible());
}

void CMainFrame::OnViewToolbar() 
{
	BOOL bShow = m_wndToolBar.IsVisible();
	ShowControlBar( &m_wndToolBar, !bShow, FALSE );
}

void CMainFrame::OnUpdateViewToolbar(CCmdUI* pCmdUI) 
{
	pCmdUI->Enable();
	pCmdUI->SetCheck(m_wndToolBar.IsVisible());
}

void CMainFrame::OnFontBold() 
{
	m_bIsBold = !m_bIsBold;
	ChangeFont();
}

void CMainFrame::OnUpdateFontBold(CCmdUI* pCmdUI) 
{
	pCmdUI->Enable();
	pCmdUI->SetCheck(m_bIsBold);
}

void CMainFrame::OnFontItalic() 
{
	m_bIsItalic = !m_bIsItalic;
	ChangeFont();
}

void CMainFrame::OnUpdateFontItalic(CCmdUI* pCmdUI) 
{
	pCmdUI->Enable();
	pCmdUI->SetCheck(m_bIsItalic);
}

void CMainFrame::OnFontUnderline() 
{
	m_bIsUnderline = !m_bIsUnderline;
	ChangeFont();
}

void CMainFrame::OnUpdateFontUnderline(CCmdUI* pCmdUI) 
{
	pCmdUI->Enable();
	pCmdUI->SetCheck(m_bIsUnderline);
}

void CMainFrame::ChangeFont() 
{
	long lHeight;
	HFONT hFont;
	lHeight = -20;
	//lHeight = -12;
	if( m_plfCurrent == NULL ) return;
	if( m_plfCurrent->lfHeight < lHeight ) m_plfCurrent->lfHeight = lHeight;
	if( m_plfCurrent->lfHeight > 0 )
	{
		if( m_plfCurrent->lfHeight > 16 ) m_plfCurrent->lfHeight = 16;
		m_plfCurrent->lfHeight = -m_plfCurrent->lfHeight;
		m_plfCurrent->lfWidth = 0;
	}
	if( m_bIsBold ) m_plfCurrent->lfWeight = 700;
	else m_plfCurrent->lfWeight = 400;
	if( m_bIsItalic ) m_plfCurrent->lfItalic = true;
	else m_plfCurrent->lfItalic = false;
	if( m_bIsUnderline ) m_plfCurrent->lfUnderline = true;
	else m_plfCurrent->lfUnderline = false;
	hFont = CreateFontIndirect( m_plfCurrent );
	CGAMDoc* pDoc = (CGAMDoc*)GetActiveDocument();
	pDoc->m_pRightView->m_dcBuffer.SelectObject( hFont );
	pDoc->UpdateAll(TRUE, FALSE);
}

void CMainFrame::OnViewChangefont() 
{
	long lHeight;
	CFontDialog dlg(m_plfCurrent);
	if( dlg.DoModal() == IDCANCEL ) return;
	if( m_plfCurrent == NULL ) m_plfCurrent = new LOGFONT;
	lHeight = -24;
	dlg.GetCurrentFont(m_plfCurrent);
#ifdef _DEBUG
	char cStr[32];
	ZeroMemory( cStr, sizeof(cStr) );
	wsprintf( cStr, "%d", m_plfCurrent->lfHeight );
	MessageBox( cStr );
#endif
	if( m_plfCurrent->lfHeight < lHeight ) m_plfCurrent->lfHeight = lHeight;
	ChangeFont();
}

void CMainFrame::OnComboSelChange()
{
	int i, iIndex;
	CString str;
	iIndex = m_comboFont.GetCurSel();
	if( iIndex == CB_ERR ) return;
	m_comboFont.GetLBText(iIndex, str);
	for( i=0 ; i<DEF_MAXFONTNO ; i++ )
	{
		if( m_comboFont.m_plf[i] != NULL )
		{
			if( str.Compare( m_comboFont.m_plf[i]->lfFaceName ) == 0 ) 
			{
				memcpy( m_plfCurrent, m_comboFont.m_plf[i], sizeof(LOGFONT) );
				ChangeFont();
				return;
			}
		}
		else return;
	}
}

void CMainFrame::OnContextMenu(CWnd* pWnd, CPoint point) 
{
	ScreenToClient( &point );
	if( point.y > 0 && point.y < 27 )
	{
		CMenu menu;
		CString str;
		menu.CreatePopupMenu();
		menu.AppendMenu( MF_STRING, ID_VIEW_DATA, "Data" );
		menu.AppendMenu( MF_STRING, ID_VIEW_MINIMAP, "MiniMap" );
		menu.AppendMenu( MF_STRING, ID_VIEW_RESULT, "Result" );
		menu.AppendMenu( MF_STRING, ID_VIEW_GRAPH, "Graph" );
		menu.AppendMenu( MF_SEPARATOR );
		menu.AppendMenu( MF_STRING, ID_VIEW_TOOLBAR, "Toolbar" );
		menu.AppendMenu( MF_STRING, ID_VIEW_STATUS_BAR, "Status Bar" );
		SetForegroundWindow();
		ClientToScreen( &point );
		menu.TrackPopupMenu( TPM_LEFTALIGN, point.x, point.y, this, NULL );
	}
	CFrameWnd::OnContextMenu(pWnd, point);
}

void CMainFrame::OnToolOption() 
{
	COptionDialog dlg;
	if( dlg.DoModal() == IDCANCEL ) return;
}

HMENU CMainFrame::NewMenu()
{
	m_menu.LoadMenu( IDR_MAINFRAME );
	m_menu.LoadToolbar( IDR_MAINFRAME );
	return(m_menu.Detach());
}

void CMainFrame::OnMeasureItem(int nIDCtl, LPMEASUREITEMSTRUCT lpMeasureItemStruct) 
{
	BOOL setflag=FALSE;
	if(lpMeasureItemStruct->CtlType==ODT_MENU)
	{
		if(IsMenu((HMENU)lpMeasureItemStruct->itemID))
		{
			CMenu* cmenu = CMenu::FromHandle((HMENU)lpMeasureItemStruct->itemID);
			if(m_menu.IsMenu(cmenu)||m_menu.IsMenu(cmenu))
			{
				m_menu.MeasureItem(lpMeasureItemStruct);
				setflag=TRUE;
			}
		}
	}
	if(!setflag) CFrameWnd::OnMeasureItem(nIDCtl, lpMeasureItemStruct);
}

LRESULT CMainFrame::OnMenuChar(UINT nChar, UINT nFlags, CMenu* pMenu) 
{
	LRESULT lresult;
	if(m_menu.IsMenu(pMenu))
		 lresult=BCMenu::FindKeyboardShortcut(nChar, nFlags, pMenu);
	else lresult=CFrameWnd::OnMenuChar(nChar, nFlags, pMenu);
	return(lresult);
}

void CMainFrame::OnInitMenuPopup(CMenu* pPopupMenu, UINT nIndex, BOOL bSysMenu) 
{
	CFrameWnd::OnInitMenuPopup(pPopupMenu, nIndex, bSysMenu);
	if(!bSysMenu)
	{
		if(m_menu.IsMenu(pPopupMenu)) BCMenu::UpdateMenu(pPopupMenu);
	}
}
