// NewData.cpp : implementation file
//

#include "stdafx.h"
#include "Fouler.h"
#include "NewData.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CNewData dialog


CNewData::CNewData(double dAverage, int iDataNo, double dDeviation, double dMoverate, CWnd* pParent /*=NULL*/)
	: CDialog(CNewData::IDD, pParent)
{
	//{{AFX_DATA_INIT(CNewData)
	//}}AFX_DATA_INIT
	m_average = dAverage;

	if( iDataNo != 0 ) m_datano = iDataNo;
	else m_datano = 1;

	if( dDeviation != 0 ) m_deviation = dDeviation;
	else m_deviation = 2.0;

	if( dMoverate != 0 ) m_moverate = dMoverate;
	else m_moverate = 0.0;
}

void CNewData::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CNewData)
	DDX_Control(pDX, IDC_SPIN_DATANO, m_spinDataNo);
	DDX_Control(pDX, IDC_COMBO_DISTRIBUTION, m_distribution);
	DDX_Text(pDX, IDC_EDIT_AVERAGE, m_average);
	DDX_Text(pDX, IDC_EDIT_DATANO, m_datano);
	DDX_Text(pDX, IDC_EDIT_DEVIATION, m_deviation);
	DDX_Text(pDX, IDC_EDIT_MOVERATE, m_moverate);
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CNewData, CDialog)
	//{{AFX_MSG_MAP(CNewData)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CNewData message handlers

void CNewData::OnOK() 
{
	UpdateData( TRUE );
	if( m_datano < 0 ) return;
	if( m_deviation <= 0 ) return;
	m_iGenMode = m_distribution.GetCurSel();
	if( m_iGenMode == DEF_POISSON_DISTRIBUTION )
	{
		if( m_average <=0 )
		{
			MessageBox( "Poisson분포에서는 평균이 0보다 커야합니다." );
			return;
		}
		if( m_average <= m_deviation*m_deviation )
		{
			MessageBox( "Poisson분포에서는 평균이 sigma*sigma보다 커야합니다." );
			return;
		}
	}
	CDialog::OnOK();
}

BOOL CNewData::OnInitDialog() 
{
	CDialog::OnInitDialog();
	m_distribution.SetCurSel(0);
	m_spinDataNo.SetBase( 0 );
	m_spinDataNo.SetRange( 0, 1000000 );
	return TRUE;
}
