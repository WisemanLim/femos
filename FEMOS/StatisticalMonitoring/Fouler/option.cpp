// Option.cpp : implementation file
//

#include "stdafx.h"
#include "Fouler.h"
#include "Option.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// COptionColor property page

IMPLEMENT_DYNCREATE(COptionColor, CPropertyPage)

COptionColor::COptionColor() : CPropertyPage(COptionColor::IDD)
{
	//{{AFX_DATA_INIT(COptionColor)
	//}}AFX_DATA_INIT
	m_brush.CreateSysColorBrush(COLOR_BTNFACE);
}

COptionColor::~COptionColor()
{
}

void COptionColor::DoDataExchange(CDataExchange* pDX)
{
	CPropertyPage::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(COptionColor)
	DDX_Control(pDX, IDC_STATIC_BACKGROUND, m_static_color0);
	DDX_Control(pDX, IDC_STATIC_COLOR8, m_static_color8);
	DDX_Control(pDX, IDC_STATIC_COLOR7, m_static_color7);
	DDX_Control(pDX, IDC_STATIC_COLOR6, m_static_color6);
	DDX_Control(pDX, IDC_STATIC_COLOR5, m_static_color5);
	DDX_Control(pDX, IDC_STATIC_COLOR4, m_static_color4);
	DDX_Control(pDX, IDC_STATIC_COLOR3, m_static_color3);
	DDX_Control(pDX, IDC_STATIC_COLOR2, m_static_color2);
	DDX_Control(pDX, IDC_STATIC_COLOR1, m_static_color1);
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(COptionColor, CPropertyPage)
	//{{AFX_MSG_MAP(COptionColor)
	ON_BN_CLICKED(IDC_BUTTON_BACKGROUND, OnButtonBackground)
	ON_BN_CLICKED(IDC_BUTTON_COLOR1, OnButtonColor1)
	ON_BN_CLICKED(IDC_BUTTON_COLOR2, OnButtonColor2)
	ON_BN_CLICKED(IDC_BUTTON_COLOR3, OnButtonColor3)
	ON_BN_CLICKED(IDC_BUTTON_COLOR4, OnButtonColor4)
	ON_BN_CLICKED(IDC_BUTTON_COLOR5, OnButtonColor5)
	ON_BN_CLICKED(IDC_BUTTON_COLOR6, OnButtonColor6)
	ON_BN_CLICKED(IDC_BUTTON_COLOR7, OnButtonColor7)
	ON_BN_CLICKED(IDC_BUTTON_COLOR8, OnButtonColor8)
	ON_WM_CTLCOLOR()
	ON_BN_CLICKED(IDC_BUTTON_COLOR_DEFAULT, OnButtonColorDefault)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// COptionColor message handlers

HBRUSH COptionColor::OnCtlColor(CDC* pDC, CWnd* pWnd, UINT nCtlColor) 
{
	if(m_static_color0.m_hWnd == pWnd->m_hWnd)
	{
		pDC->SetTextColor(m_rgb0);
		pDC->SetBkColor(m_rgb0);
		return m_brush;
	}
	if(m_static_color1.m_hWnd == pWnd->m_hWnd)
	{
		pDC->SetTextColor(m_rgb1);
		pDC->SetBkColor(m_rgb1);
		return m_brush;
	}
	if(m_static_color2.m_hWnd == pWnd->m_hWnd)
	{
		pDC->SetTextColor(m_rgb2);
		pDC->SetBkColor(m_rgb2);
		return m_brush;
	}
	if(m_static_color3.m_hWnd == pWnd->m_hWnd)
	{
		pDC->SetTextColor(m_rgb3);
		pDC->SetBkColor(m_rgb3);
		return m_brush;
	}
	if(m_static_color4.m_hWnd == pWnd->m_hWnd)
	{
		pDC->SetTextColor(m_rgb4);
		pDC->SetBkColor(m_rgb4);
		return m_brush;
	}
	if(m_static_color5.m_hWnd == pWnd->m_hWnd)
	{
		pDC->SetTextColor(m_rgb5);
		pDC->SetBkColor(m_rgb5);
		return m_brush;
	}
	if(m_static_color6.m_hWnd == pWnd->m_hWnd)
	{
		pDC->SetTextColor(m_rgb6);
		pDC->SetBkColor(m_rgb6);
		return m_brush;
	}
	if(m_static_color7.m_hWnd == pWnd->m_hWnd)
	{
		pDC->SetTextColor(m_rgb7);
		pDC->SetBkColor(m_rgb7);
		return m_brush;
	}
	if(m_static_color8.m_hWnd == pWnd->m_hWnd)
	{
		pDC->SetTextColor(m_rgb8);
		pDC->SetBkColor(m_rgb8);
		return m_brush;
	}

	return CPropertyPage::OnCtlColor(pDC, pWnd, nCtlColor);
}

void COptionColor::OnButtonColorDefault() 
{
	m_rgb0 = RGB(255,255,255);
	m_rgb1 = RGB(255,  0,  0);
	m_rgb2 = RGB(  0,255,  0);
	m_rgb3 = RGB(  0,  0,255);
	m_rgb4 = RGB(  0,255,255);
	m_rgb5 = RGB(255,  0,255);
	m_rgb6 = RGB(255,255,  0);
	m_rgb7 = RGB(  0,  0,  0);
	m_rgb8 = RGB( 64, 64, 64);
	m_static_color0.Invalidate();
	m_static_color1.Invalidate();
	m_static_color2.Invalidate();
	m_static_color3.Invalidate();
	m_static_color4.Invalidate();
	m_static_color5.Invalidate();
	m_static_color6.Invalidate();
	m_static_color7.Invalidate();
	m_static_color8.Invalidate();
}

void COptionColor::OnButtonBackground() 
{
	CColorDialog colordlg(m_rgb0);
	if(IDOK == colordlg.DoModal())
	{
		m_rgb0 = colordlg.GetColor();
		m_static_color0.Invalidate();
	}
}

void COptionColor::OnButtonColor1() 
{
	CColorDialog colordlg(m_rgb1);
	if(IDOK == colordlg.DoModal())
	{
		m_rgb1 = colordlg.GetColor();
		m_static_color1.Invalidate();
	}
}

void COptionColor::OnButtonColor2() 
{
	CColorDialog colordlg(m_rgb2);
	if(IDOK == colordlg.DoModal())
	{
		m_rgb2 = colordlg.GetColor();
		m_static_color2.Invalidate();
	}
}

void COptionColor::OnButtonColor3() 
{
	CColorDialog colordlg(m_rgb3);
	if(IDOK == colordlg.DoModal())
	{
		m_rgb3 = colordlg.GetColor();
		m_static_color3.Invalidate();
	}
}

void COptionColor::OnButtonColor4() 
{
	CColorDialog colordlg(m_rgb4);
	if(IDOK == colordlg.DoModal())
	{
		m_rgb4 = colordlg.GetColor();
		m_static_color4.Invalidate();
	}
}

void COptionColor::OnButtonColor5() 
{
	CColorDialog colordlg(m_rgb5);
	if(IDOK == colordlg.DoModal())
	{
		m_rgb5 = colordlg.GetColor();
		m_static_color5.Invalidate();
	}
}

void COptionColor::OnButtonColor6() 
{
	CColorDialog colordlg(m_rgb6);
	if(IDOK == colordlg.DoModal())
	{
		m_rgb6 = colordlg.GetColor();
		m_static_color6.Invalidate();
	}
}

void COptionColor::OnButtonColor7() 
{
	CColorDialog colordlg(m_rgb7);
	if(IDOK == colordlg.DoModal())
	{
		m_rgb7 = colordlg.GetColor();
		m_static_color7.Invalidate();
	}
}

void COptionColor::OnButtonColor8() 
{
	CColorDialog colordlg(m_rgb8);
	if(IDOK == colordlg.DoModal())
	{
		m_rgb8 = colordlg.GetColor();
		m_static_color8.Invalidate();
	}
}

/////////////////////////////////////////////////////////////////////////////
// COptionGeneral property page

IMPLEMENT_DYNCREATE(COptionGeneral, CPropertyPage)

COptionGeneral::COptionGeneral() : CPropertyPage(COptionGeneral::IDD)
{
	//{{AFX_DATA_INIT(COptionGeneral)
		// NOTE: the ClassWizard will add member initialization here
	//}}AFX_DATA_INIT
}

COptionGeneral::~COptionGeneral()
{
}

void COptionGeneral::DoDataExchange(CDataExchange* pDX)
{
	CPropertyPage::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(COptionGeneral)
		// NOTE: the ClassWizard will add DDX and DDV calls here
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(COptionGeneral, CPropertyPage)
	//{{AFX_MSG_MAP(COptionGeneral)
		// NOTE: the ClassWizard will add message map macros here
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// COptionGeneral message handlers
/////////////////////////////////////////////////////////////////////////////
// COption

IMPLEMENT_DYNAMIC(COption, CPropertySheet)

COption::COption(LPCTSTR pszCaption, CWnd* pParentWnd, UINT iSelectPage)
	:CPropertySheet(pszCaption, pParentWnd, iSelectPage)
{
	AddPage(&m_tabGeneral);
	AddPage(&m_tabColor);
}

COption::~COption()
{
}


BEGIN_MESSAGE_MAP(COption, CPropertySheet)
	//{{AFX_MSG_MAP(COption)
		// NOTE - the ClassWizard will add and remove mapping macros here.
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// COption message handlers
