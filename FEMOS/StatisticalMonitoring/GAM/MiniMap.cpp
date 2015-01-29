// MiniMap.cpp : implementation file
//

#include "stdafx.h"
#include "GAM.h"
#include "MiniMap.h"
#include "MainFrm.h"
#include "GAMDoc.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CMiniMap

CMiniMap::CMiniMap()
{
	m_pDCBuffer = NULL;
	m_bLButtonDown = FALSE;
}

CMiniMap::~CMiniMap()
{
	if( m_pDCBuffer != NULL )
	{
		delete m_pDCBuffer;
		m_pDCBuffer = NULL;
	}
}


BEGIN_MESSAGE_MAP(CMiniMap, CSCBar)
	//{{AFX_MSG_MAP(CMiniMap)
    ON_WM_SIZE()
	ON_WM_PAINT()
	ON_WM_CREATE()
	ON_WM_LBUTTONDOWN()
	ON_WM_MOUSEMOVE()
	ON_WM_LBUTTONUP()
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()


/////////////////////////////////////////////////////////////////////////////
// CMiniMap message handlers

void CMiniMap::OnUpdateCmdUI(CFrameWnd* pTarget, BOOL bDisableIfNoHndler)
{
    CSCBar::OnUpdateCmdUI(pTarget, bDisableIfNoHndler);

    UpdateDialogControls(pTarget, bDisableIfNoHndler);
}

void CMiniMap::OnSize(UINT nType, int cx, int cy) 
{
    CSCBar::OnSize(nType, cx, cy);
	if( m_pDCBuffer ) Render(TRUE);
}

void CMiniMap::OnPaint() 
{
	CPaintDC dc(this); // device context for painting
	if( m_pDCBuffer )
	{
		RECT rt;
		CGAMDoc *pDoc = (CGAMDoc*)(((CMainFrame *)AfxGetMainWnd())->GetActiveDocument());
		dc.BitBlt( 0, 0, m_rtClient.right, m_rtClient.bottom, m_pDCBuffer, 0, 0, SRCCOPY );
		if( pDoc == NULL ) return;
		if( pDoc->m_pRightView == NULL ) return;
		SetRect( &rt, pDoc->m_ptScroll.x*m_rtDraw.right/pDoc->m_ptSheet.x, pDoc->m_ptScroll.y*m_rtDraw.bottom/pDoc->m_ptSheet.y, (pDoc->m_ptScroll.x+pDoc->m_pRightView->m_rtClient.right)*m_rtDraw.right/pDoc->m_ptSheet.x, (pDoc->m_ptScroll.y+pDoc->m_pRightView->m_rtClient.bottom)*m_rtDraw.bottom/pDoc->m_ptSheet.y );
		dc.Draw3dRect( &rt, RGB(0,0,0), RGB(0,0,0) );
	}
}

int CMiniMap::OnCreate(LPCREATESTRUCT lpCreateStruct) 
{
	if (CSCBar::OnCreate(lpCreateStruct) == -1) return -1;
	return 0;
}

void CMiniMap::Render(BOOL bRedraw)
{
	if( bRedraw )
	{
		CGAMDoc *pDoc = (CGAMDoc*)(((CMainFrame *)AfxGetMainWnd())->GetActiveDocument());
		RECT rt;
		CDC *pDC;
		CBrush brush;
		brush.CreateSolidBrush( RGB(212,208,200) );
		CBitmap bmpBuffer;
		GetClientRect(&rt);
		m_rtDraw.left = 0;
		m_rtDraw.top = 0;
		m_rtDraw.right = min( rt.right, rt.bottom*pDoc->m_ptSheet.x/pDoc->m_ptSheet.y );
		m_rtDraw.bottom = min( rt.bottom, rt.right*pDoc->m_ptSheet.y/pDoc->m_ptSheet.x );
		if( rt.left != m_rtClient.left || rt.right != m_rtClient.right || rt.top != m_rtClient.top || rt.bottom != m_rtClient.bottom )
		{
			if( m_pDCBuffer != NULL )
			{
				delete m_pDCBuffer;
				m_pDCBuffer = NULL;
			}
		}
		if( m_pDCBuffer == NULL )
		{
			m_pDCBuffer = new CDC;
			pDC = GetDC();
			m_pDCBuffer->CreateCompatibleDC(pDC);
			bmpBuffer.CreateCompatibleBitmap(pDC, rt.right, rt.bottom );
			m_pDCBuffer->SelectObject( &bmpBuffer );
			ReleaseDC( pDC );
		}
		m_pDCBuffer->FillRect( &rt, &brush );
		m_pDCBuffer->BitBlt( 0, 0, m_rtDraw.right, m_rtDraw.bottom, NULL, 0, 0, WHITENESS );
		m_rtClient = rt;
		DrawItem();
	}
	InvalidateRect( &m_rtClient, FALSE );
}

void CMiniMap::DrawItem()
{
	int i;
	POINT pt;
	RECT rt;
	RECT *prt;
	CBrush *pOldBrush;
	CPen *pOldPen;
	CItem *pItem;
	CLink *pLink;
	CGAMDoc *pDoc = (CGAMDoc*)(((CMainFrame *)AfxGetMainWnd())->GetActiveDocument());
	if( pDoc == NULL ) return;
	if( pDoc->m_pRightView == NULL ) return;
	pOldBrush = m_pDCBuffer->SelectObject( &pDoc->m_brsFace );
	pOldPen = m_pDCBuffer->SelectObject( &pDoc->m_penFace );
	for( i=0 ; i<DEF_MAXITEM ; i++ )
	{
		pItem = pDoc->m_pData->GetItem(i);
		if( pItem == NULL ) break;
		prt = &pItem->m_rt;
		SetRect( &rt, prt->left*m_rtDraw.right/pDoc->m_ptSheet.x, prt->top*m_rtDraw.bottom/pDoc->m_ptSheet.y, prt->right*m_rtDraw.right/pDoc->m_ptSheet.x, prt->bottom*m_rtDraw.bottom/pDoc->m_ptSheet.y );
		m_pDCBuffer->SelectObject( &pDoc->m_penFace );
		m_pDCBuffer->Rectangle( &rt );
		m_pDCBuffer->SelectObject( &pDoc->m_penWindowColour );
		m_pDCBuffer->MoveTo( rt.left+1, rt.bottom-3 );
		m_pDCBuffer->LineTo( rt.left+1, rt.top+1 );
		m_pDCBuffer->LineTo( rt.right-2, rt.top+1 );
		m_pDCBuffer->SelectObject( &pDoc->m_penShadow );
		m_pDCBuffer->MoveTo( rt.left+1, rt.bottom-2 );
		m_pDCBuffer->LineTo( rt.right-2, rt.bottom-2 );
		m_pDCBuffer->LineTo( rt.right-2, rt.top );
		m_pDCBuffer->SelectObject( &pDoc->m_penDKShadow );
		m_pDCBuffer->MoveTo( rt.left, rt.bottom-1 );
		m_pDCBuffer->LineTo( rt.right-1, rt.bottom-1 );
		m_pDCBuffer->LineTo( rt.right-1, rt.top-1 );
	}
	m_pDCBuffer->SelectObject(pOldBrush);
	m_pDCBuffer->SelectObject(pOldPen);
	for( i=0 ; i<DEF_MAXLINK ; i++ )
	{
		pLink = pDoc->m_pData->GetLink(i);
		if( pLink == NULL ) break;
		pt.x = pLink->m_ptParent.x*m_rtDraw.right/pDoc->m_ptSheet.x;
		pt.y = pLink->m_ptParent.y*m_rtDraw.bottom/pDoc->m_ptSheet.y;
		m_pDCBuffer->MoveTo( pt );
		pt.x = pLink->m_ptChild.x*m_rtDraw.right/pDoc->m_ptSheet.x;
		pt.y = pLink->m_ptChild.y*m_rtDraw.bottom/pDoc->m_ptSheet.y;
		m_pDCBuffer->LineTo( pt );
	}
}

void CMiniMap::OnLButtonDown(UINT nFlags, CPoint point) 
{
	POINT pt;
	RECT rt;
	if( point.x > m_rtDraw.left && point.x < m_rtDraw.right && point.y > m_rtDraw.top && point.y < m_rtDraw.bottom )
	{
		m_bLButtonDown = TRUE;
		SetRect( &rt, m_rtDraw.left, m_rtDraw.top, m_rtDraw.right, m_rtDraw.bottom );
		ClientToScreen( &rt );
		ClipCursor( &rt );
		CGAMDoc *pDoc = (CGAMDoc*)(((CMainFrame *)AfxGetMainWnd())->GetActiveDocument());
		pt.x = point.x*pDoc->m_ptSheet.x/m_rtDraw.right - pDoc->m_pRightView->m_rtClient.right/2;
		pt.y = point.y*pDoc->m_ptSheet.y/m_rtDraw.bottom - pDoc->m_pRightView->m_rtClient.bottom/2;
		pDoc->ScrollToPos( pt );
	}
	else CSCBar::OnLButtonDown(nFlags, point);
}

void CMiniMap::OnMouseMove(UINT nFlags, CPoint point) 
{
	POINT pt;
	if(m_bLButtonDown)
	{
		CGAMDoc *pDoc = (CGAMDoc*)(((CMainFrame *)AfxGetMainWnd())->GetActiveDocument());
		pt.x = point.x*pDoc->m_ptSheet.x/m_rtDraw.right - pDoc->m_pRightView->m_rtClient.right/2;
		pt.y = point.y*pDoc->m_ptSheet.y/m_rtDraw.bottom - pDoc->m_pRightView->m_rtClient.bottom/2;
		pDoc->ScrollToPos( pt );
	}
	else CSCBar::OnMouseMove(nFlags, point);
}

void CMiniMap::OnLButtonUp(UINT nFlags, CPoint point) 
{
	m_bLButtonDown = FALSE;
	ClipCursor(NULL);
	CSCBar::OnLButtonUp(nFlags, point);
}
