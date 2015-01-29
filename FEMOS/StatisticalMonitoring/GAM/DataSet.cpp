// DataSet.cpp: implementation of the CDataSet class.
//
//////////////////////////////////////////////////////////////////////

#include "stdafx.h"
#include "GAM.h"
#include "DataSet.h"

#ifdef _DEBUG
#undef THIS_FILE
static char THIS_FILE[]=__FILE__;
#define new DEBUG_NEW
#endif

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

CDataSet::CDataSet()
{
	m_fValue = 0.0f;
	m_fPoint = 0.0f;
}

CDataSet::~CDataSet()
{

}
