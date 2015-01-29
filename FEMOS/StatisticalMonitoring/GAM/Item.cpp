// Item.cpp: implementation of the CItem class.
//
//////////////////////////////////////////////////////////////////////

#include "stdafx.h"
#include "GAM.h"
#include "Item.h"

#ifdef _DEBUG
#undef THIS_FILE
static char THIS_FILE[]=__FILE__;
#define new DEBUG_NEW
#endif

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

CItem::CItem()
{
	m_iLevel = -1;
	m_iValueType = 0;
	ZeroMemory( m_cLabel, sizeof(m_cLabel) );
	m_bSelected = FALSE;
	SetRect( &m_rt, 0, 0, 0, 0 );
}

CItem::~CItem()
{

}
