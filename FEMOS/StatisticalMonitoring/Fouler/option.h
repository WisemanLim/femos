#if !defined(AFX_OPTION_H__01C41A4E_7D6D_43AD_B898_9684CE94DD88__INCLUDED_)
#define AFX_OPTION_H__01C41A4E_7D6D_43AD_B898_9684CE94DD88__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// Option.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// COptionColor dialog

class COptionColor : public CPropertyPage
{
	DECLARE_DYNCREATE(COptionColor)

// Construction
public:
	COptionColor();
	~COptionColor();
	COLORREF	m_rgb0;
	COLORREF	m_rgb1;
	COLORREF	m_rgb2;
	COLORREF	m_rgb3;
	COLORREF	m_rgb4;
	COLORREF	m_rgb5;
	COLORREF	m_rgb6;
	COLORREF	m_rgb7;
	COLORREF	m_rgb8;
	CBrush		m_brush;

// Dialog Data
	//{{AFX_DATA(COptionColor)
	enum { IDD = IDD_DIALOG_OPTION_COLOR };
	CStatic	m_static_color0;
	CStatic	m_static_color8;
	CStatic	m_static_color7;
	CStatic	m_static_color6;
	CStatic	m_static_color5;
	CStatic	m_static_color4;
	CStatic	m_static_color3;
	CStatic	m_static_color2;
	CStatic	m_static_color1;
	//}}AFX_DATA


// Overrides
	// ClassWizard generate virtual function overrides
	//{{AFX_VIRTUAL(COptionColor)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:
	// Generated message map functions
	//{{AFX_MSG(COptionColor)
	afx_msg void OnButtonBackground();
	afx_msg void OnButtonColor1();
	afx_msg void OnButtonColor2();
	afx_msg void OnButtonColor3();
	afx_msg void OnButtonColor4();
	afx_msg void OnButtonColor5();
	afx_msg void OnButtonColor6();
	afx_msg void OnButtonColor7();
	afx_msg void OnButtonColor8();
	afx_msg HBRUSH OnCtlColor(CDC* pDC, CWnd* pWnd, UINT nCtlColor);
	afx_msg void OnButtonColorDefault();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()

};

/////////////////////////////////////////////////////////////////////////////
// COptionGeneral dialog

class COptionGeneral : public CPropertyPage
{
	DECLARE_DYNCREATE(COptionGeneral)

// Construction
public:
	COptionGeneral();
	~COptionGeneral();

// Dialog Data
	//{{AFX_DATA(COptionGeneral)
	enum { IDD = IDD_DIALOG_OPTION_GENERAL };
		// NOTE - ClassWizard will add data members here.
		//    DO NOT EDIT what you see in these blocks of generated code !
	//}}AFX_DATA


// Overrides
	// ClassWizard generate virtual function overrides
	//{{AFX_VIRTUAL(COptionGeneral)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:
	// Generated message map functions
	//{{AFX_MSG(COptionGeneral)
		// NOTE: the ClassWizard will add member functions here
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()

};
/////////////////////////////////////////////////////////////////////////////
// COption

class COption : public CPropertySheet
{
	DECLARE_DYNAMIC(COption)

// Construction
public:
	COption(LPCTSTR pszCaption, CWnd* pParentWnd = NULL, UINT iSelectPage = 0);

// Attributes
public:
	COptionGeneral	m_tabGeneral;
	COptionColor	m_tabColor;
// Operations
public:

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(COption)
	//}}AFX_VIRTUAL

// Implementation
public:
	virtual ~COption();

	// Generated message map functions
protected:
	//{{AFX_MSG(COption)
		// NOTE - the ClassWizard will add and remove member functions here.
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

/////////////////////////////////////////////////////////////////////////////
//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_OPTION_H__01C41A4E_7D6D_43AD_B898_9684CE94DD88__INCLUDED_)
