// FoulerDoc.h : interface of the CFoulerDoc class
//
/////////////////////////////////////////////////////////////////////////////

#if !defined(AFX_FOULERDOC_H__91050774_5071_430F_ACB9_B31F83431F92__INCLUDED_)
#define AFX_FOULERDOC_H__91050774_5071_430F_ACB9_B31F83431F92__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#include "Analysis.h"
#include "Generator.h"
#include "HISTOGRAM.h"
#include "SHEWART.h"
#include "CUSUM.h"
#include "SPRT.h"
#include "NewData.h"
#include "LeftView.h"
#include "FoulerView.h"
#include "Data.h"

class CFoulerDoc : public CDocument
{
protected: // create from serialization only
	CFoulerDoc();
	DECLARE_DYNCREATE(CFoulerDoc)

// Attributes
public:
	CData*		m_pData[DEF_MAX_DATASIZE];
	CData*		m_pOrgData[DEF_MAX_DATASIZE];
	int			m_iOriginNo;
	int			m_iNo;
	int			m_iSubGroupSize;
	int			m_iSubGroupIndex;
	int			m_iViewMode;
	int			m_iHistogram[DEF_HISTOGRAM_SIZE];
	double		m_dSpeed;
	double		m_dIndex;
	BOOL		m_bPlaying;
	BOOL		m_bModified;
	CGenerator	m_generator;
	CHISTOGRAM	m_histogram;
	CSHEWART	m_shewart;
	CCUSUM		m_cusum;
	CSPRT		m_sprt;
	CString		m_strPathName;
	CString		m_strFileName;
	CString		m_strFileTitle;
	CString		m_strFileExt;
	CLeftView	*m_pLeftView;
	CFoulerView	*m_pRightView;
	DWORD		m_dwTime;

// Operations
public:
	void		InsertOneData(double dData);
	void		InsertData(int iNo);
	void		AddDataFromText(DWORD dwSize, char *pHeader);
	void		GenerateData();
	void		AnalysisData();
	void		AnalysisWholeData();
	void		SetLeftView( CLeftView *pView );
	void		SetRightView( CFoulerView *pView );
	void		ClearData();
	void		ChangeViewMode(int iViewMode);
	void		OnTimer();
	int			GetItemNo(char *pHeader);
	BOOL		OpenXLS(CString sFile);
	BOOL		SaveCCA(HANDLE hFileWrite);
	BOOL		SaveTXT(HANDLE hFileWrite);
	BOOL		OpenCCA(HANDLE hFileRead);
	BOOL		OpenTXT(HANDLE hFileRead);

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CFoulerDoc)
	public:
	virtual BOOL OnNewDocument();
	//}}AFX_VIRTUAL

// Implementation
public:
	virtual ~CFoulerDoc();
#ifdef _DEBUG
	virtual void AssertValid() const;
	virtual void Dump(CDumpContext& dc) const;
#endif

protected:

// Generated message map functions
protected:
	//{{AFX_MSG(CFoulerDoc)
	afx_msg void OnEditNewdata();
	afx_msg void OnEditPause();
	afx_msg void OnEditPlay();
	afx_msg void OnUpdateEditPause(CCmdUI* pCmdUI);
	afx_msg void OnUpdateEditPlay(CCmdUI* pCmdUI);
	afx_msg void OnViewCusum();
	afx_msg void OnViewHistogram();
	afx_msg void OnViewShewart();
	afx_msg void OnViewSprt();
	afx_msg void OnFileOpen();
	afx_msg void OnFileSaveAs();
	afx_msg void OnFileSave();
	afx_msg void OnUpdateFileSave(CCmdUI* pCmdUI);
	afx_msg void OnEditClearAll();
	afx_msg void OnEditAnalysis();
	afx_msg void OnUpdateFileSaveAs(CCmdUI* pCmdUI);
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_FOULERDOC_H__91050774_5071_430F_ACB9_B31F83431F92__INCLUDED_)
