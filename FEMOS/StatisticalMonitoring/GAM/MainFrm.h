// MainFrm.h : interface of the CMainFrame class
//
/////////////////////////////////////////////////////////////////////////////

#if !defined(AFX_MAINFRM_H__7E64DB4A_9C83_44E3_A680_A0C932A5DBF6__INCLUDED_)
#define AFX_MAINFRM_H__7E64DB4A_9C83_44E3_A680_A0C932A5DBF6__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#include "Graph.h"
#include "MiniMap.h"
#include "Result.h"
#include "DataView.h"
#include "ComboFont.h"
#include "BCMenu.h"

class CMainFrame : public CFrameWnd
{
	
protected: // create from serialization only
	CMainFrame();
	DECLARE_DYNCREATE(CMainFrame)

// Attributes
public:
	BOOL		m_bIsBold;
	BOOL		m_bIsItalic;
	BOOL		m_bIsUnderline;
	CDataView	m_wndData;
	CMiniMap	m_wndMiniMap;
	CResult		m_wndResult;
	CGraph		m_wndGraph;
	CComboFont	m_comboFont;
	LOGFONT*	m_plfCurrent;
	CSize		m_scr;
	HMENU		NewMenu();
	BCMenu		m_menu;

// Operations
public:
	void	ChangeFont();

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CMainFrame)
	public:
	virtual BOOL DestroyWindow();
	//}}AFX_VIRTUAL

// Implementation
public:
	virtual ~CMainFrame();
#ifdef _DEBUG
	virtual void AssertValid() const;
	virtual void Dump(CDumpContext& dc) const;
#endif

protected:  // control bar embedded members
	CStatusBar  m_wndStatusBar;
	CToolBar    m_wndToolBar;

// Generated message map functions
protected:
	//{{AFX_MSG(CMainFrame)
	afx_msg int OnCreate(LPCREATESTRUCT lpCreateStruct);
	afx_msg void OnViewData();
	afx_msg void OnUpdateViewData(CCmdUI* pCmdUI);
	afx_msg void OnViewGraph();
	afx_msg void OnUpdateViewGraph(CCmdUI* pCmdUI);
	afx_msg void OnViewMinimap();
	afx_msg void OnUpdateViewMinimap(CCmdUI* pCmdUI);
	afx_msg void OnFontBold();
	afx_msg void OnUpdateFontBold(CCmdUI* pCmdUI);
	afx_msg void OnFontItalic();
	afx_msg void OnUpdateFontItalic(CCmdUI* pCmdUI);
	afx_msg void OnFontUnderline();
	afx_msg void OnUpdateFontUnderline(CCmdUI* pCmdUI);
	afx_msg void OnViewChangefont();
	afx_msg void OnContextMenu(CWnd* pWnd, CPoint point);
	afx_msg void OnViewResult();
	afx_msg void OnUpdateViewResult(CCmdUI* pCmdUI);
	afx_msg void OnToolOption();
	afx_msg void OnViewToolbar();
	afx_msg void OnUpdateViewToolbar(CCmdUI* pCmdUI);
	afx_msg void OnMeasureItem(int nIDCtl, LPMEASUREITEMSTRUCT lpMeasureItemStruct);
	afx_msg LRESULT OnMenuChar(UINT nChar, UINT nFlags, CMenu* pMenu);
	afx_msg void OnInitMenuPopup(CMenu* pPopupMenu, UINT nIndex, BOOL bSysMenu);
	//}}AFX_MSG
	afx_msg void OnComboSelChange();
	DECLARE_MESSAGE_MAP()
};

/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_MAINFRM_H__7E64DB4A_9C83_44E3_A680_A0C932A5DBF6__INCLUDED_)
