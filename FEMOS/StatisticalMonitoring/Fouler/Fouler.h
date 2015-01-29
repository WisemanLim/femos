// Fouler.h : main header file for the FOULER application
//

#if !defined(AFX_FOULER_H__1B59D6A3_3FDF_4600_91EB_75890DD19C03__INCLUDED_)
#define AFX_FOULER_H__1B59D6A3_3FDF_4600_91EB_75890DD19C03__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#ifndef __AFXWIN_H__
	#error include 'stdafx.h' before including this file for PCH
#endif

#include "resource.h"       // main symbols
#include "Splash.h"

/////////////////////////////////////////////////////////////////////////////
// CFoulerApp:
// See Fouler.cpp for the implementation of this class
//

class CFoulerApp : public CWinApp
{
public:
	CFoulerApp();

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CFoulerApp)
	public:
	virtual BOOL InitInstance();
	//}}AFX_VIRTUAL

// Implementation
	//{{AFX_MSG(CFoulerApp)
	afx_msg void OnAppAbout();
		// NOTE - the ClassWizard will add and remove member functions here.
		//    DO NOT EDIT what you see in these blocks of generated code !
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};


/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_FOULER_H__1B59D6A3_3FDF_4600_91EB_75890DD19C03__INCLUDED_)
