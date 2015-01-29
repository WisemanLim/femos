// Link.cpp: implementation of the CLink class.
//
//////////////////////////////////////////////////////////////////////

#include "stdafx.h"
#include "GAM.h"
#include "Link.h"

#ifdef _DEBUG
#undef THIS_FILE
static char THIS_FILE[]=__FILE__;
#define new DEBUG_NEW
#endif

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

CLink::CLink(int iParent, int iChild)
{
	m_iParent = iParent;
	m_iChild = iChild;
	m_fWeight = -1;
	m_bSelected = FALSE;
}

CLink::~CLink()
{

}

