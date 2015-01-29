#if !defined(AFX_FIELDSELECT_H__A8F697D4_8C4B_49DB_A9A9_76951528851C__INCLUDED_)
#define AFX_FIELDSELECT_H__A8F697D4_8C4B_49DB_A9A9_76951528851C__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// FieldSelect.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CFieldSelect dialog

class CFieldSelect : public CDialog
{
// Construction
public:
	CFieldSelect( CRecordset* pRecordSet, CWnd* pParent = NULL);   // standard constructor
	CRecordset* m_pRecordSet;
	short	m_sCurField;
	short	m_sField0;
	short	m_sField1;
	short	m_sField2;
	short	m_sField3;
	double	m_dCo0;
	double	m_dCo1;
	double	m_dCo2;
	double	m_dCo3;

// Dialog Data
	//{{AFX_DATA(CFieldSelect)
	enum { IDD = IDD_DIALOG_FIELDSELECT };
	CEdit	m_field3;
	CEdit	m_field2;
	CEdit	m_field1;
	CEdit	m_field0;
	CEdit	m_co0;
	CEdit	m_co3;
	CEdit	m_co2;
	CEdit	m_co1;
	CListBox	m_fieldlist;
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CFieldSelect)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:

	// Generated message map functions
	//{{AFX_MSG(CFieldSelect)
	virtual BOOL OnInitDialog();
	virtual void OnOK();
	afx_msg void OnDblclkListField();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_FIELDSELECT_H__A8F697D4_8C4B_49DB_A9A9_76951528851C__INCLUDED_)
