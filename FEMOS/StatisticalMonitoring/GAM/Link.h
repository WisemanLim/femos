// Link.h: interface for the CLink class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_LINK_H__B3D15E76_9CFD_4C2D_B5BD_D1D96556A275__INCLUDED_)
#define AFX_LINK_H__B3D15E76_9CFD_4C2D_B5BD_D1D96556A275__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

class CLink
{
public:
	CLink(int iParent, int iChild);
	virtual ~CLink();
	int		m_iParent;
	int		m_iChild;
	float	m_fWeight;
	POINT	m_ptParent;
	POINT	m_ptChild;
	BOOL	m_bSelected;
};

#endif // !defined(AFX_LINK_H__B3D15E76_9CFD_4C2D_B5BD_D1D96556A275__INCLUDED_)
