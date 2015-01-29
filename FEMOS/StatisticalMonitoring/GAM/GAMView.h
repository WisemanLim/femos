// GAMView.h : interface of the CGAMView class
//
/////////////////////////////////////////////////////////////////////////////

#if !defined(AFX_GAMVIEW_H__FA20231F_7F9F_4BB0_9DAF_2E645F814867__INCLUDED_)
#define AFX_GAMVIEW_H__FA20231F_7F9F_4BB0_9DAF_2E645F814867__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

class CGAMDoc;

class CGAMView : public CScrollView
{
protected: // create from serialization only
	CGAMView();
	DECLARE_DYNCREATE(CGAMView)

// Attributes
public:
	RECT	m_rtClient;
	CDC		m_dcBuffer;
	CDC		m_dcBack;

// Operations
public:
	void	Render(BOOL bRedraw);
	void	SetGridColor(COLORREF back, COLORREF grid);
	void	ChangeDisplay();

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CGAMView)
	public:
	virtual void OnDraw(CDC* pDC);  // overridden to draw this view
	virtual BOOL OnScroll(UINT nScrollCode, UINT nPos, BOOL bDoScroll = TRUE);
	virtual BOOL PreTranslateMessage(MSG* pMsg);
	protected:
	virtual void OnInitialUpdate(); // called first time after construct
	virtual BOOL OnPreparePrinting(CPrintInfo* pInfo);
	//}}AFX_VIRTUAL

// Implementation
protected:
	RECT	m_rtDrag;
	RECT	m_rtEditing;
	BOOL	m_bLButtonDown;
	BOOL	m_bShiftPressed;
	BOOL	m_bCtrlPressed;
	BOOL	m_bEditing;
	BOOL	m_bViewGrid;
	CEdit	m_editStr;
	CGAMDoc*		m_pDoc;
	CToolTipCtrl	m_tooltip;

	CGAMDoc*	GetDoc();
	void		DrawItem();
	void		DrawUnSelectedLink();
	void		DrawSelectedLink();
	void		OnEditText();
	void		DrawLabel();
	void		DrawToolTip();
public:
	virtual		~CGAMView();
#ifdef _DEBUG
	virtual void AssertValid() const;
	virtual void Dump(CDumpContext& dc) const;
#endif

protected:

// Generated message map functions
protected:
	//{{AFX_MSG(CGAMView)
	afx_msg void OnSize(UINT nType, int cx, int cy);
	afx_msg void OnLButtonDown(UINT nFlags, CPoint point);
	afx_msg void OnLButtonUp(UINT nFlags, CPoint point);
	afx_msg void OnMouseMove(UINT nFlags, CPoint point);
	afx_msg void OnContextMenu(CWnd* pWnd, CPoint point);
	afx_msg BOOL OnEraseBkgnd(CDC* pDC);
	afx_msg void OnKeyDown(UINT nChar, UINT nRepCnt, UINT nFlags);
	afx_msg void OnKeyUp(UINT nChar, UINT nRepCnt, UINT nFlags);
	afx_msg BOOL OnMouseWheel(UINT nFlags, short zDelta, CPoint pt);
	afx_msg void OnRButtonDown(UINT nFlags, CPoint point);
	afx_msg void OnLButtonDblClk(UINT nFlags, CPoint point);
	afx_msg void OnChar(UINT nChar, UINT nRepCnt, UINT nFlags);
	afx_msg void OnEditTextedit();
	afx_msg void OnUpdateEditText(CCmdUI* pCmdUI);
	afx_msg void OnViewGrid();
	afx_msg void OnUpdateViewGrid(CCmdUI* pCmdUI);
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

#ifndef _DEBUG  // debug version in GAMView.cpp
inline CGAMDoc* CGAMView::GetDoc()
   { return (CGAMDoc*)m_pDocument; }
#endif

/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_GAMVIEW_H__FA20231F_7F9F_4BB0_9DAF_2E645F814867__INCLUDED_)
