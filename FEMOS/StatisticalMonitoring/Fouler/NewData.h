#if !defined(AFX_NEWDATA_H__4679BD0F_C2BF_42F5_850C_5DB8204343A2__INCLUDED_)
#define AFX_NEWDATA_H__4679BD0F_C2BF_42F5_850C_5DB8204343A2__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// NewData.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CNewData dialog

class CNewData : public CDialog
{
// Construction
public:
	CNewData(double dAverage, int iDataNo, double dDeviation, double dMoverate, CWnd* pParent = NULL);   // standard constructor

	int m_iGenMode;
// Dialog Data
	//{{AFX_DATA(CNewData)
	enum { IDD = IDD_DIALOG_NEWDATA };
	CSpinButtonCtrl	m_spinDataNo;
	CComboBox	m_distribution;
	double	m_average;
	int		m_datano;
	double	m_deviation;
	double	m_moverate;
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CNewData)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:

	// Generated message map functions
	//{{AFX_MSG(CNewData)
	virtual void OnOK();
	virtual BOOL OnInitDialog();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_NEWDATA_H__4679BD0F_C2BF_42F5_850C_5DB8204343A2__INCLUDED_)
