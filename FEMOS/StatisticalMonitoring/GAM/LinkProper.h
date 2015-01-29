#if !defined(AFX_LINKPROPER_H__5B132B1F_938E_4ED6_A6F3_754923269880__INCLUDED_)
#define AFX_LINKPROPER_H__5B132B1F_938E_4ED6_A6F3_754923269880__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// LinkProper.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CLinkProper dialog

class CLinkProper : public CDialog
{
// Construction
public:
	CLinkProper(CWnd* pParent = NULL);   // standard constructor

// Dialog Data
	//{{AFX_DATA(CLinkProper)
	enum { IDD = IDD_DIALOG_LINKPROPER };
	CString	m_strChild;
	CString	m_strParent;
	float	m_fValue;
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CLinkProper)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:

	// Generated message map functions
	//{{AFX_MSG(CLinkProper)
		// NOTE: the ClassWizard will add member functions here
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_LINKPROPER_H__5B132B1F_938E_4ED6_A6F3_754923269880__INCLUDED_)
