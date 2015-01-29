// Alter.h: interface for the CAlter class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_ALTER_H__1469E906_6E3F_489F_9BE4_9A0390B56414__INCLUDED_)
#define AFX_ALTER_H__1469E906_6E3F_489F_9BE4_9A0390B56414__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#include "DataSet.h"

class CAlter  
{
public:
	CAlter();
	virtual ~CAlter();
	void		AddValue(int iIndex = -1, float fValue = 0 );
	void		RemoveData(int iIndex);
	char		cStrAlter[32];
	CDataSet	*m_pDataSet[DEF_MAXITEM];
//	float	*m_fpItemValue[DEF_MAXITEM];
};

#endif // !defined(AFX_ALTER_H__1469E906_6E3F_489F_9BE4_9A0390B56414__INCLUDED_)
