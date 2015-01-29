package com.util;

public class PagingUtil {
	
	public static String Paging_post(int intPage,int intPageSize,int intTotalCnt)
	{
		int intPageBlockSize = 10;
	
		int intPageCnt = (intTotalCnt-1) / intPageSize + 1;
		
		String script = "";
		
		if(intTotalCnt == 0) 
		{
			intPage = 1;
			intPageCnt = 1;
		}
		
		int intPageStart = ((intPage - 1) / intPageBlockSize) * intPageBlockSize + 1;
		int intPageEnd = ((intPage - 1) / intPageBlockSize) * intPageBlockSize + intPageBlockSize;
		
		String strPaging = "";

		if( intPage > intPageBlockSize ) {
			script = "goPage("+(intPageStart - intPageBlockSize)+")";
			strPaging += "<a href='javascript:"+script+"'><img src='../images/btn_previous.gif' alt='' style='vertical-align:bottom;' /></a>";
		}
		else {
			strPaging += "<img src='../images/btn_previous.gif' alt='' style='vertical-align:bottom;' />";
		}

		if( intPageEnd > intPageCnt)
			intPageEnd = intPageCnt;

		for( int i=intPageStart;i<=intPageEnd;i++) {
			if( i==intPage )
			{
				strPaging += "<a href='#' class='on' style='padding:4px 4px 0 4px'><span style='color:#fff;'><strong>["+i+"]</strong></span></a>";
			}
			else
			{
				script = "goPage("+i+")";
				strPaging += "<a href='javascript:"+script+"' style='padding:4px 4px 0 4px'>["+i+"]</a>";
			}
		}

		if( intPage  < intPageCnt && intPageEnd < intPageCnt ) {
			script = "goPage("+(intPageStart + intPageBlockSize)+")";
			strPaging += "<a href='javascript:"+script+"'><img src='../images/btn_next.gif' alt='' style='vertical-align:bottom;' /></a>";
		}
		else {
			strPaging += "<img src='../images/btn_next.gif' alt='' style='vertical-align:bottom;' />";
		}
		return strPaging;
	}
}
