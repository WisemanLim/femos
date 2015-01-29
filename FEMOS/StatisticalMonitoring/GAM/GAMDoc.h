// GAMDoc.h : interface of the CGAMDoc class
//
/////////////////////////////////////////////////////////////////////////////

#if !defined(AFX_GAMDOC_H__DC70AA23_6BD8_4D52_9F31_E0CFCCBE423A__INCLUDED_)
#define AFX_GAMDOC_H__DC70AA23_6BD8_4D52_9F31_E0CFCCBE423A__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#include "GAMView.h"
#include "MiniMap.h"
#include "Data.h"

class CGAMDoc : public CDocument
{
protected: // create from serialization only
	CGAMDoc();
	DECLARE_DYNCREATE(CGAMDoc)

// Attributes
public:
	CData		*m_pData;
	POINT		m_ptScroll;
	POINT		m_ptSheet;
	CGAMView	*m_pRightView;
	CPen		m_penDragDot;
	CPen		m_penRed, m_penGreen, m_penBlue;
	CBrush		m_brsRed, m_brsGreen, m_brsBlue;
	CPen		m_penWindowText, m_penWindowColour, m_penFace, m_penShadow, m_penDKShadow, m_penLight;
	CBrush		m_brsWindowText, m_brsWindowColour, m_brsFace, m_brsShadow, m_brsDKShadow, m_brsLight;
//				   검정색,			흰색,			 일반색,	옅은그림자, 짙은그림자,			밝은색
//				RGB(0,0,0),  RGB(255,255,255), RGB(212,208,200),RGB(128,128,128),RGB(64,64,64),RGB(241,239,226)

// Operations
public:
	int		GetSelectedItemNo();
	int		GetSelectedLinkNo();
	int		GetChildNo(int iParent);
	void	UpdateAll(BOOL bRedrawMain, BOOL bRedraw);
	void	GetSelectedItem(int *pItem1, int *pItem2 = NULL);
	void	GetSelectedLink(int *pLink1, int *pLink2 = NULL);
	void	ClearSelected();
	void	ChangeSelection(BOOL bShiftPressed);
	void	CheckSelected(RECT *pRect, BOOL bUpdate);
	void	Restore();
	void	CalculateSiblings();
	void	SetLabel(char *cLabel);
	void	SetRightView( CGAMView *pView );
	void	ScrollToPos( POINT pt );
	void	ScrollByPos( POINT pt );
	void	AddChild();
	void	AddChilds();
	void	InsertAlter(int iIndex);
	void	DeleteAlter(int iIndex);
	void	SetCurAlter(int iIndex);
	void	ExtendSheet(int iSize);
	BOOL	IsPointInRect( POINT *pt, RECT *rt );
	BOOL	IsLineInRect( POINT *ptParent, POINT *ptChild, RECT *pRect);
	BOOL	IsPointNearLine( POINT *pt, POINT *ptParent, POINT *ptChild );
	BOOL	IsLinkable();
	BOOL	IsRemovable();
	float	GetValue(int iAlter, int iItem);
	float	GetPercentage(int iIndex);

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CGAMDoc)
	public:
	virtual BOOL OnNewDocument();
	virtual void Serialize(CArchive& ar);
	virtual BOOL OnOpenDocument(LPCTSTR lpszPathName);
	virtual void DeleteContents();
	virtual BOOL OnSaveDocument(LPCTSTR lpszPathName);
	//}}AFX_VIRTUAL

// Implementation
public:
	virtual ~CGAMDoc();
#ifdef _DEBUG
	virtual void AssertValid() const;
	virtual void Dump(CDumpContext& dc) const;
#endif

// Generated message map functions
	afx_msg void OnViewProperties();
	afx_msg void OnEditRemoveitem();
protected:
	//{{AFX_MSG(CGAMDoc)
	afx_msg void AddLink();
	afx_msg void OnUpdateEditRemoveitem(CCmdUI* pCmdUI);
	afx_msg void OnEditSelectAll();
	afx_msg void OnEditCalculate();
	afx_msg void OnViewOnGraph();
	afx_msg void OnUpdateEditCalculate(CCmdUI* pCmdUI);
	afx_msg void OnUpdateEditAddlink(CCmdUI* pCmdUI);
	afx_msg void OnUpdateEditAddchild(CCmdUI* pCmdUI);
	afx_msg void OnUpdateEditProperties(CCmdUI* pCmdUI);
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_GAMDOC_H__DC70AA23_6BD8_4D52_9F31_E0CFCCBE423A__INCLUDED_)
