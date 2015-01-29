// Data.h: interface for the CData class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_DATA_H__88DA6ED0_B6E4_4AD8_93CE_D26BFA7B7F7D__INCLUDED_)
#define AFX_DATA_H__88DA6ED0_B6E4_4AD8_93CE_D26BFA7B7F7D__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

class CData  
{
public:
	CData();
	virtual ~CData();
	double	GetItem();
	double	GetPlus();
	double	GetMinus();
	void	SetItem( double dData );
	void	SetPlus( double dPlus );
	void	SetMinus( double dMinus );
protected:
	double	m_dData;//실제 데이터
	double	m_dPlus;//Plus값
	double	m_dMinus;//Minus값
};

#endif // !defined(AFX_DATA_H__88DA6ED0_B6E4_4AD8_93CE_D26BFA7B7F7D__INCLUDED_)
