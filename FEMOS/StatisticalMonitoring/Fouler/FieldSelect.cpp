// FieldSelect.cpp : implementation file
//

#include "stdafx.h"
#include "Fouler.h"
#include "FieldSelect.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CFieldSelect dialog


CFieldSelect::CFieldSelect( CRecordset* pRecordSet, CWnd* pParent /*=NULL*/)
	: CDialog(CFieldSelect::IDD, pParent)
{
	//{{AFX_DATA_INIT(CFieldSelect)
		// NOTE: the ClassWizard will add member initialization here
	//}}AFX_DATA_INIT
	m_sCurField = 0;
	m_sField0 = -1;
	m_sField1 = -1;
	m_sField2 = -1;
	m_sField3 = -1;
	m_dCo0 = 0;
	m_dCo1 = 0;
	m_dCo2 = 0;
	m_dCo3 = 0;
	m_pRecordSet = pRecordSet;
}


void CFieldSelect::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CFieldSelect)
	DDX_Control(pDX, IDC_EDIT_FIELD3, m_field3);
	DDX_Control(pDX, IDC_EDIT_FIELD2, m_field2);
	DDX_Control(pDX, IDC_EDIT_FIELD1, m_field1);
	DDX_Control(pDX, IDC_EDIT_FIELD0, m_field0);
	DDX_Control(pDX, IDC_EDIT_CONSTANT, m_co0);
	DDX_Control(pDX, IDC_EDIT_CO3, m_co3);
	DDX_Control(pDX, IDC_EDIT_CO2, m_co2);
	DDX_Control(pDX, IDC_EDIT_CO1, m_co1);
	DDX_Control(pDX, IDC_LIST_FIELD, m_fieldlist);
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CFieldSelect, CDialog)
	//{{AFX_MSG_MAP(CFieldSelect)
	ON_LBN_DBLCLK(IDC_LIST_FIELD, OnDblclkListField)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CFieldSelect message handlers

BOOL CFieldSelect::OnInitDialog() 
{
	CDialog::OnInitDialog();
	
	short sFieldCount = m_pRecordSet->GetODBCFieldCount();
	CODBCFieldInfo fieldinfo;
	for( short i=0 ; i<sFieldCount ; i++ )
	{
		m_pRecordSet->GetODBCFieldInfo( i, fieldinfo );
		m_fieldlist.InsertString( i, fieldinfo.m_strName );
	}
	m_fieldlist.SetCurSel(0);
	m_co0.SetWindowText( "0" );
	m_co1.SetWindowText( "0" );
	m_co2.SetWindowText( "0" );
	m_co3.SetWindowText( "0" );
	return TRUE;  // return TRUE unless you set the focus to a control
	              // EXCEPTION: OCX Property Pages should return FALSE
}

void CFieldSelect::OnOK()
{
	if( m_sField0 < 0 )
	{
		MessageBox( "Select at least one field" );
		return;
	}
	char cStr[32];
	m_co0.GetWindowText( cStr, 32 );
	m_dCo0 = atof(cStr);
	m_co1.GetWindowText( cStr, 32 );
	m_dCo1 = atof(cStr);
	m_co2.GetWindowText( cStr, 32 );
	m_dCo2 = atof(cStr);
	m_co3.GetWindowText( cStr, 32 );
	m_dCo3 = atof(cStr);
	CDialog::OnOK();
}

void CFieldSelect::OnDblclkListField() 
{
	int i = m_fieldlist.GetCurSel();
	CODBCFieldInfo fieldinfo;
	m_pRecordSet->GetODBCFieldInfo( i, fieldinfo );
	switch( m_sCurField )
	{
	case 0:
		m_sField0 = i;
		m_field0.SetWindowText( fieldinfo.m_strName );
		break;
	case 1:
		m_sField1 = i;
		m_field1.SetWindowText( fieldinfo.m_strName );
		m_co1.SetReadOnly( FALSE );
		break;
	case 2:
		m_sField2 = i;
		m_field2.SetWindowText( fieldinfo.m_strName );
		m_co2.SetReadOnly( FALSE );
		break;
	case 3:
		m_sField3 = i;
		m_field3.SetWindowText( fieldinfo.m_strName );
		m_co3.SetReadOnly( FALSE );
		break;
	}
	m_sCurField++;
	if( m_sCurField > 3 ) m_sCurField = 0;
}
