// ProgressBar.cpp : implementation file
#include "stdafx.h"
#include "ProgressBar.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

IMPLEMENT_DYNCREATE(CProgressBar, CProgressCtrl)

BEGIN_MESSAGE_MAP(CProgressBar, CProgressCtrl)
	//{{AFX_MSG_MAP(CProgressBar)
    //}}AFX_MSG_MAP
END_MESSAGE_MAP()

CProgressBar::CProgressBar()
{
    CRect rc;
    CFrameWnd *pFrame = (CFrameWnd*)AfxGetMainWnd();
    if (!pFrame || !pFrame->IsKindOf(RUNTIME_CLASS(CFrameWnd))) return;
    CStatusBar* pStatusBar = (CStatusBar*) pFrame->GetMessageBar();
    if (!pStatusBar || !pStatusBar->IsKindOf(RUNTIME_CLASS(CStatusBar))) return;
	if(!CProgressCtrl::Create(WS_CHILD|WS_VISIBLE, CRect(0,0,0,0), pStatusBar, 1)) return;
	SetRange( 0, 256 );
    pStatusBar->GetItemRect(0, rc);
	MoveWindow(&rc);
}

CProgressBar::~CProgressBar()
{
}
