// CUSUM.h: interface for the CCUSUM class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_CUSUM_H__8F0102C3_2552_41FD_BF29_95C11C10EFAB__INCLUDED_)
#define AFX_CUSUM_H__8F0102C3_2552_41FD_BF29_95C11C10EFAB__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

class CCUSUM
{
public:
	CCUSUM();
	virtual ~CCUSUM();
	BOOL	GetReady();
	double	GetTheta0();
	double	GetDeviation();
	double	GetK();
	double	GetH();
	void	SetReady( BOOL bReady );
	void	SetTheta0( double dTheta0 );
	void	SetDeviation( double dDeviation );
	void	SetK( double dK );
	void	SetH( double dH );
private:
	BOOL	m_bReady;
	double	m_dTheta0;
	double	m_dDeviation;
	double	m_dK;
	double	m_dH;
};

#endif // !defined(AFX_CUSUM_H__8F0102C3_2552_41FD_BF29_95C11C10EFAB__INCLUDED_)
