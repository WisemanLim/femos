// FoulerView.h : interface of the CFoulerView class
//
/////////////////////////////////////////////////////////////////////////////

#if !defined(AFX_FOULERVIEW_H__66635161_1CD3_407E_867F_E3A6F15F6F46__INCLUDED_)
#define AFX_FOULERVIEW_H__66635161_1CD3_407E_867F_E3A6F15F6F46__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000


class CFoulerView : public CScrollView
{
protected: // create from serialization only
	CFoulerView();
	DECLARE_DYNCREATE(CFoulerView)

// Attributes
public:
	CFoulerDoc* GetDocument();
	HGLRC		m_hRC;
	HDC			m_hDC;
	int			m_iSizeX;
	int			m_iSizeY;
	int			m_iScrollShewart;
	int			m_iScrollCUSUM;
	int			m_iScrollSPRT;
	HFONT		m_hFont;
	LOGFONT*	m_plf;
	COLORREF	rgb0;
	COLORREF	rgb1;
	COLORREF	rgb2;
	COLORREF	rgb3;
	COLORREF	rgb4;
	COLORREF	rgb5;
	COLORREF	rgb6;
	COLORREF	rgb7;
	COLORREF	rgb8;
	RECT		m_rtClient;

// Operations
public:
	void DrawGrid();
	void Refresh();
	void DrawHistogram();
	void DrawShewart();
	void DrawCUSUM();
	void DrawSPRT();

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CFoulerView)
	public:
	virtual void OnDraw(CDC* pDC);  // overridden to draw this view
	virtual BOOL PreCreateWindow(CREATESTRUCT& cs);
	virtual BOOL OnScroll(UINT nScrollCode, UINT nPos, BOOL bDoScroll = TRUE);
	virtual BOOL DestroyWindow();
	protected:
	virtual void OnInitialUpdate(); // called first time after construct
	virtual BOOL OnPreparePrinting(CPrintInfo* pInfo);
	virtual void OnBeginPrinting(CDC* pDC, CPrintInfo* pInfo);
	virtual void OnEndPrinting(CDC* pDC, CPrintInfo* pInfo);
	//}}AFX_VIRTUAL

// Implementation
public:
	virtual ~CFoulerView();
#ifdef _DEBUG
	virtual void AssertValid() const;
	virtual void Dump(CDumpContext& dc) const;
#endif

protected:

// Generated message map functions
protected:
	//{{AFX_MSG(CFoulerView)
	afx_msg void OnSize(UINT nType, int cx, int cy);
	afx_msg int OnCreate(LPCREATESTRUCT lpCreateStruct);
	afx_msg void OnPaint();
	afx_msg void OnTimer(UINT nIDEvent);
	afx_msg void OnMouseMove(UINT nFlags, CPoint point);
	afx_msg BOOL OnMouseWheel(UINT nFlags, short zDelta, CPoint pt);
	afx_msg void OnContextMenu(CWnd* pWnd, CPoint point);
	afx_msg BOOL OnEraseBkgnd(CDC* pDC);
	afx_msg void OnViewChangefont();
	afx_msg void OnFilePrintPreview();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

#ifndef _DEBUG  // debug version in FoulerView.cpp
inline CFoulerDoc* CFoulerView::GetDocument()
   { return (CFoulerDoc*)m_pDocument; }
#endif

/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_FOULERVIEW_H__66635161_1CD3_407E_867F_E3A6F15F6F46__INCLUDED_)
