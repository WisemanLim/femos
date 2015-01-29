#if !defined(AFX_RESULT_H__89BD7A94_C835_459D_8BE3_7E2F0D605939__INCLUDED_)
#define AFX_RESULT_H__89BD7A94_C835_459D_8BE3_7E2F0D605939__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// Result.h : header file
//

#include "SCBar.h"
#include "MyListCtrl.h"
/////////////////////////////////////////////////////////////////////////////
// CResult window

class CResult : public CSCBar
{
// Construction
public:
	CResult();

// Attributes
public:
	CMyListCtrl m_list;

// Overridables
    virtual void OnUpdateCmdUI(CFrameWnd* pTarget, BOOL bDisableIfNoHndler);

// Operations
public:
	void Render();

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CResult)
	//}}AFX_VIRTUAL

// Implementation
public:
	virtual ~CResult();

	// Generated message map functions
protected:
	//{{AFX_MSG(CResult)
    afx_msg void OnSize(UINT nType, int cx, int cy);
	afx_msg void OnPaint();
	afx_msg int OnCreate(LPCREATESTRUCT lpCreateStruct);
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_RESULT_H__89BD7A94_C835_459D_8BE3_7E2F0D605939__INCLUDED_)
