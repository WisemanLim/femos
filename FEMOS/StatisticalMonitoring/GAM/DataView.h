#if !defined(AFX_DATAVIEW_H__D62683DF_B9D1_45FF_813B_0E4626A29EAB__INCLUDED_)
#define AFX_DATAVIEW_H__D62683DF_B9D1_45FF_813B_0E4626A29EAB__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// DataView.h : header file
//

#include "SCBar.h"
#include "GridCtrl.h"

/////////////////////////////////////////////////////////////////////////////
// CDataView window

class CDataView : public CSCBar
{
// Construction
public:
	CDataView();
	DECLARE_DYNCREATE(CDataView)

// Attributes
public:
	CComboBox	m_cbViewType;
	CGridCtrl	m_Grid;
	CSize		m_OldSize;
	BOOL		m_bPasting;

// Overridables
    virtual void OnUpdateCmdUI(CFrameWnd* pTarget, BOOL bDisableIfNoHndler);

// Operations
public:
	void Render();

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CDataView)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
public:
	virtual ~CDataView();

protected:
	// Generated message map functions
protected:
	//{{AFX_MSG(CDataView)
    afx_msg void OnSize(UINT nType, int cx, int cy);
	afx_msg void OnPaint();
	afx_msg int OnCreate(LPCREATESTRUCT lpCreateStruct);
	afx_msg void OnEditCopy();
	afx_msg void OnEditCut();
	afx_msg void OnEditPaste();
	afx_msg void OnEditLabel();
	afx_msg void OnInsertAlter();
	afx_msg void OnDeleteAlter();
	afx_msg void OnCurrentAlter();
	afx_msg void OnUpdateEditCopy(CCmdUI* pCmdUI);
	afx_msg void OnUpdateEditCut(CCmdUI* pCmdUI);
	afx_msg void OnUpdateEditPaste(CCmdUI* pCmdUI);
	//}}AFX_MSG
	afx_msg void OnEndLabelEdit(NMHDR *pNotifyStruct, LRESULT* pResult);
	afx_msg void OnBeginPaste(NMHDR *pNotifyStruct, LRESULT* pResult);
	afx_msg void OnEndPaste(NMHDR *pNotifyStruct, LRESULT* pResult);
    afx_msg void OnGridDblClick(NMHDR *pNotifyStruct, LRESULT* pResult);
    afx_msg void OnGridClick(NMHDR *pNotifyStruct, LRESULT* pResult);
    afx_msg void OnGridRClick(NMHDR *pNotifyStruct, LRESULT* pResult);
	DECLARE_MESSAGE_MAP()
};

/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_DATAVIEW_H__D62683DF_B9D1_45FF_813B_0E4626A29EAB__INCLUDED_)
