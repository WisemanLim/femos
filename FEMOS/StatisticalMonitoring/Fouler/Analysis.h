#if !defined(AFX_ANALYSIS_H__5ED18532_2CBA_4445_B2C8_12044E4A27A8__INCLUDED_)
#define AFX_ANALYSIS_H__5ED18532_2CBA_4445_B2C8_12044E4A27A8__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// Analysis.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CAnalysis dialog

class CAnalysis : public CDialog
{
// Construction
public:
	CAnalysis( int iSubGroupSize, double dAlpha, double dBeta, double dDeviation, double dH, double dK, double dTheta0, CWnd* pParent = NULL);   // standard constructor

// Dialog Data
	//{{AFX_DATA(CAnalysis)
	enum { IDD = IDD_DIALOG_ANALYSIS };
	CSpinButtonCtrl	m_spinSubGroup;
	double	m_dAlpha;
	double	m_dBeta;
	double	m_dDeviation;
	double	m_dH;
	double	m_dK;
	double	m_dTheta0;
	int		m_iSubGroupSize;
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CAnalysis)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:

	// Generated message map functions
	//{{AFX_MSG(CAnalysis)
	virtual void OnOK();
	virtual BOOL OnInitDialog();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_ANALYSIS_H__5ED18532_2CBA_4445_B2C8_12044E4A27A8__INCLUDED_)
