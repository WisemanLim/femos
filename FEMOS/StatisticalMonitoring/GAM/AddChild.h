#if !defined(AFX_ADDCHILD_H__AE17EE55_193C_4D11_90EA_A42DAF676F67__INCLUDED_)
#define AFX_ADDCHILD_H__AE17EE55_193C_4D11_90EA_A42DAF676F67__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// AddChild.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CAddChild dialog

class CAddChild : public CDialog
{
// Construction
public:
	CAddChild(CWnd* pParent = NULL);   // standard constructor

// Dialog Data
	//{{AFX_DATA(CAddChild)
	enum { IDD = IDD_DIALOG_ADDCHILDS };
	CSpinButtonCtrl	m_spinNo;
	int		m_itemno;
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CAddChild)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:

	// Generated message map functions
	//{{AFX_MSG(CAddChild)
	virtual BOOL OnInitDialog();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_ADDCHILD_H__AE17EE55_193C_4D11_90EA_A42DAF676F67__INCLUDED_)
