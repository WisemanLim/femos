// CUSUM.cpp: implementation of the CCUSUM class.
//
//////////////////////////////////////////////////////////////////////

#include "stdafx.h"
#include "Fouler.h"
#include "CUSUM.h"

#ifdef _DEBUG
#undef THIS_FILE
static char THIS_FILE[]=__FILE__;
#define new DEBUG_NEW
#endif

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

CCUSUM::CCUSUM()
{
	m_bReady = FALSE;
	m_dTheta0 = 0;
	m_dDeviation = 0;
	m_dK = 0;
	m_dH = 0;
}

CCUSUM::~CCUSUM()
{
}

BOOL CCUSUM::GetReady()
{
	return m_bReady;
}

double CCUSUM::GetTheta0()
{
	return m_dTheta0;
}

double CCUSUM::GetDeviation()
{
	return m_dDeviation;
}

double CCUSUM::GetK()
{
	return m_dK;
}

double CCUSUM::GetH()
{
	return m_dH;
}

void CCUSUM::SetReady( BOOL bReady )
{
	m_bReady = bReady;
}

void CCUSUM::SetTheta0( double dTheta0 )
{
	m_dTheta0 = dTheta0;
}

void CCUSUM::SetDeviation( double dDeviation )
{
	m_dDeviation = dDeviation;
}

void CCUSUM::SetK( double dK )
{
	m_dK = dK;
}

void CCUSUM::SetH( double dH )
{
	m_dH = dH;
}
