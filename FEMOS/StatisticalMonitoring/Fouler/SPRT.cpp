// SPRT.cpp: implementation of the CSPRT class.
//
//////////////////////////////////////////////////////////////////////

#include "stdafx.h"
#include "Fouler.h"
#include "SPRT.h"

#ifdef _DEBUG
#undef THIS_FILE
static char THIS_FILE[]=__FILE__;
#define new DEBUG_NEW
#endif

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

CSPRT::CSPRT()
{
	m_bReady = FALSE;
	m_dTheta0 = 0;
	m_dTheta1 = 0;
	m_dDeviation = 0;
	m_dAlpha = 0;
	m_dBeta = 0;
}

CSPRT::~CSPRT()
{

}

BOOL CSPRT::GetReady()
{
	return m_bReady;
}

double CSPRT::GetTheta0()
{
	return m_dTheta0;
}

double CSPRT::GetTheta1()
{
	return m_dTheta1;
}

double CSPRT::GetDeviation()
{
	return m_dDeviation;
}

double CSPRT::GetAlpha()
{
	return m_dAlpha;
}

double CSPRT::GetBeta()
{
	return m_dBeta;
}

void CSPRT::SetReady( BOOL bReady )
{
	m_bReady = bReady;
}

void CSPRT::SetTheta0( double dTheta0 )
{
	m_dTheta0 = dTheta0;
}

void CSPRT::SetTheta1( double dTheta1 )
{
	m_dTheta1 = dTheta1;
}

void CSPRT::SetDeviation( double dDeviation )
{
	m_dDeviation = dDeviation;
}

void CSPRT::SetAlpha( double dAlpha )
{
	m_dAlpha = dAlpha;
}

void CSPRT::SetBeta( double dBeta )
{
	m_dBeta = dBeta;
}
