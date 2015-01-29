// LinkProper.cpp : implementation file
//

#include "stdafx.h"
#include "GAM.h"
#include "LinkProper.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CLinkProper dialog


CLinkProper::CLinkProper(CWnd* pParent /*=NULL*/)
	: CDialog(CLinkProper::IDD, pParent)
{
	//{{AFX_DATA_INIT(CLinkProper)
	m_strChild = _T("");
	m_strParent = _T("");
	m_fValue = 0.0f;
	//}}AFX_DATA_INIT
}


void CLinkProper::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CLinkProper)
	DDX_Text(pDX, IDC_EDIT_CHILD_NAME, m_strChild);
	DDX_Text(pDX, IDC_EDIT_PARENT_NAME, m_strParent);
	DDX_Text(pDX, IDC_EDIT_VALUE, m_fValue);
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CLinkProper, CDialog)
	//{{AFX_MSG_MAP(CLinkProper)
		// NOTE: the ClassWizard will add message map macros here
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CLinkProper message handlers
