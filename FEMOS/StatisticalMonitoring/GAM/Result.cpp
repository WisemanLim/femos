// Result.cpp : implementation file
//

#include "stdafx.h"
#include "GAM.h"
#include "MainFrm.h"
#include "GAMDoc.h"
#include "Result.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CResult

CResult::CResult()
{
}

CResult::~CResult()
{
}


BEGIN_MESSAGE_MAP(CResult, CSCBar)
	//{{AFX_MSG_MAP(CResult)
    ON_WM_SIZE()
	ON_WM_PAINT()
	ON_WM_CREATE()
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()


/////////////////////////////////////////////////////////////////////////////
// CResult message handlers

void CResult::OnUpdateCmdUI(CFrameWnd* pTarget, BOOL bDisableIfNoHndler)
{
    CSCBar::OnUpdateCmdUI(pTarget, bDisableIfNoHndler);

    UpdateDialogControls(pTarget, bDisableIfNoHndler);
}

void CResult::OnSize(UINT nType, int cx, int cy) 
{
    CSCBar::OnSize(nType, cx, cy);
	if( AfxGetMainWnd() != NULL ) Render();
}

void CResult::Render() 
{
    RECT rt;
	LV_COLUMN lvc;
	LV_ITEM lvitem;
	char cStr[32];
	int i, iItemCount, iColumnWidth;
	CAlter *pAlter;
	i = 0;
    GetClientRect(&rt);
	CMainFrame *pFrame;
	pFrame = (CMainFrame *)AfxGetMainWnd();
	if( pFrame == NULL ) return;
	CGAMDoc *pDoc = (CGAMDoc*)(pFrame->GetActiveDocument());
	iItemCount = pDoc->m_pData->GetTotalItem();
	if( iItemCount < 1 ) return;
	m_list.DestroyWindow();
	m_list.Create( WS_VISIBLE | WS_CHILD | LVS_REPORT | LVS_EDITLABELS | LVS_NOSORTHEADER, rt, this, 5325 );
	ZeroMemory( cStr, sizeof(cStr) );
	lvc.mask = LVCF_FMT | LVCF_WIDTH | LVCF_TEXT | LVS_SHOWSELALWAYS;
	lvc.fmt	= LVCFMT_CENTER;
	lvc.iImage = 0;
	iColumnWidth = rt.right/2;
	lvc.cx = iColumnWidth;
	lvc.pszText = "Item";
	m_list.InsertColumn(0, &lvc);
	lvc.pszText = "Result";
	m_list.InsertColumn(1, &lvc);

	lvitem.mask = LVIF_TEXT;
	lvitem.iSubItem = 0;
	for( i=0 ; i<pDoc->m_pData->m_iNoAlter ; i++ )
	{
		pAlter = pDoc->m_pData->GetAlter(i);
		if( pAlter == NULL ) break;
		lvitem.iItem = i;
		strcpy( cStr, pAlter->cStrAlter );
		lvitem.pszText = cStr;
		m_list.InsertItem(&lvitem);
		sprintf( cStr, "%f", pAlter->m_pDataSet[0]->m_fValue );
		m_list.SetItemText( i, 1, cStr );
	}

	InvalidateRect(&rt, FALSE);
}

void CResult::OnPaint() 
{
	CPaintDC dc(this); // device context for painting
}

int CResult::OnCreate(LPCREATESTRUCT lpCreateStruct) 
{
	if( CSCBar::OnCreate(lpCreateStruct) == -1) return -1;
	if( m_list.Create( WS_VISIBLE | WS_CHILD | LVS_REPORT | LVS_OWNERDRAWFIXED | LVS_EDITLABELS | LVS_SINGLESEL | LVS_SHOWSELALWAYS, CRect(0,0,200,200), this, 5325 ) == 0 ) return -1;
	return 0;
}
