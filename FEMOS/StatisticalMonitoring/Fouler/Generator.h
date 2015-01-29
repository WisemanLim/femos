// Generator.h: interface for the CGenerator class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_GENERATOR_H__048EE42C_B346_4348_8E95_93BCD88C0B3A__INCLUDED_)
#define AFX_GENERATOR_H__048EE42C_B346_4348_8E95_93BCD88C0B3A__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

class CGenerator  
{
public:
	CGenerator();
	virtual ~CGenerator();
	double	Gen();
	double	normal();
	double	poisson();
	double	uniform();
	double	ran(long *idum);
	long	idum;

	BOOL	GetReady();
	int		GetGenMode();
	double	GetAverage();
	double	GetDeviation();
	double	GetMoveRate();
	void	SetReady(BOOL bReady);
	void	SetGenMode(int iGenMode);
	void	SetAverage(double dAverage);
	void	SetDeviation(double dDeviation);
	void	SetMoveRate(double dMoveRate);
private:
	BOOL	m_bReady;
	int		m_iGenMode;
	double	m_dAverage;
	double	m_dDeviation;
	double	m_dMoveRate;
};

#endif // !defined(AFX_GENERATOR_H__048EE42C_B346_4348_8E95_93BCD88C0B3A__INCLUDED_)
