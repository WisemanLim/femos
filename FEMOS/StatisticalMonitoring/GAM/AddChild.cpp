// AddChild.cpp : implementation file
//

#include "stdafx.h"
#include "GAM.h"
#include "AddChild.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CAddChild dialog


CAddChild::CAddChild(CWnd* pParent /*=NULL*/)
	: CDialog(CAddChild::IDD, pParent)
{
	//{{AFX_DATA_INIT(CAddChild)
	m_itemno = 2;
	//}}AFX_DATA_INIT
}


void CAddChild::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CAddChild)
	DDX_Control(pDX, IDC_SPIN_ITEMNO, m_spinNo);
	DDX_Text(pDX, IDC_EDIT_ITEMNO, m_itemno);
	DDV_MinMaxInt(pDX, m_itemno, 1, 20);
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CAddChild, CDialog)
	//{{AFX_MSG_MAP(CAddChild)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CAddChild message handlers

BOOL CAddChild::OnInitDialog() 
{
	CDialog::OnInitDialog();
	
	m_spinNo.SetBase( 1 );
	m_spinNo.SetRange( 1, 20 );
	
	return TRUE;  // return TRUE unless you set the focus to a control
	              // EXCEPTION: OCX Property Pages should return FALSE
}
