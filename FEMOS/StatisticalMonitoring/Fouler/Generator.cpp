// Generator.cpp: implementation of the CGenerator class.
//
//////////////////////////////////////////////////////////////////////

#include "stdafx.h"
#include "Fouler.h"
#include "Generator.h"

#ifdef _DEBUG
#undef THIS_FILE
static char THIS_FILE[]=__FILE__;
#define new DEBUG_NEW
#endif

#define	IA		16807
#define	IM		2147483647
#define	AM		(1.0/IM)
#define	IQ		127773
#define	IR		2836
#define	NTAB	32
#define	NDIV	(1+(IM-1)/NTAB)
#define	EPS		1.2e-7
#define	RNMX	(1.0-EPS)

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

CGenerator::CGenerator()
{
	m_bReady = FALSE;
	m_iGenMode = DEF_NORMAL_DISTRIBUTION;
	m_dAverage = 0;
	m_dDeviation = 0;
	m_dMoveRate = 0;
	idum = - rand();
}

CGenerator::~CGenerator()
{

}

double CGenerator::Gen()
{
	m_dAverage += m_dMoveRate;
	switch( m_iGenMode )
	{
	case DEF_UNIFORM_DISTRIBUTION:
		return uniform();
		break;
	case DEF_POISSON_DISTRIBUTION:
		return poisson();
		break;
	case DEF_NORMAL_DISTRIBUTION:
	default:
		return normal();
		break;
	}
}

double CGenerator::normal()
{
	return m_dAverage + sqrt( -2.0*log(1.0 - ran(&idum)) )*cos(6.2831853071795864 * ran(&idum) )*m_dDeviation;
}

double CGenerator::ran(long *idum)
{
	int j;
	long k;
	static long iy = 0;
	static long iv[NTAB];
	double temp;
	
	if( *idum <=0 || !iy )
	{
		if( -(*idum) < 1 ) *idum = 1;
		else *idum = -(*idum);
		for( j=NTAB+7 ; j>=0 ; j-- )
		{
			k = (*idum)/IQ;
			*idum = IA*(*idum - k*IQ)-IR*k;
			if( *idum < 0 ) *idum += IM;
			if( j < NTAB ) iv[j] = *idum;
		}
		iy = iv[0];
	}
	k = (*idum)/IQ;
	*idum = IA*(*idum - k*IQ) - IR*k;
	if( *idum < 0 ) *idum += IM;
	j = iy/NDIV;
	iy = iv[j];
	iv[j] = *idum;
	if( (temp=AM*iy) > RNMX ) return RNMX;
	else return temp;
}

double CGenerator::uniform()
{
	return m_dAverage + m_dDeviation*3.4641016151377544*(ran( &idum )-0.5);
//	double a = (double)(rand())/RAND_MAX - 0.5;
//	return m_dAverage + a*m_dDeviation*3.4641016151377544;//2*root3
}

double CGenerator::poisson()
{
	double p = 1 - m_dDeviation*m_dDeviation/m_dAverage;
	int n = (int)(m_dAverage/p);
	double iCount=0;
	for( int i=0 ; i < n ; i++ )
	{
		if( (double)(rand())/32768 < p ) iCount++;
	}
	return iCount;
}

BOOL CGenerator::GetReady()
{
	return m_bReady;
}

int CGenerator::GetGenMode()
{
	return m_iGenMode;
}

double CGenerator::GetAverage()
{
	return m_dAverage;
}

double CGenerator::GetDeviation()
{
	return m_dDeviation;
}

double CGenerator::GetMoveRate()
{
	return m_dMoveRate;
}

void CGenerator::SetReady(BOOL bReady)
{
	m_bReady = bReady;
}

void CGenerator::SetGenMode(int iGenMode)
{
	m_iGenMode = iGenMode;
}

void CGenerator::SetAverage(double dAverage)
{
	m_dAverage = dAverage;
}

void CGenerator::SetDeviation(double dDeviation)
{
	m_dDeviation = dDeviation;
}

void CGenerator::SetMoveRate(double dMoveRate)
{
	m_dMoveRate = dMoveRate;
}
