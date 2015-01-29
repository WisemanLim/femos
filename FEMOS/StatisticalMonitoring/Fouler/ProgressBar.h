#if !defined(AFX_PROGRESSBAR_H__5FB385E1_E412_11D1_994B_444553540000__INCLUDED_)
#define AFX_PROGRESSBAR_H__5FB385E1_E412_11D1_994B_444553540000__INCLUDED_

#if _MSC_VER >= 1000
#pragma once
#endif // _MSC_VER >= 1000
// ProgressBar.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CProgressBar command target

class CProgressBar: public CProgressCtrl
{
    DECLARE_DYNCREATE(CProgressBar)

public:
    CProgressBar();
    ~CProgressBar();

// operations
public:
// Overrides
    //{{AFX_VIRTUAL(CProgressBar)
    //}}AFX_VIRTUAL

// implementation
protected:

// Generated message map functions
protected:
    //{{AFX_MSG(CProgressBar)
    //}}AFX_MSG
    DECLARE_MESSAGE_MAP()
};

#endif
/////////////////////////////////////////////////////////////////////////////

