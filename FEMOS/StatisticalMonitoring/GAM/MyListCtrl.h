#if !defined(AFX_MYLISTCTRL_H__B37B8C5D_0A23_45CD_BBAC_99BB5D8DA976__INCLUDED_)
#define AFX_MYLISTCTRL_H__B37B8C5D_0A23_45CD_BBAC_99BB5D8DA976__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// MyListCtrl.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CMyListCtrl window

class CMyListCtrl : public CListCtrl
{
// Construction
public:
	CMyListCtrl();

// Attributes
public:
	int m_item;
	int m_subitem;

// Operations
public:

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CMyListCtrl)
	protected:
	//}}AFX_VIRTUAL

// Implementation
public:
	virtual ~CMyListCtrl();
	void	SetToolTips(BOOL bEnable = TRUE);
	int     OnToolHitTest(CPoint point, TOOLINFO *pTI) const;
    inline  void SetColumnCount(int nCount) { m_nColumnCount = nCount; }

protected:
    int			m_nColumnCount;
    COLORREF	m_colorTextOdd, m_colorTextEven, m_colorBackOdd, m_colorBackEven, m_colorTextHighlight, m_colorBackHighlight;

	// Generated message map functions
protected:
	int		GetRowFromPoint(CPoint &point, CRect *rcCell, int *nCol) const;
	void	DrawItem(LPDRAWITEMSTRUCT lpDrawItemStruct);

	//{{AFX_MSG(CMyListCtrl)
	afx_msg void OnEndlabeledit(NMHDR* pNMHDR, LRESULT* pResult);
	afx_msg void OnLButtonUp(UINT nFlags, CPoint point);
	afx_msg void OnPaint();
	//}}AFX_MSG
	afx_msg BOOL OnToolTipText(UINT id, NMHDR *pNMHDR, LRESULT *pResult);

	DECLARE_MESSAGE_MAP()
};

/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_MYLISTCTRL_H__B37B8C5D_0A23_45CD_BBAC_99BB5D8DA976__INCLUDED_)
