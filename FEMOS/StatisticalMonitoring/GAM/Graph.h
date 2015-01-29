#if !defined(AFX_GRAPH_H__4ACDDDBC_114A_42BF_8ABA_542A78C94435__INCLUDED_)
#define AFX_GRAPH_H__4ACDDDBC_114A_42BF_8ABA_542A78C94435__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// Graph.h : header file
//

#include "SCBar.h"
#include "GraphObject.h"
#include "GAMDoc.h"
#include "DataView.h"

/////////////////////////////////////////////////////////////////////////////
// CGraph window

class CGraph : public CSCBar
{
// Construction
public:
	CGraph();

// Attributes
public:
	CItem			*m_pCurItem;
	CComboBox		m_cbGraphType;
	CComboBox		m_cbGraphEffect;
	CComboBox		m_cbGraphItemID;
	CGraphObject	*m_pGraph;
	COLORREF		m_rgb[DEF_MAXALTER];

// Overridables
    virtual void OnUpdateCmdUI(CFrameWnd* pTarget, BOOL bDisableIfNoHndler);

// Operations
public:
	void	Render();
	void	DrawGraph();
	void	DrawPie();
	void	DrawBar();
	void	DrawLine();

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CGraph)
	//}}AFX_VIRTUAL

// Implementation
public:
	virtual ~CGraph();

protected:
	// Generated message map functions
protected:
	//{{AFX_MSG(CGraph)
    afx_msg void OnSize(UINT nType, int cx, int cy);
	afx_msg int OnCreate(LPCREATESTRUCT lpCreateStruct);
	//}}AFX_MSG
public:
	afx_msg void ChangeGraphType();
	afx_msg void ChangeItemID();
	DECLARE_MESSAGE_MAP()
};

/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_GRAPH_H__4ACDDDBC_114A_42BF_8ABA_542A78C94435__INCLUDED_)
