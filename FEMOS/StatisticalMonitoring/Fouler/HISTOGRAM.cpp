// HISTOGRAM.cpp: implementation of the CHISTOGRAM class.
//
//////////////////////////////////////////////////////////////////////

#include "stdafx.h"
#include "Fouler.h"
#include "HISTOGRAM.h"

#ifdef _DEBUG
#undef THIS_FILE
static char THIS_FILE[]=__FILE__;
#define new DEBUG_NEW
#endif

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

CHISTOGRAM::CHISTOGRAM()
{
	m_bReady = FALSE;
	m_dTheta0 = 0;
	m_dDeviation = 0;
}

CHISTOGRAM::~CHISTOGRAM()
{

}

BOOL CHISTOGRAM::GetReady()
{
	return m_bReady;
}

double CHISTOGRAM::GetTheta0()
{
	return m_dTheta0;
}

double CHISTOGRAM::GetDeviation()
{
	return m_dDeviation;
}

void CHISTOGRAM::SetReady( BOOL bReady )
{
	m_bReady = bReady;
}

void CHISTOGRAM::SetTheta0( double dTheta0 )
{
	m_dTheta0 = dTheta0;
}

void CHISTOGRAM::SetDeviation( double dDeviation )
{
	m_dDeviation = dDeviation;
}