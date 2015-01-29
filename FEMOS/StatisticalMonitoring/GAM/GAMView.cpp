// GAMView.cpp : implementation of the CGAMView class
//

#include "stdafx.h"
#include "GAM.h"

#include "GAMDoc.h"
#include "GAMView.h"
#include "MainFrm.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CGAMView

IMPLEMENT_DYNCREATE(CGAMView, CScrollView)

BEGIN_MESSAGE_MAP(CGAMView, CScrollView)
	//{{AFX_MSG_MAP(CGAMView)
	ON_WM_SIZE()
	ON_WM_LBUTTONDOWN()
	ON_WM_LBUTTONUP()
	ON_WM_MOUSEMOVE()
	ON_WM_CONTEXTMENU()
	ON_WM_ERASEBKGND()
	ON_WM_KEYDOWN()
	ON_WM_KEYUP()
	ON_WM_MOUSEWHEEL()
	ON_WM_RBUTTONDOWN()
	ON_WM_LBUTTONDBLCLK()
	ON_WM_CHAR()
	ON_UPDATE_COMMAND_UI(ID_EDIT_TEXTEDIT, OnUpdateEditText)
	ON_COMMAND(ID_VIEW_GRID, OnViewGrid)
	ON_UPDATE_COMMAND_UI(ID_VIEW_GRID, OnUpdateViewGrid)
	ON_WM_CTLCOLOR()
	ON_COMMAND(ID_EDIT_TEXTEDIT, OnEditText)
	//}}AFX_MSG_MAP
	// Standard printing commands
	ON_COMMAND(ID_FILE_PRINT, CScrollView::OnFilePrint)
	ON_COMMAND(ID_FILE_PRINT_DIRECT, CScrollView::OnFilePrint)
	ON_COMMAND(ID_FILE_PRINT_PREVIEW, CScrollView::OnFilePrintPreview)
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CGAMView construction/destruction

CGAMView::CGAMView()
{
	m_bLButtonDown = FALSE;
	m_bShiftPressed = FALSE;
	m_bCtrlPressed = FALSE;
	m_bEditing = FALSE;
	m_bViewGrid = FALSE;
	m_pDoc = NULL;

	m_tooltip.Create(this, WS_POPUP | WS_EX_TOOLWINDOW | TTS_ALWAYSTIP | TTS_NOPREFIX);
	m_tooltip.SetMaxTipWidth( 1024 );
	m_tooltip.SetDelayTime( TTDT_INITIAL, 200 );
	m_tooltip.SetDelayTime( TTDT_RESHOW, 200 );
	m_tooltip.SetDelayTime( TTDT_AUTOPOP, 20000 );
	m_tooltip.SetTipTextColor( RGB(0,0,255) );
}

CGAMView::~CGAMView()
{
}

/////////////////////////////////////////////////////////////////////////////
// CGAMView drawing

void CGAMView::OnInitialUpdate()
{
	CScrollView::OnInitialUpdate();
	if( m_dcBuffer.m_hDC != NULL ) return;
	CGAMDoc* pDoc = GetDoc();
	ASSERT_VALID(pDoc);
	m_pDoc = pDoc;
	ChangeDisplay();
	SetFocus();
	pDoc->SetRightView(this);
}

void CGAMView::OnDraw(CDC* pDC)
{
	if( pDC->IsPrinting() )
	{
		m_dcBuffer.BitBlt( 0, 0, m_pDoc->m_ptSheet.x, m_pDoc->m_ptSheet.y, NULL, 0, 0, WHITENESS );
		DrawUnSelectedLink();
		DrawItem();
		DrawSelectedLink();
		DrawLabel();
		pDC->SetMapMode(MM_LOMETRIC);
		CSize size = pDC->GetWindowExt();
		pDC->StretchBlt( 0, 0, size.cx, -size.cx*m_pDoc->m_ptSheet.y/m_pDoc->m_ptSheet.x, &m_dcBuffer, 0, 0, m_pDoc->m_ptSheet.x, m_pDoc->m_ptSheet.y, SRCCOPY );
		Render(TRUE);
	}
	else
	{
		pDC->BitBlt( m_pDoc->m_ptScroll.x, m_pDoc->m_ptScroll.y, m_rtClient.right, m_rtClient.bottom, &m_dcBuffer, m_pDoc->m_ptScroll.x, m_pDoc->m_ptScroll.y, SRCCOPY );
		if( m_pDoc->m_ptScroll.y+m_rtClient.bottom > m_pDoc->m_ptSheet.y )
		{
			pDC->BitBlt( m_pDoc->m_ptScroll.x, m_pDoc->m_ptScroll.y+m_pDoc->m_ptSheet.y , m_rtClient.right, m_rtClient.bottom-m_pDoc->m_ptSheet.y, &m_dcBack, m_pDoc->m_ptScroll.x, m_pDoc->m_ptScroll.y, SRCCOPY );
		}
		if( m_bLButtonDown )
		{
			CPen *pOldPen;
			pDC->SetBkMode( TRANSPARENT );
			pOldPen = pDC->SelectObject( &m_pDoc->m_penDragDot );
			pDC->MoveTo( m_rtDrag.left, m_rtDrag.top );
			pDC->LineTo( m_rtDrag.right, m_rtDrag.top );
			pDC->LineTo( m_rtDrag.right, m_rtDrag.bottom );
			pDC->LineTo( m_rtDrag.left, m_rtDrag.bottom );
			pDC->LineTo( m_rtDrag.left, m_rtDrag.top );
			pDC->SelectObject( pOldPen );
		} 
		else
		{
			int i;
			int iCount = m_tooltip.GetToolCount();
			RECT rt;
			CItem *pItem;
			for( i=0 ; i<iCount ; i++ )
			{
				pItem = m_pDoc->m_pData->GetItem(i);
				if( pItem )
				{
					SetRect( &rt, pItem->m_rt.left-m_pDoc->m_ptScroll.x, pItem->m_rt.top-m_pDoc->m_ptScroll.y, pItem->m_rt.right-m_pDoc->m_ptScroll.x, pItem->m_rt.bottom-m_pDoc->m_ptScroll.y );
					m_tooltip.SetToolRect( this, i+1, &rt );
				}
			}
		}
	}
}

/////////////////////////////////////////////////////////////////////////////
// CGAMView printing

BOOL CGAMView::OnPreparePrinting(CPrintInfo* pInfo)
{
	// default preparation
	return DoPreparePrinting(pInfo);
}

/////////////////////////////////////////////////////////////////////////////
// CGAMView diagnostics

#ifdef _DEBUG
void CGAMView::AssertValid() const
{
	CScrollView::AssertValid();
}

void CGAMView::Dump(CDumpContext& dc) const
{
	CScrollView::Dump(dc);
}

CGAMDoc* CGAMView::GetDoc() // non-debug version is inline
{
	ASSERT(m_pDocument->IsKindOf(RUNTIME_CLASS(CGAMDoc)));
	return (CGAMDoc*)m_pDocument;
}
#endif //_DEBUG

/////////////////////////////////////////////////////////////////////////////
// CGAMView message handlers

void CGAMView::ChangeDisplay()
{
	if( m_pDoc == NULL ) return;
	if( m_dcBuffer.m_hDC != NULL )
	{
		m_dcBuffer.DeleteDC();
		m_dcBack.DeleteDC();
	}
	CDC *pDC = GetDC();
	m_dcBuffer.CreateCompatibleDC(pDC);
	m_dcBack.CreateCompatibleDC(pDC);
	CBitmap bmpBuffer, bmpBack;
	bmpBuffer.CreateCompatibleBitmap(pDC, m_pDoc->m_ptSheet.x, m_pDoc->m_ptSheet.y);
	bmpBack.CreateCompatibleBitmap(pDC, m_pDoc->m_ptSheet.x, m_pDoc->m_ptSheet.y);
	ReleaseDC(pDC);
	m_dcBack.SelectObject(&bmpBack);
	m_dcBuffer.SelectObject(&bmpBuffer);

	if( m_bViewGrid ) SetGridColor( ::GetSysColor(COLOR_3DFACE), ::GetSysColor(COLOR_3DSHADOW) );
	else SetGridColor( ::GetSysColor(COLOR_3DFACE), ::GetSysColor(COLOR_3DFACE) );

	m_dcBuffer.SetBkMode( TRANSPARENT );
	SetScrollSizes(MM_TEXT, CSize(m_pDoc->m_ptSheet.x,m_pDoc->m_ptSheet.y));
}

void CGAMView::OnSize(UINT nType, int cx, int cy) 
{
	CScrollView::OnSize(nType, cx, cy);
	GetClientRect( &m_rtClient );
	if( m_pDoc != NULL )
	{
		if( m_pDoc->m_pRightView != NULL )
		{
			POINT pt;
			pt.x = ((m_pDoc->m_ptSheet.x-cx)/64)*32;
			pt.y = -1;
			m_pDoc->ScrollToPos( pt );
		}
	}
}

BOOL CGAMView::OnEraseBkgnd(CDC* pDC) 
{
	return m_bEditing;
}

void CGAMView::Render(BOOL bRedraw)
{
	if( m_pDoc == NULL ) return;
	if( m_dcBuffer.m_hDC == NULL ) return;
	if( m_bEditing ) return;

	if( bRedraw )
	{
		CBrush *pOldBrush;
		CPen *pOldPen;
		pOldBrush = m_dcBuffer.SelectObject( &m_pDoc->m_brsWindowColour );
		pOldPen = m_dcBuffer.SelectObject( &m_pDoc->m_penWindowText );
		m_dcBuffer.BitBlt( 0, 0, m_pDoc->m_ptSheet.x, m_pDoc->m_ptSheet.y, &m_dcBack, 0, 0, SRCCOPY );
		DrawUnSelectedLink();
		DrawItem();
		DrawSelectedLink();
		DrawLabel();
		DrawToolTip();
		m_dcBuffer.SelectObject( pOldBrush );
		m_dcBuffer.SelectObject( pOldPen );
	}
	InvalidateRect( &m_rtClient, FALSE );
}

void CGAMView::DrawItem()
{
	int i;
	RECT *prt;
	CItem *pItem;
	for( i=0 ; i<DEF_MAXITEM ; i++ )
	{
		pItem = m_pDoc->m_pData->GetItem(i);
		if( pItem == NULL ) break;
		prt = &pItem->m_rt;
		if( pItem->m_bSelected )//선택된 아이템 그리기
		{
			m_dcBuffer.SelectObject( &m_pDoc->m_penWindowColour );
			m_dcBuffer.SelectObject( &m_pDoc->m_brsWindowColour );
			m_dcBuffer.Rectangle( prt );
			m_dcBuffer.SelectObject( &m_pDoc->m_penShadow );
			m_dcBuffer.MoveTo( prt->left, prt->bottom-2 );
			m_dcBuffer.LineTo( prt->left, prt->top );
			m_dcBuffer.LineTo( prt->right-1, prt->top );
			m_dcBuffer.SelectObject( &m_pDoc->m_penFace );
			m_dcBuffer.MoveTo( prt->left+1, prt->bottom-2 );
			m_dcBuffer.LineTo( prt->right-2, prt->bottom-2 );
			m_dcBuffer.LineTo( prt->right-2, prt->top );
			m_dcBuffer.SelectObject( &m_pDoc->m_penDKShadow );
			m_dcBuffer.MoveTo( prt->left+1, prt->bottom-3 );
			m_dcBuffer.LineTo( prt->left+1, prt->top+1 );
			m_dcBuffer.LineTo( prt->right-2, prt->top+1 );
		}
		else//선택되지 않은 일반 아이템 그리기
		{
			m_dcBuffer.SelectObject( &m_pDoc->m_penDKShadow );
			m_dcBuffer.SelectObject( &m_pDoc->m_brsFace );
			m_dcBuffer.Rectangle( prt );
			m_dcBuffer.SelectObject( &m_pDoc->m_penWindowColour );
			m_dcBuffer.MoveTo( prt->left, prt->bottom-2 );
			m_dcBuffer.LineTo( prt->left, prt->top );
			m_dcBuffer.LineTo( prt->right-1, prt->top );
			m_dcBuffer.SelectObject( &m_pDoc->m_penLight );
			m_dcBuffer.MoveTo( prt->left+1, prt->bottom-3 );
			m_dcBuffer.LineTo( prt->left+1, prt->top+1 );
			m_dcBuffer.LineTo( prt->right-2, prt->top+1 );
			m_dcBuffer.SelectObject( &m_pDoc->m_penShadow );
			m_dcBuffer.MoveTo( prt->left+1, prt->bottom-2 );
			m_dcBuffer.LineTo( prt->right-2, prt->bottom-2 );
			m_dcBuffer.LineTo( prt->right-2, prt->top );
		}
	}
}

void CGAMView::DrawUnSelectedLink()
{
	int i;
	CLink *pLink;
	//비선택 링크 그리는 부분
	for( i=0 ; i<DEF_MAXLINK ; i++ )
	{
		pLink = m_pDoc->m_pData->GetLink(i);
		if( pLink == NULL ) break;
		if( pLink->m_bSelected ) continue;//선택된 링크면 스킵
		if( pLink->m_fWeight < 0 )
		{
			m_dcBuffer.SelectObject( &m_pDoc->m_penWindowText );
			//m_dcBuffer.SelectObject( &m_pDoc->m_penShadow );
		}
		else
		{
			m_dcBuffer.SelectObject( &m_pDoc->m_penWindowText );
		}
		m_dcBuffer.MoveTo( pLink->m_ptParent );
		m_dcBuffer.LineTo( pLink->m_ptChild );
	}
	//비선택 링크 그리는 부분
}

void CGAMView::DrawSelectedLink()
{
	int i;
	RECT rt;
	CLink *pLink;
	//선택된 링크 그리는 부분
	m_dcBuffer.SelectObject( &m_pDoc->m_penRed );
	m_dcBuffer.SelectObject( &m_pDoc->m_brsWindowColour );
	for( i=0 ; i<DEF_MAXLINK ; i++ )
	{
		pLink = m_pDoc->m_pData->GetLink(i);
		if( pLink == NULL ) break;
		if( !pLink->m_bSelected ) continue;//비선택 링크면 스킵
		{
			m_dcBuffer.MoveTo( pLink->m_ptParent );
			m_dcBuffer.LineTo( pLink->m_ptChild );
			SetRect( &rt, pLink->m_ptParent.x-3, pLink->m_ptParent.y-3, pLink->m_ptParent.x+4, pLink->m_ptParent.y+4 );
			m_dcBuffer.Ellipse( &rt );
			SetRect( &rt, pLink->m_ptChild.x-3, pLink->m_ptChild.y-3, pLink->m_ptChild.x+4, pLink->m_ptChild.y+4 );
			m_dcBuffer.Ellipse( &rt );
		}
	}
}

void CGAMView::DrawLabel()
{
	int i, iType;
	RECT rt;
	POINT pt;
	CString cStr, cTmp1, cTmp2;
	CItem *pItem;
	CLink *pLink;
	CAlter *pAlter;
	pAlter = m_pDoc->m_pData->GetCurAlter();
	if( pAlter == NULL ) return;
	pItem = m_pDoc->m_pData->GetItem(0);
	if( pItem != NULL )
	{
		rt = pItem->m_rt;
		rt.left = 0;
		rt.right = m_pDoc->m_ptSheet.x;
		rt.top -= DEF_TILESIZE;
		m_dcBuffer.SetTextColor( RGB(255,0,0) );
		m_dcBuffer.DrawText( pAlter->cStrAlter, &rt, DT_CENTER | DT_NOCLIP | DT_END_ELLIPSIS);
		m_dcBuffer.SetTextColor( RGB(0,0,0) );
	}
	for( i=0 ; i<DEF_MAXITEM ; i++ )
	{
		pItem = m_pDoc->m_pData->GetItem(i);
		if( pItem == NULL ) break;
		rt = pItem->m_rt;
		rt.top += 3;
		m_dcBuffer.DrawText( pItem->m_cLabel, &rt, DT_CENTER | DT_NOCLIP | DT_END_ELLIPSIS);
		rt.top += 21;
		iType = pItem->m_iValueType;
		if( iType >= 0 )
		{
			if( iType >= 100 ) cStr = _T("Descending");
			else cStr = _T("Ascending");
			m_dcBuffer.DrawText( cStr, &rt, DT_CENTER | DT_NOCLIP | DT_END_ELLIPSIS);
			if( iType%10 == 0 ) cStr = _T("Linear");
			else
			{
				if( (iType/10)%10 != 0 ) cStr.Format( "Accel Down, %d", iType%10 );
				else cStr.Format( "Accel Up, %d", iType%10 );
			}
			rt.top += 21;
			m_dcBuffer.DrawText( cStr, &rt, DT_CENTER | DT_NOCLIP | DT_END_ELLIPSIS);
		}
	}

	m_dcBuffer.SetTextColor( RGB(0,0,255) );

	for( i=0 ; i<DEF_MAXLINK ; i++ )
	{
		pLink = m_pDoc->m_pData->GetLink(i);
		if( pLink == NULL ) break;
		pt.x = pLink->m_ptChild.x*2/3+pLink->m_ptParent.x/3;
		if( pLink->m_fWeight < 0.0f )
		{
			cStr = _T("N/A");
		}
		else
		{
			cTmp1.Format( "%f", pLink->m_fWeight );
			cTmp1.TrimRight( '0' );
			cTmp1.TrimRight( '.' );
			cStr = cTmp1;
			if( m_pDoc->GetPercentage(i) < 0.0f )
			{
			}
			else
			{
				cTmp2.Format( "(%.1f", m_pDoc->GetPercentage(i) );
				cTmp2.TrimRight( '0' );
				cTmp2.TrimRight( '.' );
				cStr += cTmp2;
				cStr += _T("%)");
			}
		}
		if( pLink->m_ptChild.x < pLink->m_ptParent.x )
		{
			SetRect( &rt, pt.x-DEF_TILESIZE*4, pLink->m_ptChild.y-33, pt.x, pLink->m_ptChild.y );
			m_dcBuffer.DrawText( cStr, &rt, DT_RIGHT | DT_NOCLIP | DT_END_ELLIPSIS);
		}
		else
		{
			SetRect( &rt, pt.x, pLink->m_ptChild.y-33, pt.x+DEF_TILESIZE*4, pLink->m_ptChild.y );
			m_dcBuffer.DrawText( cStr, &rt, DT_LEFT | DT_NOCLIP | DT_END_ELLIPSIS);
		}
	}
	m_dcBuffer.SetTextColor( RGB(0,0,0) );
}

void CGAMView::DrawToolTip()
{
	int i, j, iType;
	RECT rt;
	CItem *pItem;
	CAlter *pAlter;
	CString cStr, cTemp;
	for( i=0 ; i<DEF_MAXITEM ; i++ )
	{
		m_tooltip.DelTool( this, i+1 );
	}
	for( i=0 ; i<DEF_MAXITEM ; i++ )
	{
		pItem = m_pDoc->m_pData->GetItem(i);
		if( pItem == NULL ) break;
		SetRect( &rt, pItem->m_rt.left-m_pDoc->m_ptScroll.x, pItem->m_rt.top-m_pDoc->m_ptScroll.y, pItem->m_rt.right-m_pDoc->m_ptScroll.x, pItem->m_rt.bottom-m_pDoc->m_ptScroll.y );
		iType = pItem->m_iValueType;
		cStr.Format( "Label : %s", pItem->m_cLabel );
		cStr += "\r\nSort : ";
		if( iType >= 100 ) cStr += "Descending";
		else cStr += "Ascending";
		cStr += "\r\nAccel : ";
		if( (iType/10)%10 != 0 ) cStr += "Down";
		else cStr += "Up";
		cStr += "\r\nDepth : ";
		cTemp.Format( "%d", iType%10 );
		cStr += cTemp;
		cStr += "\r\nAlternative\tData\t\tScore";

		for( j=0 ; j<DEF_MAXALTER ; j++ )
		{
			pAlter = m_pDoc->m_pData->GetAlter(j);
			if( pAlter == NULL ) break;
			cTemp.Format( "\r\n%s", pAlter->cStrAlter );
			cStr += cTemp;
			cTemp.Format( "\t\t%f", pAlter->m_pDataSet[i]->m_fValue );
			cStr += cTemp;
			cTemp.Format( "\t%f", pAlter->m_pDataSet[i]->m_fPoint );
			cStr += cTemp;
		}
		m_tooltip.AddTool( this, cStr, &rt, i+1 );
	}
}

void CGAMView::OnViewGrid() 
{
	m_bViewGrid = !m_bViewGrid;
	if( m_bViewGrid ) SetGridColor( ::GetSysColor(COLOR_3DFACE), ::GetSysColor(COLOR_3DSHADOW) );
	else SetGridColor( ::GetSysColor(COLOR_3DFACE), ::GetSysColor(COLOR_3DFACE) );
	Render(TRUE);
}

void CGAMView::OnUpdateViewGrid(CCmdUI* pCmdUI) 
{
	if( m_bViewGrid ) pCmdUI->SetCheck(1);
	else pCmdUI->SetCheck(0);
}

void CGAMView::OnKeyDown(UINT nChar, UINT nRepCnt, UINT nFlags) 
{
	POINT pt;
	if( m_pDoc == NULL ) return;
	if( nChar == VK_F2 ) OnEditText();
	if( nChar == VK_SHIFT ) m_bShiftPressed = TRUE;
	if( nChar == VK_CONTROL ) m_bCtrlPressed = TRUE;
	if( nChar == VK_DELETE ) m_pDoc->OnEditRemoveitem();
	if( nChar == VK_INSERT )
	{
		if( m_bCtrlPressed ) m_pDoc->AddChilds();
		else m_pDoc->AddChild();
	}
	if( nChar == VK_TAB ) m_pDoc->ChangeSelection( m_bShiftPressed );
	if( nChar == VK_LEFT )
	{
		pt.x = -DEF_TILESIZE;
		pt.y = 0;
		m_pDoc->ScrollByPos( pt );
	}
	if( nChar == VK_RIGHT )
	{
		pt.x = DEF_TILESIZE;
		pt.y = 0;
		m_pDoc->ScrollByPos( pt );
	}
	if( nChar == VK_UP )
	{
		pt.x = 0;
		pt.y = -DEF_TILESIZE;
		m_pDoc->ScrollByPos( pt );
	}
	if( nChar == VK_DOWN )
	{
		pt.x = 0;
		pt.y = DEF_TILESIZE;
		m_pDoc->ScrollByPos( pt );
	}
	CScrollView::OnKeyDown(nChar, nRepCnt, nFlags);
}

void CGAMView::OnKeyUp(UINT nChar, UINT nRepCnt, UINT nFlags) 
{
	if( nChar == VK_SHIFT ) m_bShiftPressed = FALSE;
	if( nChar == VK_CONTROL ) m_bCtrlPressed = FALSE;
	CScrollView::OnKeyUp(nChar, nRepCnt, nFlags);
}

BOOL CGAMView::OnScroll(UINT nScrollCode, UINT nPos, BOOL bDoScroll) 
{
	// calc new x position
	int x = GetScrollPos(SB_HORZ);
	int xOrig = x;

	switch (LOBYTE(nScrollCode))
	{
	case SB_LINELEFT://0
		x -= DEF_TILESIZE;
		break;
	case SB_LINERIGHT://1
		x += DEF_TILESIZE;
		break;
	case SB_PAGELEFT://2
		x -= m_pageDev.cx;
		break;
	case SB_PAGERIGHT://3
		x += m_pageDev.cx;
		break;
	case SB_THUMBPOSITION://4
	case SB_THUMBTRACK://5
		x = nPos;
		break;
	case SB_LEFT://6
		x = 0;
		break;
	case SB_RIGHT://7
		x = INT_MAX;
		break;
	}

	// calc new y position
	int y = GetScrollPos(SB_VERT);
	int yOrig = y;

	switch (HIBYTE(nScrollCode))
	{
	case SB_LINEUP://0
		y -= DEF_TILESIZE;
		break;
	case SB_LINEDOWN://1
		y += DEF_TILESIZE;
		break;
	case SB_PAGEUP://2
		y -= m_pageDev.cy;
		break;
	case SB_PAGEDOWN://3
		y += m_pageDev.cy;
		break;
	case SB_THUMBPOSITION://4
	case SB_THUMBTRACK://5
		y = nPos;
		break;
	case SB_TOP://6
		y = 0;
		break;
	case SB_BOTTOM://7
		y = INT_MAX;
		break;
	}
	if( x == xOrig && y == yOrig ) return FALSE;
	POINT pt;
	pt.x = x-xOrig;
	pt.y = y-yOrig;
	m_pDoc->ScrollByPos(pt);
	return FALSE;
}

BOOL CGAMView::OnMouseWheel(UINT nFlags, short zDelta, CPoint pt) 
{
	POINT ptNew;
	if( zDelta == 0 ) return CScrollView::OnMouseWheel(nFlags, zDelta, pt);
	if( zDelta < 0 ) ptNew.x = DEF_TILESIZE*2;
	else ptNew.x = -DEF_TILESIZE*2;
	ptNew.y = 0;
	m_pDoc->ScrollByPos( ptNew );
	return FALSE;
}

void CGAMView::OnLButtonDblClk(UINT nFlags, CPoint point) 
{
	m_pDoc->OnViewProperties();
	CScrollView::OnLButtonDblClk(nFlags, point);
}

void CGAMView::OnMouseMove(UINT nFlags, CPoint point) 
{
	CString str;
	CMainFrame *pFrame = (CMainFrame*)AfxGetMainWnd();
	if( pFrame )
	{
		str.Format( "%d, %d", point.x, point.y );
		((CStatusBar*)(pFrame->GetMessageBar()))->SetPaneText( 2, str );
	}

	if( m_bLButtonDown )
	{
		m_rtDrag.right = point.x + m_pDoc->m_ptScroll.x;
		m_rtDrag.bottom = point.y + m_pDoc->m_ptScroll.y;
		InvalidateRect( &m_rtClient, FALSE );
	}
	CScrollView::OnMouseMove(nFlags, point);
}

void CGAMView::OnLButtonDown(UINT nFlags, CPoint point) 
{
	int iIndex;
	char cStr[64];
	RECT rt;
	ZeroMemory( cStr, sizeof(cStr) );
	m_bLButtonDown = TRUE;
	if( m_bEditing )
	{
		iIndex = -1;
		if( point.x <= m_rtEditing.left || point.x >= m_rtEditing.right || point.y >= m_rtEditing.top || point.y <= m_rtEditing.bottom )
		{
			if( m_pDoc->GetSelectedItemNo() == 1 )
			{
				m_pDoc->GetSelectedItem( &iIndex );
				if( iIndex >= 0 )
				{
					m_editStr.GetWindowText( cStr, 64 );
					m_pDoc->SetLabel(cStr);
					m_editStr.DestroyWindow();
					m_bEditing = FALSE;
				}
			}
		}
	}
	if( m_bShiftPressed == FALSE )
	{
		m_pDoc->ClearSelected();
		m_pDoc->UpdateAll( TRUE, FALSE );
	}
	m_rtDrag.left = point.x + m_pDoc->m_ptScroll.x;
	m_rtDrag.top = point.y + m_pDoc->m_ptScroll.y;
	m_rtDrag.right = point.x + m_pDoc->m_ptScroll.x;
	m_rtDrag.bottom = point.y + m_pDoc->m_ptScroll.y;
	rt = m_rtClient;
	ClientToScreen( &rt );
	ClipCursor( &rt );
	CScrollView::OnLButtonDown(nFlags, point);
}

void CGAMView::OnLButtonUp(UINT nFlags, CPoint point) 
{
	RECT rt;
	m_bLButtonDown = FALSE;
	if( m_rtDrag.left > m_rtDrag.right )
	{
		rt.left = m_rtDrag.right;
		m_rtDrag.right = m_rtDrag.left;
		m_rtDrag.left = rt.left;
	}
	if( m_rtDrag.top > m_rtDrag.bottom )
	{
		rt.top = m_rtDrag.bottom;
		m_rtDrag.bottom = m_rtDrag.top;
		m_rtDrag.top = rt.top;
	}
	m_pDoc->CheckSelected( &m_rtDrag, m_bShiftPressed );
	m_rtDrag.left = 0;
	m_rtDrag.top = 0;
	m_rtDrag.right = 0;
	m_rtDrag.bottom = 0;
	ClipCursor( NULL );
	CScrollView::OnLButtonUp(nFlags, point);
}

void CGAMView::OnRButtonDown(UINT nFlags, CPoint point) 
{
	int i, iIndex;
	char cStr[64];
	POINT pt;
	BOOL bCheck;
	CItem *pItem;
	CLink *pLink;
	pt.x = point.x + m_pDoc->m_ptScroll.x;
	pt.y = point.y + m_pDoc->m_ptScroll.y;
	bCheck = FALSE;
	if( m_bEditing )
	{
		if( m_pDoc->GetSelectedItemNo() == 1 )
		{
			m_pDoc->GetSelectedItem( &iIndex );
			if( iIndex >= 0 )
			{
				ZeroMemory( cStr, sizeof(cStr) );
				m_editStr.GetWindowText( cStr, 64 );
				m_pDoc->SetLabel(cStr);
			}
		}
		m_editStr.DestroyWindow();
		m_bEditing = FALSE;
	}
	for( i=0 ; i<DEF_MAXITEM ; i++ )
	{
		pItem = m_pDoc->m_pData->GetItem(i);
		if( pItem == NULL ) break;
		if( pItem->m_bSelected )
		{
			if( m_pDoc->IsPointInRect( &pt, &pItem->m_rt ) )
			{
				bCheck = TRUE;
				break;
			}
		}
	}
	for( i=0 ; i<DEF_MAXLINK ; i++ )
	{
		pLink = m_pDoc->m_pData->GetLink(i);
		if( pLink == NULL ) break;
		if( pLink->m_bSelected )
		{
			if( m_pDoc->IsPointNearLine( &pt, &pLink->m_ptParent, &pLink->m_ptChild ) )
			{
				bCheck = TRUE;
				break;
			}
		}
	}
	if( bCheck == FALSE )
	{
		m_pDoc->ClearSelected();
		for( i=0 ; i<DEF_MAXITEM ; i++ )
		{
			pItem = m_pDoc->m_pData->GetItem(i);
			if( pItem == NULL ) break;
			if( m_pDoc->IsPointInRect( &pt, &pItem->m_rt ) )
			{
				pItem->m_bSelected = TRUE;
				break;
			}
		}
		for( i=0 ; i<DEF_MAXLINK ; i++ )
		{
			pLink = m_pDoc->m_pData->GetLink(i);
			if( pLink == NULL ) break;
			if( m_pDoc->IsPointNearLine( &pt, &pLink->m_ptParent, &pLink->m_ptChild ) )
			{
				pLink->m_bSelected = TRUE;
				break;
			}
		}
	}
	m_pDoc->UpdateAll(TRUE, FALSE);
	CScrollView::OnRButtonDown(nFlags, point);
}

void CGAMView::OnContextMenu(CWnd* pWnd, CPoint point) 
{
	int iSelItemCount, iSelLinkCount;
	ScreenToClient( &point );
	if( point.x < m_rtClient.right && point.y < m_rtClient.bottom )
	{
		CMenu topmenu;
		CMenu menu;
		CString str;
		topmenu.LoadMenu( IDR_MAINFRAME );
		menu.Attach( topmenu.GetSubMenu(1)->GetSafeHmenu() );
		iSelItemCount = m_pDoc->GetSelectedItemNo();
		iSelLinkCount = m_pDoc->GetSelectedLinkNo();
		if( iSelItemCount == 1 && iSelLinkCount == 0 )
			menu.AppendMenu( MF_STRING, ID_VIEW_ONGRAPH, "Show on Graph" );
		else menu.AppendMenu( MF_GRAYED, 0, "Show on Graph" );
		if( iSelItemCount < 1 )
			menu.AppendMenu( MF_DISABLED, 0, "No item has been selected" );
		else if( iSelItemCount == 1 )
			menu.AppendMenu( MF_DISABLED, 0, "1 item has been selected" );
		else
		{
			str.Format( "%d items have been selected", iSelItemCount );
			menu.AppendMenu( MF_DISABLED, 0, str );
		}
		if( iSelLinkCount < 1 )
			menu.AppendMenu( MF_DISABLED, 0, "No link has been selected" );
		else if( iSelLinkCount == 1 )
			menu.AppendMenu( MF_DISABLED, 0, "1 link has been selected" );
		else
		{
			str.Format( "%d links have been selected", iSelLinkCount );
			menu.AppendMenu( MF_DISABLED, 0, str );
		}

		if( iSelItemCount != 1 || iSelLinkCount != 0 )
		{
			menu.EnableMenuItem( ID_EDIT_ADDCHILD, MF_BYCOMMAND | MF_GRAYED );
			menu.EnableMenuItem( ID_EDIT_ADDCHILDS, MF_BYCOMMAND | MF_GRAYED );
			menu.EnableMenuItem( ID_EDIT_TEXTEDIT, MF_BYCOMMAND | MF_GRAYED );
		}
		
		if( iSelItemCount == 0 )
		{
			menu.EnableMenuItem( ID_EDIT_REMOVEITEM, MF_BYCOMMAND | MF_GRAYED );
		}
		if( iSelItemCount != 1 && iSelLinkCount != 1 )
		{
			menu.EnableMenuItem( ID_EDIT_PROPERTIES, MF_BYCOMMAND | MF_GRAYED );
			menu.SetDefaultItem( ID_EDIT_CALCULATE, FALSE );
		}
		else menu.SetDefaultItem( ID_EDIT_PROPERTIES, FALSE );
		if( iSelItemCount != 2 || iSelLinkCount != 0 )
		{
			menu.EnableMenuItem( ID_EDIT_ADDLINK, MF_BYCOMMAND | MF_GRAYED );
		}

		SetForegroundWindow();
		ClientToScreen(&point);
		menu.TrackPopupMenu( TPM_LEFTALIGN, point.x, point.y, this, NULL );
		CScrollView::OnContextMenu(pWnd, point);
	}
	else CScrollView::OnContextMenu(pWnd, point);
}

void CGAMView::OnChar(UINT nChar, UINT nRepCnt, UINT nFlags) 
{
	if( nChar != VK_TAB ) OnEditText();
	CScrollView::OnChar(nChar, nRepCnt, nFlags);
}

void CGAMView::OnEditText()
{
	int iIndex, iLength;
	CItem *pItem;
	if( m_pDoc->GetSelectedItemNo() != 1 ) return;
	m_pDoc->GetSelectedItem( &iIndex );
	if( iIndex < 0 ) return;
	pItem = m_pDoc->m_pData->GetItem(iIndex);
	if( pItem == NULL ) return;
	SetRect( &m_rtEditing, pItem->m_rt.left-m_pDoc->m_ptScroll.x+2, pItem->m_rt.top - m_pDoc->m_ptScroll.y+3, pItem->m_rt.right-m_pDoc->m_ptScroll.x-2, pItem->m_rt.top-m_pDoc->m_ptScroll.y+25 );
	if( m_bEditing ) m_editStr.DestroyWindow();
	m_bEditing = TRUE;
	m_editStr.Create( WS_CHILD | ES_CENTER | ES_AUTOHSCROLL, m_rtEditing, this, ID_EDIT_WINDOW );
	m_editStr.SetWindowText( pItem->m_cLabel );
	iLength = strlen( pItem->m_cLabel );
	m_editStr.LimitText( 32 );
	m_editStr.SetFocus();
	m_editStr.SetSel( iLength, iLength, FALSE );
	m_editStr.ShowWindow( SW_SHOW );
}

void CGAMView::OnUpdateEditText(CCmdUI* pCmdUI) 
{
	if( m_pDoc->GetSelectedItemNo() == 1 && m_bEditing == FALSE ) pCmdUI->Enable(TRUE);
	else pCmdUI->Enable(FALSE);
}

BOOL CGAMView::PreTranslateMessage(MSG* pMsg) 
{
	m_tooltip.RelayEvent(pMsg);
	return CScrollView::PreTranslateMessage(pMsg);
}

void CGAMView::SetGridColor(COLORREF back, COLORREF grid)
{
	int x, y;
	CBitmap bmpBack;
	CDC dcTile;
	CBrush brush;
	RECT rt;
	brush.CreateSolidBrush( back );
	dcTile.CreateCompatibleDC(&m_dcBack);
	bmpBack.CreateCompatibleBitmap(&m_dcBack, DEF_TILESIZE, DEF_TILESIZE);
	dcTile.SelectObject(&bmpBack);
	SetRect( &rt, 0, 0, DEF_TILESIZE, DEF_TILESIZE );
	dcTile.FillRect( &rt, &brush );
	if( back != grid )
	{
		for( x=0 ; x<DEF_TILESIZE ; x+=4 )
		{
			dcTile.SetPixel( x, 0, grid );
			dcTile.SetPixel( x+1, 0, grid );
			dcTile.SetPixel( x+2, 0, grid );
		}
		for( x=0 ; x<DEF_TILESIZE ; x+=2 )
		{
			dcTile.SetPixel( x, 16, grid );
		}
		for( y=0 ; y<DEF_TILESIZE ; y+=4 )
		{
			dcTile.SetPixel( 0, y, grid );
			dcTile.SetPixel( 0, y+1, grid );
			dcTile.SetPixel( 0, y+2, grid );
		}
		for( y=0 ; y<DEF_TILESIZE ; y+=2 )
		{
			dcTile.SetPixel( 16, y, grid );
		}
	}

	for( x=0; x < m_pDoc->m_ptSheet.x ; x+=DEF_TILESIZE )
	{
		for( y=0 ; y < m_pDoc->m_ptSheet.y ; y+=DEF_TILESIZE )
		{
			m_dcBack.BitBlt( x, y, DEF_TILESIZE, DEF_TILESIZE, &dcTile, 0, 0, SRCCOPY );
		}
	}
}

