#if !defined(AFX_SPLASH_H__EC16ADF1_0232_418A_A190_CE098A4E0D90__INCLUDED_)
#define AFX_SPLASH_H__EC16ADF1_0232_418A_A190_CE098A4E0D90__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// Splash.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CSplash dialog

class CSplash : public CDialog
{
// Construction
public:
	CSplash(CWnd* pParent = NULL);   // standard constructor

// Dialog Data
	//{{AFX_DATA(CSplash)
	enum { IDD = IDD_SPLASH };
	CStatic	m_static;
	CProgressCtrl	m_progress;
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CSplash)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:

	// Generated message map functions
	//{{AFX_MSG(CSplash)
		// NOTE: the ClassWizard will add member functions here
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_SPLASH_H__EC16ADF1_0232_418A_A190_CE098A4E0D90__INCLUDED_)
