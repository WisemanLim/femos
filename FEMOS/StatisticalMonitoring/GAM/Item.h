// Item.h: interface for the CItem class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_ITEM_H__9CE8A721_7108_4FA0_95B8_87D780D3629A__INCLUDED_)
#define AFX_ITEM_H__9CE8A721_7108_4FA0_95B8_87D780D3629A__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

class CItem
{
public:
	CItem();
	virtual ~CItem();
	int		m_iValueType;
	int		m_iLevel;
	char	m_cLabel[32];
	BOOL	m_bSelected;
	RECT	m_rt;
};

#endif // !defined(AFX_ITEM_H__9CE8A721_7108_4FA0_95B8_87D780D3629A__INCLUDED_)
