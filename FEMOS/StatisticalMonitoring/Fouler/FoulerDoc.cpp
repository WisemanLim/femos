// FoulerDoc.cpp : implementation of the CFoulerDoc class
//

#include "stdafx.h"
#include "Fouler.h"
#include "MainFrm.h"
#include "FoulerDoc.h"
#include "ProgressBar.h"
#include "FieldSelect.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CFoulerDoc

IMPLEMENT_DYNCREATE(CFoulerDoc, CDocument)

BEGIN_MESSAGE_MAP(CFoulerDoc, CDocument)
	//{{AFX_MSG_MAP(CFoulerDoc)
	ON_COMMAND(ID_EDIT_NEWDATA, OnEditNewdata)
	ON_COMMAND(ID_EDIT_PAUSE, OnEditPause)
	ON_COMMAND(ID_EDIT_PLAY, OnEditPlay)
	ON_UPDATE_COMMAND_UI(ID_EDIT_PAUSE, OnUpdateEditPause)
	ON_UPDATE_COMMAND_UI(ID_EDIT_PLAY, OnUpdateEditPlay)
	ON_COMMAND(ID_VIEW_CUSUM, OnViewCusum)
	ON_COMMAND(ID_VIEW_HISTOGRAM, OnViewHistogram)
	ON_COMMAND(ID_VIEW_SHEWART, OnViewShewart)
	ON_COMMAND(ID_VIEW_SPRT, OnViewSprt)
	ON_COMMAND(ID_FILE_OPEN, OnFileOpen)
	ON_COMMAND(ID_FILE_SAVE_AS, OnFileSaveAs)
	ON_COMMAND(ID_FILE_SAVE, OnFileSave)
	ON_UPDATE_COMMAND_UI(ID_FILE_SAVE, OnUpdateFileSave)
	ON_COMMAND(ID_EDIT_CLEAR_ALL, OnEditClearAll)
	ON_COMMAND(ID_EDIT_ANALYSIS, OnEditAnalysis)
	ON_UPDATE_COMMAND_UI(ID_FILE_SAVE_AS, OnUpdateFileSaveAs)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CFoulerDoc construction/destruction

CFoulerDoc::CFoulerDoc()
{
	m_dwTime = 0;
	m_pLeftView = NULL;
	m_pRightView = NULL;
	m_iViewMode = DEF_SPRT;
	m_bPlaying = FALSE;
	m_iSubGroupIndex = 0;
	m_dSpeed = 0;
	m_dIndex = 0;
	m_iSubGroupSize = 1;
	for( int i=0 ; i < DEF_MAX_DATASIZE ; i++ )
	{
		m_pData[i] = NULL;
		m_pOrgData[i] = NULL;
	}
	ClearData();
	m_bModified = FALSE;
}

CFoulerDoc::~CFoulerDoc()
{
	for( int i=0 ; i < DEF_MAX_DATASIZE ; i++ )
	{
		if( m_pOrgData[i] != NULL )
		{
			delete m_pOrgData[i];
			m_pOrgData[i] = NULL;
		}
		if( m_pData[i] != NULL )
		{
			delete m_pData[i];
			m_pData[i] = NULL;
		}
	}
}

BOOL CFoulerDoc::OnNewDocument()
{
	if (!CDocument::OnNewDocument()) return FALSE;
	return TRUE;
}

/////////////////////////////////////////////////////////////////////////////
// CFoulerDoc diagnostics

#ifdef _DEBUG
void CFoulerDoc::AssertValid() const
{
	CDocument::AssertValid();
}

void CFoulerDoc::Dump(CDumpContext& dc) const
{
	CDocument::Dump(dc);
}
#endif //_DEBUG

/////////////////////////////////////////////////////////////////////////////
// CFoulerDoc commands

void CFoulerDoc::SetLeftView( CLeftView *pView )
{
	m_pLeftView = pView;
}

void CFoulerDoc::SetRightView( CFoulerView *pView )
{
	m_pRightView = pView;
}

void CFoulerDoc::InsertData(int iNo)
{
	int i, iTo;
	iTo = (iNo+m_iSubGroupIndex)/m_iSubGroupSize;
	for( i=0 ; i<iNo ; i++ )
	{
		m_pOrgData[m_iOriginNo+i] = new CData;
	}
	m_iOriginNo += iNo;
	for( i=0 ; i< iTo ; i++ )
	{
		m_pData[m_iNo+i] = new CData;
	}
	m_iNo += iTo;
}

void CFoulerDoc::InsertOneData(double dData)
{
	int i;
	double dSum = 0;
	if( m_iOriginNo >= DEF_MAX_DATASIZE ) return;
	m_pOrgData[m_iOriginNo] = new CData;
	m_pOrgData[m_iOriginNo]->SetItem(dData);
	m_iOriginNo++;
	m_iSubGroupIndex++;
	if( m_iSubGroupIndex >= m_iSubGroupSize )
	{
		m_iSubGroupIndex = 0;
		for( i=m_iOriginNo-m_iSubGroupSize ; i<m_iOriginNo ; i++ )
		{
			dSum += m_pOrgData[i]->GetItem();
		}
		m_pData[m_iNo] = new CData;
		m_pData[m_iNo]->SetItem(dSum/m_iSubGroupSize);
		m_iNo++;
		AnalysisData();
		if( m_pLeftView != NULL ) m_pLeftView->Update();
	}
}

void CFoulerDoc::ClearData()
{
	int i;
	m_histogram.SetReady( FALSE );
	m_shewart.SetReady( FALSE );
	m_cusum.SetReady( FALSE );
	m_sprt.SetReady( FALSE );
	m_iNo = 0;
	m_iOriginNo = 0;
	m_iSubGroupIndex = 0;
	m_iSubGroupSize = 1;
	m_dIndex = 0;
	m_strPathName = _T("");
	m_strFileName = _T("");
	m_strFileTitle = _T("");
	m_strFileExt = _T("");
	for( i=0 ; i < DEF_HISTOGRAM_SIZE ; i++ )
	{
		m_iHistogram[i] = 0;
	}
	for( i=0 ; i < DEF_MAX_DATASIZE ; i++ )
	{
		if( m_pOrgData[i] != NULL )
		{
			delete m_pOrgData[i];
			m_pOrgData[i] = NULL;
		}
		if( m_pData[i] != NULL )
		{
			delete m_pData[i];
			m_pData[i] = NULL;
		}
	}
}

void CFoulerDoc::OnEditNewdata() 
{
	double dAverage=0, dDeviation=0, dMoveRate=0;
	int i=0, iNo = 0;
	char cStr[64];
	if( m_generator.GetReady() )
	{
		iNo = 0;
		dAverage = m_generator.GetAverage();
		dDeviation = m_generator.GetDeviation();
		dMoveRate = m_generator.GetMoveRate();
	}
	else
	{
		iNo = 0;
		dAverage = 0;
		dDeviation = 1;
		dMoveRate = 0;
	}
	CNewData dlg( dAverage, iNo, dDeviation, dMoveRate );
	if( dlg.DoModal() == IDCANCEL ) return;
	BeginWaitCursor();
	m_generator.SetReady(TRUE);
	m_generator.SetAverage(dlg.m_average);
	m_generator.SetDeviation(dlg.m_deviation);
	m_generator.SetGenMode(dlg.m_iGenMode);
	m_generator.SetMoveRate(dlg.m_moverate);
	CMainFrame *pFrame = (CMainFrame*)AfxGetMainWnd();
	ZeroMemory( cStr, sizeof(cStr) );
	sprintf( cStr, "%f", m_generator.GetAverage() );
	if( pFrame != NULL ) pFrame->m_edit.SetWindowText( cStr );
	m_dIndex += dlg.m_datano;
	CProgressBar* pBar = new CProgressBar();
	iNo = m_iNo;
	InsertData( dlg.m_datano );
	for( i=iNo ; i<m_iNo ; i++ )
	{
		m_pOrgData[i]->SetItem( m_generator.Gen() );
		m_iSubGroupIndex++;
		if( m_iSubGroupIndex >= m_iSubGroupSize )
		{
			m_iSubGroupIndex = 0;
			dAverage = 0;
			for( int j=i+1-m_iSubGroupSize ; j<i+1 ; j++ )
			{
				dAverage += m_pOrgData[j]->GetItem();
			}
			m_pData[i/m_iSubGroupSize]->SetItem(dAverage/m_iSubGroupSize);
			AnalysisData();
		}
		pBar->SetPos( ((i-iNo)<<8)/dlg.m_datano );
	}
	delete pBar;

	if( m_histogram.GetReady() == FALSE )
	{
		EndWaitCursor();
		OnEditAnalysis();
		BeginWaitCursor();
	}
	m_pRightView->Refresh();
	ChangeViewMode(m_iViewMode);
	EndWaitCursor();
}

void CFoulerDoc::AnalysisData()
{
	int i=0;
	double dPlus,dMinus;

	if( m_histogram.GetReady() )
	{
		if( m_pData[m_iNo-1]->GetItem() < m_histogram.GetTheta0()-5*m_histogram.GetDeviation() ) i = 0;
		else if( m_pData[m_iNo-1]->GetItem() > m_histogram.GetTheta0()+5*m_histogram.GetDeviation() ) i = DEF_HISTOGRAM_SIZE-1;
		else i = (int)( (m_pData[m_iNo-1]->GetItem()-m_histogram.GetTheta0())*DEF_HISTOGRAM_SIZE/10/m_histogram.GetDeviation() + DEF_HISTOGRAM_SIZE/2 );
		m_iHistogram[i]++;
		//Histogram계산용 도수분포

		if( m_iNo < 2 )
		{
			dPlus = 0;
			dMinus = 0;
		}
		else
		{
			dPlus = m_pData[m_iNo-2]->GetPlus();
			dMinus = m_pData[m_iNo-2]->GetMinus();
		}
		dPlus = m_pData[m_iNo-1]->GetItem() - m_cusum.GetK() - m_cusum.GetTheta0() + dPlus;
		if( dPlus < 0 ) dPlus = 0;
		m_pData[m_iNo-1]->SetPlus( dPlus );
		dMinus = m_pData[m_iNo-1]->GetItem() + m_cusum.GetK() - m_cusum.GetTheta0() + dMinus;
		if( dMinus > 0 ) dMinus = 0;
		m_pData[m_iNo-1]->SetMinus( dMinus );
		//CUSUM, SPRT계산용
	}
}

void CFoulerDoc::AnalysisWholeData()
{
	int i;
	int iTemp = 0;
	double dPlus = 0;
	double dMinus = 0;

	if( m_histogram.GetReady() )
	{
		for( i=0 ; i < DEF_HISTOGRAM_SIZE ; i++ )
		{
			m_iHistogram[i] = 0;
		}
		CProgressBar* pBar = new CProgressBar();
		for( i=0 ; i < m_iNo ; i++ )
		{
			if( m_pData[i]->GetItem() < m_histogram.GetTheta0()-5*m_histogram.GetDeviation() )
			{
				m_iHistogram[0] ++;
				continue;
			}
			else if( m_pData[i]->GetItem() > m_histogram.GetTheta0()+5*m_histogram.GetDeviation() )
			{
				m_iHistogram[DEF_HISTOGRAM_SIZE-1] ++;
				continue;
			}
			iTemp = (int)( (m_pData[i]->GetItem()-m_histogram.GetTheta0())*DEF_HISTOGRAM_SIZE/10/m_histogram.GetDeviation() + DEF_HISTOGRAM_SIZE/2 );
			m_iHistogram[iTemp]++;
			//Histogram계산용 도수분포
			dPlus = m_pData[i]->GetItem() - m_cusum.GetK() - m_cusum.GetTheta0() + dPlus;
			if( dPlus < 0 ) dPlus = 0;
			m_pData[i]->SetPlus( dPlus );
			dMinus = m_pData[i]->GetItem() + m_cusum.GetK() - m_cusum.GetTheta0() + dMinus;
			if( dMinus > 0 ) dMinus = 0;
			m_pData[i]->SetMinus( dMinus );
			//CUSUM, SPRT계산용
			pBar->SetPos( (i<<8)/m_iNo );
		}
		delete pBar;
	}
}

void CFoulerDoc::OnViewHistogram() 
{
	ChangeViewMode(DEF_HISTOGRAM);
}

void CFoulerDoc::OnViewShewart() 
{
	ChangeViewMode(DEF_SHEWART);
}

void CFoulerDoc::OnViewCusum() 
{
	ChangeViewMode(DEF_CUSUM);
}

void CFoulerDoc::OnViewSprt() 
{
	ChangeViewMode(DEF_SPRT);
}

void CFoulerDoc::ChangeViewMode(int iViewMode)
{
	m_iViewMode = (iViewMode+4)%4;
	CMainFrame *pFrame = (CMainFrame*)AfxGetMainWnd();
	if( pFrame == NULL ) return;
	if( m_pRightView == NULL ) return;
	pFrame->m_Combo.SetCurSel(m_iViewMode);
	if( m_sprt.GetReady() )
	{
		switch( m_iViewMode )
		{
		case DEF_HISTOGRAM:
			m_pRightView->SetScrollSizes( MM_TEXT, CSize(1, 1));
			break;
		case DEF_SHEWART:
			if( m_iNo > 500 ) m_pRightView->SetScrollSizes( MM_TEXT, CSize(m_pRightView->m_iSizeX*m_iNo/500, 1 ) );
			else
			{
				m_pRightView->SetScrollSizes( MM_TEXT, CSize(1, 1));
				m_pRightView->m_iScrollShewart = 0;
			}
			break;
		case DEF_CUSUM:
			if( m_iNo > 1000 ) m_pRightView->SetScrollSizes( MM_TEXT, CSize(m_pRightView->m_iSizeX*m_iNo/1000, 1 ) );
			else
			{
				m_pRightView->SetScrollSizes( MM_TEXT, CSize(1, 1));
				m_pRightView->m_iScrollCUSUM = 0;
			}
			break;
		case DEF_SPRT:
			if( m_iNo > 1000 ) m_pRightView->SetScrollSizes( MM_TEXT, CSize(m_pRightView->m_iSizeX*m_iNo/1000, 1 ) );
			else
			{
				m_pRightView->SetScrollSizes( MM_TEXT, CSize(1, 1));
				m_pRightView->m_iScrollSPRT = 0;
			}
			break;
		}
	}
	if( m_iNo > 0 && m_sprt.GetReady() == FALSE ) OnEditAnalysis();
	m_pRightView->Refresh();
}

void CFoulerDoc::OnEditPlay() 
{
	CString str;
	m_bPlaying = TRUE;
	CMainFrame *pFrame = (CMainFrame*)AfxGetMainWnd();
	pFrame->m_edit.GetWindowText( str );
	m_generator.SetAverage( atof( str ) );
	m_dIndex = m_iNo;
	pFrame->m_wndToolBar.SetButtonInfo(12, ID_EDIT_PAUSE, TBBS_BUTTON, 8);
}

void CFoulerDoc::OnUpdateEditPlay(CCmdUI* pCmdUI) 
{
	if( !m_bPlaying && m_generator.GetReady() ) pCmdUI->Enable();
	else pCmdUI->Enable(FALSE);
}

void CFoulerDoc::OnEditPause() 
{
	m_bPlaying = FALSE;
	m_pRightView->Refresh();
	CMainFrame *pFrame = (CMainFrame*)AfxGetMainWnd();
	pFrame->m_wndToolBar.SetButtonInfo(12, ID_EDIT_PLAY, TBBS_BUTTON, 7);
}

void CFoulerDoc::OnUpdateEditPause(CCmdUI* pCmdUI) 
{
	pCmdUI->Enable( m_bPlaying );
}

void CFoulerDoc::OnTimer()
{
	int i=0;
	DWORD dwTime;
	dwTime = timeGetTime();
	if( m_pLeftView != NULL ) m_pLeftView->Update();
	if( m_bPlaying == FALSE ) 
	{
		m_dwTime = dwTime;
		return;
	}
	if( m_generator.GetReady() )
	{
		m_dIndex += (dwTime-m_dwTime)*m_dSpeed;
		m_dwTime = dwTime;
	}
	if( (int)(m_dIndex) > m_iNo )
	{
		for( i=0 ; i < (int)(m_dIndex)-m_iNo ; i++ )
		{
			InsertOneData(m_generator.Gen());
		}
		if( m_pRightView != NULL )
		{
			if( m_iViewMode == DEF_SHEWART )
			{
				if( m_iNo > 500 )
				{
					m_pRightView->SetScrollSizes( MM_TEXT, CSize(m_pRightView->m_iSizeX*m_iNo/500, 1 ) );
					if( m_pRightView->m_iScrollShewart+500 >= m_iNo*0.8 )
					{
						m_pRightView->m_iScrollShewart = m_iNo-500;
						if( m_pRightView->m_iScrollShewart < 0 ) m_pRightView->m_iScrollShewart = 0;
						m_pRightView->SetScrollPos( 0, INT_MAX, TRUE );
					}
				}
			}
			if( m_iViewMode == DEF_CUSUM )
			{
				if( m_iNo > 1000 )
				{
					m_pRightView->SetScrollSizes( MM_TEXT, CSize(m_pRightView->m_iSizeX*m_iNo/1000, 1 ) );
					if( m_pRightView->m_iScrollCUSUM+1000 >= m_iNo*0.8 )
					{
						m_pRightView->m_iScrollCUSUM = m_iNo-1000;
						if( m_pRightView->m_iScrollCUSUM < 0 ) m_pRightView->m_iScrollCUSUM = 0;
						m_pRightView->SetScrollPos( 0, INT_MAX, TRUE );
					}
				}
			}
			if( m_iViewMode == DEF_SPRT )
			{
				if( m_iNo > 1000 )
				{
					m_pRightView->SetScrollSizes( MM_TEXT, CSize(m_pRightView->m_iSizeX*m_iNo/1000, 1 ) );
					if( m_pRightView->m_iScrollSPRT+1000 >= m_iNo*0.8 )
					{
						m_pRightView->m_iScrollSPRT = m_iNo-1000;
						if( m_pRightView->m_iScrollSPRT < 0 ) m_pRightView->m_iScrollSPRT = 0;
						m_pRightView->SetScrollPos( 0, INT_MAX, TRUE );
					}
				}
			}
		}
		if( m_pRightView != NULL )
		{
			m_pRightView->Refresh();
		}
	}
}

void CFoulerDoc::OnFileSaveAs() 
{
	HANDLE hFileWrite;
	CString pathname, fileext;
	pathname.Format( "*.cca" );
	CFileDialog dlg( FALSE, "cca", pathname, OFN_OVERWRITEPROMPT, "Control Chart Analyzer (*.cca)|*.cca|Text File (*.txt)|*.txt|", NULL );
	if( dlg.DoModal() != IDOK ) return;
	pathname = dlg.GetPathName();
	fileext = dlg.GetFileExt();
	fileext.MakeLower();
	if( fileext.Compare( "cca" ) == 0 )
	{
		hFileWrite = CreateFile(pathname, GENERIC_WRITE, NULL, NULL, CREATE_ALWAYS, NULL, NULL);
		if(hFileWrite == INVALID_HANDLE_VALUE)
		{
			MessageBox( NULL, "Couldn't save file", "Error", MB_OK );
			return;
		}
		if( SaveCCA(hFileWrite) )
		{
			m_strPathName = pathname;
			m_strFileExt = fileext;
			m_strFileName = dlg.GetFileName();
			m_strFileTitle = dlg.GetFileTitle();
			SetTitle( m_strFileName );
			m_bModified = FALSE;
		}
		else
		{
			MessageBox( NULL, "Couldn't save file", "Error", MB_OK );
		}
		CloseHandle( hFileWrite );
	}
	else if( fileext.Compare( "txt" ) == 0 )
	{
		hFileWrite = CreateFile(pathname, GENERIC_WRITE, NULL, NULL, CREATE_ALWAYS, NULL, NULL);
		if(hFileWrite == INVALID_HANDLE_VALUE)
		{
			MessageBox( NULL, "Couldn't save file", "Error", MB_OK );
			return;
		}
		if( SaveTXT(hFileWrite) )
		{
			m_strPathName = pathname;
			m_strFileExt = fileext;
			m_strFileName = dlg.GetFileName();
			m_strFileTitle = dlg.GetFileTitle();
			SetTitle( m_strFileName );
			m_bModified = FALSE;
		}
		else
		{
			MessageBox( NULL, "Couldn't save file", "Error", MB_OK );
		}
		CloseHandle( hFileWrite );
	}
	else return;
}

BOOL CFoulerDoc::SaveCCA(HANDLE hFileWrite)
{
	int i;
	double dData = 0;
	char cHeader[32], cStr[32];
	DWORD nCount;
	ZeroMemory( cHeader, sizeof(cHeader) );
	ZeroMemory( cStr, sizeof(cStr) );
	strcpy( cHeader, "Control Chart Analyzer File" );
	SetFilePointer( hFileWrite, 0, NULL, FILE_BEGIN);
	WriteFile( hFileWrite, cHeader, sizeof(cHeader), &nCount, NULL);
	WriteFile( hFileWrite, (char*)&m_iNo, sizeof(m_iNo), &nCount, NULL);
	WriteFile( hFileWrite, (char*)&m_histogram, sizeof(m_histogram), &nCount, NULL);
	WriteFile( hFileWrite, (char*)&m_shewart, sizeof(m_shewart), &nCount, NULL);
	WriteFile( hFileWrite, (char*)&m_cusum, sizeof(m_cusum), &nCount, NULL);
	WriteFile( hFileWrite, (char*)&m_sprt, sizeof(m_sprt), &nCount, NULL);
	for( i=0 ; i<m_iNo ; i++ )
	{
		dData = m_pData[i]->GetItem();
		WriteFile( hFileWrite, (char*)&dData, sizeof(dData), &nCount, NULL);
	}
	return TRUE;
}

BOOL CFoulerDoc::SaveTXT(HANDLE hFileWrite)
{
	int i;
	char cStr[32];
	DWORD nCount;
	SetFilePointer( hFileWrite, 0, NULL, FILE_BEGIN);
	for( i=0 ; i<m_iNo ; i++ )
	{
		ZeroMemory( cStr, sizeof(cStr) );
		sprintf( cStr, "%f\r\n", m_pData[i]->GetItem() );
		WriteFile( hFileWrite, cStr, strlen(cStr), &nCount, NULL);
	}
	return TRUE;
}

BOOL CFoulerDoc::OpenCCA(HANDLE hFileRead)
{
	char cHeader[32];
	double dData = 0;
	DWORD nCount;
	DWORD dwHighSize, dwLowSize;
	int i;
	ZeroMemory( cHeader, sizeof(cHeader) );
	dwLowSize = GetFileSize( hFileRead, &dwHighSize );
	SetFilePointer( hFileRead, 0, NULL, FILE_BEGIN);
	ReadFile( hFileRead, cHeader, 32, &nCount, NULL );
	if( strcmp( cHeader, "Control Chart Analyzer File" ) != 0 ) return FALSE;
	int itemno = 0;
	ReadFile( hFileRead, &itemno, sizeof(itemno), &nCount, NULL );
	if( itemno < 0 ) return FALSE;
	if( dwLowSize < itemno*sizeof(dData)+32+sizeof(itemno)+sizeof(m_histogram)+sizeof(m_shewart)+sizeof(m_cusum)+sizeof(m_sprt) ) return FALSE;
	ClearData();
	ReadFile( hFileRead, &m_histogram, sizeof(m_histogram), &nCount, NULL );
	ReadFile( hFileRead, &m_shewart, sizeof(m_shewart), &nCount, NULL );
	ReadFile( hFileRead, &m_cusum, sizeof(m_cusum), &nCount, NULL );
	ReadFile( hFileRead, &m_sprt, sizeof(m_sprt), &nCount, NULL );
	double* pData;
	pData = new double[itemno];
	ReadFile( hFileRead, pData, sizeof(dData)*itemno, &nCount, NULL );
	double *dp;
	dp = pData;
	CProgressBar* pBar = new CProgressBar();
	InsertData( itemno );
	for( i=0 ; i<itemno ; i++ )
	{
		m_pOrgData[i]->SetItem( *dp );
		m_iSubGroupIndex++;
		if( m_iSubGroupIndex >= m_iSubGroupSize )
		{
			m_iSubGroupIndex = 0;
			dData = 0;
			for( int j=i+1-m_iSubGroupSize ; j<i+1 ; j++ )
			{
				dData += m_pOrgData[j]->GetItem();
			}
			m_pData[i/m_iSubGroupSize]->SetItem(dData/m_iSubGroupSize);
			AnalysisData();
		}
		dp++;
		pBar->SetPos( (i<<8)/itemno );
	}
	delete[] pData;
	delete pBar;
	return TRUE;
}

BOOL CFoulerDoc::OpenTXT(HANDLE hFileRead)
{
	double dData = 0;
	DWORD nCount;
	DWORD dwSize, dwHighSize, dwLowSize;
	dwLowSize = GetFileSize( hFileRead, &dwHighSize );
	dwSize = dwLowSize;
	SetFilePointer( hFileRead, 0, NULL, FILE_BEGIN);
	char* cpTextData = new char[dwSize];
	ReadFile( hFileRead, cpTextData, dwSize, &nCount, NULL );
	ClearData();
	AddDataFromText( dwSize, cpTextData );
	delete[] cpTextData;
	return TRUE;
}

int CFoulerDoc::GetItemNo(char *pHeader)
{
	int iCount = 0;
	CString str;
	str = pHeader;
	char seps[] = "abcdfghijklmnopqrstuvwxyzABCDFGHIJKLMNOPQRSTUVWXYZ= ,\t\n:()";
	char *token;
	token = strtok( pHeader, seps );
	while( token!= NULL )
	{
		if( atof(token) != 0 ) iCount++;
		token = strtok( NULL, seps );
	}
	return iCount;
}

void CFoulerDoc::AddDataFromText(DWORD dwSize, char *pHeader)
{
	char seps[] = "abcdfghijklmnopqrstuvwxyzABCDFGHIJKLMNOPQRSTUVWXYZ= ,\t\n:()";
	char *token, *cpTextData;
	int i, iOrg, iData, itemno, iIndex;
	double dData;
	BeginWaitCursor();
	for (DWORD dw = 0; dw < dwSize; dw++)
	{
		if (pHeader[dw] == NULL) pHeader[dw] = ' ';
	}
	cpTextData = new char[dwSize];
	memcpy( cpTextData, pHeader, dwSize );
	itemno = GetItemNo( cpTextData );
	delete[] cpTextData;
	if( itemno < 1 ) return;
	CProgressBar* pBar = new CProgressBar();
	iData = m_iNo;
	iOrg = m_iOriginNo;
	InsertData( itemno );
	iIndex = 0;
	token = strtok( pHeader, seps );
	while( token!= NULL )
	{
		dData = atof(token);
		if( dData != 0 )
		{
			m_pOrgData[iOrg]->SetItem( dData );
			m_iSubGroupIndex++;
			if( m_iSubGroupIndex >= m_iSubGroupSize )
			{
				m_iSubGroupIndex = 0;
				dData = 0;
				for( i=iOrg+1-m_iSubGroupSize ; i<iOrg+1 ; i++ )
				{
					dData += m_pOrgData[i]->GetItem();
				}
				m_pData[iData]->SetItem(dData/m_iSubGroupSize);
				iData++;
				AnalysisData();
			}
			iOrg++;
			iIndex++;
			pBar->SetPos((iIndex<<8)/itemno);
		}
		token = strtok( NULL, seps );
	}
	delete pBar;
	EndWaitCursor();
}

void CFoulerDoc::OnFileOpen()
{
	HANDLE hFileRead;
	CString pathname, fileext;
	CString filter;
	CMainFrame *pFrame = (CMainFrame*)AfxGetMainWnd();
	if( pFrame->m_strExcelDriver.IsEmpty() ) filter.Format( "All Supported Files(*.cca; *.txt)|*.cca; *.txt|Control Chart Analyzer File(*.cca)|*.cca|Text File (*.txt)|*.txt|" );
	else filter.Format( "All Supported Files(*.cca; *.xls; *.txt)|*.cca; *.xls; *.txt|Control Chart Analyzer File(*.cca)|*.cca|Text File (*.txt)|*.txt|Microsoft Excel File (*.xls)|*.xls|" );
	CFileDialog dlg( TRUE, "*.cca", NULL, OFN_FILEMUSTEXIST, filter, NULL );
	if( dlg.DoModal() != IDOK ) return;
	pathname = dlg.GetPathName();
	fileext = dlg.GetFileExt();
	fileext.MakeLower();
	if( fileext.Compare( "cca" ) == 0 )
	{
		hFileRead = CreateFile(pathname, GENERIC_READ, NULL, NULL, OPEN_EXISTING, NULL, NULL);
		if (hFileRead == INVALID_HANDLE_VALUE)
		{
			MessageBox( NULL, "Selected file is in use.", "Can not open file", MB_OK );
			return;
		}
		BeginWaitCursor();
		if( OpenCCA(hFileRead) )
		{
			m_strPathName = pathname;
			m_strFileExt = fileext;
			m_strFileName = dlg.GetFileName();
			m_strFileTitle = dlg.GetFileTitle();
			SetTitle( m_strFileName );
			m_bModified = FALSE;
			m_pLeftView->Refresh();
			EndWaitCursor();
			if( m_histogram.GetReady() == FALSE ) OnEditAnalysis();
			BeginWaitCursor();
			m_pRightView->Refresh();
		}
		else
		{
			EndWaitCursor();
			MessageBox( NULL, "Selected file is not compatible format.", "Can not open file", MB_OK );
		}
		CloseHandle( hFileRead );
	}
	else if( fileext.Compare( "txt" ) == 0 )
	{
		hFileRead = CreateFile(pathname, GENERIC_READ, NULL, NULL, OPEN_EXISTING, NULL, NULL);
		if (hFileRead == INVALID_HANDLE_VALUE)
		{
			MessageBox( NULL, "Selected file is in use.", "Can not open file", MB_OK );
			return;
		}
		BeginWaitCursor();
		if( OpenTXT(hFileRead) )
		{
			m_strPathName = pathname;
			m_strFileExt = fileext;
			m_strFileName = dlg.GetFileName();
			m_strFileTitle = dlg.GetFileTitle();
			SetTitle( m_strFileName );
			m_bModified = FALSE;
			m_pLeftView->Refresh();
			EndWaitCursor();
			if( m_histogram.GetReady() == FALSE ) OnEditAnalysis();
			BeginWaitCursor();
			m_pRightView->Refresh();
		}
		else
		{
			EndWaitCursor();
			MessageBox( NULL, "Selected file is not compatible format.", "Can not open file", MB_OK );
		}
		CloseHandle( hFileRead );
	}
	else if( fileext.Compare( "xls" ) == 0 )
	{
		hFileRead = CreateFile(pathname, GENERIC_READ, NULL, NULL, OPEN_EXISTING, NULL, NULL);
		if (hFileRead == INVALID_HANDLE_VALUE)
		{
			MessageBox( NULL, "Selected file is in use.", "Can not open file", MB_OK );
			return;
		}
		CloseHandle( hFileRead );
		BeginWaitCursor();
		if( OpenXLS(pathname) )
		{
			m_strPathName = pathname;
			m_strFileExt = fileext;
			m_strFileName = dlg.GetFileName();
			m_strFileTitle = dlg.GetFileTitle();
			SetTitle( m_strFileName );
			m_bModified = FALSE;
			m_pLeftView->Refresh();
			EndWaitCursor();
			if( m_histogram.GetReady() == FALSE ) OnEditAnalysis();
			BeginWaitCursor();
			m_pRightView->Refresh();
		}
		else
		{
			EndWaitCursor();
			MessageBox( NULL, "Selected file is not compatible format.", "Can not open file", MB_OK );
		}
	}
	else return;
	EndWaitCursor();
}

void CFoulerDoc::OnFileSave() 
{
	HANDLE hFileWrite;
	if( m_iNo < 1 ) return;
	if( m_strPathName == "" || m_strFileName == "" || m_strFileTitle == "" || m_strFileExt == "" )
	{
		OnFileSaveAs();
		return;
	}
	if( m_strFileExt.Compare( "cca" ) == 0 )
	{
		hFileWrite = CreateFile(m_strPathName, GENERIC_WRITE, NULL, NULL, CREATE_ALWAYS, NULL, NULL);
		if(hFileWrite == INVALID_HANDLE_VALUE)
		{
			OnFileSaveAs();
			return;
		}
		if( SaveCCA(hFileWrite) )
		{
			SetTitle( m_strFileName );
			m_bModified = FALSE;
		}
		else
		{
			OnFileSaveAs();
		}
		CloseHandle( hFileWrite );
	}
	else if( m_strFileExt.Compare( "txt" ) == 0 )
	{
		hFileWrite = CreateFile(m_strPathName, GENERIC_WRITE, NULL, NULL, CREATE_ALWAYS, NULL, NULL);
		if(hFileWrite == INVALID_HANDLE_VALUE)
		{
			OnFileSaveAs();
			return;
		}
		if( SaveTXT(hFileWrite) )
		{
			SetTitle( m_strFileName );
			m_bModified = FALSE;
		}
		else
		{
			OnFileSaveAs();
		}
		CloseHandle( hFileWrite );
	}
	else OnFileSaveAs();
}

void CFoulerDoc::OnUpdateFileSave(CCmdUI* pCmdUI) 
{
	if( m_iNo > 0 ) pCmdUI->Enable();
	else pCmdUI->Enable(FALSE);
}

void CFoulerDoc::OnUpdateFileSaveAs(CCmdUI* pCmdUI) 
{
	if( m_iNo > 0 ) pCmdUI->Enable();
	else pCmdUI->Enable(FALSE);
}

void CFoulerDoc::OnEditClearAll() 
{
	BeginWaitCursor();
	ClearData();
	m_pLeftView->Refresh();
	m_pRightView->Refresh();
	EndWaitCursor();
}

void CFoulerDoc::OnEditAnalysis() 
{
	int i=0;
	double dTheta0=0, dDeviation=0, dH=0, dK=0, dAlpha=0.01, dBeta=0.03;
	if( m_histogram.GetReady() && m_shewart.GetReady() && m_cusum.GetReady() && m_sprt.GetReady() )
	{
		dTheta0 = m_sprt.GetTheta0();
		dDeviation = m_sprt.GetDeviation();
		dH = m_cusum.GetH();
		dK = m_sprt.GetTheta1() - m_sprt.GetTheta0();
		dAlpha = m_sprt.GetAlpha();
		dBeta = m_sprt.GetBeta();
	}
	else
	{
		if( m_iNo > 0 )
		{
			for( i=0 ; i < m_iNo ; i++ )
			{
				dTheta0 += m_pData[i]->GetItem();
			}
			dTheta0 = dTheta0/m_iNo;
		}
		else dTheta0 = 0;

		for( i=0 ; i < m_iNo ; i++ )
		{
			dDeviation += (m_pData[i]->GetItem()-dTheta0)*(m_pData[i]->GetItem()-dTheta0);
		}
		dDeviation = sqrt(dDeviation / m_iNo);
		if( dDeviation <=0 ) dDeviation = 1;
		dH = dDeviation * 8;
		dK = dDeviation;
	}
	CAnalysis dlg( m_iSubGroupSize, dAlpha, dBeta, dDeviation, dH, dK, dTheta0 );
	if( dlg.DoModal() == IDCANCEL ) return;
	m_histogram.SetReady( TRUE );
	m_shewart.SetReady( TRUE );
	m_cusum.SetReady( TRUE );
	m_sprt.SetReady( TRUE );

	m_histogram.SetTheta0(dlg.m_dTheta0);
	m_histogram.SetDeviation(dlg.m_dDeviation);
	m_shewart.SetTheta0(dlg.m_dTheta0);
	m_shewart.SetDeviation(dlg.m_dDeviation);
	m_cusum.SetTheta0(dlg.m_dTheta0);
	m_cusum.SetDeviation(dlg.m_dDeviation);
	m_cusum.SetH(dlg.m_dH);
	m_cusum.SetK(dlg.m_dK/2);
	m_sprt.SetTheta0(dlg.m_dTheta0);
	m_sprt.SetDeviation(dlg.m_dDeviation);
	m_sprt.SetTheta1(dlg.m_dTheta0+dlg.m_dK);
	m_sprt.SetAlpha(dlg.m_dAlpha);
	m_sprt.SetBeta(dlg.m_dBeta);

	BeginWaitCursor();
	if( m_iSubGroupSize != dlg.m_iSubGroupSize )
	{
		m_iSubGroupSize = dlg.m_iSubGroupSize;
		for( i=0 ; i < DEF_MAX_DATASIZE ; i++ )
		{
			if( m_pData[i] != NULL )
			{
				delete m_pData[i];
				m_pData[i] = NULL;
			}
		}
		m_iNo = 0;
		int j=0;
		for( i=0 ; i<m_iOriginNo/m_iSubGroupSize ; i++ )
		{
			dAlpha = 0;
			for( j=0 ; j<m_iSubGroupSize ; j++ )
			{
				dAlpha += m_pOrgData[i*m_iSubGroupSize+j]->GetItem();
			}
			m_pData[m_iNo] = new CData;
			m_pData[m_iNo]->SetItem(dAlpha/m_iSubGroupSize);
			m_iNo++;
		}
		AnalysisWholeData();
		m_pLeftView->Refresh();
	}
	else
	{
		AnalysisWholeData();
		m_pLeftView->UpdateIcon();
	}
	m_pRightView->Refresh();
	EndWaitCursor();
}

BOOL CFoulerDoc::OpenXLS(CString sFile)
{
	int i;
	double dData;
	CDatabase db;
	CString sSql;
	CString sItem;
	CString sDsn;
	CODBCFieldInfo fieldinfo;
	CMainFrame *pFrame = (CMainFrame*)AfxGetMainWnd();
	if( pFrame->m_strExcelDriver.IsEmpty() ) return FALSE;
	sDsn.Format("ODBC;DRIVER={%s};DSN='';DBQ=%s",pFrame->m_strExcelDriver,sFile);
	TRY
	{
		db.Open(NULL,FALSE,TRUE,sDsn);// Open the db using the former created pseudo DSN
		CRecordset rs( &db );// Allocate the recordset
		sSql = "SELECT * FROM Data";// Build the SQL string
		rs.Open(CRecordset::forwardOnly,sSql,CRecordset::readOnly);// Execute that query (implicitly by opening the recordset)
		CFieldSelect dlg(&rs);
		if( dlg.DoModal() == IDCANCEL )
		{
			rs.Close();
			db.Close();
			return FALSE;
		}
		BeginWaitCursor();
		while( !rs.IsEOF() ) rs.MoveNext();
		int iRecCount = (int)(rs.GetRecordCount());
		rs.Close();
		rs.Open(CRecordset::forwardOnly,sSql,CRecordset::readOnly);

		CProgressBar* pBar = new CProgressBar();
		ClearData();
		InsertData( iRecCount );
		for( i=0 ; i<iRecCount ; i++ )
		{
			rs.GetFieldValue(dlg.m_sField0,sItem);
			dData = atof(sItem)+dlg.m_dCo0;
			if( dlg.m_sField1 >= 0 && dlg.m_dCo1 != 0)
			{
				rs.GetFieldValue(dlg.m_sField1,sItem);
				dData += atof(sItem)*dlg.m_dCo1;
			}
			if( dlg.m_sField2 >= 0 && dlg.m_dCo2 != 0)
			{
				rs.GetFieldValue(dlg.m_sField2,sItem);
				dData += atof(sItem)*dlg.m_dCo2;
			}
			if( dlg.m_sField3 >= 0 && dlg.m_dCo3 != 0)
			{
				rs.GetFieldValue(dlg.m_sField3,sItem);
				dData += atof(sItem)*dlg.m_dCo3;
			}
			
			m_pOrgData[i]->SetItem( dData );
			m_iSubGroupIndex++;
			if( m_iSubGroupIndex >= m_iSubGroupSize )
			{
				m_iSubGroupIndex = 0;
				dData = 0;
				for( int j=i+1-m_iSubGroupSize ; j<i+1 ; j++ )
				{
					dData += m_pOrgData[j]->GetItem();
				}
				m_pData[i/m_iSubGroupSize]->SetItem(dData/m_iSubGroupSize);
			}
			rs.MoveNext();
			pBar->SetPos( (i<<8)/iRecCount );
		}
		delete pBar;
		rs.Close();
		db.Close();
		EndWaitCursor();
		return TRUE;
	}
	CATCH(CDBException, e)
	{
		return FALSE;// A db exception occured. Pop out the details...
	}
	END_CATCH;
}
