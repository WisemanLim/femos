// Alter.cpp: implementation of the CAlter class.
//
//////////////////////////////////////////////////////////////////////

#include "stdafx.h"
#include "GAM.h"
#include "Alter.h"

#ifdef _DEBUG
#undef THIS_FILE
static char THIS_FILE[]=__FILE__;
#define new DEBUG_NEW
#endif

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

CAlter::CAlter()
{
	ZeroMemory( cStrAlter, sizeof(cStrAlter) );
	for( int i=0 ; i<DEF_MAXITEM ; i++ )
	{
		m_pDataSet[i] = NULL;
	}
}

CAlter::~CAlter()
{
	for( int i=0 ; i<DEF_MAXITEM ; i++ )
	{
		if( m_pDataSet[i] != NULL ) delete m_pDataSet[i];
	}
}

void CAlter::RemoveData(int iIndex)
{
	int i, iCount;
	iCount = 0;
	if( m_pDataSet[iIndex] == NULL ) return;
	for( i=0 ; i<DEF_MAXITEM ; i++ )
	{
		if( m_pDataSet[i] != NULL ) iCount++;
	}
	if( iIndex >= iCount ) return;
	delete m_pDataSet[iIndex];
	for( i=iIndex ; i<DEF_MAXITEM ; i++ )
	{
		m_pDataSet[i] = m_pDataSet[i+1];
		if( m_pDataSet[i] == NULL ) break;
	}
}

void CAlter::AddValue(int iIndex, float fValue)
{
	if( iIndex < 0 )
	{
		for( int i=0 ; i<DEF_MAXITEM ; i++ )
		{
			if( m_pDataSet[i] == NULL )
			{
				m_pDataSet[i] = new CDataSet;
				m_pDataSet[i]->m_fValue = fValue;
				return;
			}
		}
	}
	else
	{
		if( m_pDataSet[iIndex] != NULL ) return;
		m_pDataSet[iIndex] = new CDataSet;
		m_pDataSet[iIndex]->m_fValue = fValue;
	}
}