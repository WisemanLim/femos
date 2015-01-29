// stdafx.h : include file for standard system include files,
//  or project specific include files that are used frequently, but
//      are changed infrequently
//

#if !defined(AFX_STDAFX_H__7FC89582_024B_468D_96E2_0D541C7D42E9__INCLUDED_)
#define AFX_STDAFX_H__7FC89582_024B_468D_96E2_0D541C7D42E9__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#define VC_EXTRALEAN		// Exclude rarely-used stuff from Windows headers
#define	DEF_MAX_DATASIZE			1000000
#define DEF_HISTOGRAM_SIZE			150
#define glRGB(x, y, z)				glColor3ub((GLubyte)x, (GLubyte)y, (GLubyte)z)
#define	X_RANGE_MAX					10000.0f		// X축:0에서 X_RANGE_MAX사이 범위
#define	Y_RANGE_MAX					10000.0f	// Y축:0에서 T_RANGE_MAX사이 범위

#define DEF_HISTOGRAM				0
#define DEF_SHEWART					1
#define DEF_CUSUM					2
#define DEF_SPRT					3

#define	DEF_NORMAL_DISTRIBUTION		0
#define	DEF_UNIFORM_DISTRIBUTION	1
#define	DEF_POISSON_DISTRIBUTION	2

#define DEF_MAX_SLIDER_POS			15
#define	DEF_MAX_SIZE				1000000

#include <math.h>
#include <afxwin.h>         // MFC core and standard components
#include <afxext.h>         // MFC extensions
#include <afxcview.h>
#include <afxdisp.h>        // MFC Automation classes
#include <afxdtctl.h>		// MFC support for Internet Explorer 4 Common Controls
#include "odbcinst.h"
#include "afxtempl.h"
#include "gl\gl.h"
#include "gl\glu.h"
#ifndef _AFX_NO_AFXCMN_SUPPORT
#include <afxcmn.h>			// MFC support for Windows Common Controls
#endif // _AFX_NO_AFXCMN_SUPPORT

#include <afxdb.h>         // MFC ODBC database classes
#include <mmsystem.h>

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_STDAFX_H__7FC89582_024B_468D_96E2_0D541C7D42E9__INCLUDED_)
