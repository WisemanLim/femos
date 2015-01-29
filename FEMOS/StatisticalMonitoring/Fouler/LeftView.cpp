// LeftView.cpp : implementation of the CLeftView class
//

#include "stdafx.h"
#include "Fouler.h"

#include "FoulerDoc.h"
#include "LeftView.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CLeftView

IMPLEMENT_DYNCREATE(CLeftView, CListView)

BEGIN_MESSAGE_MAP(CLeftView, CListView)
	//{{AFX_MSG_MAP(CLeftView)
	ON_COMMAND(ID_EDIT_COPY, OnEditCopy)
	ON_COMMAND(ID_EDIT_PASTE, OnEditPaste)
	ON_UPDATE_COMMAND_UI(ID_EDIT_COPY, OnUpdateEditCopy)
	ON_UPDATE_COMMAND_UI(ID_EDIT_PASTE, OnUpdateEditPaste)
	ON_WM_CONTEXTMENU()
	ON_UPDATE_COMMAND_UI(ID_FILE_PRINT, OnUpdateFilePrint)
	ON_UPDATE_COMMAND_UI(ID_FILE_PRINT_PREVIEW, OnUpdateFilePrintPreview)
	ON_COMMAND(ID_EDIT_SELECT_ALL, OnEditSelectAll)
	//}}AFX_MSG_MAP
	// Standard printing commands
	ON_COMMAND(ID_FILE_PRINT, CListView::OnFilePrint)
	ON_COMMAND(ID_FILE_PRINT_DIRECT, CListView::OnFilePrint)
	ON_COMMAND(ID_FILE_PRINT_PREVIEW, CListView::OnFilePrintPreview)
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CLeftView construction/destruction

CLeftView::CLeftView()
{
}

CLeftView::~CLeftView()
{
}

BOOL CLeftView::PreCreateWindow(CREATESTRUCT& cs)
{
	cs.style = cs.style | LVS_REPORT;
	return CListView::PreCreateWindow(cs);
}

/////////////////////////////////////////////////////////////////////////////
// CLeftView drawing

void CLeftView::OnDraw(CDC* pDC)
{
	CFoulerDoc* pDoc = GetDocument();
	ASSERT_VALID(pDoc);
}

/////////////////////////////////////////////////////////////////////////////
// CLeftView printing

void CLeftView::OnInitialUpdate()
{
	CListView::OnInitialUpdate();
	CFoulerDoc* pDoc = GetDocument();
	ASSERT_VALID(pDoc);
	pDoc->SetLeftView( this );
	CListCtrl& refCtrl = GetListCtrl();

	EnableToolTips(TRUE);
	m_ImageList.Create(MAKEINTRESOURCE(IDB_ICONS), 15, 1, RGB(255,255,255));
	refCtrl.SetImageList(&m_ImageList, LVSIL_SMALL);

	char cStr[256];
	ZeroMemory( cStr, sizeof(cStr) );

	LV_COLUMN lvc;
	lvc.mask = LVCF_FMT | LVCF_WIDTH | LVCF_TEXT | LVS_SHOWSELALWAYS;
	lvc.fmt	= LVCFMT_RIGHT;
	lvc.iImage = 0;

	wsprintf( cStr, "Trial" );
	lvc.pszText = cStr;
	lvc.cx = 60;
	refCtrl.InsertColumn(0, &lvc);

	wsprintf( cStr, "Value" );
	lvc.pszText = cStr;
	lvc.cx = 80;
	refCtrl.InsertColumn(1, &lvc);
}

/////////////////////////////////////////////////////////////////////////////
// CLeftView diagnostics

#ifdef _DEBUG
void CLeftView::AssertValid() const
{
	CListView::AssertValid();
}

void CLeftView::Dump(CDumpContext& dc) const
{
	CListView::Dump(dc);
}

CFoulerDoc* CLeftView::GetDocument() // non-debug version is inline
{
	ASSERT(m_pDocument->IsKindOf(RUNTIME_CLASS(CFoulerDoc)));
	return (CFoulerDoc*)m_pDocument;
}
#endif //_DEBUG

/////////////////////////////////////////////////////////////////////////////
// CLeftView message handlers

void CLeftView::Refresh()
{
	GetListCtrl().DeleteAllItems();
}

void CLeftView::UpdateIcon()
{
	int i=0, iCount=0, iGap = 0;
	double dDeviation = 0;
	CFoulerDoc* pDoc = GetDocument();
	ASSERT_VALID(pDoc);
	if( pDoc->m_sprt.GetReady() == FALSE ) return;
	dDeviation = pDoc->m_sprt.GetDeviation();
	if( dDeviation <= 0 ) return;
	CListCtrl& refCtrl = GetListCtrl();
	iCount = refCtrl.GetItemCount();
	for( i = 0 ; i < iCount ; i++ )
	{
		iGap = (int)( (pDoc->m_pData[i]->GetItem()-pDoc->m_sprt.GetTheta0())/dDeviation );
		iGap = abs(iGap);
		if( iGap > 3 ) iGap = 3;
		refCtrl.SetItem( i, 0, LVIF_IMAGE, NULL, iGap, 0, 0, 0 );
	}
	//refCtrl.Scroll( CSize(100, pDoc->m_iNo*20) );
}

void CLeftView::OnEditCopy() 
{
	char cStr[32];
	int i, iCount, nItem;
	CString str;
	CListCtrl& refCtrl = GetListCtrl();
	iCount = refCtrl.GetSelectedCount();
	POSITION pos;
	pos = refCtrl.GetFirstSelectedItemPosition();
	if( pos == NULL ) return;
	CFoulerDoc* pDoc = GetDocument();
	ASSERT_VALID(pDoc);
	while( pos )
	{
		nItem = refCtrl.GetNextSelectedItem( pos );
		i = refCtrl.GetItemData( nItem );
		sprintf( cStr, "%f\r\n", pDoc->m_pData[i]->GetItem() );
		str = str + cStr;
	}

    if(OpenClipboard())
    {
        HGLOBAL clipbuffer;
        char * buffer;
        EmptyClipboard();
        clipbuffer = GlobalAlloc(GMEM_DDESHARE, str.GetLength()+1);
        buffer = (char*)GlobalLock(clipbuffer);
        strcpy(buffer, LPCSTR(str));
        GlobalUnlock(clipbuffer);
        SetClipboardData(CF_TEXT,clipbuffer);
        CloseClipboard();
    }
}

void CLeftView::OnEditPaste() 
{
	char *buffer = NULL;
	char *cpTextData;
	if ( !OpenClipboard() ) return;
	CFoulerDoc* pDoc = GetDocument();
	ASSERT_VALID(pDoc);

	HANDLE hData = GetClipboardData( CF_TEXT );
	buffer = (char*)GlobalLock( hData );
	int iLength = strlen(buffer);
	if( iLength > 0 )
	{
		cpTextData = new char[iLength+1];
		ZeroMemory( cpTextData, iLength+1 );
		memcpy( cpTextData, buffer, iLength );
		GlobalUnlock( hData );
		CloseClipboard();
		pDoc->AddDataFromText( iLength, cpTextData );
		delete cpTextData;
	}
	else 
	{
		GlobalUnlock( hData );
		CloseClipboard();
	}
}

void CLeftView::OnUpdateEditCopy(CCmdUI* pCmdUI) 
{
	CListCtrl& refCtrl = GetListCtrl();
	if( refCtrl.GetSelectedCount() < 1 ) pCmdUI->Enable( FALSE );
	else pCmdUI->Enable();
}

BOOL CLeftView::CanPaste()
{
	BOOL bAvailable = FALSE;
	char *buffer = NULL;
	if ( OpenClipboard() )
	{
		HANDLE hData = GetClipboardData( CF_TEXT );
		buffer = (char*)GlobalLock( hData );
		if( buffer != NULL ) 
		{
			if( strlen(buffer) > 0 ) bAvailable = TRUE;
		}
		GlobalUnlock( hData );
		CloseClipboard();
	}
	return bAvailable;
}

void CLeftView::OnUpdateEditPaste(CCmdUI* pCmdUI) 
{
	pCmdUI->Enable( CanPaste() );
}

void CLeftView::OnContextMenu(CWnd* pWnd, CPoint point) 
{
	char cStr[64];
	ZeroMemory( cStr, sizeof(cStr) );
	CMenu menu;
	CFoulerDoc* pDoc = GetDocument();
	ASSERT_VALID(pDoc);
	menu.CreatePopupMenu();
	CListCtrl& refCtrl = GetListCtrl();
	int iCount = refCtrl.GetSelectedCount();
	if( iCount > 0 )
	{
		wsprintf( cStr, "%d items have been selected", iCount );
		menu.AppendMenu( MF_STRING, NULL, cStr );
		menu.AppendMenu( MF_STRING, ID_EDIT_COPY, "Copy" );
	}
	if( CanPaste() ) menu.AppendMenu( MF_STRING, ID_EDIT_PASTE, "Paste" );
	SetForegroundWindow();
	menu.TrackPopupMenu( TPM_LEFTALIGN, point.x, point.y, this, NULL );
}

void CLeftView::OnUpdateFilePrint(CCmdUI* pCmdUI) 
{
	pCmdUI->Enable(FALSE);
}

void CLeftView::OnUpdateFilePrintPreview(CCmdUI* pCmdUI) 
{
	pCmdUI->Enable(FALSE);
}

void CLeftView::OnEditSelectAll() 
{
	CListCtrl& refCtrl = GetListCtrl();
	int iCount = refCtrl.GetItemCount();
	for( int i=0 ; i < iCount ; i++ )
	{
		refCtrl.SetItemState( i, LVIS_SELECTED, LVIS_SELECTED );
	}
}

void CLeftView::Update()
{
	int i, iCount;
	char cStr[32];
	double dDeviation = 0;
	int iGap = 0;
	LV_ITEM lvi;
	CFoulerDoc* pDoc = GetDocument();
	ASSERT_VALID(pDoc);
	CListCtrl& refCtrl = GetListCtrl();
	iCount = refCtrl.GetItemCount();
	if( iCount >= pDoc->m_iNo ) return;
	lvi.mask       = LVIF_TEXT | LVIF_IMAGE;
	lvi.cchTextMax = 0;
	lvi.lParam     = 0;
	lvi.iSubItem	= 0;
	for( i = iCount ; i < iCount+200 && i < pDoc->m_iNo ; i++ )
	{
		wsprintf( cStr, "%d", i+1 );
		lvi.iItem		= i;
		lvi.pszText		= cStr;
		dDeviation = pDoc->m_sprt.GetDeviation();
		if( dDeviation > 0 )
		{
			iGap = (int)( (pDoc->m_pData[i]->GetItem()-pDoc->m_sprt.GetTheta0())/dDeviation );
			iGap = abs(iGap);
			if( iGap > 3 ) iGap = 3;
		}
		else iGap = -1;
		lvi.iImage = iGap;
		refCtrl.InsertItem(&lvi);
		refCtrl.SetItemData( i, i );
		sprintf( cStr, "%f", pDoc->m_pData[i]->GetItem() );
		refCtrl.SetItemText(i, 1, cStr);
	}
	if( pDoc->m_iNo <= i ) refCtrl.Scroll( CSize(100, pDoc->m_iNo*20) );
}
