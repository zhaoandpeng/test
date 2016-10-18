package com.cn.redsbubbles;

import java.util.ArrayList;

import com.sun.xml.internal.bind.v2.schemagen.xmlschema.List;

public abstract class JobDefault implements Target {

	public void speakChinese() {  
		
    }  
  
    public void speakEnglish() {  
          
    }  
  
    public void speakFrench() {  
          
    }  
  
    public void speakJapanese() {  
          
    }  
    
    public static void main(String[] args) {
		ArrayList list1 = new ArrayList();
		ArrayList list2 = new ArrayList();
		int arr[] = {1,2,3,4};
		for (int i = 0; i < arr.length; i++) {
			list1.add(arr[i]);
			list2.add(arr[i]);
		}
		System.out.println(list1.size());
		System.out.println(list2.size());
	}
}
