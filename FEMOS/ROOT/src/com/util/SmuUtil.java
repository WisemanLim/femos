package com.util;

public class SmuUtil 
{
	public static String getObjRoutePath(int arr_data[][],int start,int end) throws Exception 
	{		
		String route_path = "";
		int n = arr_data.length; //�迭�� �ִ����
		int m = 10000; //�ʹ� �־ �̵����� ���ϴ� �� (�ٸ����� ���� ����� ũ�� ��)
		int i,j,k=0;
		int s = start;
		int e = end;
		int min; 
		int [] v = new int[n];
		int [] distance = new int[n]; //�����Ÿ� �迭
		int [] via = new int[n];
		/*
		int [][] arr_data = {
								{0,200,m,m}, 		//1
								{200,0,242,320}, 	//2
								{m,242,0,141}, 		//3
								{m,320,141,0} 		//4
							};
		*/
		
							
		
		int [][] data = arr_data;
		//���� ��� ��Ʈ����
		/*
		int [][] data = {
							{0,2,m,m,m,3,m,m,2,1},
							{2,0,4,1,m,m,m,m,2,2},
							{m,4,0,m,3,m,m,m,2,m},
							{m,1,m,0,3,m,2,m,4,2},
							{m,m,3,3,0,m,m,4,6,4},
							{3,m,m,m,m,0,6,m,m,1},
							{m,m,m,2,m,6,0,4,7,2},
							{m,m,m,m,4,m,4,0,5,5},
							{m,4,m,m,2,m,4,2,m,m},
							{m,1,m,5,4,m,4,m,5,8}
						};	
		*/			
			
		
		for( j = 0; j < n; j++ ) 
		{			
			v[j] = 0;			
			distance[j] = m;		
		}				
		
		distance[s-1] = 0;				
		
		for( i=0; i < n; i++ ) 
		{			
			min = m;			
			for( j=0; j < n; j++ ) 
			{				
				if( v[j] == 0 && distance[j] < min ) 
				{					
					k = j;					
					min = distance[j];				
				}			
			}
			
			v[k] = 1;			
			
			if(min == m) break;						
			
			for(j = 0; j < n; j++) 
			{				
				if(distance[j] > distance[k] + data[k][j]) 
				{					
					distance[j] = distance[k] + data[k][j];					
					via[j] = k;				
				}			
			}		
		}		
		
		System.out.printf("\n %d���� ����Ͽ�, %d�� ���� �ִ� �Ÿ��� %d�Դϴ�.\n", s, e, distance[e-1]);	
		
		int path[] = new int[n];		
		int path_cnt = 0;				
		k = e-1;		
		while(true) 
		{			
			path[path_cnt++] = k;			
			if(k == s-1)break;			
			k = via[k];		
		}				
		
		System.out.print(" ��δ� : ");				
		
		for(i = path_cnt-1; i >= 1; i--) 
		{			
			System.out.printf("%d -> ",path[i]+1);	
			route_path += Integer.toString(path[i]+1)+"-";
		}				
		route_path += Integer.toString(path[i]+1);
		System.out.printf("%d�Դϴ�",path[i]+1);
		
		return route_path;
	}
}
