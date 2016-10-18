package com.cn.redsbubbles;

import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.catalina.tribes.util.Arrays;

//适配器模式
public class JobImpl extends JobDefault{

	public static void main(String[] args) {
		
//		String str = "dfafds3442dfsaf3dsafd";
//		String result = str.replaceAll("\\d+", "");
//		System.out.println(result);
		
		
		String str = "过夜<haokan>0哈何苦<haokan>1去我儿<haokan>2<list>[/storage/emulated/0/portal/common/images/bfbe29258a3b492ca8d03e1533a1de01.png, /storage/emulated/0/portal/common/images/c53f29c6e9d64ed68ec93cc3bb06cc38.png, /storage/emulated/0/portal/common/images/b0c454a080d047289c5ed79c570c1a89.png]";
		
		String[] arr = str.split("\\[");
		
		for (int i = 0; i < arr.length; i++) {
			if(i==0){
				String ar = arr[0];
				
				List<String> digitList = new ArrayList<String>();
				
				Pattern p = Pattern.compile("[^0-9]");
				
				Matcher m = p.matcher(ar);
				
				String result = m.replaceAll("");
				
				for (int j = 0; j < result.length(); j++) {
					
					digitList.add(result.substring(j, j+1));

				}
				System.out.println(digitList);
				
				String[] ab = arr[0].replaceAll("\\d+", "").split("<haokan>");
				
				List ls = new ArrayList();
				
				for (int j = 0; j < ab.length; j++) {
					if(j!=ab.length-1){
						ls.add(ab[j]);
					}
				}
				System.out.println(ls);
			}
			if(i==1){
				String arb = "["+arr[1];
				String[] att = arb.split(",");
				for (int j = 0; j < att.length; j++) {
					if(j==0){
						System.out.println("第"+j+"张图片"+att[j].substring(1, att[j].length()));
					}else if(j==att.length-1){
						System.out.println("第"+j+"张图片"+att[j].substring(1, att[j].length()-1));
					}else{
						System.out.println("第"+j+"张图片"+att[j]);
					}
				}
			}
		
		}
			
		

		
//		String[] arr = str.split("\\[");
//		String ar ;
//		for (int i = 0; i < arr.length; i++) {
//			System.out.println(arr[i]);
//			if(i==1){
//				ar = "["+arr[1];
//				System.out.println(ar);
//			}
//			if(i==0){
//				String[] arr2 = arr[0].split("<haokan>");
//				for (int j = 0; j < arr2.length; j++) {
//					System.out.println("-----------"+arr2[j]);
//				}
//			}
//			
//		}
	}
	
	
}
