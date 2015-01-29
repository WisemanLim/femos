// Analysis.cpp : implementation file
//

#include "stdafx.h"
#include "Fouler.h"
#include "Analysis.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CAnalysis dialog

CAnalysis::CAnalysis( int iSubGroupSize, double dAlpha, double dBeta, double dDeviation, double dH, double dK, double dTheta0, CWnd* pParent /*=NULL*/)
	: CDialog(CAnalysis::IDD, pParent)
{
	//{{AFX_DATA_INIT(CAnalysis)
	m_dAlpha = 0.0;
	m_dBeta = 0.0;
	m_dDeviation = 0.0;
	m_dH = 0.0;
	m_dK = 0.0;
	m_dTheta0 = 0.0;
	m_iSubGroupSize = 0;
	//}}AFX_DATA_INIT
	m_dAlpha = dAlpha;
	m_dBeta = dBeta;
	m_dDeviation = dDeviation;
	m_dH = dH;
	m_dK = dDeviation/5;
	//m_dK = dK;
	//m_dTheta0 = dTheta0;
	m_dTheta0 = 0;
	m_iSubGroupSize = iSubGroupSize;
}

void CAnalysis::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CAnalysis)
	DDX_Control(pDX, IDC_SPIN_SUBGROUP, m_spinSubGroup);
	DDX_Text(pDX, IDC_EDIT_ALPHA, m_dAlpha);
	DDX_Text(pDX, IDC_EDIT_BETA, m_dBeta);
	DDX_Text(pDX, IDC_EDIT_DEVIATION, m_dDeviation);
	DDX_Text(pDX, IDC_EDIT_H_CUSUM, m_dH);
	DDX_Text(pDX, IDC_EDIT_K_CUSUM, m_dK);
	DDX_Text(pDX, IDC_EDIT_THETAZERO, m_dTheta0);
	DDX_Text(pDX, IDC_EDIT_SUBGROUPSIZE, m_iSubGroupSize);
	DDV_MinMaxUInt(pDX, m_iSubGroupSize, 1, 1000);
	//}}AFX_DATA_MAP
}

BEGIN_MESSAGE_MAP(CAnalysis, CDialog)
	//{{AFX_MSG_MAP(CAnalysis)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CAnalysis message handlers

void CAnalysis::OnOK() 
{
	UpdateData( TRUE );
	if( m_dDeviation <= 0 )
	{
		MessageBox( "σ값은 0보다 커야합니다." );
		return;
	}
	if( m_dH <= 0 )
	{
		MessageBox( "h값은 0보다 커야합니다." );
		return;
	}
	if( m_dK <= 0 )
	{
		MessageBox( "k값은 0보다 커야합니다." );
		return;
	}
	if( m_dAlpha <= 0 || m_dAlpha >= 1 )
	{
		MessageBox( "α값은 0보다 크고 1보다 작은 수여야 합니다." );
		return;
	}
	if( m_dBeta <= 0 || m_dBeta >= 1 )
	{
		MessageBox( "β값은 0보다 크고 1보다 작은 수여야 합니다." );
		return;
	}
	
	CDialog::OnOK();
}

BOOL CAnalysis::OnInitDialog() 
{
	CDialog::OnInitDialog();
	m_spinSubGroup.SetBase( 1 );
	m_spinSubGroup.SetRange( 1, 1000 );
	return TRUE;
}
