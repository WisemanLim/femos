// Data.cpp: implementation of the CData class.
//
//////////////////////////////////////////////////////////////////////

#include "stdafx.h"
#include "Fouler.h"
#include "Data.h"

#ifdef _DEBUG
#undef THIS_FILE
static char THIS_FILE[]=__FILE__;
#define new DEBUG_NEW
#endif

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

CData::CData()
{
}

CData::~CData()
{
}

double CData::GetItem()
{
	return m_dData;
}

double CData::GetPlus()
{
	return m_dPlus;
}

double CData::GetMinus()
{
	return m_dMinus;
}

void CData::SetItem( double dData )
{
	m_dData = dData;
}

void CData::SetPlus( double dPlus )
{
	m_dPlus = dPlus;
}

void CData::SetMinus( double dMinus )
{
	m_dMinus = dMinus;
}
