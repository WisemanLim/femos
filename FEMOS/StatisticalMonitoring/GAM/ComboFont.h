#if !defined(AFX_COMBOFONT_H__1631502C_7939_44CF_9729_3B5A8B218494__INCLUDED_)
#define AFX_COMBOFONT_H__1631502C_7939_44CF_9729_3B5A8B218494__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// ComboFont.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CComboFont window

class CComboFont : public CComboBox
{
// Construction
public:
	CComboFont();

// Attributes
public:
	LOGFONT	*m_plf[DEF_MAXFONTNO];
// Operations
public:
	void	Initialize();
	BOOL	EnumerateFonts();
	void	AddFont(ENUMLOGFONTEX* pelf);

	static BOOL CALLBACK AFX_EXPORT EnumFamScreenCallBackEx(
	ENUMLOGFONTEX* pelf, NEWTEXTMETRICEX* /*lpntm*/, int FontType, 
	LPVOID pThis);

	static BOOL CALLBACK AFX_EXPORT EnumFamPrinterCallBackEx(
	ENUMLOGFONTEX* pelf, NEWTEXTMETRICEX* /*lpntm*/, int FontType, 
	LPVOID pThis);

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CComboFont)
	//}}AFX_VIRTUAL

// Implementation
public:
	virtual ~CComboFont();

	// Generated message map functions
protected:
	//{{AFX_MSG(CComboFont)
	afx_msg int OnCreate(LPCREATESTRUCT lpCreateStruct);
	//}}AFX_MSG

	DECLARE_MESSAGE_MAP()
};

/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_COMBOFONT_H__1631502C_7939_44CF_9729_3B5A8B218494__INCLUDED_)
