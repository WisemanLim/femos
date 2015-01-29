// FoulerView.cpp : implementation of the CFoulerView class
//

#include "stdafx.h"
#include "Fouler.h"
#include "MainFrm.h"

#include "FoulerDoc.h"
#include "FoulerView.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CFoulerView

IMPLEMENT_DYNCREATE(CFoulerView, CScrollView)

BEGIN_MESSAGE_MAP(CFoulerView, CScrollView)
	//{{AFX_MSG_MAP(CFoulerView)
	ON_WM_SIZE()
	ON_WM_CREATE()
	ON_WM_PAINT()
	ON_WM_TIMER()
	ON_WM_MOUSEMOVE()
	ON_WM_MOUSEWHEEL()
	ON_WM_CONTEXTMENU()
	ON_WM_ERASEBKGND()
	ON_COMMAND(ID_VIEW_CHANGEFONT, OnViewChangefont)
	ON_COMMAND(ID_FILE_PRINT_PREVIEW, OnFilePrintPreview)
	//}}AFX_MSG_MAP
	// Standard printing commands
	ON_COMMAND(ID_FILE_PRINT, CScrollView::OnFilePrint)
	ON_COMMAND(ID_FILE_PRINT_DIRECT, CScrollView::OnFilePrint)
	ON_COMMAND(ID_FILE_PRINT_PREVIEW, CScrollView::OnFilePrintPreview)
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CFoulerView construction/destruction

CFoulerView::CFoulerView()
{
	m_iSizeX = 0;
	m_iSizeY = 0;
	m_iScrollShewart = 0;
	m_iScrollCUSUM = 0;
	m_iScrollSPRT = 0;
	m_hDC = NULL;
	rgb0 = RGB(255,255,255);
	rgb1 = RGB(255,  0,  0);
	rgb2 = RGB(  0,255,  0);
	rgb3 = RGB(  0,  0,255);
	rgb4 = RGB(  0,255,255);
	rgb5 = RGB(255,  0,255);
	rgb6 = RGB(255,255,  0);
	//rgb7 = RGB(  0,  0,  0);
	rgb7 = RGB(255,255,255);
	rgb8 = RGB( 64, 64, 64);
	char cStr[16];
	ZeroMemory( cStr, sizeof(cStr) );
	wsprintf( cStr, "Comic Sans MS" );
	m_plf = new LOGFONT;
	m_plf->lfCharSet = 0;
	m_plf->lfClipPrecision = 2;
	m_plf->lfEscapement = 0;
	strcpy( m_plf->lfFaceName, cStr );
	m_plf->lfHeight = -13;
	m_plf->lfItalic = 0;
	m_plf->lfOrientation = 0;
	m_plf->lfOutPrecision = 3;
	m_plf->lfPitchAndFamily = 66;
	m_plf->lfQuality = 1;
	m_plf->lfStrikeOut = 0;
	m_plf->lfUnderline = 0;
	m_plf->lfWeight = 400;
	m_plf->lfWidth = 0;
	m_hFont = CreateFontIndirect( m_plf );
}

CFoulerView::~CFoulerView()
{
	if( m_hFont != NULL )
	{
		DeleteObject( m_hFont );
	}
	if( m_plf != NULL )
	{
		delete m_plf;
		m_plf = NULL;
	}
}

BOOL CFoulerView::PreCreateWindow(CREATESTRUCT& cs)
{
	return CScrollView::PreCreateWindow(cs);
}

/////////////////////////////////////////////////////////////////////////////
// CFoulerView drawing

void CFoulerView::OnDraw(CDC* pDC)
{
	CFoulerDoc* pDoc = GetDocument();
	ASSERT_VALID(pDoc);
}

void CFoulerView::OnInitialUpdate()
{
	CScrollView::OnInitialUpdate();
	CFoulerDoc* pDoc = GetDocument();
	ASSERT_VALID(pDoc);
	SetScrollSizes(MM_TEXT, CSize(1, 1));
	pDoc->SetRightView( this );
	SetTimer( WM_USER+1004, 20, NULL );
}

/////////////////////////////////////////////////////////////////////////////
// CFoulerView printing

BOOL CFoulerView::OnPreparePrinting(CPrintInfo* pInfo)
{
	return DoPreparePrinting(pInfo);
}

void CFoulerView::OnBeginPrinting(CDC* /*pDC*/, CPrintInfo* /*pInfo*/)
{
}

void CFoulerView::OnEndPrinting(CDC* /*pDC*/, CPrintInfo* /*pInfo*/)
{
}

/////////////////////////////////////////////////////////////////////////////
// CFoulerView diagnostics

#ifdef _DEBUG
void CFoulerView::AssertValid() const
{
	CScrollView::AssertValid();
}

void CFoulerView::Dump(CDumpContext& dc) const
{
	CScrollView::Dump(dc);
}

CFoulerDoc* CFoulerView::GetDocument() // non-debug version is inline
{
	ASSERT(m_pDocument->IsKindOf(RUNTIME_CLASS(CFoulerDoc)));
	return (CFoulerDoc*)m_pDocument;
}
#endif //_DEBUG

/////////////////////////////////////////////////////////////////////////////
// CFoulerView message handlers

BOOL CFoulerView::OnEraseBkgnd(CDC* pDC) 
{
	return FALSE;
}

int CFoulerView::OnCreate(LPCREATESTRUCT lpCreateStruct) 
{
	if (CScrollView::OnCreate(lpCreateStruct) == -1) return -1;	
	int	nPixelFormat;
	m_hDC = ::GetDC(m_hWnd);
	SetBkMode( m_hDC, TRANSPARENT );
	PIXELFORMATDESCRIPTOR pfd = {sizeof(PIXELFORMATDESCRIPTOR), 1, PFD_DRAW_TO_WINDOW | PFD_SUPPORT_OPENGL | PFD_DOUBLEBUFFER, PFD_TYPE_RGBA, 24, 0,0,0,0,0,0,0,0,0,0,0,0,0,32,0,0,PFD_MAIN_PLANE,0,0,0,0 };
	nPixelFormat = ChoosePixelFormat(m_hDC, &pfd);
	VERIFY(SetPixelFormat(m_hDC, nPixelFormat, &pfd));
	m_hRC = wglCreateContext(m_hDC);
	VERIFY(wglMakeCurrent(m_hDC, m_hRC));
	glClearColor(GetRValue(rgb7), GetGValue(rgb7), GetBValue(rgb7), 1.0f);
	wglMakeCurrent(NULL, NULL);
	return 0;
}

void CFoulerView::OnSize(UINT nType, int cx, int cy) 
{
	m_rtClient.left = 0;
	m_rtClient.top = 0;
	m_rtClient.right = cx;
	m_rtClient.bottom = cy;
	m_iSizeX = cx;
	m_iSizeY = cy;
	if( m_plf != NULL )
	{
		long lHeight = - m_iSizeX/50;
		m_plf->lfHeight = lHeight;
		if( m_hFont != NULL ) DeleteObject(m_hFont);
		m_hFont = CreateFontIndirect( m_plf );
	}
	CScrollView::OnSize(nType, cx, cy);
	VERIFY(wglMakeCurrent(m_hDC, m_hRC));
	GLfloat nRange = 120.0f;
	if(cy == 0) cy = 1;// Prevent a divide by zero
    glViewport(0, 0, cx, cy);// Set Viewport to window dimensions
	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();// Reset coordinate system
	glOrtho (0.0f, X_RANGE_MAX, 0.0f, Y_RANGE_MAX, -nRange, nRange);// Establish clipping volume (left, right, bottom, top, near, far)
	glMatrixMode(GL_MODELVIEW);
	VERIFY(wglMakeCurrent(NULL, NULL));
	CFoulerDoc* pDoc = GetDocument();
	ASSERT_VALID(pDoc);
	pDoc->ChangeViewMode(pDoc->m_iViewMode);
}

void CFoulerView::OnPaint() 
{
	HFONT *pOldFont;
	CPaintDC dc(this);
	CFoulerDoc* pDoc = GetDocument();
	ASSERT_VALID(pDoc);
	CMainFrame *pFrame = (CMainFrame*)AfxGetMainWnd();
	if( pFrame )
	{
		rgb0 = pFrame->m_rgb0;
		rgb1 = pFrame->m_rgb1;
		rgb2 = pFrame->m_rgb2;
		rgb3 = pFrame->m_rgb3;
		rgb4 = pFrame->m_rgb4;
		rgb5 = pFrame->m_rgb5;
		rgb6 = pFrame->m_rgb6;
		rgb7 = pFrame->m_rgb7;
		rgb8 = pFrame->m_rgb8;
	}
	wglMakeCurrent(m_hDC, m_hRC);
	glClearColor(GetRValue(rgb7), GetGValue(rgb7), GetBValue(rgb7), 1.0f);
	wglMakeCurrent(NULL, NULL);
	wglMakeCurrent(m_hDC, m_hRC);
	glClear(GL_COLOR_BUFFER_BIT);
	if( m_hFont != NULL )
	{
		pOldFont = (HFONT*)SelectObject( m_hDC, m_hFont );
	}
	glPushMatrix();
	DrawGrid();
	if( pDoc->m_iNo > 0 ) 
	{
		switch( pDoc->m_iViewMode )
		{
		case DEF_HISTOGRAM:
			if( pDoc->m_histogram.GetReady() ) DrawHistogram();
			else
			{
				glPopMatrix();
				SwapBuffers(m_hDC);
			}
			break;
		case DEF_SHEWART:
			if( pDoc->m_shewart.GetReady() ) DrawShewart();
			else
			{
				glPopMatrix();
				SwapBuffers(m_hDC);
			}
			break;
		case DEF_CUSUM:
			if( pDoc->m_cusum.GetReady() ) DrawCUSUM();
			else
			{
				glPopMatrix();
				SwapBuffers(m_hDC);
			}
			break;
		case DEF_SPRT:
			if( pDoc->m_sprt.GetReady() ) DrawSPRT();
			else
			{
				glPopMatrix();
				SwapBuffers(m_hDC);
			}
			break;
		}
	}
	else
	{
		glPopMatrix();
		SwapBuffers(m_hDC);
	}
	//if( m_hFont != NULL ) SelectObject( m_hDC, pOldFont );
	wglMakeCurrent(m_hDC, NULL);
}

void CFoulerView::DrawGrid() 
{
	float f;
	glBegin(GL_LINES);
	glRGB(GetRValue(rgb8), GetGValue(rgb8), GetBValue(rgb8));
	for(f=0; f<X_RANGE_MAX; f+=X_RANGE_MAX/50)
	{
		glVertex2f(f, 0.0f);
		glVertex2f(f, Y_RANGE_MAX);
	}
	for(f=0; f<Y_RANGE_MAX; f+=Y_RANGE_MAX/50)
	{
		glVertex2f(0.0f,		f);
		glVertex2f(X_RANGE_MAX,	f);
	}
	glEnd();
}

void CFoulerView::DrawHistogram()
{
	CFoulerDoc* pDoc = GetDocument();
	ASSERT_VALID(pDoc);
	int i;
	double iYsize;
	double dTemp = 0;

	for( i=0 ; i < DEF_HISTOGRAM_SIZE ; i+=2 )
	{
		if( dTemp < pDoc->m_iHistogram[i]+pDoc->m_iHistogram[i+1] ) dTemp = pDoc->m_iHistogram[i]+pDoc->m_iHistogram[i+1];
	}
	if( dTemp < 1 ) dTemp = 1;
	iYsize = (16000/(float)(dTemp));
	
	glBegin(GL_LINE_STRIP);
	glRGB(GetRValue(rgb2), GetGValue(rgb2), GetBValue(rgb2));
	for( i=0 ; i < DEF_HISTOGRAM_SIZE-1 ; i+=2 )
	{
		dTemp = iYsize*pDoc->m_iNo*2*(exp( - (10*(float)(i)/DEF_HISTOGRAM_SIZE-5)*(10*(float)(i)/DEF_HISTOGRAM_SIZE-5)/2 )+exp( - (10*(float)(i+2)/DEF_HISTOGRAM_SIZE-5)*(10*(float)(i+2)/DEF_HISTOGRAM_SIZE-5)/2 ) )/DEF_HISTOGRAM_SIZE;
		glVertex2f((float)((i+1)*X_RANGE_MAX/DEF_HISTOGRAM_SIZE), (float)(dTemp+Y_RANGE_MAX/10));
	}

	glEnd();
	glBegin(GL_LINE_STRIP);
	glRGB(GetRValue(rgb5), GetGValue(rgb5), GetBValue(rgb5));
	for( i=0 ; i < DEF_HISTOGRAM_SIZE-1 ; i+=2 )
	{
		glVertex2f((float)((i+1)*X_RANGE_MAX/DEF_HISTOGRAM_SIZE), (float)((pDoc->m_iHistogram[i]+pDoc->m_iHistogram[i+1])*iYsize/2+Y_RANGE_MAX/10));
	}
	glEnd();
	glBegin(GL_LINES);
	glRGB(GetRValue(rgb0), GetGValue(rgb0), GetBValue(rgb0));
	glVertex2f(X_RANGE_MAX/2, 0);
	glVertex2f(X_RANGE_MAX/2, Y_RANGE_MAX);
	glVertex2f(0.0f,		Y_RANGE_MAX/10);
	glVertex2f(X_RANGE_MAX, Y_RANGE_MAX/10);
	
	glRGB(GetRValue(rgb6), GetGValue(rgb6), GetBValue(rgb6));
	for( i=0 ; i < 40 ; i++ )
	{
		glVertex2f((float)(X_RANGE_MAX*0.3), (float)(i*Y_RANGE_MAX/40+Y_RANGE_MAX/10));
		glVertex2f((float)(X_RANGE_MAX*0.3), (float)(i*Y_RANGE_MAX/40+Y_RANGE_MAX/10+150));
		glVertex2f((float)(X_RANGE_MAX*0.7), (float)(i*Y_RANGE_MAX/40+Y_RANGE_MAX/10));
		glVertex2f((float)(X_RANGE_MAX*0.7), (float)(i*Y_RANGE_MAX/40+Y_RANGE_MAX/10+150));
	}
	glVertex2f(X_RANGE_MAX*0.2, Y_RANGE_MAX/10);
	glVertex2f(X_RANGE_MAX*0.2, Y_RANGE_MAX);
	glVertex2f(X_RANGE_MAX*0.8, Y_RANGE_MAX/10);
	glVertex2f(X_RANGE_MAX*0.8, Y_RANGE_MAX);
	
	glEnd();
	glPopMatrix();
	SwapBuffers(m_hDC);

	RECT rt;
	float dSum;
	char cStr[16];
	ZeroMemory( cStr, sizeof(cStr) );

	SetTextColor( m_hDC, rgb2 );
	SetRect( &rt, 0, 0, m_rtClient.right, m_rtClient.bottom );
	DrawText( m_hDC, "Histogram", 9, &rt, DT_LEFT );

	SetTextColor( m_hDC, rgb6 );
	SetRect( &rt, (int)(m_rtClient.right*0.2-100), (int)(m_rtClient.bottom*0.9), (int)(m_rtClient.right*0.2+100), (int)(m_rtClient.bottom) );
	DrawText( m_hDC, "3¥ò", 3, &rt, DT_CENTER );
	SetRect( &rt, (int)(m_rtClient.right*0.3-100), (int)(m_rtClient.bottom*0.9), (int)(m_rtClient.right*0.3+100), (int)(m_rtClient.bottom) );
	DrawText( m_hDC, "2¥ò", 3, &rt, DT_CENTER );
	SetRect( &rt, (int)(m_rtClient.right*0.7-100), (int)(m_rtClient.bottom*0.9), (int)(m_rtClient.right*0.7+100), (int)(m_rtClient.bottom) );
	DrawText( m_hDC, "2¥ò", 3, &rt, DT_CENTER );
	SetRect( &rt, (int)(m_rtClient.right*0.8-100), (int)(m_rtClient.bottom*0.9), (int)(m_rtClient.right*0.8+100), (int)(m_rtClient.bottom) );
	DrawText( m_hDC, "3¥ò", 3, &rt, DT_CENTER );

	SetTextColor( m_hDC, rgb4 );
	dSum = 0;
	for( i=0 ; i < DEF_HISTOGRAM_SIZE*0.2 ; i++ ) dSum += pDoc->m_iHistogram[i];
	dSum = dSum*100/((float)(pDoc->m_iNo));
	sprintf( cStr, "%.3f%%", dSum );
	SetRect( &rt, (int)(m_rtClient.right*0.1-100), (int)(m_rtClient.bottom*0.9+5), (int)(m_rtClient.right*0.1+100), (int)(m_rtClient.bottom) );
	DrawText( m_hDC, cStr, strlen(cStr), &rt, DT_CENTER );
	dSum = 0;
	for( i=(int)(DEF_HISTOGRAM_SIZE*0.2) ; i < DEF_HISTOGRAM_SIZE*0.3 ; i++ ) dSum += pDoc->m_iHistogram[i];
	dSum = dSum*100/((float)(pDoc->m_iNo));
	sprintf( cStr, "%.2f%%", dSum );
	SetRect( &rt, (int)(m_rtClient.right*0.25-100), (int)(m_rtClient.bottom*0.9+5), (int)(m_rtClient.right*0.25+100), (int)(m_rtClient.bottom) );
	DrawText( m_hDC, cStr, strlen(cStr), &rt, DT_CENTER );
	dSum = 0;
	for( i=(int)(DEF_HISTOGRAM_SIZE*0.3) ; i < DEF_HISTOGRAM_SIZE*0.4 ; i++ ) dSum += pDoc->m_iHistogram[i];
	dSum = dSum*100/((float)(pDoc->m_iNo));
	sprintf( cStr, "%.1f%%", dSum );
	SetRect( &rt, (int)(m_rtClient.right*0.35-100), (int)(m_rtClient.bottom*0.9+5), (int)(m_rtClient.right*0.35+100), (int)(m_rtClient.bottom) );
	DrawText( m_hDC, cStr, strlen(cStr), &rt, DT_CENTER );
	dSum = 0;
	for( i=(int)(DEF_HISTOGRAM_SIZE*0.4) ; i < DEF_HISTOGRAM_SIZE*0.5 ; i++ ) dSum += pDoc->m_iHistogram[i];
	dSum = dSum*100/((float)(pDoc->m_iNo));
	sprintf( cStr, "%.1f%%", dSum );
	SetRect( &rt, (int)(m_rtClient.right*0.45-100), (int)(m_rtClient.bottom*0.9+5), (int)(m_rtClient.right*0.45+100), (int)(m_rtClient.bottom) );
	DrawText( m_hDC, cStr, strlen(cStr), &rt, DT_CENTER );
	dSum = 0;
	for( i=(int)(DEF_HISTOGRAM_SIZE*0.5) ; i < DEF_HISTOGRAM_SIZE*0.6 ; i++ ) dSum += pDoc->m_iHistogram[i];
	dSum = dSum*100/((float)(pDoc->m_iNo));
	sprintf( cStr, "%.1f%%", dSum );
	SetRect( &rt, (int)(m_rtClient.right*0.55-100), (int)(m_rtClient.bottom*0.9+5), (int)(m_rtClient.right*0.55+100), (int)(m_rtClient.bottom) );
	DrawText( m_hDC, cStr, strlen(cStr), &rt, DT_CENTER );
	dSum = 0;
	for( i=(int)(DEF_HISTOGRAM_SIZE*0.6) ; i < DEF_HISTOGRAM_SIZE*0.7 ; i++ ) dSum += pDoc->m_iHistogram[i];
	dSum = dSum*100/((float)(pDoc->m_iNo));
	sprintf( cStr, "%.1f%%", dSum );
	SetRect( &rt, (int)(m_rtClient.right*0.65-100), (int)(m_rtClient.bottom*0.9+5), (int)(m_rtClient.right*0.65+100), (int)(m_rtClient.bottom) );
	DrawText( m_hDC, cStr, strlen(cStr), &rt, DT_CENTER );
	dSum = 0;
	for( i=(int)(DEF_HISTOGRAM_SIZE*0.7) ; i < DEF_HISTOGRAM_SIZE*0.8 ; i++ ) dSum += pDoc->m_iHistogram[i];
	dSum = dSum*100/((float)(pDoc->m_iNo));
	sprintf( cStr, "%.2f%%", dSum );
	SetRect( &rt, (int)(m_rtClient.right*0.75-100), (int)(m_rtClient.bottom*0.9+5), (int)(m_rtClient.right*0.75+100), (int)(m_rtClient.bottom) );
	DrawText( m_hDC, cStr, strlen(cStr), &rt, DT_CENTER );
	dSum = 0;
	for( i=(int)(DEF_HISTOGRAM_SIZE*0.8) ; i < DEF_HISTOGRAM_SIZE ; i++ ) dSum += pDoc->m_iHistogram[i];
	dSum = dSum*100/((float)(pDoc->m_iNo));
	sprintf( cStr, "%.3f%%", dSum );
	SetRect( &rt, (int)(m_rtClient.right*0.9-100), (int)(m_rtClient.bottom*0.9+5), (int)(m_rtClient.right*0.9+100), (int)(m_rtClient.bottom) );
	DrawText( m_hDC, cStr, strlen(cStr), &rt, DT_CENTER );

	SetTextColor( m_hDC, rgb2 );
	SetRect( &rt, (int)(m_rtClient.right*0.1-100), (int)(m_rtClient.bottom*0.94+5), (int)(m_rtClient.right*0.1+100), (int)(m_rtClient.bottom) );
	DrawText( m_hDC, "0.135%%", 6, &rt, DT_CENTER );
	SetRect( &rt, (int)(m_rtClient.right*0.25-100), (int)(m_rtClient.bottom*0.94+5), (int)(m_rtClient.right*0.25+100), (int)(m_rtClient.bottom) );
	DrawText( m_hDC, "2.15%%", 5, &rt, DT_CENTER );
	SetRect( &rt, (int)(m_rtClient.right*0.35-100), (int)(m_rtClient.bottom*0.94+5), (int)(m_rtClient.right*0.35+100), (int)(m_rtClient.bottom) );
	DrawText( m_hDC, "13.6%%", 5, &rt, DT_CENTER );
	SetRect( &rt, (int)(m_rtClient.right*0.45-100), (int)(m_rtClient.bottom*0.94+5), (int)(m_rtClient.right*0.45+100), (int)(m_rtClient.bottom) );
	DrawText( m_hDC, "34.1%%", 5, &rt, DT_CENTER );
	SetRect( &rt, (int)(m_rtClient.right*0.55-100), (int)(m_rtClient.bottom*0.94+5), (int)(m_rtClient.right*0.55+100), (int)(m_rtClient.bottom) );
	DrawText( m_hDC, "34.1%%", 5, &rt, DT_CENTER );
	SetRect( &rt, (int)(m_rtClient.right*0.65-100), (int)(m_rtClient.bottom*0.94+5), (int)(m_rtClient.right*0.65+100), (int)(m_rtClient.bottom) );
	DrawText( m_hDC, "13.6%%", 5, &rt, DT_CENTER );
	SetRect( &rt, (int)(m_rtClient.right*0.75-100), (int)(m_rtClient.bottom*0.94+5), (int)(m_rtClient.right*0.75+100), (int)(m_rtClient.bottom) );
	DrawText( m_hDC, "2.15%%", 5, &rt, DT_CENTER );
	SetRect( &rt, (int)(m_rtClient.right*0.9-100), (int)(m_rtClient.bottom*0.94+5), (int)(m_rtClient.right*0.9+100), (int)(m_rtClient.bottom) );
	DrawText( m_hDC, "0.135%%", 6, &rt, DT_CENTER );
}

void CFoulerView::DrawShewart()
{
	double dTemp;
	int i;
	CFoulerDoc* pDoc = GetDocument();
	ASSERT_VALID(pDoc);

	CSHEWART *pShewart = &pDoc->m_shewart;
	float xsize = 20;
	float ysize = (float)(400/(float)(pShewart->GetDeviation()));

	if( m_iScrollShewart > pDoc->m_iNo-500 ) m_iScrollShewart = pDoc->m_iNo - 500;
	if( m_iScrollShewart < 0 ) m_iScrollShewart = 0;

	glBegin(GL_LINE_STRIP);

	glRGB(GetRValue(rgb5), GetGValue(rgb5), GetBValue(rgb5));
	for( i=m_iScrollShewart ; i<pDoc->m_iNo-1 && i<m_iScrollShewart+500 ; i++ )
	{
		glVertex2f((float)(xsize*i-m_iScrollShewart*xsize), (float)(Y_RANGE_MAX*0.8+(pDoc->m_pData[i]->GetItem()-pShewart->GetTheta0())*ysize));
	}
	glEnd();
	glBegin(GL_LINE_STRIP);
	if( pDoc->m_iNo > 1 )
	{
		for( i=m_iScrollShewart+1 ; i<pDoc->m_iNo-1 && i<m_iScrollShewart+500 ; i++ )
		{
			dTemp = pDoc->m_pData[i]->GetItem() - pDoc->m_pData[i-1]->GetItem();
			if( dTemp > 0 )
				glVertex2f((float)(xsize*i-m_iScrollShewart*xsize), (float)(Y_RANGE_MAX*0.1 + dTemp*ysize ));
			else
				glVertex2f((float)(xsize*i-m_iScrollShewart*xsize), (float)(Y_RANGE_MAX*0.1 - dTemp*ysize ));
		}
	}
	glEnd();

	glBegin(GL_LINES);
	glRGB(GetRValue(rgb6), GetGValue(rgb6), GetBValue(rgb6));
	for( i=0 ; i < 40 ; i++ )
	{
		glVertex2f((float)(i*X_RANGE_MAX/40),		(float)(Y_RANGE_MAX*0.8+pShewart->GetDeviation()*ysize*2));
		glVertex2f((float)(i*X_RANGE_MAX/40+150),	(float)(Y_RANGE_MAX*0.8+pShewart->GetDeviation()*ysize*2));
		glVertex2f((float)(i*X_RANGE_MAX/40),		(float)(Y_RANGE_MAX*0.8-pShewart->GetDeviation()*ysize*2));
		glVertex2f((float)(i*X_RANGE_MAX/40+150),	(float)(Y_RANGE_MAX*0.8-pShewart->GetDeviation()*ysize*2));
	}
	glVertex2f(0,			(float)(Y_RANGE_MAX*0.8+pShewart->GetDeviation()*ysize*3));
	glVertex2f(X_RANGE_MAX,	(float)(Y_RANGE_MAX*0.8+pShewart->GetDeviation()*ysize*3));
	glVertex2f(0,			(float)(Y_RANGE_MAX*0.8-pShewart->GetDeviation()*ysize*3));
	glVertex2f(X_RANGE_MAX,	(float)(Y_RANGE_MAX*0.8-pShewart->GetDeviation()*ysize*3));

	glRGB(GetRValue(rgb0), GetGValue(rgb0), GetBValue(rgb0));
	glVertex2f(0.0f,		Y_RANGE_MAX*0.8);
	glVertex2f(X_RANGE_MAX, Y_RANGE_MAX*0.8);
	glVertex2f(0.0f,		Y_RANGE_MAX*0.1);
	glVertex2f(X_RANGE_MAX, Y_RANGE_MAX*0.1);
	for( i=-1 ; i < 7 ; i++ )
	{
		glVertex2f((float)((i*100-m_iScrollShewart%100)*xsize),	(float)(Y_RANGE_MAX*0.79));
		glVertex2f((float)((i*100-m_iScrollShewart%100)*xsize),	(float)(Y_RANGE_MAX*0.81));
		glVertex2f((float)((i*100-m_iScrollShewart%100)*xsize),	(float)(Y_RANGE_MAX*0.09));
		glVertex2f((float)((i*100-m_iScrollShewart%100)*xsize),	(float)(Y_RANGE_MAX*0.11));
	}
	glEnd();
	glPopMatrix();
	SwapBuffers(m_hDC);

	RECT rt;
	SetRect( &rt, 0, 0, m_rtClient.right, 30 );
	SetTextColor( m_hDC, rgb2 );
	DrawText( m_hDC, "Shewart Chart", 13, &rt, DT_LEFT );
	SetRect( &rt, 0, (int)(m_rtClient.bottom*0.35), m_rtClient.right, (int)(m_rtClient.bottom*0.4+30) );
	DrawText( m_hDC, "X Chart", 7, &rt, DT_LEFT );
	SetRect( &rt, 0, (int)(m_rtClient.bottom*0.6), m_rtClient.right, (int)(m_rtClient.bottom*0.6+30) );
	DrawText( m_hDC, "R Chart", 7, &rt, DT_LEFT );

	SetRect( &rt, 10, 0, (int)(m_rtClient.right), (int)(m_rtClient.bottom) );
	SetTextColor( m_hDC, rgb6 );
	SetRect( &rt, rt.left, (int)(m_rtClient.bottom*0.08), rt.right, rt.bottom );
	DrawText( m_hDC, "3¥ò", 3, &rt, DT_LEFT );
	SetRect( &rt, rt.left, (int)(m_rtClient.bottom*0.12), rt.right, rt.bottom );
	DrawText( m_hDC, "2¥ò", 3, &rt, DT_LEFT );
	SetRect( &rt, rt.left, (int)(m_rtClient.bottom*0.28), rt.right, rt.bottom );
	DrawText( m_hDC, "2¥ò", 3, &rt, DT_LEFT );
	SetRect( &rt, rt.left, (int)(m_rtClient.bottom*0.32), rt.right, rt.bottom );
	DrawText( m_hDC, "3¥ò", 3, &rt, DT_LEFT );

	char cStr[32];
	ZeroMemory( cStr, sizeof(cStr) );
	i = m_iScrollShewart-m_iScrollShewart%500+500;
	wsprintf( cStr, "%d", i );
	SetTextColor( m_hDC, rgb0 );
	dTemp = (i - m_iScrollShewart)*m_rtClient.right/500;
	SetRect( &rt, (int)(dTemp)-100, (int)(m_rtClient.bottom*0.9), (int)(dTemp)+100, (int)(m_rtClient.bottom) );
	DrawText( m_hDC, cStr, strlen(cStr), &rt, DT_CENTER );
}

void CFoulerView::DrawCUSUM()
{
	CFoulerDoc* pDoc = GetDocument();
	ASSERT_VALID(pDoc);
	CCUSUM *pCusum = &pDoc->m_cusum;
	int i;
	double xsize, ysize;
	xsize = 10;
	ysize = (3000/pCusum->GetH());

	if( m_iScrollCUSUM > pDoc->m_iNo-1000 ) m_iScrollCUSUM = pDoc->m_iNo - 1000;
	if( m_iScrollCUSUM < 0 ) m_iScrollCUSUM = 0;

	glBegin(GL_LINE_STRIP);

	glRGB(GetRValue(rgb1), GetGValue(rgb1), GetBValue(rgb1));
	for( i=m_iScrollCUSUM ; i<pDoc->m_iNo-1 && i<m_iScrollCUSUM+1000-1 ; i++ )
	{
		glVertex2f((float)((i-m_iScrollCUSUM)*xsize),	(float)(Y_RANGE_MAX/2+pDoc->m_pData[i]->GetPlus()*ysize));
	}
	glEnd();
	glBegin(GL_LINE_STRIP);
	glRGB(GetRValue(rgb3), GetGValue(rgb3), GetBValue(rgb3));
	for( i=m_iScrollCUSUM ; i<pDoc->m_iNo-1 && i<m_iScrollCUSUM+1000-1 ; i++ )
	{
		glVertex2f((float)((i-m_iScrollCUSUM)*xsize),	(float)(Y_RANGE_MAX/2+pDoc->m_pData[i]->GetMinus()*ysize));
	}

	glEnd();
	glBegin(GL_LINES);

	glRGB(GetRValue(rgb0), GetGValue(rgb0), GetBValue(rgb0));
	glVertex2f(0.0f,		Y_RANGE_MAX/2);
	glVertex2f(X_RANGE_MAX, Y_RANGE_MAX/2);
	for( i=-1 ; i < 12 ; i++ )
	{
		glVertex2f((float)((i*100-m_iScrollCUSUM%100)*xsize),	Y_RANGE_MAX*0.49);
		glVertex2f((float)((i*100-m_iScrollCUSUM%100)*xsize),	Y_RANGE_MAX*0.51);
	}
	
	glRGB(GetRValue(rgb6), GetGValue(rgb6), GetBValue(rgb6));
	glVertex2f(0,			Y_RANGE_MAX/5);
	glVertex2f(X_RANGE_MAX,	Y_RANGE_MAX/5);
	glVertex2f(0,			Y_RANGE_MAX*0.8);
	glVertex2f(X_RANGE_MAX,	Y_RANGE_MAX*0.8);

	glEnd();
	glPopMatrix();
	SwapBuffers(m_hDC);

	RECT rt;
	SetRect( &rt, 0, 0, m_rtClient.right, 30 );
	SetTextColor( m_hDC, rgb2 );
	DrawText( m_hDC, "CUSUM Chart", 11, &rt, DT_LEFT );

	SetTextColor( m_hDC, rgb6 );
	SetRect( &rt, 5, (int)(m_rtClient.bottom*0.2+7), m_rtClient.right, m_rtClient.bottom );
	DrawText( m_hDC, "h", 1, &rt, DT_LEFT );
	SetRect( &rt, 5, (int)(m_rtClient.bottom*0.8+7), m_rtClient.right, m_rtClient.bottom );
	DrawText( m_hDC, "h", 1, &rt, DT_LEFT );

	char cStr[32];
	ZeroMemory( cStr, sizeof(cStr) );
	i = m_iScrollCUSUM-m_iScrollCUSUM%1000+1000;
	wsprintf( cStr, "%d", i );
	SetTextColor( m_hDC, rgb0 );
	xsize = (i - m_iScrollCUSUM)*m_rtClient.right/1000;
	SetRect( &rt, (int)(xsize)-100, (int)(m_rtClient.bottom*0.5), (int)(xsize)+100, (int)(m_rtClient.bottom) );
	DrawText( m_hDC, cStr, strlen(cStr), &rt, DT_CENTER );
}

void CFoulerView::DrawSPRT()
{
	CFoulerDoc* pDoc = GetDocument();
	ASSERT_VALID(pDoc);
	int i;
	CSPRT *pSprt = &pDoc->m_sprt;
	double xsize, ysize;
	double dTemp;
	xsize = 10;
	if( m_iScrollSPRT > pDoc->m_iNo-1000 ) m_iScrollSPRT = pDoc->m_iNo - 1000;
	if( m_iScrollSPRT < 0 ) m_iScrollSPRT = 0;
	dTemp = pSprt->GetDeviation()*pSprt->GetDeviation()*(log( (1-pSprt->GetBeta()) / pSprt->GetAlpha() ) - log( pSprt->GetBeta() / (1-pSprt->GetAlpha()) )) / ( pDoc->m_cusum.GetK()*2 );
	ysize = 3000.0f/(dTemp);
	glBegin(GL_LINE_STRIP);
	glRGB(GetRValue(rgb1), GetGValue(rgb1), GetBValue(rgb1));
	for( i=m_iScrollSPRT ; i<pDoc->m_iNo-1 && i<m_iScrollSPRT+1000-1 ; i++ )
	{
		glVertex2f((float)((i-m_iScrollSPRT)*xsize),	(float)(Y_RANGE_MAX/2+pDoc->m_pData[i]->GetPlus()*ysize));
	}
	glEnd();

	glBegin(GL_LINE_STRIP);
	glRGB(GetRValue(rgb3), GetGValue(rgb3), GetBValue(rgb3));
	for( i=m_iScrollSPRT ; i<pDoc->m_iNo-1 && i<m_iScrollSPRT+1000-1 ; i++ )
	{
		glVertex2f((float)((i-m_iScrollSPRT)*xsize),	(float)(Y_RANGE_MAX/2+pDoc->m_pData[i]->GetMinus()*ysize));
	}
	glEnd();

	glBegin(GL_LINES);
	glRGB(GetRValue(rgb0), GetGValue(rgb0), GetBValue(rgb0));
	glVertex2f(0.0f,		Y_RANGE_MAX/2);
	glVertex2f(X_RANGE_MAX, Y_RANGE_MAX/2);
	for( i=-1 ; i < 12 ; i++ )
	{
		glVertex2f((float)((i*100-m_iScrollSPRT%100)*xsize),	Y_RANGE_MAX*0.49);
		glVertex2f((float)((i*100-m_iScrollSPRT%100)*xsize),	Y_RANGE_MAX*0.51);
	}
	
	glRGB(GetRValue(rgb6), GetGValue(rgb6), GetBValue(rgb6));
	glVertex2f(0,			Y_RANGE_MAX/5);
	glVertex2f(X_RANGE_MAX,	Y_RANGE_MAX/5);
	glVertex2f(0,			Y_RANGE_MAX*0.8);
	glVertex2f(X_RANGE_MAX,	Y_RANGE_MAX*0.8);

	glEnd();
	glPopMatrix();
	SwapBuffers(m_hDC);

	RECT rt;
	SetRect( &rt, 0, 0, m_rtClient.right, 30 );
	SetTextColor( m_hDC, rgb2 );
	DrawText( m_hDC, "Sequential Probability Ratio Test", 33, &rt, DT_LEFT );
	char cStr[32];
	ZeroMemory( cStr, sizeof(cStr) );
	i = m_iScrollSPRT-m_iScrollSPRT%1000+1000;
	wsprintf( cStr, "%d", i );
	SetTextColor( m_hDC, rgb0 );
	xsize = (i - m_iScrollSPRT)*m_rtClient.right/1000;
	SetRect( &rt, (int)(xsize)-100, (int)(m_rtClient.bottom*0.5), (int)(xsize)+100, (int)(m_rtClient.bottom) );
	DrawText( m_hDC, cStr, strlen(cStr), &rt, DT_CENTER );
}

void CFoulerView::Refresh()
{
	InvalidateRect( &m_rtClient, FALSE );
}

void CFoulerView::OnTimer(UINT nIDEvent) 
{
	if( nIDEvent == WM_USER+1004 )
	{
		CFoulerDoc* pDoc = GetDocument();
		ASSERT_VALID(pDoc);
		pDoc->OnTimer();
	}	
	CScrollView::OnTimer(nIDEvent);
}

BOOL CFoulerView::OnScroll(UINT nScrollCode, UINT nPos, BOOL bDoScroll) 
{
	int x = GetScrollPos(SB_HORZ);
	SCROLLINFO si;
	switch (LOBYTE(nScrollCode))
	{
	case SB_LINELEFT:
		x -= m_lineDev.cx;
		break;
	case SB_LINERIGHT:
		x += m_lineDev.cx;
		break;
	case SB_PAGELEFT:
		x -= m_pageDev.cx;
		break;
	case SB_PAGERIGHT:
		x += m_pageDev.cx;
		break;
	case SB_THUMBPOSITION:
		ZeroMemory(&si, sizeof(SCROLLINFO) );
		si.cbSize = sizeof(SCROLLINFO);
		si.fMask = SIF_TRACKPOS;
		GetScrollInfo( SB_HORZ, &si, SIF_TRACKPOS );
		x = si.nTrackPos;
		break;
	case SB_THUMBTRACK:
		ZeroMemory(&si, sizeof(SCROLLINFO) );
		si.cbSize = sizeof(SCROLLINFO);
		si.fMask = SIF_TRACKPOS;
		GetScrollInfo( SB_HORZ, &si, SIF_TRACKPOS );
		x = si.nTrackPos;
		break;
	case SB_LEFT:
		x = 0;
		break;
	case SB_RIGHT:
		x = INT_MAX;
		break;
	}
	if( x < 0 ) x = 0;
	SetScrollPos( SB_HORZ, x, bDoScroll );
	CFoulerDoc* pDoc = GetDocument();
	ASSERT_VALID(pDoc);
	if( pDoc->m_iViewMode == DEF_SHEWART ) m_iScrollShewart = x*500/m_iSizeX;
	if( pDoc->m_iViewMode == DEF_CUSUM ) m_iScrollCUSUM = x*1000/m_iSizeX;
	if( pDoc->m_iViewMode == DEF_SPRT ) m_iScrollSPRT = x*1000/m_iSizeX;
	InvalidateRect( &m_rtClient, FALSE );
	return TRUE;
}

void CFoulerView::OnMouseMove(UINT nFlags, CPoint point) 
{
	CString str;
	CMainFrame *pFrame = (CMainFrame*)AfxGetMainWnd();
	if( pFrame )
	{
		str.Format( "%d, %d", point.x, point.y );
		pFrame->m_wndStatusBar.SetPaneText( 1, str );
	}
	
	CScrollView::OnMouseMove(nFlags, point);
}

BOOL CFoulerView::OnMouseWheel(UINT nFlags, short zDelta, CPoint pt) 
{
	int iViewMode;
	CFoulerDoc* pDoc = GetDocument();
	ASSERT_VALID(pDoc);
	iViewMode = pDoc->m_iViewMode;
	if( zDelta < 0 ) iViewMode ++;
	else if( zDelta > 0 ) iViewMode --;
	else return CScrollView::OnMouseWheel(nFlags, zDelta, pt);
	pDoc->ChangeViewMode( iViewMode );
	return CScrollView::OnMouseWheel(nFlags, zDelta, pt);
}

BOOL CFoulerView::DestroyWindow() 
{
	KillTimer( WM_USER+1004 );
	wglDeleteContext(m_hRC);
	::ReleaseDC(m_hWnd,m_hDC);
	return CScrollView::DestroyWindow();
}

void CFoulerView::OnContextMenu(CWnd* pWnd, CPoint point) 
{
	int i;
	char cStr[64];
	double dAverage, dTemp;
	POINT pt;
	ZeroMemory( cStr, sizeof(cStr) );
	pt.x = point.x;
	pt.y = point.y;
	ScreenToClient( &pt );
	if( pt.y < m_iSizeY )
	{
		CMenu menu;
		CFoulerDoc* pDoc = GetDocument();
		ASSERT_VALID(pDoc);
		menu.CreatePopupMenu();
		dTemp = 0;
		if( pDoc->m_iNo > 0 )
		{
			for( i=0 ; i<pDoc->m_iNo ; i++ )
			{
				dTemp += pDoc->m_pData[i]->GetItem();
			}
			dAverage = dTemp / pDoc->m_iNo;
			dTemp = 0;
			for( i=0 ; i<pDoc->m_iNo ; i++ )
			{
				dTemp += (pDoc->m_pData[i]->GetItem()-dAverage)*(pDoc->m_pData[i]->GetItem()-dAverage);
			}
			dTemp = sqrt(dTemp / pDoc->m_iNo);
			sprintf( cStr, "Data Average : %f", dAverage );
			menu.AppendMenu( MF_STRING, 0, cStr );
			sprintf( cStr, "Data Deviation : %f", dTemp );
			menu.AppendMenu( MF_STRING, 0, cStr );
		}
		if( pDoc->m_bPlaying ) menu.AppendMenu( MF_STRING, ID_EDIT_PAUSE, "Pause" );
		else if( pDoc->m_generator.GetReady() )
		{
			menu.AppendMenu( MF_STRING, ID_EDIT_PLAY, "Play" );
		}
		if( !pDoc->m_bPlaying )
		{
			menu.AppendMenu( MF_STRING, ID_EDIT_NEWDATA, "Data Setup" );
			menu.AppendMenu( MF_STRING, ID_EDIT_ANALYSIS, "Analysis Setup" );
		}
		menu.AppendMenu( MF_SEPARATOR );
		menu.AppendMenu( MF_STRING, ID_VIEW_HISTOGRAM, "View Histogram" );
		menu.AppendMenu( MF_STRING, ID_VIEW_SHEWART, "View Shewart Chart" );
		menu.AppendMenu( MF_STRING, ID_VIEW_CUSUM, "View CUSUM Chart" );
		menu.AppendMenu( MF_STRING, ID_VIEW_SPRT, "View SPRT Chart" );
		menu.AppendMenu( MF_SEPARATOR );
		if( !pDoc->m_bPlaying )
		{
			sprintf( cStr, "Data No : %d", pDoc->m_iNo );
			menu.AppendMenu( MF_DISABLED, 0, cStr );
		}
		sprintf( cStr, "¥è¡£: %f", pDoc->m_sprt.GetTheta0() );
		menu.AppendMenu( MF_DISABLED, 0, cStr );
		sprintf( cStr, "¥ò : %f", pDoc->m_sprt.GetDeviation() );
		menu.AppendMenu( MF_DISABLED, 0, cStr );
		sprintf( cStr, "k : %f", pDoc->m_sprt.GetTheta1()-pDoc->m_sprt.GetTheta0() );
		menu.AppendMenu( MF_DISABLED, 0, cStr );
		sprintf( cStr, "h : %f", pDoc->m_cusum.GetH() );
		menu.AppendMenu( MF_DISABLED, 0, cStr );
		sprintf( cStr, "¥á : %f", pDoc->m_sprt.GetAlpha() );
		menu.AppendMenu( MF_DISABLED, 0, cStr );
		sprintf( cStr, "¥â : %f", pDoc->m_sprt.GetBeta() );
		menu.AppendMenu( MF_DISABLED, 0, cStr );
		sprintf( cStr, "x : %d, y : %d", pt.x, pt.y );
		menu.AppendMenu( MF_DISABLED, 0, cStr );

		SetForegroundWindow();
		menu.TrackPopupMenu( TPM_LEFTALIGN, point.x, point.y, this, NULL );
	}
	CScrollView::OnContextMenu(pWnd, point);
	Refresh();
}

void CFoulerView::OnViewChangefont() 
{
	long lHeight;
	CFontDialog dlg(m_plf);
	if( dlg.DoModal() == IDCANCEL ) return;
	if( m_hFont != NULL ) DeleteObject(m_hFont);
	if( m_plf != NULL ) delete m_plf;
	m_plf = new LOGFONT;
	lHeight = - m_iSizeX/40;
	dlg.GetCurrentFont(m_plf);
	if( m_plf->lfHeight < lHeight ) m_plf->lfHeight = lHeight;
	m_hFont = CreateFontIndirect( m_plf );
	Refresh();
}

void CFoulerView::OnFilePrintPreview() 
{
	// TODO: Add your command handler code here
	
}
