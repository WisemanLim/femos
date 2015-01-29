// MainFrm.h : interface of the CMainFrame class
//
/////////////////////////////////////////////////////////////////////////////

#if !defined(AFX_MAINFRM_H__0149A57A_4720_4644_952B_981D20D80434__INCLUDED_)
#define AFX_MAINFRM_H__0149A57A_4720_4644_952B_981D20D80434__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#include "FoulerDoc.h"

class CMainFrame : public CMDIFrameWnd
{
	DECLARE_DYNAMIC(CMainFrame)
public:
	CMainFrame();

// Attributes
public:
	CStatusBar  m_wndStatusBar;
	CToolBar    m_wndToolBar;
	CComboBox	m_Combo;
	CSliderCtrl	m_slider;
	CEdit		m_edit;
	CStatic		m_static;
	CString		m_strExcelDriver;
	COLORREF	m_rgb0;
	COLORREF	m_rgb1;
	COLORREF	m_rgb2;
	COLORREF	m_rgb3;
	COLORREF	m_rgb4;
	COLORREF	m_rgb5;
	COLORREF	m_rgb6;
	COLORREF	m_rgb7;
	COLORREF	m_rgb8;

// Operations
public:
	CString		GetExcelDriver();

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CMainFrame)
	public:
	virtual BOOL PreCreateWindow(CREATESTRUCT& cs);
	//}}AFX_VIRTUAL

// Implementation
public:
	virtual ~CMainFrame();
#ifdef _DEBUG
	virtual void AssertValid() const;
	virtual void Dump(CDumpContext& dc) const;
#endif

protected:  // control bar embedded members

// Generated message map functions
protected:
	//{{AFX_MSG(CMainFrame)
	afx_msg int OnCreate(LPCREATESTRUCT lpCreateStruct);
	afx_msg void OnTimer(UINT nIDEvent);
	afx_msg void OnEditIncreaseSpeed();
	afx_msg void OnEditDecreaseSpeed();
	afx_msg void OnToolOption();
	//}}AFX_MSG
	afx_msg void OnComboSelChange();
	DECLARE_MESSAGE_MAP()
};

/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_MAINFRM_H__0149A57A_4720_4644_952B_981D20D80434__INCLUDED_)
