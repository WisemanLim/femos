// SPRT.h: interface for the CSPRT class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_SPRT_H__DC519639_BE77_4658_81E0_9D531A8EC60A__INCLUDED_)
#define AFX_SPRT_H__DC519639_BE77_4658_81E0_9D531A8EC60A__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

class CSPRT  
{
public:
	CSPRT();
	virtual ~CSPRT();
	BOOL	GetReady();
	double	GetTheta0();
	double	GetTheta1();
	double	GetDeviation();
	double	GetAlpha();
	double	GetBeta();
	void	SetReady( BOOL bReady );
	void	SetTheta0( double dTheta0 );
	void	SetTheta1( double dTheta1 );
	void	SetDeviation( double dDeviation );
	void	SetAlpha( double dAlpha );
	void	SetBeta( double dBeta );
private:
	BOOL	m_bReady;
	double	m_dTheta0;
	double	m_dTheta1;
	double	m_dDeviation;
	double	m_dAlpha;
	double	m_dBeta;
};

#endif // !defined(AFX_SPRT_H__DC519639_BE77_4658_81E0_9D531A8EC60A__INCLUDED_)
