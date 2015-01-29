// ComboFont.cpp : implementation file
//

#include "stdafx.h"
#include "GAM.h"
#include "ComboFont.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CComboFont

CComboFont::CComboFont()
{
	int i;
	for( i=0 ; i<DEF_MAXFONTNO ; i++ )
	{
		m_plf[i] = NULL;
	}
}

CComboFont::~CComboFont()
{
	int i;
	for( i=0 ; i<DEF_MAXFONTNO ; i++ )
	{
		if( m_plf[i] != NULL ) delete m_plf[i];
	}
}

BEGIN_MESSAGE_MAP(CComboFont, CComboBox)
	//{{AFX_MSG_MAP(CComboFont)
	ON_WM_CREATE()
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CComboFont message handlers


int CComboFont::OnCreate(LPCREATESTRUCT lpCreateStruct) 
{
	if( CComboBox::OnCreate(lpCreateStruct) == -1) return -1;
	Initialize();
	if( EnumerateFonts() == FALSE ) return -1;
	return 0;
}

void CComboFont::Initialize()
{
	char cStr[32];
	ZeroMemory( cStr, sizeof(cStr) );
	m_plf[0] = new LOGFONT;
	strcpy( cStr, "System" );
	m_plf[0]->lfCharSet = 129;
	m_plf[0]->lfClipPrecision = 2;
	m_plf[0]->lfEscapement = 0;
	strcpy( m_plf[0]->lfFaceName, cStr );
	m_plf[0]->lfHeight = -16;
	m_plf[0]->lfItalic = 0;
	m_plf[0]->lfOrientation = 0;
	m_plf[0]->lfOutPrecision = 1;
	m_plf[0]->lfPitchAndFamily = 34;
	m_plf[0]->lfQuality = 1;
	m_plf[0]->lfStrikeOut = 0;
	m_plf[0]->lfUnderline = 0;
	m_plf[0]->lfWeight = 400;
	m_plf[0]->lfWidth = 0;
	int iIndex = AddString( "System" );
	SetCurSel(iIndex);
}

BOOL CComboFont::EnumerateFonts()
{
	HDC hDC;
	LOGFONT lf;
	hDC = ::GetWindowDC(NULL);// Get screen fonts
	ZeroMemory(&lf,sizeof(lf));
	lf.lfCharSet = DEFAULT_CHARSET;
	lf.lfPitchAndFamily = 0;
	if (!EnumFontFamiliesEx( hDC, &lf, (FONTENUMPROC)EnumFamScreenCallBackEx, (LPARAM)this, (DWORD) 0)) return FALSE;
	::ReleaseDC(NULL,hDC);

	// Now get printer fonts
	CPrintDialog dlg(FALSE);
	if (AfxGetApp()->GetPrinterDeviceDefaults(&dlg.m_pd))
	{
		// GetPrinterDC returns a HDC so attach it
		hDC= dlg.CreatePrinterDC();
		ASSERT(hDC != NULL);
		ZeroMemory(&lf,sizeof(lf));
		lf.lfCharSet = DEFAULT_CHARSET;
		if (!EnumFontFamiliesEx( hDC, &lf, (FONTENUMPROC)EnumFamPrinterCallBackEx, (LPARAM)this, (DWORD) 0)) return FALSE;
	}
	return TRUE; // All's ok
}

void CComboFont::AddFont(ENUMLOGFONTEX* pelf)
{
	int i;
	if( pelf->elfLogFont.lfFaceName[0] == 64 ) return;//'@'가 들어간 Font는 제외
//	if( pelf->elfLogFont.lfCharSet > 1 ) return;//이상한 CharSet은 제외
	for( i=0; i<DEF_MAXFONTNO; i++ )
	{
		if( m_plf[i] != NULL )
		{
			if( strcmp( m_plf[i]->lfFaceName, pelf->elfLogFont.lfFaceName ) == 0 ) return;
		}
		else
		{
			m_plf[i] = new LOGFONT;
			memcpy( m_plf[i], &(pelf->elfLogFont), sizeof(LOGFONT) );
			AddString( m_plf[i]->lfFaceName );
			return;
		}
	}
}

BOOL CALLBACK AFX_EXPORT CComboFont::EnumFamScreenCallBackEx(ENUMLOGFONTEX* pelf, NEWTEXTMETRICEX* /*lpntm*/, int FontType, LPVOID pThis)
{
	if( FontType & RASTER_FONTTYPE ) return TRUE;// don't put in non-printer raster fonts
	((CComboFont*)pThis)->AddFont(pelf);
	return TRUE; // Call me back
}

BOOL CALLBACK AFX_EXPORT CComboFont::EnumFamPrinterCallBackEx(ENUMLOGFONTEX* pelf, NEWTEXTMETRICEX* /* lpntm */, int FontType, LPVOID pThis)
{
	if( !(FontType & DEVICE_FONTTYPE) ) return TRUE;
	if( (FontType & TRUETYPE_FONTTYPE) ) return TRUE;
	((CComboFont*)pThis)->AddFont(pelf);
	return TRUE; // Call me back
}