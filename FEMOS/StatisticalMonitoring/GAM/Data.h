// Data.h: interface for the CData class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_DATA_H__AADDB4DE_1BB2_45EE_9821_AA1C35AE3768__INCLUDED_)
#define AFX_DATA_H__AADDB4DE_1BB2_45EE_9821_AA1C35AE3768__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#include "item.h"
#include "Link.h"
#include "Alter.h"

typedef struct tagFPOINT
{
    float  x;
    float  y;
} FPOINT;

class CData  
{
public:
// Operations
	CData();
	virtual ~CData();
	void	Initialize();
	void	AddChild(int iParent);
	void	AddLink(int iIndex1, int iIndex2);
	void	InsertLink(int iParent, int iChild);
	void	RemoveItem(int iIndex);
	void	RemoveLink(int iIndex);
	void	Calculate();
	void	Calculate(int iIndex);
	int		GetTotalItem();
	int		GetTotalLink();
	int		GetInsertIndex(int iParent);
	int		GetLargestParentIndex(int iIndex);
	int		GetChildNo(int iParent);
	BOOL	OpenData(FILE *fp);
	BOOL	SaveData(FILE *fp);
	BOOL	CanAddChild(int iParent);
	BOOL	IsLinkable(int iIndex1, int iIndex2);
	BOOL	IsRemovable(int iIndex);
	BOOL	MakeItem(char *cStr);
	BOOL	InsertAlter(int iIndex);
	BOOL	DeleteAlter(int iIndex);
	BOOL	CanCalculate();
	BOOL	SetCurAlter(int iIndex);
	CItem*	GetItem(int iIndex);
	CLink*	GetLink(int iIndex);
	CAlter*	GetAlter(int iIndex);
	CAlter*	GetCurAlter();

// Attributes
	int		m_iItemNo;
	int		m_iLinkNo;
	int		m_iNoAlter;
	int		m_iCurAlter;
	BOOL	m_bCalculated;
private:
	CItem	*m_pItem[DEF_MAXITEM];
	CLink	*m_pLink[DEF_MAXLINK];
	CAlter	*m_pAlter[DEF_MAXALTER];
};

#endif // !defined(AFX_DATA_H__AADDB4DE_1BB2_45EE_9821_AA1C35AE3768__INCLUDED_)
