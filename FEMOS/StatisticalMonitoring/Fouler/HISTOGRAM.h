// HISTOGRAM.h: interface for the CHISTOGRAM class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_HISTOGRAM_H__6233E941_8F85_46DA_9951_9C783C837C0E__INCLUDED_)
#define AFX_HISTOGRAM_H__6233E941_8F85_46DA_9951_9C783C837C0E__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

class CHISTOGRAM  
{
public:
	CHISTOGRAM();
	virtual ~CHISTOGRAM();
	BOOL	GetReady();
	double	GetTheta0();
	double	GetDeviation();
	void	SetReady( BOOL bReady );
	void	SetTheta0( double dTheta0 );
	void	SetDeviation( double dDeviation );
private:
	BOOL	m_bReady;
	double	m_dTheta0;
	double	m_dDeviation;
};

#endif // !defined(AFX_HISTOGRAM_H__6233E941_8F85_46DA_9951_9C783C837C0E__INCLUDED_)
