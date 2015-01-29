#if !defined(AFX_PROPERTIES_H__BEA79A5F_8877_4BCE_B94A_F9689F158ED4__INCLUDED_)
#define AFX_PROPERTIES_H__BEA79A5F_8877_4BCE_B94A_F9689F158ED4__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// Properties.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CProperties dialog

#include "GAMDoc.h"

class CProperties : public CDialog
{
// Construction
public:
	CProperties(CGAMDoc *pDoc, CWnd* pParent = NULL);   // standard constructor
	BOOL m_bReady;
	CGAMDoc *m_pDoc;

// Dialog Data
	//{{AFX_DATA(CProperties)
	enum { IDD = IDD_DIALOG_PROPERTIES };
	CSpinButtonCtrl	m_spinDepth;
	CEdit	m_editValue;
	int		m_iIndex;
	int		m_iLevel;
	CString	m_strName;
	float	m_fValue;
	int		m_iDepth;
	int		m_iAccel;
	int		m_iSort;
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CProperties)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:

	// Generated message map functions
	//{{AFX_MSG(CProperties)
	afx_msg void OnRadioSum();
	virtual BOOL OnInitDialog();
	afx_msg void OnPaint();
	afx_msg void OnRadioAccelup();
	afx_msg void OnRadioAcceldown();
	afx_msg void OnRadioAscending();
	afx_msg void OnRadioDescending();
	afx_msg void OnChangeEditDepth();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_PROPERTIES_H__BEA79A5F_8877_4BCE_B94A_F9689F158ED4__INCLUDED_)
