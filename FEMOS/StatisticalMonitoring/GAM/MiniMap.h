#if !defined(AFX_MINIMAP_H__D6539EC1_6DB7_438A_AEC1_EFFC3471EB82__INCLUDED_)
#define AFX_MINIMAP_H__D6539EC1_6DB7_438A_AEC1_EFFC3471EB82__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// MiniMap.h : header file
//

#include "SCBar.h"
/////////////////////////////////////////////////////////////////////////////
// CMiniMap window

class CMiniMap : public CSCBar
{
// Construction
public:
	CMiniMap();

// Attributes
public:
	CDC		*m_pDCBuffer;
	RECT	m_rtClient;
	RECT	m_rtDraw;
	BOOL	m_bLButtonDown;

// Overridables
    virtual void OnUpdateCmdUI(CFrameWnd* pTarget, BOOL bDisableIfNoHndler);

// Operations
public:
	void Render(BOOL bRedraw);
	void DrawItem();

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CMiniMap)
	//}}AFX_VIRTUAL

// Implementation
public:
	virtual ~CMiniMap();

protected:
	// Generated message map functions
protected:
	//{{AFX_MSG(CMiniMap)
    afx_msg void OnSize(UINT nType, int cx, int cy);
	afx_msg void OnPaint();
	afx_msg int OnCreate(LPCREATESTRUCT lpCreateStruct);
	afx_msg void OnLButtonDown(UINT nFlags, CPoint point);
	afx_msg void OnMouseMove(UINT nFlags, CPoint point);
	afx_msg void OnLButtonUp(UINT nFlags, CPoint point);
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_MINIMAP_H__D6539EC1_6DB7_438A_AEC1_EFFC3471EB82__INCLUDED_)
