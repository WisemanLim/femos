// GAMDoc.cpp : implementation of the CGAMDoc class
//

#include "stdafx.h"
#include "GAM.h"

#include "GAMDoc.h"
#include "Properties.h"
#include "LinkProper.h"
#include "MainFrm.h"
#include "AddChild.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CGAMDoc

IMPLEMENT_DYNCREATE(CGAMDoc, CDocument)

BEGIN_MESSAGE_MAP(CGAMDoc, CDocument)
	//{{AFX_MSG_MAP(CGAMDoc)
	ON_COMMAND(ID_EDIT_ADDLINK, AddLink)
	ON_UPDATE_COMMAND_UI(ID_EDIT_REMOVEITEM, OnUpdateEditRemoveitem)
	ON_COMMAND(ID_EDIT_SELECT_ALL, OnEditSelectAll)
	ON_COMMAND(ID_EDIT_CALCULATE, OnEditCalculate)
	ON_UPDATE_COMMAND_UI(ID_EDIT_CALCULATE, OnUpdateEditCalculate)
	ON_UPDATE_COMMAND_UI(ID_EDIT_ADDLINK, OnUpdateEditAddlink)
	ON_UPDATE_COMMAND_UI(ID_EDIT_ADDCHILD, OnUpdateEditAddchild)
	ON_COMMAND(ID_EDIT_REMOVEITEM, OnEditRemoveitem)
	ON_COMMAND(ID_EDIT_PROPERTIES, OnViewProperties)
	ON_COMMAND(ID_EDIT_ADDCHILD, AddChild)
	ON_COMMAND(ID_EDIT_ADDCHILDS, AddChilds)
	ON_COMMAND(ID_VIEW_ONGRAPH, OnViewOnGraph)
	ON_UPDATE_COMMAND_UI(ID_EDIT_ADDCHILDS, OnUpdateEditAddchild)
	ON_UPDATE_COMMAND_UI(ID_EDIT_PROPERTIES, OnUpdateEditProperties)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CGAMDoc construction/destruction

CGAMDoc::CGAMDoc()
{
	m_ptSheet.x = GetSystemMetrics( SM_CXSCREEN );
	m_ptSheet.y = GetSystemMetrics( SM_CYSCREEN )-DEF_TILESIZE*2;
	m_pRightView = NULL;
	m_ptScroll.x = 0;
	m_ptScroll.y = 0;
	m_pData = NULL;

	m_penDragDot.CreatePen(PS_DOT, 1, RGB(0,0,0) );
	m_penRed.CreatePen( PS_SOLID, 1, RGB(255,0,0) );
	m_brsRed.CreateSolidBrush( RGB(255,0,0) );
	m_penGreen.CreatePen( PS_SOLID, 1, RGB(0,255,0) );
	m_brsGreen.CreateSolidBrush( RGB(0,255,0) );
	m_penBlue.CreatePen( PS_SOLID, 1, RGB(0,0,255) );
	m_brsBlue.CreateSolidBrush( RGB(0,0,255) );
    m_penWindowText.CreatePen( PS_SOLID, 1, ::GetSysColor(COLOR_WINDOWTEXT) );
	m_brsWindowText.CreateSolidBrush( ::GetSysColor(COLOR_WINDOWTEXT) );
    m_penWindowColour.CreatePen( PS_SOLID, 1, ::GetSysColor(COLOR_WINDOW) );
	m_brsWindowColour.CreateSolidBrush( ::GetSysColor(COLOR_WINDOW) );
    m_penFace.CreatePen( PS_SOLID, 1, ::GetSysColor(COLOR_3DFACE) );
	m_brsFace.CreateSolidBrush( ::GetSysColor(COLOR_3DFACE) );
    m_penShadow.CreatePen( PS_SOLID, 1, ::GetSysColor(COLOR_3DSHADOW) );
	m_brsShadow.CreateSolidBrush( ::GetSysColor(COLOR_3DSHADOW) );
    m_penDKShadow.CreatePen( PS_SOLID, 1, ::GetSysColor(COLOR_3DDKSHADOW) );
	m_brsDKShadow.CreateSolidBrush( ::GetSysColor(COLOR_3DDKSHADOW) );
    m_penLight.CreatePen( PS_SOLID, 1, ::GetSysColor(COLOR_3DLIGHT) );
	m_brsLight.CreateSolidBrush( ::GetSysColor(COLOR_3DLIGHT) );
}

CGAMDoc::~CGAMDoc()
{
	if( m_pData ) delete m_pData;
}

BOOL CGAMDoc::OnNewDocument()
{
	if (!CDocument::OnNewDocument()) return FALSE;
	if( m_pData ) delete m_pData;
	m_pData = new CData;
	m_pData->Initialize();
	if( m_pRightView ) Restore();
	// TODO: add reinitialization code here
	// (SDI documents will reuse this document)
	return TRUE;
}

BOOL CGAMDoc::OnOpenDocument(LPCTSTR lpszPathName) 
{
	CData *pData;
	FILE *fp;
	//if (!CDocument::OnOpenDocument(lpszPathName)) return FALSE;
	fp = fopen( lpszPathName, "r" );
	if ( fp==NULL )
	{
		MessageBox( NULL, "Can not open file", "Graphic Aggregation Model", MB_OK );
		return FALSE;
	}
	pData = new CData;
	if( pData->OpenData(fp) )
	{
		fclose(fp);
		if( m_pData ) delete m_pData;
		m_pData = pData;
		if( m_pRightView ) Restore();
		return TRUE;
	}
	else
	{
		fclose(fp);
		delete pData;
		MessageBox( NULL, "Selected file is not correct GAM file.", "Can not open file", MB_OK );
		if( m_pRightView ) Restore();
		return FALSE;
	}
}

void CGAMDoc::DeleteContents() 
{
	if( m_pData )
	{
		delete m_pData;
		m_pData = NULL;
	}
	CDocument::DeleteContents();
}

BOOL CGAMDoc::OnSaveDocument(LPCTSTR lpszPathName) 
{
	FILE *fp;
	if( !CDocument::OnSaveDocument(lpszPathName) ) return FALSE;
	fp = fopen( lpszPathName, "w" );
	if ( fp==NULL )
	{
		MessageBox( NULL, "Selected file is in use.", "Can not save file", MB_OK );
		return FALSE;
	}
	if( m_pData->SaveData(fp) )
	{
		fclose(fp);
		//MessageBox( NULL, "File has been successfully saved.", "Graphic Aggregation Model", MB_OK );
		return TRUE;
	}
	else
	{
		fclose(fp);
		MessageBox( NULL, "Failed to save file.", "Graphic Aggregation Model", MB_OK );
		return FALSE;
	}
}

/////////////////////////////////////////////////////////////////////////////
// CGAMDoc serialization

void CGAMDoc::Serialize(CArchive& ar)
{
	if (ar.IsStoring())
	{
		// TODO: add storing code here
	}
	else
	{
		// TODO: add loading code here
	}
}

/////////////////////////////////////////////////////////////////////////////
// CGAMDoc diagnostics

#ifdef _DEBUG
void CGAMDoc::AssertValid() const
{
	CDocument::AssertValid();
}

void CGAMDoc::Dump(CDumpContext& dc) const
{
	CDocument::Dump(dc);
}
#endif //_DEBUG

/////////////////////////////////////////////////////////////////////////////
// CGAMDoc commands

void CGAMDoc::SetRightView(CGAMView *pView)
{
	m_pRightView = pView;
	Restore();
}

void CGAMDoc::GetSelectedItem(int *pItem1, int *pItem2)
{
	if( pItem1 == NULL ) return;
	int i, iCount;
	iCount = 0;
	CItem *pItem;
	for( i=0 ; i<DEF_MAXITEM ; i++ )
	{
		pItem = m_pData->GetItem(i);
		if( pItem == NULL ) break;
		if( pItem->m_bSelected )
		{
			if( iCount == 0 )
			{
				*pItem1 = i;
				iCount ++;
				if( pItem2 == NULL ) return;
			}
			else if( iCount == 1 )
			{
				*pItem2 = i;
				return;
			}
		}
	}
	*pItem1 = -1;
}

void CGAMDoc::GetSelectedLink(int *pLink1, int *pLink2)
{
	if( pLink1 == NULL ) return;
	int i, iCount;
	CLink *pLink;
	iCount = 0;
	for( i=0 ; i<DEF_MAXLINK ; i++ )
	{
		pLink = m_pData->GetLink(i);
		if( pLink == NULL ) break;
		if( pLink->m_bSelected )
		{
			if( iCount == 0 )
			{
				*pLink1 = i;
				iCount ++;
				if( pLink2 == NULL ) return;
			}
			else if( iCount == 1 )
			{
				*pLink2 = i;
				return;
			}
		}
	}
	*pLink1 = -1;
}

int CGAMDoc::GetSelectedItemNo()
{
	int i;
	int iCount;
	CItem *pItem;
	iCount = 0;
	if( m_pData == NULL ) return -1;
	for( i=0 ; i<DEF_MAXITEM ; i++ )
	{
		pItem = m_pData->GetItem(i);
		if( pItem == NULL ) break;
		if( pItem->m_bSelected ) iCount++;
	}
	return iCount;
}

int CGAMDoc::GetSelectedLinkNo()
{
	int i;
	int iCount;
	CLink *pLink;
	iCount = 0;
	for( i=0 ; i<DEF_MAXITEM ; i++ )
	{
		pLink = m_pData->GetLink(i);
		if( pLink == NULL ) break;
		if( pLink->m_bSelected ) iCount++;
	}
	return iCount;
}

void CGAMDoc::ClearSelected()
{
	int i;
	CItem *pItem;
	CLink *pLink;
	for( i=0 ; i<DEF_MAXITEM ; i++ )
	{
		pItem = m_pData->GetItem(i);
		if( pItem == NULL ) break;
		pItem->m_bSelected = FALSE;
	}
	for( i=0 ; i<DEF_MAXLINK ; i++ )
	{
		pLink = m_pData->GetLink(i);
		if( pLink == NULL ) break;
		pLink->m_bSelected = FALSE;
	}
}

void CGAMDoc::ChangeSelection(BOOL bShiftPressed)
{
	POINT pt;
	int iIndex;
	CItem *pItem;
	if( GetSelectedItemNo() > 1 ) return;
	if( GetSelectedLinkNo() > 0 ) return;
	GetSelectedItem(&iIndex);
	ClearSelected();
	if( bShiftPressed )
	{
		if( iIndex < 0 ) iIndex = 0;
		else iIndex--;
	}
	else
	{
		if( iIndex < 0 ) iIndex = 0;
		else iIndex++;
	}
	if( iIndex < 0 ) iIndex = m_pData->m_iItemNo-1;
	if( iIndex >= m_pData->m_iItemNo ) iIndex = 0;
	pItem = m_pData->GetItem(iIndex);
	if( pItem == NULL ) return;
	pItem->m_bSelected = TRUE;
	if( pItem->m_rt.right + DEF_TILESIZE*2 > m_ptScroll.x+m_pRightView->m_rtClient.right )
	{
		pt.x = pItem->m_rt.right - m_pRightView->m_rtClient.right + DEF_TILESIZE*2;
		pt.y = 0;
		ScrollToPos( pt );
	}
	else if( pItem->m_rt.left < m_ptScroll.x + DEF_TILESIZE*2 )
	{
		pt.x = pItem->m_rt.left-DEF_TILESIZE*2;
		pt.y = 0;
		ScrollToPos( pt );
	}
	UpdateAll(TRUE, FALSE);
}

void CGAMDoc::CheckSelected(RECT *pRect, BOOL bUpdate)
{
	int i;
	RECT rt;
	RECT *prt;
	BOOL bDragMode;
	POINT pt;
	CItem *pItem;
	CLink *pLink;

	if( pRect->right == pRect->left && pRect->bottom == pRect->top ) bDragMode = FALSE;
	else bDragMode = TRUE;

	for( i=0 ; i<DEF_MAXITEM ; i++ )
	{
		pItem = m_pData->GetItem(i);
		if( pItem == NULL ) break;
		prt = &pItem->m_rt;
		if( pRect->left >= prt->left && pRect->top >= prt->top && pRect->right <= prt->right && pRect->bottom <= prt->bottom )
		{
			if( bUpdate ) pItem->m_bSelected = !pItem->m_bSelected;
			else pItem->m_bSelected = TRUE;
			break;
		}
		else if( pRect->left <= prt->left && pRect->top <= prt->top && pRect->right >= prt->right && pRect->bottom >= prt->bottom )
		{
			pItem->m_bSelected = TRUE;
		}
	}

	pt.x = pRect->left;
	pt.y = pRect->top;

	if( bDragMode )
	{
		for( i=0 ; i<DEF_MAXLINK ; i++ )
		{
			pLink = m_pData->GetLink(i);
			if( pLink == NULL ) break;
			if( pLink->m_ptParent.x < pLink->m_ptChild.x )
				SetRect( &rt, pLink->m_ptParent.x, pLink->m_ptParent.y, pLink->m_ptChild.x, pLink->m_ptChild.y );
			else
				SetRect( &rt, pLink->m_ptChild.x, pLink->m_ptParent.y, pLink->m_ptParent.x, pLink->m_ptChild.y );

			if( pRect->left <= rt.left && pRect->top <= rt.top && pRect->right >= rt.right && pRect->bottom >= rt.bottom )
			{
				pLink->m_bSelected = TRUE;
			}
			//else if( pRect->left >= rt.left && pRect->top >= rt.top && pRect->right <= rt.right && pRect->bottom <= rt.bottom )
			else if( pRect->top >= rt.top && pRect->bottom <= rt.bottom )
			{
				if( IsLineInRect( &pLink->m_ptParent, &pLink->m_ptChild, pRect) ) pLink->m_bSelected = TRUE;
			}
		}
	}
	else
	{
		for( i=0 ; i<DEF_MAXLINK ; i++ )
		{
			pLink = m_pData->GetLink(i);
			if( pLink == NULL ) break;
			if( IsPointNearLine( &pt, &pLink->m_ptParent, &pLink->m_ptChild ) )
			{
				if( bUpdate ) pLink->m_bSelected = !pLink->m_bSelected;
				else pLink->m_bSelected = TRUE;
				break;
			}
		}
	}
	UpdateAll(TRUE, FALSE);
}

void CGAMDoc::Restore()
{
	CString str;
	if( m_pData == NULL ) return;
	CalculateSiblings();
	CMainFrame *pFrame = (CMainFrame*)AfxGetMainWnd();
	if( pFrame )
	{
		str.Format( "Item : %d, Link : %d", m_pData->m_iItemNo, m_pData->m_iLinkNo );
		((CStatusBar*)(pFrame->GetMessageBar()))->SetPaneText( 1, str );
	}
	UpdateAll(TRUE, TRUE);
}

void CGAMDoc::CalculateSiblings()
{
	int i;
	int iWidth, iLevel;
	int iMaxSibling, iMaxLevel;
	int	iSiblings[DEF_MAXLEVEL];
	int	iCurSibling[DEF_MAXLEVEL];
	BOOL bNeedChange = FALSE;
	CItem *pItem;
	CLink *pLink;
	CItem *pParent;
	CItem *pChild;
	
	if( m_pData == NULL ) return;
	iMaxSibling = 0;
	iMaxLevel = 0;
	for( i=0 ; i<DEF_MAXLEVEL ; i++ )
	{
		iSiblings[i] = 0;
		iCurSibling[i] = 0;
	}
	for( i=0 ; i<DEF_MAXITEM ; i++ )
	{
		pItem = m_pData->GetItem(i);
		if( pItem == NULL ) break;
		SetRect( &pItem->m_rt, 0,0,0,0 );
		iSiblings[pItem->m_iLevel]++;
		iMaxLevel = max( iMaxLevel, pItem->m_iLevel );
	}
	for( i=0 ; i<DEF_MAXLEVEL ; i++ )
	{
		iMaxSibling = max( iMaxSibling, iSiblings[i] );
	}

	iWidth = iMaxSibling*DEF_TILESIZE*13/4;
	if( m_ptSheet.x < iMaxSibling*DEF_TILESIZE*13/4 )
	{
		bNeedChange = TRUE;
		m_ptSheet.x = iMaxSibling*DEF_TILESIZE*13/4;
	}
	if( m_ptSheet.y < iMaxLevel*DEF_TILESIZE*4+DEF_TILESIZE*6 )
	{
		bNeedChange = TRUE;
		m_ptSheet.y = iMaxLevel*DEF_TILESIZE*4+DEF_TILESIZE*6;
	}
	if( bNeedChange ) m_pRightView->ChangeDisplay();

	pItem = m_pData->GetItem(0);
	if( pItem == NULL ) return;
	SetRect( &pItem->m_rt, m_ptSheet.x/2-DEF_TILESIZE*3/2, DEF_TILESIZE*2, m_ptSheet.x/2+DEF_TILESIZE*3/2+1, DEF_TILESIZE*4+1 );
	for( i=0 ; i<DEF_MAXLINK ; i++ )
	{
		pLink = m_pData->GetLink(i);
		if( pLink == NULL ) break;
		pParent = m_pData->GetItem(pLink->m_iParent);
		pChild = m_pData->GetItem(pLink->m_iChild);
		if( pChild->m_rt.top == 0 )
		{
			iLevel = pChild->m_iLevel;
			iWidth = (m_ptSheet.x / (iSiblings[iLevel]*2))-2;
			if( iWidth > DEF_TILESIZE*3/2 ) iWidth = DEF_TILESIZE*3/2;
			SetRect( &pChild->m_rt	, (iCurSibling[iLevel]*2+1)*m_ptSheet.x/iSiblings[iLevel]/2-iWidth
									, DEF_TILESIZE*(iLevel*4+2)
									, (iCurSibling[iLevel]*2+1)*m_ptSheet.x/iSiblings[iLevel]/2+iWidth+1
									, DEF_TILESIZE*(iLevel*4+2)+DEF_TILESIZE*2+1 );
			iCurSibling[iLevel]++;
		}
		pLink->m_ptParent.x = (pParent->m_rt.left+pParent->m_rt.right)/2;
		pLink->m_ptParent.y = pParent->m_rt.bottom;
		pLink->m_ptChild.x = (pChild->m_rt.left+pChild->m_rt.right)/2;
		pLink->m_ptChild.y = pChild->m_rt.top;
	}
}

void CGAMDoc::ExtendSheet(int iSize)
{
	m_ptSheet.x = iSize;
	m_pRightView->ChangeDisplay();
}

void CGAMDoc::UpdateAll(BOOL bRedrawMain, BOOL bRedraw)
{
	CMainFrame *pFrame = (CMainFrame *)AfxGetMainWnd();
	if( pFrame == NULL ) return;
	if( m_pRightView != NULL ) m_pRightView->Render(bRedrawMain);
	pFrame->m_wndMiniMap.Render(bRedraw);
	if(bRedraw)
	{
		pFrame->m_wndData.Render();
		pFrame->m_wndResult.Render();
		pFrame->m_wndGraph.Render();
	}
}

void CGAMDoc::ScrollToPos( POINT pt )
{
	if( pt.x >= 0 )
	{
		if( pt.x > m_ptSheet.x-m_pRightView->m_rtClient.right ) pt.x = m_ptSheet.x-m_pRightView->m_rtClient.right;
		m_ptScroll.x = pt.x;
		m_pRightView->SetScrollPos( SB_HORZ, m_ptScroll.x, TRUE );
	}
	if( pt.y >= 0 )
	{
		if( pt.y > m_ptSheet.y-m_pRightView->m_rtClient.bottom ) pt.y = m_ptSheet.y-m_pRightView->m_rtClient.bottom;
		m_ptScroll.y = pt.y;
		m_pRightView->SetScrollPos( SB_VERT, m_ptScroll.y, TRUE );
	}
	UpdateAll(FALSE, FALSE);
}

void CGAMDoc::ScrollByPos( POINT pt )
{
	POINT ptNew;
	ptNew.x = m_ptScroll.x+pt.x;
	ptNew.y = m_ptScroll.y+pt.y;
	if( ptNew.x < 0 ) ptNew.x = 0;
	if( ptNew.x > m_ptSheet.x-m_pRightView->m_rtClient.right ) ptNew.x = m_ptSheet.x-m_pRightView->m_rtClient.right;
	if( ptNew.y < 0 ) ptNew.y = 0;
	if( ptNew.y > m_ptSheet.y-m_pRightView->m_rtClient.bottom ) ptNew.y = m_ptSheet.y-m_pRightView->m_rtClient.bottom;
	if( ptNew.x == m_ptScroll.x && ptNew.y == m_ptScroll.y ) return;
	if( ptNew.x != m_ptScroll.x )
	{
		m_ptScroll.x = ptNew.x;
		m_pRightView->SetScrollPos( SB_HORZ, m_ptScroll.x, TRUE );
	}
	if( ptNew.y != m_ptScroll.y )
	{
		m_ptScroll.y = ptNew.y;
		m_pRightView->SetScrollPos( SB_VERT, m_ptScroll.y, TRUE );
	}
	UpdateAll(FALSE, FALSE);
}

void CGAMDoc::SetLabel(char* cLabel)
{
	int iIndex;
	CItem *pItem;
	if( GetSelectedItemNo() != 1 ) return;
	GetSelectedItem(&iIndex);
	pItem = m_pData->GetItem(iIndex);
	if( pItem == NULL ) return;
	strcpy( pItem->m_cLabel, cLabel );
	SetModifiedFlag(TRUE);
	Restore();
}

void CGAMDoc::OnViewProperties() 
{
	int iIndex, iSelItemCount, iSelLinkCount;
	CItem *pItem;
	CLink *pLink;
	CAlter *pAlter;
	iSelItemCount = GetSelectedItemNo();
	iSelLinkCount = GetSelectedLinkNo();
	if( iSelItemCount == 1 && iSelLinkCount == 0 )
	{
		CProperties dlg(this);
		GetSelectedItem(&iIndex);
		pItem = m_pData->GetItem(iIndex);
		pAlter = m_pData->GetCurAlter();
		if( pItem == NULL ) return;
		dlg.m_fValue = pAlter->m_pDataSet[iIndex]->m_fValue;
		dlg.m_iIndex = iIndex;
		dlg.m_iLevel = pItem->m_iLevel+1;
		dlg.m_iSort = pItem->m_iValueType/100;
		dlg.m_iAccel = (pItem->m_iValueType/10)%10;
		dlg.m_iDepth = pItem->m_iValueType%10;
		dlg.m_strName = pItem->m_cLabel;
		if( dlg.DoModal() == IDCANCEL ) return;
		pAlter->m_pDataSet[iIndex]->m_fValue = dlg.m_fValue;
		pItem->m_iValueType = dlg.m_iSort*100+dlg.m_iAccel*10+dlg.m_iDepth;
		strcpy( pItem->m_cLabel, dlg.m_strName );
		SetModifiedFlag(TRUE);
		Restore();
	}
	else if( iSelItemCount == 0 && iSelLinkCount == 1 )
	{
		CLinkProper dlg;
		GetSelectedLink(&iIndex);
		pLink = m_pData->GetLink(iIndex);
		if( pLink == NULL ) return;
		dlg.m_fValue = pLink->m_fWeight;
		dlg.m_strParent = m_pData->GetItem(pLink->m_iParent)->m_cLabel;
		dlg.m_strChild = m_pData->GetItem(pLink->m_iChild)->m_cLabel;
		if( dlg.DoModal() == IDCANCEL ) return;
		pLink->m_fWeight = dlg.m_fValue;
		SetModifiedFlag(TRUE);
		Restore();
	}
}

void CGAMDoc::OnUpdateEditProperties(CCmdUI* pCmdUI) 
{
	int iSelItemNo, iSelLinkNo;
	iSelItemNo = GetSelectedItemNo();
	iSelLinkNo = GetSelectedLinkNo();
	if( iSelItemNo == 1 && iSelLinkNo == 0 ) pCmdUI->Enable(TRUE);
	else if( iSelItemNo == 0 && iSelLinkNo == 1 ) pCmdUI->Enable(TRUE);
	else pCmdUI->Enable(FALSE);
}

void CGAMDoc::AddChild() 
{
	int iParent;
	if( GetSelectedItemNo() != 1 ) return;
	GetSelectedItem(&iParent);
	if( m_pData == NULL ) return;
	if( m_pData->CanAddChild(iParent) == FALSE ) return;
	m_pData->AddChild(iParent);
	SetModifiedFlag(TRUE);
	Restore();
}

void CGAMDoc::AddChilds()
{
	int i, iParent;
	if( GetSelectedItemNo() != 1 ) return;
	GetSelectedItem(&iParent);
	if( m_pData == NULL ) return;
	if( m_pData->CanAddChild(iParent) == FALSE ) return;
	CAddChild dlg;
	if( dlg.DoModal() == IDCANCEL ) return;
	for( i=0 ; i<dlg.m_itemno ; i++ ) m_pData->AddChild(iParent);
	SetModifiedFlag(TRUE);
	Restore();
}

void CGAMDoc::OnUpdateEditAddchild(CCmdUI* pCmdUI) 
{
	int iIndex;
	if( GetSelectedItemNo() != 1 )
	{
		pCmdUI->Enable(FALSE);
		return;
	}
	GetSelectedItem(&iIndex);
	if( m_pData->CanAddChild(iIndex) ) pCmdUI->Enable();
	else pCmdUI->Enable(FALSE);
}

void CGAMDoc::OnEditRemoveitem() 
{
	int i;
	CItem *pItem;
	BOOL bRemoved;
	bRemoved = FALSE;
	for( i=m_pData->m_iItemNo-1 ; i>0 ; i-- )
	{
		pItem = m_pData->GetItem(i);
		if( pItem == NULL ) return;
		if( pItem->m_bSelected )
		{
			if( m_pData->IsRemovable(i) )
			{
				bRemoved = TRUE;
				m_pData->RemoveItem(i);
			}
		}
	}	
	if( bRemoved )
	{
		SetModifiedFlag(TRUE);
		Restore();
	}
}

void CGAMDoc::OnEditSelectAll() 
{
	int i;
	CItem *pItem;
	CLink *pLink;
	for( i=0 ; i<DEF_MAXITEM ; i++ )
	{
		pItem = m_pData->GetItem(i);
		if( pItem == NULL ) break;
		pItem->m_bSelected = TRUE;
	}
	for( i=0 ; i<DEF_MAXLINK ; i++ )
	{
		pLink = m_pData->GetLink(i);
		if( pLink == NULL ) break;
		pLink->m_bSelected = TRUE;
	}
	UpdateAll(TRUE, FALSE);
}

BOOL CGAMDoc::IsPointInRect( POINT *pt, RECT *rt )
{
	if( pt == NULL ) return FALSE;
	if( rt == NULL ) return FALSE;
	if( pt->x >= rt->left && pt->x <= rt->right && pt->y >= rt->top && pt->y <= rt->bottom ) return TRUE;
	else return FALSE;
}

BOOL CGAMDoc::IsPointNearLine( POINT *pt, POINT *ptParent, POINT *ptChild )
{
	double a,b,c,d,e;
	if( pt == NULL ) return FALSE;
	if( ptParent == NULL ) return FALSE;
	if( ptChild == NULL ) return FALSE;
	if( pt->y < ptParent->y ) return FALSE;
	if( pt->y > ptChild->y ) return FALSE;
	a = (double)(ptChild->y-ptParent->y);
	b = (double)(ptParent->x-ptChild->x);
	c = (double)( (ptChild->x-ptParent->x)*ptParent->y + (ptParent->y-ptChild->y)*ptParent->x );
	d = a*pt->x + b*pt->y + c;
	if( d < 0 ) d = d * -1;
	e = d / sqrt(a*a + b*b);
	if( pt->y < ptParent->y ) return FALSE;
	if( pt->y > ptChild->y ) return FALSE;
	if( e > 6 ) return FALSE;

	return TRUE;
}

BOOL CGAMDoc::IsLineInRect( POINT *ptParent, POINT *ptChild, RECT *pRect)
{
	int i;
	int iXLength, iYLength;
	POINT pt;
	if( ptParent == NULL ) return FALSE;
	if( ptChild == NULL ) return FALSE;
	if( pRect == NULL ) return FALSE;
	if( ptChild->y <= ptParent->y ) return FALSE;
	iYLength = ptChild->y - ptParent->y;
	iXLength = ptChild->x - ptParent->x;

	for( i=ptParent->y ; i<ptChild->y ; i++ )
	{
		pt.x = ptParent->x + iXLength*(i-ptParent->y)/iYLength;
		pt.y = i;
		if( IsPointInRect( &pt, pRect ) == TRUE ) return TRUE;
	}
	return FALSE;
}

void CGAMDoc::OnEditCalculate() 
{
	if( m_pData->CanCalculate() )
	{
		BeginWaitCursor();
		m_pData->Calculate();
		SetModifiedFlag(TRUE);
		Restore();
		EndWaitCursor();
	}
}

void CGAMDoc::OnUpdateEditCalculate(CCmdUI* pCmdUI) 
{
	if( m_pData ) pCmdUI->Enable(m_pData->CanCalculate());
}

void CGAMDoc::AddLink() 
{
	int iIndex1, iIndex2, iParent, iChild;
	iParent = iChild = iIndex1 = iIndex2 = -1;
	if( GetSelectedItemNo() != 2 ) return;
	GetSelectedItem( &iIndex1, &iIndex2 );
	if( iIndex1 < 0 || iIndex2 < 0 ) return;
	m_pData->AddLink( iIndex1, iIndex2 );
	SetModifiedFlag(TRUE);
	Restore();
}

BOOL CGAMDoc::IsLinkable()
{
	int iIndex1, iIndex2;
	if( GetSelectedItemNo() != 2 ) return FALSE;
	if( GetSelectedLinkNo() != 0 ) return FALSE;
	GetSelectedItem( &iIndex1, &iIndex2 );
	return m_pData->IsLinkable( iIndex1, iIndex2 );
}

BOOL CGAMDoc::IsRemovable()
{
	if( GetSelectedItemNo() < 1 ) return FALSE;
	int iIndex;
	GetSelectedItem( &iIndex );
	if( iIndex == 0 ) return FALSE;
	return TRUE;
}

void CGAMDoc::OnUpdateEditAddlink(CCmdUI* pCmdUI) 
{
	pCmdUI->Enable( IsLinkable() );
}

void CGAMDoc::OnUpdateEditRemoveitem(CCmdUI* pCmdUI) 
{
	pCmdUI->Enable( IsRemovable() );
}

void CGAMDoc::SetCurAlter(int iIndex)
{
	if( m_pData == NULL ) return;
	if( m_pData->SetCurAlter( iIndex ) )
	{
		UpdateAll( TRUE, FALSE );
	}
}

void CGAMDoc::InsertAlter(int iIndex)
{
	if( m_pData == NULL ) return;
	if( m_pData->InsertAlter( iIndex ) )
	{
		SetModifiedFlag();
		Restore();
	}
}

void CGAMDoc::DeleteAlter(int iIndex)
{
	if( m_pData == NULL ) return;
	if( m_pData->DeleteAlter( iIndex ) )
	{
		SetModifiedFlag();
		Restore();
	}
}

float CGAMDoc::GetValue(int iAlter, int iItem)
{
	if( m_pData == NULL ) return -1.0;
	if( iAlter >= m_pData->m_iNoAlter ) return -1.0;
	if( iItem >= m_pData->m_iItemNo ) return -1.0;
	if( m_pData->GetAlter(iAlter) == NULL ) return -1.0;
	if( m_pData->GetAlter(iAlter)->m_pDataSet[iItem] == NULL ) return -1.0;
	return m_pData->GetAlter(iAlter)->m_pDataSet[iItem]->m_fValue;
}

int CGAMDoc::GetChildNo(int iParent)
{
	if( m_pData == NULL ) return -1;
	return m_pData->GetChildNo(iParent);
}

void CGAMDoc::OnViewOnGraph()
{
	int iIndex;
	CItem *pItem;
	CMainFrame *pFrame;
	if( GetSelectedItemNo() != 1 ) return;
	if( GetSelectedLinkNo() != 0 ) return;
	GetSelectedItem(&iIndex);
	pItem = m_pData->GetItem(iIndex);
	if( pItem == NULL ) return;
	pFrame = (CMainFrame *)AfxGetMainWnd();
	if( pFrame == NULL ) return;
	pFrame->m_wndGraph.m_pCurItem = pItem;
	pFrame->m_wndGraph.m_cbGraphItemID.SetCurSel(iIndex);
	pFrame->m_wndGraph.DrawGraph();
}

float CGAMDoc::GetPercentage(int iIndex)
{
	float fSum, fPer;
	int i, iParent;
	CLink *pLink;
	fPer = fSum = 0.0f;
	if( iIndex >= m_pData->m_iLinkNo ) return -1.0f;
	pLink = m_pData->GetLink(iIndex);
	if( pLink == NULL ) return -1.0f;
	iParent = pLink->m_iParent;
	for( i=0 ; i<DEF_MAXLINK ; i++ )
	{
		pLink = m_pData->GetLink(i);
		if( pLink == NULL ) break;
		if( pLink->m_iParent == iParent )
		{
			fSum += pLink->m_fWeight;
		}
	}
	if( fSum <= 0.0f ) return -1.0f;
	fPer = m_pData->GetLink(iIndex)->m_fWeight*100/fSum;
	return fPer;
}


