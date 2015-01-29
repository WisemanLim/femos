// Graph.cpp : implementation file
//

#include "stdafx.h"
#include "GAM.h"
#include "Graph.h"
#include "MainFrm.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CGraph

CGraph::CGraph()
{
	m_pGraph = NULL;
	m_pCurItem = NULL;
	m_rgb[0] = RGB(255,0,255);
	m_rgb[1] = RGB(0,255,255);
	m_rgb[2] = RGB(255,255,0);
	m_rgb[3] = RGB(255,0,0);
	m_rgb[4] = RGB(0,255,0);
	m_rgb[5] = RGB(0,0,255);
	for( int i=6 ; i<DEF_MAXALTER ; i++ )
	{
		m_rgb[i] = RGB(rand()%255, rand()%255, rand()%255 );
	}
}

CGraph::~CGraph()
{
	if( m_pGraph != NULL ) delete m_pGraph;
}


BEGIN_MESSAGE_MAP(CGraph, CSCBar)
	//{{AFX_MSG_MAP(CGraph)
    ON_WM_SIZE()
	ON_WM_CREATE()
	//}}AFX_MSG_MAP
	ON_CBN_SELCHANGE(ID_COMBO_GRAPHTYPE, ChangeGraphType)
	ON_CBN_SELCHANGE(ID_COMBO_GRAPHEFFECT, DrawGraph)
	ON_CBN_SELCHANGE(ID_COMBO_GRAPHITEMID, ChangeItemID)
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CGraph message handlers

int CGraph::OnCreate(LPCREATESTRUCT lpCreateStruct) 
{
	char cStr[32];
	ZeroMemory( cStr, sizeof(cStr) );
	if( CSCBar::OnCreate(lpCreateStruct) == -1 ) return -1;
	if( m_cbGraphType.Create( WS_CHILD | WS_VISIBLE | WS_VSCROLL | CBS_AUTOHSCROLL | CBS_DROPDOWNLIST | CBS_HASSTRINGS, CRect(0,0,55,300), this, ID_COMBO_GRAPHTYPE ) == 0 ) return -1;
	if( m_cbGraphEffect.Create( WS_CHILD | WS_VISIBLE | WS_VSCROLL | CBS_AUTOHSCROLL | CBS_DROPDOWNLIST | CBS_HASSTRINGS, CRect(55,0,88,300), this, ID_COMBO_GRAPHEFFECT ) == 0 ) return -1;
	if( m_cbGraphItemID.Create( WS_CHILD | WS_VISIBLE | WS_VSCROLL | CBS_AUTOHSCROLL | CBS_DROPDOWNLIST | CBS_HASSTRINGS, CRect(88,0,120,300), this, ID_COMBO_GRAPHITEMID ) == 0 ) return -1;
	
	m_cbGraphType.AddString( "Pie" );
	m_cbGraphType.AddString( "Bar" );
	m_cbGraphType.AddString( "Line" );
	m_cbGraphType.SetCurSel( 0 );
	m_cbGraphEffect.AddString( "1" );
	m_cbGraphEffect.AddString( "2" );
	m_cbGraphEffect.AddString( "3" );
	m_cbGraphEffect.SetCurSel( 0 );
	return 0;
}

void CGraph::OnUpdateCmdUI(CFrameWnd* pTarget, BOOL bDisableIfNoHndler)
{
    CSCBar::OnUpdateCmdUI(pTarget, bDisableIfNoHndler);
    UpdateDialogControls(pTarget, bDisableIfNoHndler);
}

void CGraph::OnSize(UINT nType, int cx, int cy) 
{
	RECT rt;
	int ix1, ix2;
    CSCBar::OnSize(nType, cx, cy);
	if( AfxGetMainWnd() == NULL ) return;
	GetClientRect(&rt);
	ix1 = max( rt.right/4, 55 );
	m_cbGraphType.MoveWindow( 0, 0, ix1, 200 );
	ix2 = max( rt.right/6, 33 );
	m_cbGraphEffect.MoveWindow( ix1, 0, ix2, 200 );
	m_cbGraphItemID.MoveWindow( ix1+ix2, rt.top, rt.right-ix1-ix2+1, 200 );
	DrawGraph();
}

void CGraph::ChangeGraphType()
{
	int iSel = m_cbGraphEffect.GetCurSel();
	m_cbGraphEffect.ResetContent();
	m_cbGraphEffect.AddString( "1" );
	m_cbGraphEffect.AddString( "2" );
	m_cbGraphEffect.AddString( "3" );
	if( m_cbGraphType.GetCurSel() == 1 )
	{
		m_cbGraphEffect.AddString( "4" );
		m_cbGraphEffect.AddString( "5" );
		m_cbGraphEffect.AddString( "6" );
		m_cbGraphEffect.SetCurSel(iSel);
	}
	else
	{
		if( iSel > 2 ) m_cbGraphEffect.SetCurSel(1);
		else m_cbGraphEffect.SetCurSel(iSel);
	}
	DrawGraph();
}

void CGraph::ChangeItemID()
{
	CGAMDoc *pDoc;
	pDoc = (CGAMDoc*)(((CMainFrame *)AfxGetMainWnd())->GetActiveDocument());
	if( pDoc == NULL ) return;
	m_pCurItem = pDoc->m_pData->GetItem(m_cbGraphItemID.GetCurSel());
	DrawGraph();
}

void CGraph::Render()
{
	int i;
	BOOL bRemain;
	CItem *pItem;
	CGAMDoc *pDoc;
	bRemain = FALSE;
	pDoc = (CGAMDoc*)(((CMainFrame *)AfxGetMainWnd())->GetActiveDocument());
	if( pDoc == NULL ) return;
	m_cbGraphItemID.ResetContent();
	for( i=0 ; i<DEF_MAXITEM ; i++ )
	{
		pItem = pDoc->m_pData->GetItem(i);
		if( pItem == NULL ) break;
		m_cbGraphItemID.AddString( pItem->m_cLabel );
		if( bRemain == FALSE && m_pCurItem == pItem )
		{
			bRemain = TRUE;
			m_cbGraphItemID.SetCurSel(i);
		}
	}
	if( bRemain == FALSE )
	{
		pItem = pDoc->m_pData->GetItem(0);
		if( pItem != NULL )
		{
			m_pCurItem = pItem;
			m_cbGraphItemID.SetCurSel(0);
		}
	}
	DrawGraph();
}

void CGraph::DrawGraph()
{
	int iGraphType;
	RECT rt;
	CGAMDoc *pDoc;
	pDoc = (CGAMDoc*)(((CMainFrame *)AfxGetMainWnd())->GetActiveDocument());
	if( m_cbGraphType.m_hWnd == NULL ) return;
	if( AfxGetMainWnd() == NULL ) return;
	if( m_pCurItem == NULL ) return;
	if( pDoc == NULL ) return;
	if( pDoc->m_pData == NULL ) return;
	if( m_pGraph != NULL ) delete m_pGraph;
	m_pGraph = new CGraphObject();
	GetClientRect(&rt);
	rt.top += 26;
	m_pGraph->Create( NULL, NULL, NULL, rt, this, ID_OBJECT_GRAPH, NULL );

	iGraphType = m_cbGraphType.GetCurSel();
	m_pGraph->CreateGraph( iGraphType );
	m_pGraph->SetGraphTitle( m_pCurItem->m_cLabel );
	switch( iGraphType )
	{
	case GT_2DPIE:
		DrawPie();
		break;
	case GT_2DBAR:
		DrawBar();
		break;
	case GT_2DLINE:
		DrawLine();
		break;
	default:
		return;
	}
	m_pGraph->Invalidate();
}

void CGraph::DrawPie()
{
	int i, iSel;
	CAlter *pAlter;
	float fSum;
	CGAMDoc *pDoc = (CGAMDoc*)(((CMainFrame *)AfxGetMainWnd())->GetActiveDocument());
	iSel = m_cbGraphItemID.GetCurSel();
	fSum = 0.0f;
	for( i=0 ; i<pDoc->m_pData->m_iNoAlter ; i++ )
	{
		pAlter = pDoc->m_pData->GetAlter(i);
		if( pAlter == NULL ) break;
		fSum += pAlter->m_pDataSet[iSel]->m_fPoint;
	}
	for( i=0 ; i<pDoc->m_pData->m_iNoAlter ; i++ )
	{
		pAlter = pDoc->m_pData->GetAlter(i);
		if( pAlter == NULL ) break;
		if( fSum == 0 ) m_pGraph->Add2DPieGraphSegment( 100/pDoc->m_pData->m_iNoAlter, m_rgb[i], pAlter->cStrAlter );
		else m_pGraph->Add2DPieGraphSegment( (int)(pAlter->m_pDataSet[iSel]->m_fPoint*100/fSum+0.5), m_rgb[i], pAlter->cStrAlter );
	}
	switch( m_cbGraphEffect.GetCurSel() )
	{
	case 0:
		m_pGraph->SetGraphBackgroundColor( RGB(255,255,255) );
		m_pGraph->SetGraphSubtitle( "animation - none" );
		m_pGraph->SetGraphBackgroundColor( RGB(196,196,196) );
		m_pGraph->SetGraphAnimation( FALSE, AT_PIE_DRAW );
		break;
	case 1:
		m_pGraph->SetGraphSubtitle( "animation - draw" );
		m_pGraph->SetGraphFillType( GB_GRADIENT );
		m_pGraph->SetGraphGradientColors( RGB(125,0,0), RGB(255,255,255) );
		m_pGraph->SetGraphTitleColor( RGB(196,196,196) );
		m_pGraph->SetGraphSubtitleColor( RGB(0,0,128) );
		m_pGraph->SetGraphAnimation( TRUE, AT_PIE_DRAW );
		break;
	case 2:
		m_pGraph->SetGraphBackgroundColor( RGB(196,196,128) );
		m_pGraph->SetGraphSubtitle( "animation - blend" );
		m_pGraph->SetGraphAnimation( TRUE, AT_PIE_BLEND );
		break;
	default:
		return;
	}
}

void CGraph::DrawBar()
{
	int i, j, iSel, iNoChild;
	CItem *pItem;
	CLink *pLink;
	CAlter *pAlter;
	CGAMDoc *pDoc = (CGAMDoc*)(((CMainFrame *)AfxGetMainWnd())->GetActiveDocument());
	iSel = m_cbGraphItemID.GetCurSel();
	iNoChild = pDoc->GetChildNo(iSel);

	// Add graph segments
	if( iNoChild > 0 )
	{
		for( i=0 ; i<DEF_MAXLINK ; i++ )
		{
			pLink = pDoc->m_pData->GetLink(i);
			if( pLink == NULL ) break;
			if( pLink->m_iParent == iSel )
			{
				pItem = pDoc->m_pData->GetItem(pLink->m_iChild);
				if( pItem ) m_pGraph->Add2DBarGraphSegment( pItem->m_cLabel );
			}
		}
	}
	else m_pGraph->Add2DBarGraphSegment( m_pCurItem->m_cLabel );
	// Add graph series
	for( i=0 ; i<pDoc->m_pData->m_iNoAlter ; i++ )
	{
		pAlter = pDoc->m_pData->GetAlter(i);
		if( pAlter == NULL ) break;
		m_pGraph->Add2DBarGraphSeries( pAlter->cStrAlter, m_rgb[i] );
	}
	// Set graph series values
	if( iNoChild > 0 )
	{
		iNoChild = 0;
		for( j=0 ; j<DEF_MAXLINK ; j++ )
		{
			pLink = pDoc->m_pData->GetLink(j);
			if( pLink == NULL ) break;
			if( pLink->m_iParent == iSel )
			{
				if( pDoc->m_pData->GetItem(pLink->m_iChild) )
				{
					iNoChild++;
					for( i=0 ; i<DEF_MAXALTER ; i++ )
					{
						pAlter = pDoc->m_pData->GetAlter(i);
						if( pAlter == NULL ) break;
						m_pGraph->Set2DBarGraphValue( iNoChild, i+1, (int)(pAlter->m_pDataSet[pLink->m_iChild]->m_fPoint) );
					}
				}
			}
		}
	}
	else
	{
		for( i=0 ; i<DEF_MAXALTER ; i++ )
		{
			pAlter = pDoc->m_pData->GetAlter(i);
			if( pAlter == NULL ) break;
			m_pGraph->Set2DBarGraphValue( 1, i+1, (int)(pAlter->m_pDataSet[iSel]->m_fPoint) );
		}
	}
	
	switch( m_cbGraphEffect.GetCurSel() )
	{
	case 0:
		{
			m_pGraph->SetGraphBackgroundColor( RGB(196,196,196) );
			m_pGraph->SetGraphSubtitle( "animation - none" );
			m_pGraph->SetGraphAnimation( FALSE, AT_BAR_DRAW_ALL );
		}
		break;
	case 1:
		{
			m_pGraph->SetGraphBackgroundColor( RGB(196,196,128) );
			m_pGraph->SetGraphSubtitle( "animation - draw_all" );
			m_pGraph->SetGraphAnimation( TRUE, AT_BAR_DRAW_ALL );
		}
		break;
	case 2:
		{
			m_pGraph->SetGraphBackgroundColor( RGB(196,196,128) );
			m_pGraph->SetGraphSubtitle( "animation - draw_segment" );
			m_pGraph->SetGraphAnimation( TRUE, AT_BAR_DRAW_SEGMENT );
		}
		break;
	case 3:
		{
			m_pGraph->SetGraphBackgroundColor( RGB(196,196,128) );
			m_pGraph->SetGraphSubtitle( "animation - draw_series" );
			m_pGraph->SetGraphAnimation( TRUE, AT_BAR_DRAW_SERIES );
		}
		break;
	case 4:
		{
			m_pGraph->SetGraphSubtitle( "animation - blend_segment" );
			m_pGraph->SetGraphFillType( GB_GRADIENT );
			m_pGraph->SetGraphGradientColors( RGB(255,255,255), RGB(0,0,125) );
			m_pGraph->SetGradientFillType( FT_HORIZONTAL );
			m_pGraph->SetGraphAnimation( TRUE, AT_BAR_BLEND_SEGMENT );
		}
		break;
	case 5:
		{
			m_pGraph->SetGraphBackgroundColor( RGB(196,196,128) );
			m_pGraph->SetGraphSubtitle( "animation - blend_series" );
			m_pGraph->SetGraphLegendBackgroundColor( RGB(164,164,128) );
			m_pGraph->SetGraphAnimation( TRUE, AT_BAR_BLEND_SERIES );
		}
		break;
	default:
		return;
	}
}

void CGraph::DrawLine()
{
	int i, j, iSel, iNoChild;
	CItem *pItem;
	CLink *pLink;
	CAlter *pAlter;
	CGAMDoc *pDoc = (CGAMDoc*)(((CMainFrame *)AfxGetMainWnd())->GetActiveDocument());
	iSel = m_cbGraphItemID.GetCurSel();
	iNoChild = pDoc->GetChildNo(iSel);
	
	// Add graph segments
	for( i=0 ; i<pDoc->m_pData->m_iNoAlter ; i++ )
	{
		pAlter = pDoc->m_pData->GetAlter(i);
		if( pAlter == NULL ) break;
		m_pGraph->Add2DLineGraphSegment( pAlter->cStrAlter );
	}
	// Add graph series
	if( iNoChild > 0 )
	{
		j = 0;
		for( i=0 ; i<DEF_MAXLINK ; i++ )
		{
			pLink = pDoc->m_pData->GetLink(i);
			if( pLink == NULL ) break;
			if( pLink->m_iParent == iSel )
			{
				pItem = pDoc->m_pData->GetItem(pLink->m_iChild);
				if( pItem )
				{
					m_pGraph->Add2DLineGraphSeries( pItem->m_cLabel, m_rgb[j] );
					j++;
				}
			}
		}
	}
	else m_pGraph->Add2DLineGraphSeries( m_pCurItem->m_cLabel, m_rgb[0] );

	// Set graph series values
	if( iNoChild > 0 )
	{
		for( j=0 ; j<pDoc->m_pData->m_iNoAlter ; j++ )
		{
			pAlter = pDoc->m_pData->GetAlter(j);
			if( pAlter == NULL ) break;
			iNoChild = 0;
			for( i=0 ; i<DEF_MAXLINK ; i++ )
			{
				pLink = pDoc->m_pData->GetLink(i);
				if( pLink == NULL ) break;
				if( pLink->m_iParent == iSel )
				{
					pItem = pDoc->m_pData->GetItem(pLink->m_iChild);
					if( pItem )
					{
						iNoChild++;
						m_pGraph->Set2DLineGraphValue( j+1, iNoChild, (int)(pAlter->m_pDataSet[pLink->m_iChild]->m_fPoint) );
					}
				}
			}
		}
	}
	else
	{
		for( j=0 ; j<pDoc->m_pData->m_iNoAlter ; j++ )
		{
			pAlter = pDoc->m_pData->GetAlter(j);
			if( pAlter == NULL ) break;
			m_pGraph->Set2DLineGraphValue( j+1, 1, (int)(pAlter->m_pDataSet[iSel]->m_fPoint) );
		}
	}

	switch( m_cbGraphEffect.GetCurSel() )
	{
	case 0:
		{
			m_pGraph->SetGraphBackgroundColor( RGB(128,128,96) );
			m_pGraph->SetGraphSubtitle( "animation - none" );
			m_pGraph->SetGraphAnimation( FALSE, AT_LINE_DRAW_ALL );
		}
		break;
	case 1:
		{
			m_pGraph->SetGraphSubtitle( "animation - draw_all" );
			m_pGraph->SetGraphFillType( GB_GRADIENT );
			m_pGraph->SetGraphGradientColors( RGB(0,125,0), RGB(196,196,0) );
			m_pGraph->SetGraphSubtitleColor( RGB(196,196,196) );
			m_pGraph->SetGraphLabelsColor( RGB(255,255,255) );
			m_pGraph->SetGraphAnimation( TRUE, AT_LINE_DRAW_ALL );
		}
		break;
	case 2:
		{
			m_pGraph->SetGraphBackgroundColor( RGB(196,196,128) );
			m_pGraph->SetGraphSubtitle( "animation - draw_series" );
			m_pGraph->SetGraphLegendBackgroundColor( RGB(208,208,208) );
			m_pGraph->SetGraphAnimation( TRUE, AT_LINE_DRAW_SERIES );
		}
		break;
	default:
		return;
	}
}
