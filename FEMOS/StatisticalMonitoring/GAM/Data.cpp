/////////////////////////////////////////////////////////////////////////////
// Data.cpp: implementation of the CData class.
//
//////////////////////////////////////////////////////////////////////

#include "stdafx.h"
#include "GAM.h"
#include "Data.h"

#ifdef _DEBUG
#undef THIS_FILE
static char THIS_FILE[]=__FILE__;
#define new DEBUG_NEW
#endif

/////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////
//
// ItemList, LinkList, Gmain 클래스의 각종 연산함수 및 UI와의 연계 함수 개발
//
// Project Name		: 발전원별 종합 위험도 평가를 위한 통합 인터페이스 개발
// Project Range	: 2005.04 ~ 2007.04
// Project Executor	: Sung-Jin Lee, Sang-Ha An
// Last Modified	: 2006.01.25
//
/////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

CData::CData()
{
	int i;
	m_iItemNo = 0;
	m_iLinkNo = 0;
	m_iNoAlter = 0;
	m_iCurAlter = -1;
	m_bCalculated = FALSE;
	for( i=0 ; i<DEF_MAXITEM ; i++ )
	{
		m_pItem[i] = NULL;
	}
	for( i=0 ; i<DEF_MAXLINK ; i++ )
	{
		m_pLink[i] = NULL;
	}
	for( i=0 ; i<DEF_MAXALTER ; i++ )
	{
		m_pAlter[i] = NULL;
	}
}

CData::~CData()
{
	int i;
	for( i=0 ; i<DEF_MAXITEM ; i++ )
	{
		if( m_pItem[i] != NULL) delete m_pItem[i];
	}
	for( i=0 ; i<DEF_MAXLINK ; i++ )
	{
		if( m_pLink[i] != NULL) delete m_pLink[i];
	}
	for( i=0 ; i<DEF_MAXALTER ; i++ )
	{
		if( m_pAlter[i] != NULL ) delete m_pAlter[i];
	}
}

void CData::Initialize()
{
	m_pItem[0] = new CItem;
	strcpy( m_pItem[0]->m_cLabel, "Total" );
	m_pItem[0]->m_iLevel = 0;
	m_iItemNo = 1;
	m_pAlter[0] = new CAlter;
	strcpy( m_pAlter[0]->cStrAlter, "New Alternative" );
	m_iNoAlter = 1;
	m_iCurAlter = 0;
	m_pAlter[0]->AddValue();
}

int CData::GetTotalItem()
{
	int i;
	m_iItemNo = 0;
	for( i=0 ; i<DEF_MAXITEM; i++ )
	{
		if( m_pItem[i] != NULL ) m_iItemNo ++;
		else break;
	}
	return m_iItemNo;
}

int CData::GetTotalLink()
{
	int i;
	m_iLinkNo = 0;
	for( i=0 ; i<DEF_MAXLINK; i++ )
	{
		if( m_pLink[i] != NULL ) m_iLinkNo ++;
		else break;
	}
	return m_iLinkNo;
}

void CData::AddChild(int iParent)
{
	int i, j, iNewIndex;
	CAlter *pAlter;
	if( iParent < 0 ) return;
	if( m_pItem[iParent] == NULL ) return;
	iNewIndex = GetInsertIndex( iParent );
	for( i=DEF_MAXITEM-2 ; i>=iNewIndex ; i-- )
	{
		m_pItem[i+1] = m_pItem[i];
	}
	m_pItem[iNewIndex] = new CItem;
	m_iItemNo++;
	m_pItem[iNewIndex]->m_iLevel = m_pItem[iParent]->m_iLevel+1;
	m_pItem[iNewIndex]->m_cLabel[0] = 'A'+iNewIndex;
	for( j=0 ; j<m_iNoAlter ; j++ )
	{
		pAlter = m_pAlter[j];
		if( pAlter != NULL )
		{
			for( i=DEF_MAXITEM-2 ; i>=iNewIndex ; i-- )
			{
				pAlter->m_pDataSet[i+1] = pAlter->m_pDataSet[i];
			}
			pAlter->m_pDataSet[iNewIndex] = NULL;
			pAlter->AddValue(iNewIndex);
		}
	}

	for( i=0 ; i<DEF_MAXLINK ; i++ )
	{
		if( m_pLink[i] == NULL ) break;
		if( m_pLink[i]->m_iParent >= iNewIndex ) m_pLink[i]->m_iParent++;
		if( m_pLink[i]->m_iChild >= iNewIndex ) m_pLink[i]->m_iChild++;
	}
	InsertLink(iParent, iNewIndex);
}

BOOL CData::CanAddChild(int iParent)
{
	if( m_iItemNo >= DEF_MAXITEM ) return FALSE;
	if( m_iLinkNo >= DEF_MAXLINK ) return FALSE;
	if( iParent < 0 ) return FALSE;
	if( iParent >= m_iItemNo ) return FALSE;
	if( m_pItem[iParent] == NULL ) return FALSE;
	return TRUE;
}

void CData::AddLink(int iIndex1, int iIndex2)
{
	int iParent, iChild;
	if( iIndex1 < 0 || iIndex2 < 0 ) return;
	if( m_pItem[iIndex1]->m_iLevel > m_pItem[iIndex2]->m_iLevel )
	{
		iParent = iIndex2;
		iChild = iIndex1;
	}
	else
	{
		iParent = iIndex1;
		iChild = iIndex2;
	}
	if( m_pItem[iChild]->m_iLevel - m_pItem[iParent]->m_iLevel != 1 ) return;
	InsertLink( iParent, iChild );
}

BOOL CData::IsLinkable(int iIndex1, int iIndex2)
{
	int i, iParent, iChild;
	if( iIndex1 < 0 || iIndex2 < 0 ) return FALSE;
	if( m_pItem[iIndex1] == NULL ) return FALSE;
	if( m_pItem[iIndex2] == NULL ) return FALSE;
	if( m_pItem[iIndex1]->m_iLevel > m_pItem[iIndex2]->m_iLevel )
	{
		iParent = iIndex2;
		iChild = iIndex1;
	}
	else
	{
		iParent = iIndex1;
		iChild = iIndex2;
	}
	if( m_pItem[iChild]->m_iLevel - m_pItem[iParent]->m_iLevel != 1 ) return FALSE;
	for( i=0 ; i < DEF_MAXLINK ; i++ )
	{
		if( m_pLink[i] == NULL ) return TRUE;
		if( m_pLink[i]->m_iParent == iParent && m_pLink[i]->m_iChild == iChild ) return FALSE;
	}
	return FALSE;
}

BOOL CData::IsRemovable(int iIndex)
{
	int i;
	if( iIndex < 0 ) return FALSE;
	if( m_iItemNo < 2 ) return FALSE;
	if( iIndex >= m_iItemNo ) return FALSE;
	for( i=0 ; i < DEF_MAXLINK ; i++ )
	{
		if( m_pLink[i] == NULL ) return TRUE;
		if( m_pLink[i]->m_iParent == iIndex ) return FALSE;
	}
	return TRUE;
}

int CData::GetInsertIndex(int iParent)
{
	int i;
	for( i=iParent+1 ; i<DEF_MAXITEM ; i++ )
	{
		if( m_pItem[i] == NULL ) return i;
		if( m_pItem[i]->m_iLevel <= m_pItem[iParent]->m_iLevel ) continue;
		if( GetLargestParentIndex(i) <= iParent ) continue;
		return i;
	}
	return -1;
}

int CData::GetLargestParentIndex(int iIndex)
{
	int i;
	int iLargest = -1;
	for( i=0 ; i<DEF_MAXLINK ; i++ )
	{
		if( m_pLink[i] == NULL ) break;
		if( m_pLink[i]->m_iChild == iIndex )
		{
			if( m_pLink[i]->m_iParent > iLargest ) iLargest = m_pLink[i]->m_iParent;
		}
	}
	return iLargest;
}

void CData::InsertLink(int iParent, int iChild)
{
	int i, iNewLinkIndex;
	if( m_pItem[iParent] == NULL ) return;
	if( m_pItem[iChild] == NULL ) return;
	if( m_pItem[iChild]->m_iLevel - m_pItem[iParent]->m_iLevel != 1 ) return;//바로 위아래만 링크 연결됨
	for( i=0 ; i < DEF_MAXLINK ; i++ )
	{
		if( m_pLink[i] == NULL ) break;
		if( m_pLink[i]->m_iParent == iParent && m_pLink[i]->m_iChild == iChild ) return;//중복된 링크가 이미 있으면 그냥 리턴
	}
	for( i=0 ; i < DEF_MAXLINK ; i++ )
	{
		if( m_pLink[i] == NULL )
		{
			iNewLinkIndex = i;
			break;
		}
		if( m_pLink[i]->m_iParent <= iParent ) continue;
		if( m_pLink[i]->m_iChild <= iChild ) continue;
		iNewLinkIndex = i;
		break;
	}
	for( i=DEF_MAXLINK-2 ; i>=iNewLinkIndex ; i-- )
	{
		m_pLink[i+1] = m_pLink[i];
	}
	m_pLink[iNewLinkIndex] = new CLink(iParent, iChild);
	m_iLinkNo++;
}

int CData::GetChildNo(int iParent)
{
	int i, iRet;
	iRet = 0;
	if( iParent < 0 ) return -1;
	if( iParent >= m_iItemNo ) return -1;
	if( m_pItem[iParent] == NULL ) return -1;
	for( i=0 ; i<DEF_MAXLINK ; i++ )
	{
		if( m_pLink[i] == NULL ) break;
		if( m_pLink[i]->m_iParent == iParent ) iRet++;
	}
	return iRet;
}

CItem* CData::GetItem(int iIndex)
{
	if( iIndex < 0 ) return NULL;
	return m_pItem[iIndex];
}

CLink* CData::GetLink(int iIndex)
{
	if( iIndex < 0 ) return NULL;
	return m_pLink[iIndex];
}

CAlter* CData::GetAlter(int iIndex)
{
	if( iIndex < 0 ) return NULL;
	if( iIndex > m_iNoAlter+1 ) return NULL;
	return m_pAlter[iIndex];
}

CAlter* CData::GetCurAlter()
{
	if( m_iCurAlter < 0 ) return NULL;
	if( m_iCurAlter > m_iNoAlter+1 ) return NULL;
	return m_pAlter[m_iCurAlter];
}

BOOL CData::SetCurAlter(int iIndex)
{
	if( iIndex < 0 ) return FALSE;
	if( iIndex >= m_iNoAlter ) return FALSE;
	if( m_pAlter[iIndex] == NULL ) return FALSE;
	m_iCurAlter = iIndex;
	return TRUE;
}

BOOL CData::SaveData(FILE *fp)
{
	int i, j;
	CString str;
	fprintf( fp, "Link" );
	for( i=0 ; i<m_iLinkNo ; i++ )
	{
		if( m_pLink[i] == NULL ) return FALSE;
		str.Format( "%f", m_pLink[i]->m_fWeight );
		str.TrimRight( '0' );
		str.TrimRight( '.' );
		fprintf( fp, "\t%d,%d,%s", m_pLink[i]->m_iParent, m_pLink[i]->m_iChild, str );
	}
	fprintf( fp, "\nType" );
	for( i=0 ; i<m_iItemNo ; i++ )
	{
		if( m_pItem[i] == NULL ) return FALSE;
		fprintf( fp, "\t%d", m_pItem[i]->m_iValueType );
	}
	fprintf( fp, "\nName" );
	for( i=0 ; i<m_iItemNo ; i++ )
	{
		if( m_pItem[i] == NULL ) return FALSE;
		str = m_pItem[i]->m_cLabel;
		str.Replace( ' ', '_' );
		fprintf( fp, "\t%s", str );
	}
	for( j=0 ; j<m_iNoAlter ; j++ )
	{
		if( m_pAlter[j] == NULL ) return FALSE;
		str = m_pAlter[j]->cStrAlter;
		str.Replace( ' ', '_' );
		fprintf( fp, "\n%s", str );
		for( i=0 ; i<m_iItemNo ; i++ )
		{
			if( m_pAlter[j]->m_pDataSet[i] == NULL ) return FALSE;
			str.Format( "%f", m_pAlter[j]->m_pDataSet[i]->m_fValue );
			str.TrimRight( '0' );
			str.TrimRight( '.' );
			fprintf( fp, "\t%s", str );
		}
	}

	return TRUE;
}

BOOL CData::OpenData(FILE *fp)
{
	int i;
	float f;
	char cTemp[64];
	CString str;
	m_pItem[0] = new CItem;
	m_pItem[0]->m_iLevel = 0;
	m_iItemNo = 1;
	m_iNoAlter = 0;
	ZeroMemory( cTemp, sizeof(cTemp) );
	fscanf( fp, "%s", cTemp );
	if( strcmp( cTemp, "Link" ) != 0 ) return FALSE;
	for( i=0 ; i<DEF_MAXLINK ; i++ )
	{
		ZeroMemory( cTemp, sizeof(cTemp) );
		fscanf( fp, "%s", cTemp ) ;
		if( strcmp( cTemp, "Type" ) == 0 ) break;
		if( MakeItem( cTemp ) == FALSE ) return FALSE;
	}
	for( i=0 ; i<m_iItemNo ; i++ )
	{
		if( m_pItem[i] == NULL ) return FALSE;
		ZeroMemory( cTemp, sizeof(cTemp) );
		fscanf( fp, "%s", cTemp );
		if( strcmp( cTemp, "Name" ) == 0 ) return FALSE;
		m_pItem[i]->m_iValueType = atoi(cTemp);
	}
	ZeroMemory( cTemp, sizeof(cTemp) );
	fscanf( fp, "%s", cTemp );
	if( strcmp( cTemp, "Name" ) != 0 ) return FALSE;
	for( i=0 ; i<m_iItemNo ; i++ )
	{
		if( m_pItem[i] == NULL ) return FALSE;
		ZeroMemory( cTemp, sizeof(cTemp) );
		fscanf( fp, "%s", cTemp );
		str = cTemp;
		str.Replace( '_', ' ' );
		strcpy( m_pItem[i]->m_cLabel, str );
	}
	while(1)
	{
		ZeroMemory( cTemp, sizeof(cTemp) );
		if( fscanf( fp, "%s", cTemp ) == EOF ) break;
		m_pAlter[m_iNoAlter] = new CAlter;
		str = cTemp;
		str.Replace( '_', ' ' );
		strcpy( m_pAlter[m_iNoAlter]->cStrAlter, str );
		for( i=0 ; i<m_iItemNo ; i++ )
		{
			if( fscanf( fp, "%f", &f ) == EOF ) return FALSE;
			m_pAlter[m_iNoAlter]->AddValue(i, f);
		}
		m_iNoAlter++;
	}
	if( m_iNoAlter > 0 )
	{
		m_iCurAlter = 0;
		if( m_iNoAlter > 1 ) Calculate();
		return TRUE;
	}
	return FALSE;
}

BOOL CData::MakeItem(char *cStr)
{
	int i, iReadMode;
	int iParent, iChild;
	char *token;
	char seps[] = ",";
	iReadMode = 0;
	token = strtok( (char*)(LPCTSTR)cStr, seps );
	while( token != NULL )
	{
		switch( iReadMode )
		{
		case 0:
			{
				iParent = atoi(token);
				if( m_pItem[iParent] == NULL ) return FALSE;
				iReadMode = 1;
			}
			break;
		case 1:
			{
				iChild = atoi(token);
				if( m_pItem[iChild] == NULL )
				{
					m_pItem[iChild] = new CItem;
					m_pItem[iChild]->m_iLevel = m_pItem[iParent]->m_iLevel +1;
					m_iItemNo++;
				}
				iReadMode = 2;
			}
			break;
		case 2:
			{
				for( i=0 ; i<DEF_MAXLINK ; i++ )
				{
					if( m_pLink[i] == NULL )
					{
						m_pLink[i] = new CLink(iParent, iChild);
						m_pLink[i]->m_fWeight = (float)atof( token );
						m_iLinkNo++;
						return TRUE;
					}
					else
					{
						if( m_pLink[i]->m_iParent == iParent && m_pLink[i]->m_iChild == iChild ) return FALSE;
					}
				}
				return FALSE;
			}
			break;
		default:
			return FALSE;
		}
		token = strtok( NULL, seps );
	}
	return FALSE;
}

void CData::RemoveItem(int iIndex)
{
	int i;
	if( iIndex < 0 ) return;
	if( m_iItemNo < 2 ) return;
	if( iIndex >= m_iItemNo ) return;
	if( m_pItem[iIndex] == NULL ) return;
	for( i=0 ; i<m_iLinkNo ; i++ )
	{
		if( m_pLink[i] == NULL ) return;
		if( m_pLink[i]->m_iParent == iIndex ) return;
	}
	for( i=m_iLinkNo-1 ; i>=0 ; i-- )
	{
		if( m_pLink[i] == NULL ) return;
		if( m_pLink[i]->m_iChild == iIndex ) RemoveLink(i);
	}
	delete m_pItem[iIndex];
	m_iItemNo--;
	for( i=iIndex ; i<DEF_MAXITEM ; i++ )
	{
		m_pItem[i] = m_pItem[i+1];
		if( m_pItem[i] == NULL ) break;
	}
	for( i=0 ; i<DEF_MAXLINK; i++ )
	{
		if( m_pLink[i] == NULL ) break;
		if( m_pLink[i]->m_iParent >= iIndex ) m_pLink[i]->m_iParent--;
		if( m_pLink[i]->m_iChild >= iIndex ) m_pLink[i]->m_iChild--;
	}
	for( i=0 ; i<m_iNoAlter ; i++ )
	{
		if( m_pAlter[i] == NULL ) return;
		m_pAlter[i]->RemoveData(iIndex);
	}
}

void CData::RemoveLink(int iIndex)
{
	int i;
	if( m_pLink[iIndex] == NULL ) return;
	if( iIndex >= m_iLinkNo ) return;
	delete m_pLink[iIndex];
	m_iLinkNo--;
	for( i=iIndex ; i<DEF_MAXLINK ; i++ )
	{
		m_pLink[i] = m_pLink[i+1];
		if( m_pLink[i] == NULL ) break;
	}
}

BOOL CData::InsertAlter(int iIndex)
{
	int i;
	if( iIndex < -1 || iIndex >= m_iNoAlter ) return FALSE;
	for( i=m_iNoAlter-1 ; i>iIndex ; i-- )
	{
		m_pAlter[i+1] = m_pAlter[i];
	}
	m_iNoAlter++;
	m_pAlter[iIndex+1] = new CAlter;
	sprintf( m_pAlter[iIndex+1]->cStrAlter, "New Alternative(%d)", iIndex+2 );
	for( i=0 ; i<m_iItemNo ; i++ )
	{
		m_pAlter[iIndex+1]->AddValue();
	}
	return TRUE;
}

BOOL CData::DeleteAlter(int iIndex)
{
	int i;
	if( iIndex < 0 || iIndex >= m_iNoAlter ) return FALSE;
	if( m_pAlter[iIndex] == NULL ) return FALSE;
	delete m_pAlter[iIndex];
	for( i=iIndex ; i<m_iNoAlter ; i++ )
	{
		m_pAlter[i] = m_pAlter[i+1];
	}
	m_iNoAlter--;
	return TRUE;
}

BOOL CData::CanCalculate()
{
	int i;
	for( i=0 ; i<DEF_MAXITEM; i++ )
	{
		if( m_pItem[i] == NULL ) break;
		if( m_pItem[i]->m_iValueType < 0 ) return FALSE;
	}
	for( i=0 ; i<DEF_MAXLINK; i++ )
	{
		if( m_pLink[i] == NULL ) break;
		if( m_pLink[i]->m_fWeight < 0 ) return FALSE;
	}
	return TRUE;
}

void CData::Calculate()
{
	if( CanCalculate() == FALSE ) return;
	Calculate(0);
	m_bCalculated = TRUE;
}

void CData::Calculate(int iIndex)
{
	int i, j, iChildNo;
	float fSum, fSumWeight;
	iChildNo = 0;
	fSum = 0;
	fSumWeight = 0;
	if( m_pItem[iIndex] == NULL ) return;
	for( i=0 ; i<DEF_MAXLINK; i++ )
	{
		if( m_pLink[i] == NULL ) break;
		if( m_pLink[i]->m_iParent == iIndex )
		{
			iChildNo++;
			Calculate( m_pLink[i]->m_iChild );
		}
	}
	if( iChildNo != 0 )
	{
		for( i=0 ; i<DEF_MAXALTER ; i++ )
		{
			if( m_pAlter[i] == NULL ) break;
			for( j=0 ; j<DEF_MAXLINK ; j++ )
			{
				if( m_pLink[j] == NULL ) break;
				if( m_pLink[j]->m_iParent == iIndex )
				{
					fSum += m_pLink[j]->m_fWeight;
					fSumWeight += m_pLink[j]->m_fWeight*m_pAlter[i]->m_pDataSet[m_pLink[j]->m_iChild]->m_fPoint;
				}
			}
			m_pAlter[i]->m_pDataSet[iIndex]->m_fValue = fSumWeight/fSum;
		}
	}
	float t;
	float ax, bx, cx, ay, by, cy;
	float fMaxX, fMinX, fSizeX, fCurX;
	float fMaxY, fMinY, fSizeY;
	FPOINT pt[4];
	BOOL bSort;
	BOOL bAccel;
	int iDepth;
	int iType;
	fMinY = 40.0f;
//	fMinY = 0.0f;
	fMaxY = 100.0f;
	fSizeY = fMaxY-fMinY;
	iType = m_pItem[iIndex]->m_iValueType;
	bSort = iType/100;
	bAccel = (iType/10)%10;
	iDepth = iType%10;
	for( i=0 ; i<DEF_MAXALTER ; i++ )
	{
		if( m_pAlter[i] == NULL ) break;
		fCurX = m_pAlter[i]->m_pDataSet[iIndex]->m_fValue;
		if( i==0 ) fMaxX = fMinX = fCurX;
		if( fCurX > fMaxX ) fMaxX = fCurX;
		if( fCurX < fMinX ) fMinX = fCurX;
	}
	if( fMaxX <= fMinX )
	{
		for( i=0 ; i<DEF_MAXALTER ; i++ )
		{
			if( m_pAlter[i] == NULL ) break;
			m_pAlter[i]->m_pDataSet[iIndex]->m_fPoint = fMaxY;
		}
		return;
	}
	fSizeX = fMaxX - fMinX;
	pt[0].x = fMinX;
	pt[1].x = fMinX*2/3 + fMaxX/3;
	pt[1].x = fMinX/3 + fMaxX*2/3;
	pt[3].x = fMaxX;
	for( i=0 ; i<4 ; i++ )
	{
		pt[i].x = fMinX;
		pt[i].y = fMinY;
	}
	pt[1].x += fSizeX/3;
	pt[2].x += fSizeX*2/3;
	pt[3].x += fSizeX;
	if( bSort )
	{
		pt[0].y += fSizeY;
		pt[1].y += fSizeY*2/3;
		pt[2].y += fSizeY/3;
	}
	else
	{
		pt[1].y += fSizeY/3;
		pt[2].y += fSizeY*2/3;
		pt[3].y += fSizeY;
	}
	if( bAccel )
	{
		pt[1].x -= fSizeX*iDepth/30;
		pt[2].x -= fSizeX*iDepth/15;
		if( bSort )
		{
			pt[1].y -= fSizeY*iDepth/15;
			pt[2].y -= fSizeY*iDepth/30;
		}
		else
		{
			pt[1].y += fSizeY*iDepth/15;
			pt[2].y += fSizeY*iDepth/30;
		}
	}
	else
	{
		pt[1].x += fSizeX*iDepth/15;
		pt[2].x += fSizeX*iDepth/30;
		if( bSort )
		{
			pt[1].y += fSizeY*iDepth/30;
			pt[2].y += fSizeY*iDepth/15;
		}
		else
		{
			pt[1].y -= fSizeY*iDepth/30;
			pt[2].y -= fSizeY*iDepth/15;
		}
	}
	cx = (pt[1].x-pt[0].x)*3;
	bx = (pt[2].x-pt[1].x)*3-cx;
	ax = pt[3].x-pt[0].x-bx-cx;
	cy = (pt[1].y-pt[0].y)*3;
	by = (pt[2].y-pt[1].y)*3-cy;
	ay = pt[3].y-pt[0].y-by-cy;
	float fX;
	BOOL bSet = FALSE;
	for( i=0 ; i<DEF_MAXALTER ; i++ )
	{
		if( m_pAlter[i] == NULL ) break;
		bSet = FALSE;
		for( t=0.0f; t<=1.0f ; t+= 0.01f )
		{
			fX = ax*t*t*t + bx*t*t + cx*t + pt[0].x;
			if( fX >= m_pAlter[i]->m_pDataSet[iIndex]->m_fValue && fX <= fMaxX )
			{
				m_pAlter[i]->m_pDataSet[iIndex]->m_fPoint = ay*t*t*t + by*t*t + cy*t + pt[0].y;
				bSet = TRUE;
				break;
			}
		}
		if( bSet == FALSE )
		{
			if( bSort ) m_pAlter[i]->m_pDataSet[iIndex]->m_fPoint = fMinY;
			else m_pAlter[i]->m_pDataSet[iIndex]->m_fPoint = fMaxY;
		}
	}
}
