// Properties.cpp : implementation file
//

#include "stdafx.h"
#include "GAM.h"
#include "Properties.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CProperties dialog


CProperties::CProperties(CGAMDoc *pDoc, CWnd* pParent /*=NULL*/)
	: CDialog(CProperties::IDD, pParent)
{
	//{{AFX_DATA_INIT(CProperties)
	m_iIndex = 0;
	m_iLevel = 0;
	m_strName = _T("");
	m_fValue = 0.0f;
	m_iDepth = 0;
	m_iAccel = 0;
	m_iSort = 0;
	//}}AFX_DATA_INIT
	m_bReady = FALSE;
	m_pDoc = pDoc;
}


void CProperties::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CProperties)
	DDX_Control(pDX, IDC_SPIN_DEPTH, m_spinDepth);
	DDX_Control(pDX, IDC_EDIT_VALUE, m_editValue);
	DDX_Text(pDX, IDC_EDIT_ID, m_iIndex);
	DDX_Text(pDX, IDC_EDIT_LEVEL, m_iLevel);
	DDX_Text(pDX, IDC_EDIT_NAME, m_strName);
	DDX_Text(pDX, IDC_EDIT_VALUE, m_fValue);
	DDX_Text(pDX, IDC_EDIT_DEPTH, m_iDepth);
	DDX_Radio(pDX, IDC_RADIO_ACCELUP, m_iAccel);
	DDX_Radio(pDX, IDC_RADIO_ASCENDING, m_iSort);
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CProperties, CDialog)
	//{{AFX_MSG_MAP(CProperties)
	ON_BN_CLICKED(IDC_RADIO_SUM, OnRadioSum)
	ON_WM_PAINT()
	ON_BN_CLICKED(IDC_RADIO_ACCELUP, OnRadioAccelup)
	ON_BN_CLICKED(IDC_RADIO_ACCELDOWN, OnRadioAcceldown)
	ON_BN_CLICKED(IDC_RADIO_ASCENDING, OnRadioAscending)
	ON_BN_CLICKED(IDC_RADIO_DESCENDING, OnRadioDescending)
	ON_EN_CHANGE(IDC_EDIT_DEPTH, OnChangeEditDepth)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CProperties message handlers

void CProperties::OnRadioSum() 
{
	m_editValue.SetReadOnly(TRUE);
}

BOOL CProperties::OnInitDialog() 
{
	CDialog::OnInitDialog();
	m_spinDepth.SetBase( 10 );
	m_spinDepth.SetRange( 0, 9 );
	m_spinDepth.SetPos( m_iDepth );
	m_bReady = TRUE;
	return TRUE;  // return TRUE unless you set the focus to a control
	              // EXCEPTION: OCX Property Pages should return FALSE
}

void CProperties::OnPaint() 
{
	CPaintDC dc(this); // device context for painting

	POINT pt[4];
	POINT ptOrg;
	RECT rt;
	int i, j, iSize, iDepth;
	CBrush brush;
	brush.CreateSolidBrush( ::GetSysColor(COLOR_3DFACE) );//COLOR_3DFACE
	dc.SelectObject(&brush);

	ptOrg.x = 30;
	ptOrg.y = 140;
	iSize = 180;//반드시 3의 배수
	iDepth = m_iDepth*(iSize*2/3)/20;
	SetRect( &rt, ptOrg.x-5, ptOrg.y-5, ptOrg.x+iSize+5, ptOrg.y+iSize+5 );
	dc.FillRect( &rt, &brush );
	dc.Rectangle( ptOrg.x, ptOrg.y, ptOrg.x+iSize, ptOrg.y+iSize );
	for( i=0 ; i<4 ; i++ )
	{
		pt[i].x = ptOrg.x;
		pt[i].y = ptOrg.y;
	}
	if( m_iSort )
	{
		pt[1].x += iSize/3;
		pt[1].y += iSize/3;
		pt[2].x += iSize*2/3;
		pt[2].y += iSize*2/3;
		pt[3].x += iSize-1;
		pt[3].y += iSize-1;
	}
	else
	{
		pt[0].y += iSize-1;
		pt[1].x += iSize/3;
		pt[1].y += iSize*2/3-1;
		pt[2].x += iSize*2/3-1;
		pt[2].y += iSize/3;
		pt[3].x += iSize-1;
	}
	if( m_iAccel )
	{
		pt[1].x -= iDepth;
		pt[2].x -= iDepth*2;
		if( m_iSort )
		{
			pt[1].y += iDepth*2;
			pt[2].y += iDepth;
		}
		else
		{
			pt[1].y -= iDepth*2;
			pt[2].y -= iDepth;
		}
	}
	else
	{
		pt[1].x += iDepth*2;
		pt[2].x += iDepth;
		if( m_iSort )
		{
			pt[1].y -= iDepth;
			pt[2].y -= iDepth*2;
		}
		else
		{
			pt[1].y += iDepth;
			pt[2].y += iDepth*2;
		}
	}
	dc.PolyBezier( pt, 4 );
	for( i=-2 ; i < 3 ; i++ )
	{
		for( j=-2 ; j < 3 ; j++ )
		{
			dc.SetPixel( pt[0].x+i, pt[0].y+j, RGB(255,0,0) );
			dc.SetPixel( pt[3].x+i, pt[3].y+j, RGB(255,0,0) );
		}
	}
	float fMin, fMax, fCur;
	fMin = 0.0f;
	fMax = 0.0f;
	for( i=0 ; i<DEF_MAXALTER ; i++ )
	{
		fCur = m_pDoc->GetValue( i, m_iIndex );
		if( fCur < 0.0f ) break;
		if( fMin == 0.0f && fMax == 0.0f )
		{
			fMin = fCur;
			fMax = fCur;
		}
		if( fCur < fMin ) fMin = fCur;
		if( fCur > fMax ) fMax = fCur;
	}
	if( fMin == fMax ) return;
	int iCur;
	for( i=0 ; i<DEF_MAXALTER ; i++ )
	{
		fCur = m_pDoc->GetValue( i, m_iIndex );
		if( fCur < 0.0f ) break;
		if( fCur == fMax ) continue;
		if( fCur == fMin ) continue;
		iCur = pt[0].x + (int)(iSize*(fCur-fMin)/(fMax-fMin));
		if( iCur == ptOrg.x ) continue;
		for( j = ptOrg.y+2; j < ptOrg.y+iSize-1 ; j++ )
		{
			if (dc.GetPixel( iCur, j ) == RGB(0,0,0) )
			{
				CBrush brsTemp;
				brsTemp.CreateSolidBrush( RGB( 255,0,0 ) );
				SetRect( &rt, iCur-2, j-2, iCur+3, j+3 );
				dc.FillRect( &rt, &brsTemp );
				break;
			}
		}
	}	
	// Do not call CDialog::OnPaint() for painting messages
}

void CProperties::OnRadioAccelup() 
{
	UpdateData();
	Invalidate(FALSE);
}

void CProperties::OnRadioAcceldown() 
{
	UpdateData();
	Invalidate(FALSE);
}

void CProperties::OnRadioAscending() 
{
	UpdateData();
	Invalidate(FALSE);
}

void CProperties::OnRadioDescending() 
{
	UpdateData();
	Invalidate(FALSE);
}

void CProperties::OnChangeEditDepth() 
{
	if( m_bReady )
	{
		UpdateData();
		if( m_iDepth > 9 ) m_iDepth = 9;
		if( m_iDepth < 0 ) m_iDepth = 0;
		UpdateData(FALSE);
		Invalidate(FALSE);
	}
	// TODO: If this is a RICHEDIT control, the control will not
	// send this notification unless you override the CDialog::OnInitDialog()
	// function and call CRichEditCtrl().SetEventMask()
	// with the ENM_CHANGE flag ORed into the mask.
	
	// TODO: Add your control notification handler code here
	
}
