// GAM.h : main header file for the GAM application
//

#if !defined(AFX_GAM_H__9971D460_2995_452A_B02C_EA7D476F32EE__INCLUDED_)
#define AFX_GAM_H__9971D460_2995_452A_B02C_EA7D476F32EE__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#ifndef __AFXWIN_H__
	#error include 'stdafx.h' before including this file for PCH
#endif

#include "resource.h"       // main symbols
#ifndef _DEBUG
#include "Splash.h"
#endif

/////////////////////////////////////////////////////////////////////////////
// CGAMApp:
// See GAM.cpp for the implementation of this class
//

class CGAMApp : public CWinApp
{
public:
	CGAMApp();

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CGAMApp)
	public:
	virtual BOOL InitInstance();
	//}}AFX_VIRTUAL

// Implementation
	//{{AFX_MSG(CGAMApp)
	afx_msg void OnAppAbout();
		// NOTE - the ClassWizard will add and remove member functions here.
		//    DO NOT EDIT what you see in these blocks of generated code !
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};


/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_GAM_H__9971D460_2995_452A_B02C_EA7D476F32EE__INCLUDED_)
