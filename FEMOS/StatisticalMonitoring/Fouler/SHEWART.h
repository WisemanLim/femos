// SHEWART.h: interface for the CSHEWART class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_SHEWART_H__AB1223DE_1778_470F_84C9_B8402E78A61F__INCLUDED_)
#define AFX_SHEWART_H__AB1223DE_1778_470F_84C9_B8402E78A61F__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

class CSHEWART  
{
public:
	CSHEWART();
	virtual ~CSHEWART();
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

#endif // !defined(AFX_SHEWART_H__AB1223DE_1778_470F_84C9_B8402E78A61F__INCLUDED_)
