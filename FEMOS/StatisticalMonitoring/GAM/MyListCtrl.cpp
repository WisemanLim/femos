// MyListCtrl.cpp : implementation file
//

#include "stdafx.h"
#include "GAM.h"
#include "MyListCtrl.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CMyListCtrl

CMyListCtrl::CMyListCtrl()
{
	m_subitem = 0;
    m_nColumnCount  = 1;
    m_colorTextOdd  = RGB( 26,  73, 116);
    m_colorBackOdd  = RGB(226, 237, 246);
    m_colorTextEven = RGB( 91,  92,   0);
    m_colorBackEven = RGB(254, 253, 246);
    m_colorTextHighlight = RGB(255, 255, 255);
    m_colorBackHighlight = RGB(104, 84, 138);
	EnableToolTips(TRUE);
}

CMyListCtrl::~CMyListCtrl()
{
}

BEGIN_MESSAGE_MAP(CMyListCtrl, CListCtrl)
	//{{AFX_MSG_MAP(CMyListCtrl)
	ON_NOTIFY_REFLECT(LVN_ENDLABELEDIT, OnEndlabeledit)
	ON_WM_LBUTTONUP()
	ON_WM_PAINT()
	//}}AFX_MSG_MAP
    ON_NOTIFY_EX_RANGE(TTN_NEEDTEXTW, 0, 0xFFFF, OnToolTipText)
    ON_NOTIFY_EX_RANGE(TTN_NEEDTEXTA, 0, 0xFFFF, OnToolTipText)
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CMyListCtrl message handlers

void CMyListCtrl::OnEndlabeledit(NMHDR* pNMHDR, LRESULT* pResult) 
{
	LV_DISPINFO  *plvDispInfo = (LV_DISPINFO *)pNMHDR;
	LV_ITEM      *plvItem = &plvDispInfo->item;

	if (plvItem->pszText != NULL)
		SetItemText(plvItem->iItem, plvItem->iSubItem, plvItem->pszText);
//	*pResult = 0;
}

void CMyListCtrl::OnLButtonUp(UINT nFlags, CPoint point) 
{
	LVHITTESTINFO	lvhit;
	lvhit.pt = point;
	int item = SubItemHitTest(&lvhit);

	//if (over a subitem)
	if (item != -1 && lvhit.iSubItem && (lvhit.flags & LVHT_ONITEM ))
	{
		//mouse click outside the editbox in an allready editing cell cancels editing
		if (m_subitem == lvhit.iSubItem && item == m_item)
		{
			CListCtrl::OnLButtonUp(nFlags, point);
		}
		else
		{
			CListCtrl::OnLButtonUp(nFlags, point);
			m_subitem = lvhit.iSubItem;
			m_item = item;
			EditLabel(item);
		}
	}
	else CListCtrl::OnLButtonUp(nFlags, point);
}

void CMyListCtrl::OnPaint() 
{
    Default();
}

void CMyListCtrl::SetToolTips(BOOL bEnable)
{
    EnableToolTips(bEnable);
}

int CMyListCtrl::OnToolHitTest(CPoint point, TOOLINFO *pTI) const
{
    int nRow = -1, nCol = 1;
    CRect rcCell(1, 1, 1, 1);
    nRow = GetRowFromPoint(point, &rcCell, &nCol);
    if(nRow == -1) return -1;
    pTI->hwnd     = m_hWnd;
    pTI->uId      = (UINT)((nRow << 10) + (nCol & 0x3ff) + 1);
    pTI->lpszText = LPSTR_TEXTCALLBACK;
    pTI->rect     = rcCell;
    return pTI->uId;
}

BOOL CMyListCtrl::OnToolTipText(UINT id, NMHDR *pNMHDR, LRESULT *pResult)
{
    // 메시지의 ANSI 와 UNICODE 버전의 핸들이 필요함
    TOOLTIPTEXTA* pTTTA = (TOOLTIPTEXTA*)pNMHDR;
    TOOLTIPTEXTW* pTTTW = (TOOLTIPTEXTW*)pNMHDR;
    CString strTipText;
    UINT nID = pNMHDR->idFrom;

    if(nID == 0) return FALSE; // 툴팁이 생성되었음

    int nRow   = ((nID-1) >> 10) & 0x3fffff;
    int nCol   = (nID-1) & 0x3ff;
    strTipText = GetItemText(nRow, nCol);

#ifndef _UNICODE
    if(pNMHDR->code == TTN_NEEDTEXTA)
        lstrcpyn(pTTTA->szText, strTipText, MAX_PATH);
    else
        _mbstowcsz(pTTTW->szText, strTipText, MAX_PATH);
#else
    if(pNMHDR->code == TTN_NEEDTEXTA)
        _wcstombsz(pTTTA->szText, strTipText, MAX_PATH);
    else
        lstrcpyn(pTTTW->szText, strTipText, MAX_PATH);
#endif

    *pResult = 0;

    return TRUE;
}

int CMyListCtrl::GetRowFromPoint(CPoint &point, CRect *rcCell, int *nCol) const
{
	int   nColumn, nRow, nBottom, nWidth;
    CRect rcItem, rcClient;

	// ListCtrl이 LVS_REPORT 타입인 지 확인
	if((GetWindowLong(m_hWnd, GWL_STYLE) & LVS_TYPEMASK) != LVS_REPORT) return -1;

	// 눈에 보이는 처음과 끝의 Row 값을 얻는다
	nRow    = GetTopIndex();
	nBottom = nRow + GetCountPerPage();
	if(nBottom > GetItemCount())
		nBottom = GetItemCount();

    // 보이는 Row만큼 루프를 돈다
	for(; nRow <= nBottom ; nRow++)
	{
		GetItemRect(nRow, &rcItem, LVIR_BOUNDS);
		if(rcItem.PtInRect(point))
		{
			// Column을 찾는다
			for(nColumn = 0 ; nColumn < m_nColumnCount ; nColumn++)
			{
				nWidth = GetColumnWidth(nColumn);
				if(point.x >= rcItem.left && 
                   point.x <= (rcItem.left + nWidth))
				{
					GetClientRect(&rcClient);
					if(nCol)
                        *nCol = nColumn;
					rcItem.right = rcItem.left + nWidth;

					// 오른쪽 끝이 클라이언트 영역을 벗어나지 않게
					if(rcItem.right > rcClient.right) 
						rcItem.right = rcClient.right;
					*rcCell = rcItem;
					return nRow;
				}
				rcItem.left += nWidth;
			}
		}
	}
	return -1;
}

void CMyListCtrl::DrawItem(LPDRAWITEMSTRUCT lpDrawItemStruct)
{
    int     nItem = lpDrawItemStruct->itemID, nOffset;
    CDC     *pDC = CDC::FromHandle(lpDrawItemStruct->hDC);
    CRect   rcItem(lpDrawItemStruct->rcItem), rcHighlight;
    CRect   rcBounds, rcLabel, rcIcon, rcSub, rcColumn;
    BOOL    bHighlight;
    CString strLabel;
    CImageList* pImageList;

    // DC 상태 저장
    int     nSavedDC = pDC->SaveDC();
    UINT    nJustify;
    CBrush  brush;

    LV_ITEM lvi;
    lvi.mask      = LVIF_IMAGE | LVIF_STATE;
    lvi.iItem     = nItem;
    lvi.iSubItem  = 0;
    lvi.stateMask = 0xFFFF;
    GetItem(&lvi);

    // 아이템의 선택여부 조사
    bHighlight =((lvi.state & LVIS_DROPHILITED) ||
                 ((lvi.state & LVIS_SELECTED) &&
                 ((GetFocus() == this) ||
                 (GetStyle() & LVS_SHOWSELALWAYS))));

    // 그릴 영역을 구함
    GetItemRect(nItem, rcBounds, LVIR_BOUNDS);
    GetItemRect(nItem, rcLabel,  LVIR_LABEL);
    GetItemRect(nItem, rcIcon,   LVIR_ICON);
    rcColumn = rcBounds;

    strLabel = GetItemText(nItem, 0);
    nOffset  = (pDC->GetTextExtent(_T(" "), 1).cx) << 1;
    rcHighlight      = rcBounds;
    rcHighlight.left = rcLabel.left;

    // Background를 그린다
    pDC->SetBkMode(TRANSPARENT);
    if(bHighlight)
    {
        brush.CreateSolidBrush(m_colorBackHighlight);
        pDC->SetTextColor(m_colorTextHighlight);
        pDC->FillRect(rcHighlight, &brush);
    }
    else
    {
        brush.CreateSolidBrush(nItem % 2 ? m_colorBackOdd : m_colorBackEven);
        pDC->FillRect(rcBounds, &brush);
    }
    if(brush.m_hObject)
        brush.DeleteObject();

    rcColumn.right = rcColumn.left + GetColumnWidth(0);

    // State Icon을 그린다
    if(lvi.state & LVIS_STATEIMAGEMASK)
    {
        int nImage = ((lvi.state & LVIS_STATEIMAGEMASK) >> 12) - 1;
        pImageList = GetImageList(LVSIL_STATE);
        if(pImageList)
        {
            pImageList->Draw(pDC, nImage, CPoint(rcColumn.left, rcColumn.top), 
                             ILD_TRANSPARENT);
        }
    }
    
    // Normal과 Overlay Icon을 그린다
    pImageList = GetImageList(LVSIL_SMALL);
    if(pImageList)
    {
        pImageList->Draw(pDC, lvi.iImage, CPoint(rcIcon.left, rcIcon.top),
                         (bHighlight ? ILD_BLEND50 : 0) | ILD_TRANSPARENT |
                         (lvi.state & LVIS_OVERLAYMASK));
    }
    
    rcLabel.left  += (nOffset >> 1);
    rcLabel.right -= nOffset;

    if(bHighlight)
        pDC->SetTextColor(RGB(255, 255, 255));
    else
        pDC->SetTextColor(nItem % 2 ? m_colorTextOdd : m_colorTextEven);

    // 첫 번째 Column의 텍스트 출력
    pDC->DrawText(strLabel, strLabel.GetLength(), rcLabel, DT_SINGLELINE | 
                  DT_NOPREFIX | DT_NOCLIP | DT_VCENTER | DT_END_ELLIPSIS |
                  DT_WORDBREAK);


    // SubItem의 텍스트 출력
    LV_COLUMN lvc;
    lvc.mask = LVCF_FMT | LVCF_WIDTH;

    for(int i = 1 ; i < m_nColumnCount ; i++)
    {
        // 문자의 정렬상태를 구함
        GetColumn(i, &lvc);
        switch(lvc.fmt & LVCFMT_JUSTIFYMASK)
        {
        case LVCFMT_RIGHT:
            nJustify = DT_RIGHT;
            break;
        case LVCFMT_CENTER:
            nJustify = DT_CENTER;
            break;
        default:
            nJustify = DT_LEFT;
            break;
        }

        strLabel = GetItemText(nItem, i);
        GetSubItemRect(nItem, i, LVIR_LABEL, rcSub);
        rcSub.DeflateRect(nOffset, 0, nOffset, 0);
        pDC->DrawText(strLabel, strLabel.GetLength(), rcSub, nJustify | DT_SINGLELINE | DT_NOPREFIX | DT_VCENTER | DT_END_ELLIPSIS);
    }

    // 아이템이 포커스를 가지고 있으면 포커스 영역을 그린다
    if(lvi.state & LVIS_FOCUSED && (GetFocus() == this)) pDC->DrawFocusRect(rcHighlight);
    // DC를 복원시킨다
    pDC->RestoreDC(nSavedDC);
}

