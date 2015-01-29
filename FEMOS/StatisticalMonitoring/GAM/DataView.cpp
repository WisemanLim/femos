// DataView.cpp : implementation file
//

#include "stdafx.h"
#include "GAM.h"
#include "MainFrm.h"
#include "GAMDoc.h"
#include "DataView.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CDataView

IMPLEMENT_DYNAMIC(CDataView, CDialogBar)

CDataView::CDataView()
{
	m_OldSize = CSize(-1,-1);
	m_bPasting = FALSE;
}

CDataView::~CDataView()
{
}

void CDataView::DoDataExchange(CDataExchange* pDX)
{
	CSCBar::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CDataView)
	//}}AFX_DATA_MAP
}

BEGIN_MESSAGE_MAP(CDataView, CSCBar)
	//{{AFX_MSG_MAP(CDataView)
    ON_WM_SIZE()
	ON_WM_PAINT()
	ON_WM_CREATE()
	ON_COMMAND(ID_EDIT_COPY, OnEditCopy)
	ON_COMMAND(ID_EDIT_CUT, OnEditCut)
	ON_COMMAND(ID_EDIT_PASTE, OnEditPaste)
	ON_COMMAND(ID_EDIT_LABEL, OnEditLabel)
	ON_COMMAND(ID_INSERT_ALTER, OnInsertAlter)
	ON_COMMAND(ID_DELETE_ALTER, OnDeleteAlter)
	ON_COMMAND(ID_CURRENT_ALTER, OnCurrentAlter)
	ON_UPDATE_COMMAND_UI(ID_EDIT_COPY, OnUpdateEditCopy)
	ON_UPDATE_COMMAND_UI(ID_EDIT_CUT, OnUpdateEditCut)
	ON_UPDATE_COMMAND_UI(ID_EDIT_PASTE, OnUpdateEditPaste)
	//}}AFX_MSG_MAP
    ON_NOTIFY(NM_DBLCLK, IDC_GRID, OnGridDblClick)
    ON_NOTIFY(NM_CLICK, IDC_GRID, OnGridClick)
    ON_NOTIFY(NM_RCLICK, IDC_GRID, OnGridRClick)
	ON_NOTIFY(GVN_ENDLABELEDIT, IDC_GRID, OnEndLabelEdit)
	ON_NOTIFY(GVN_BEGINPASTE, IDC_GRID, OnBeginPaste)
	ON_NOTIFY(GVN_ENDPASTE, IDC_GRID, OnEndPaste)
	ON_CBN_SELCHANGE(ID_COMBO_DATA, Render)
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CDataView message handlers

void CDataView::OnUpdateCmdUI(CFrameWnd* pTarget, BOOL bDisableIfNoHndler)
{
    CSCBar::OnUpdateCmdUI(pTarget, bDisableIfNoHndler);

    UpdateDialogControls(pTarget, bDisableIfNoHndler);
}

void CDataView::OnSize(UINT nType, int cx, int cy) 
{
    CSCBar::OnSize(nType, cx, cy);
	if( AfxGetMainWnd() != NULL )
	{
		RECT rt;
		GetClientRect(&rt);
		rt.top += 26;
		m_Grid.MoveWindow( &rt );
		m_Grid.AutoSize();
		Render();
	}
}

void CDataView::OnPaint() 
{
	CPaintDC dc(this); // device context for painting
}

void CDataView::OnInsertAlter() 
{
	int iRow;
	iRow = m_Grid.GetFocusCell().row;
	if( iRow < 1 ) return;
	CGAMDoc *pDoc = (CGAMDoc*)(((CMainFrame *)AfxGetMainWnd())->GetActiveDocument());
	pDoc->InsertAlter(iRow-2);
}

void CDataView::OnCurrentAlter() 
{
	int iRow;
	iRow = m_Grid.GetFocusCell().row;
	if( iRow < 2 ) return;
	CGAMDoc *pDoc = (CGAMDoc*)(((CMainFrame *)AfxGetMainWnd())->GetActiveDocument());
	pDoc->SetCurAlter(iRow-2);
	Render();
}

void CDataView::OnDeleteAlter() 
{
	int iRow;
	iRow = m_Grid.GetFocusCell().row;
	if( iRow < 2 ) return;
	CGAMDoc *pDoc = (CGAMDoc*)(((CMainFrame *)AfxGetMainWnd())->GetActiveDocument());
	pDoc->DeleteAlter(iRow-2);
}

void CDataView::OnEditCopy() 
{
	m_Grid.OnEditCopy();
}

void CDataView::OnEditCut() 
{
	m_Grid.OnEditCut();
	CGAMDoc *pDoc = (CGAMDoc*)(((CMainFrame *)AfxGetMainWnd())->GetActiveDocument());
	pDoc->SetModifiedFlag();
}

void CDataView::OnEditPaste() 
{
	m_Grid.OnEditPaste();
	CGAMDoc *pDoc = (CGAMDoc*)(((CMainFrame *)AfxGetMainWnd())->GetActiveDocument());
	pDoc->SetModifiedFlag();
}

void CDataView::OnEditLabel() 
{
	m_Grid.OnEditCell(m_Grid.GetFocusCell().row, m_Grid.GetFocusCell().col, CPoint( -1, -1), VK_LBUTTON);
}

void CDataView::OnUpdateEditCopy(CCmdUI* pCmdUI) 
{
	pCmdUI->Enable(m_Grid.GetSelectedCount() > 0);
}

void CDataView::OnUpdateEditCut(CCmdUI* pCmdUI) 
{
	pCmdUI->Enable(m_Grid.GetSelectedCount() > 0);
}

void CDataView::OnUpdateEditPaste(CCmdUI* pCmdUI) 
{
    // Attach a COleDataObject to the clipboard see if there is any data
    COleDataObject obj;
    pCmdUI->Enable(obj.AttachClipboard() && obj.IsDataAvailable(CF_TEXT)); 
}

int CDataView::OnCreate(LPCREATESTRUCT lpCreateStruct) 
{
	if( CSCBar::OnCreate(lpCreateStruct) == -1) return -1;
	if( m_cbViewType.Create( WS_CHILD | WS_VISIBLE | WS_VSCROLL | CBS_AUTOHSCROLL | CBS_DROPDOWNLIST | CBS_HASSTRINGS, CRect(0,0,70,100), this, ID_COMBO_DATA ) == 0 ) return -1;
	m_cbViewType.AddString( "Data" );
	m_cbViewType.AddString( "Score" );
	m_cbViewType.SetCurSel( 0 );
	m_Grid.Create( CRect(0,0,800,250), this, IDC_GRID, WS_CHILD | WS_VISIBLE);
	m_Grid.SetEditable(TRUE);
	m_Grid.SetListMode(FALSE);
	m_Grid.EnableDragAndDrop(TRUE);
	//m_Grid.SetTextBkColor(RGB(0xFF, 0xFF, 0xE0));
	m_Grid.SetTextBkColor(RGB(0xFF, 0xFF, 0xFF));
	return 0;
}

void CDataView::Render() 
{
	int iItemCount, row, col;
	CItem *pItem;
	CAlter *pAlter;
	CGAMDoc *pDoc = (CGAMDoc*)(((CMainFrame *)AfxGetMainWnd())->GetActiveDocument());
	iItemCount = pDoc->m_pData->GetTotalItem();
	if( iItemCount < 1 ) return;

	TRY {
		m_Grid.SetRowCount(pDoc->m_pData->m_iNoAlter+2);
		m_Grid.SetColumnCount(iItemCount+2);
		m_Grid.SetFixedRowCount(1);
		m_Grid.SetFixedColumnCount(1);
	}
	CATCH (CMemoryException, e)
	{
		e->ReportError();
		return;
	}
    END_CATCH

    DWORD dwTextStyle = DT_CENTER|DT_VCENTER|DT_SINGLELINE|DT_NOPREFIX;
#ifndef _WIN32_WCE
    dwTextStyle |= DT_END_ELLIPSIS;
#endif

	// fill rows/cols with text
	for ( row = 0; row < m_Grid.GetRowCount(); row++ )
	{
		pAlter = pDoc->m_pData->GetAlter(row-2);
		for ( col = 0; col < m_Grid.GetColumnCount(); col++ )
		{ 
			GV_ITEM Item;
			Item.mask = GVIF_TEXT|GVIF_FORMAT;
			Item.row = row;
			Item.col = col;
			if ( row <1 )
			{
				Item.nFormat = DT_CENTER|DT_VCENTER|DT_SINGLELINE|DT_WORDBREAK|DT_NOPREFIX;
				if( col >1 )
				{
					Item.strText = 'A'+col-2;
				}
				else if( col == 1 ) Item.strText = _T("0");
			}
			else if (row < 2)
			{
				Item.nFormat = DT_CENTER|DT_VCENTER|DT_SINGLELINE|DT_WORDBREAK|DT_NOPREFIX;
				if( col == 0 ) Item.strText = _T("0");
				else if( col == 1 ) Item.strText = _T("Item");
				else
				{
					pItem = pDoc->m_pData->GetItem(col-2);
					Item.strText.Format(_T("%s"), pItem->m_cLabel );
				}
			}
			else 
			{
				Item.nFormat = dwTextStyle;
				if( col == 0 ) Item.strText.Format(_T("%d"), row-1 );
				else if( col == 1 ) Item.strText.Format(_T("%s"), pAlter->cStrAlter );
				else
				{
					pItem = pDoc->m_pData->GetItem(col-2);
					if( pItem )
					{
						if( pAlter->m_pDataSet[col-2] != NULL )
						{
							if( m_cbViewType.GetCurSel() )
							{
								Item.strText.Format(_T("%.2f"), pAlter->m_pDataSet[col-2]->m_fPoint );
								m_Grid.SetItemState(row,col, m_Grid.GetItemState(row,col) | GVIS_READONLY);
							}
							else
							{
								Item.strText.Format(_T("%f"), pAlter->m_pDataSet[col-2]->m_fValue );
								m_Grid.SetItemState(row,col, m_Grid.GetItemState(row,col) & ~GVIS_READONLY);
								Item.strText.TrimRight( '0' );
								Item.strText.TrimRight( '.' );
							}
						}
					}
				}
			}
			m_Grid.SetItem(&Item);

			if( row == pDoc->m_pData->m_iCurAlter+2 && col == 1 )
			{
				m_Grid.SetItemFgColour(row, col, RGB(255,0,0));
			}
			else if (row>1 && col == 1 || row == 1 && col > 1 )
			{
				//m_Grid.SetItemBkColour(row, col, RGB(212,208,200));
				m_Grid.SetItemFgColour(row, col, RGB(0,0,255));
			}
		}
	}
    //m_Grid.SetItemState(1,1, m_Grid.GetItemState(1,1) | GVIS_READONLY);// Make cell 1,1 read-only
	m_Grid.AutoSize();
}

void CDataView::OnGridDblClick(NMHDR *pNotifyStruct, LRESULT* /*pResult*/)
{
	NM_GRIDVIEW* pItem = (NM_GRIDVIEW*) pNotifyStruct;
	if (pItem->iRow < 2 ) return;
	CGAMDoc *pDoc = (CGAMDoc*)(((CMainFrame *)AfxGetMainWnd())->GetActiveDocument());
	pDoc->SetCurAlter( pItem->iRow-2 );
	Render();
}

void CDataView::OnBeginPaste(NMHDR *pNotifyStruct, LRESULT* /*pResult*/)
{
	if( pNotifyStruct != NULL ) m_bPasting = TRUE;
}

void CDataView::OnEndPaste(NMHDR *pNotifyStruct, LRESULT* /*pResult*/)
{
	CGAMDoc *pDoc;
	m_bPasting = FALSE;
	pDoc = (CGAMDoc*)(((CMainFrame *)AfxGetMainWnd())->GetActiveDocument());
	if( pDoc ) pDoc->Restore();
}

void CDataView::OnEndLabelEdit(NMHDR *pNotifyStruct, LRESULT* /*pResult*/)
{
	CItem *pItem;
	CAlter* pAlter;
	CGAMDoc *pDoc;
	int iRow, iCol;
	if( pNotifyStruct == NULL ) return;
	iRow = ((NM_GRIDVIEW*)(pNotifyStruct))->iRow;
	iCol = ((NM_GRIDVIEW*)(pNotifyStruct))->iColumn;
	if( iRow < 1 ) return;
	if( iCol < 1 ) return;
	pDoc = (CGAMDoc*)(((CMainFrame *)AfxGetMainWnd())->GetActiveDocument());
	if( iRow == 1 )
	{
		if( iCol > 1 )
		{
			pItem = pDoc->m_pData->GetItem(iCol-2);
			if( pItem == NULL ) return;
			strcpy( pItem->m_cLabel, m_Grid.GetItemText(iRow, iCol) );
		}
	}
	else
	{
		pAlter = pDoc->m_pData->GetAlter( iRow-2 );
		if( pAlter == NULL ) return;
		if( iCol == 1 )
		{
			strcpy( pAlter->cStrAlter, m_Grid.GetItemText(iRow, iCol) );
		}
		else
		{
			if( pAlter->m_pDataSet[iCol-2] == NULL ) return;
			pAlter->m_pDataSet[iCol-2]->m_fValue = (float)atof(m_Grid.GetItemText(iRow, iCol));
		}
	}
	pDoc->SetModifiedFlag();
	if( !m_bPasting ) pDoc->Restore();
}

void CDataView::OnGridClick(NMHDR *pNotifyStruct, LRESULT* /*pResult*/)
{
    NM_GRIDVIEW* pItem = (NM_GRIDVIEW*) pNotifyStruct;
    if (pItem->iRow < 0) return;
}

void CDataView::OnGridRClick(NMHDR *pNotifyStruct, LRESULT* /*pResult*/)
{
	int iRow, iCol;
	POINT pt;
	CString str;
	CMenu menu;
    COleDataObject obj;
	CAlter *pAlter;
	CItem *pItem;
	if( pNotifyStruct == NULL ) return;
	iRow = ((NM_GRIDVIEW*)(pNotifyStruct))->iRow;
	iCol = ((NM_GRIDVIEW*)(pNotifyStruct))->iColumn;
	CGAMDoc *pDoc = (CGAMDoc*)(((CMainFrame *)AfxGetMainWnd())->GetActiveDocument());
	if( pDoc == NULL ) return;
    if( iRow < 1 ) return;
	if( iCol < 1 ) return;
	pAlter = pDoc->m_pData->GetAlter(iRow-2);
	pItem = pDoc->m_pData->GetItem(iCol-2);
	menu.CreatePopupMenu();

	if( iRow > 1 ) menu.AppendMenu( MF_STRING, ID_CURRENT_ALTER, "&Set Current Alternative" );
	menu.AppendMenu( MF_STRING, ID_INSERT_ALTER, "&Insert Alternative" );
	if( iRow > 1 ) menu.AppendMenu( MF_STRING, ID_DELETE_ALTER, "&Delete Alternative" );
	else menu.AppendMenu( MF_GRAYED, 0, "&Delete Alternative" );
	menu.AppendMenu( MF_SEPARATOR );

	if( iRow != 1 || iCol != 1 ) menu.AppendMenu( MF_STRING, ID_EDIT_LABEL, "&Edit Text" );
	else menu.AppendMenu( MF_GRAYED, 0, "&Edit Text" );
	if( m_Grid.GetSelectedCount() > 0 )
	{
		menu.AppendMenu( MF_STRING, ID_EDIT_CUT, "Cu&t" );
		menu.AppendMenu( MF_STRING, ID_EDIT_COPY, "&Copy" );
	}
	else
	{
		menu.AppendMenu( MF_GRAYED, 0, "Cu&t" );
		menu.AppendMenu( MF_GRAYED, 0, "&Copy" );
	}
    if(obj.AttachClipboard() && obj.IsDataAvailable(CF_TEXT))
	{
		menu.AppendMenu( MF_STRING, ID_EDIT_PASTE, "&Paste" );
	}
	else
	{
		menu.AppendMenu( MF_GRAYED, 0, "&Paste" );
	}
	menu.AppendMenu( MF_SEPARATOR );
	if( iRow == 1 ) 
	{
		if( iCol > 1 && pItem != NULL )
		{
			str.Format( "at %s", pItem->m_cLabel);
		}
	}
	else if( pAlter != NULL )
	{
		if( iCol == 1 )
		{
			str.Format( "at %s", pAlter->cStrAlter);
		}
		else if( pItem != NULL )
		{
			str.Format( "at %s, %s", pAlter->cStrAlter, pItem->m_cLabel);
		}
	}
	menu.AppendMenu( MF_DISABLED, 0, str );
	SetForegroundWindow();
	GetCursorPos(&pt);
	menu.TrackPopupMenu( TPM_LEFTALIGN, pt.x, pt.y, this, NULL );
}
