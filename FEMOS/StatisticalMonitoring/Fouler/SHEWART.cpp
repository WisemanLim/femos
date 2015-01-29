// SHEWART.cpp: implementation of the CSHEWART class.
//
//////////////////////////////////////////////////////////////////////

#include "stdafx.h"
#include "Fouler.h"
#include "SHEWART.h"

#ifdef _DEBUG
#undef THIS_FILE
static char THIS_FILE[]=__FILE__;
#define new DEBUG_NEW
#endif

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

CSHEWART::CSHEWART()
{
	m_bReady = FALSE;
	m_dTheta0 = 0;
	m_dDeviation = 0;
}

CSHEWART::~CSHEWART()
{

}

BOOL CSHEWART::GetReady()
{
	return m_bReady;
}

double CSHEWART::GetTheta0()
{
	return m_dTheta0;
}

double CSHEWART::GetDeviation()
{
	return m_dDeviation;
}

void CSHEWART::SetReady( BOOL bReady )
{
	m_bReady = bReady;
}

void CSHEWART::SetTheta0( double dTheta0 )
{
	m_dTheta0 = dTheta0;
}

void CSHEWART::SetDeviation( double dDeviation )
{
	m_dDeviation = dDeviation;
}