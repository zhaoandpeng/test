package com.cn.redsbubbles;

import java.io.File;
import java.nio.file.FileSystems;
import java.nio.file.Paths;
import java.nio.file.StandardWatchEventKinds;
import java.nio.file.WatchEvent;
import java.nio.file.WatchKey;
import java.nio.file.WatchService;
import java.util.LinkedList;

public class WatchFile {
	
	public static void main(String[] args) 
            throws Exception{

        String filePath = ("C:\\ZHAOPENG");
        
        WatchService watchService = FileSystems.getDefault().newWatchService();
        Paths.get(filePath).register(watchService 
                , StandardWatchEventKinds.ENTRY_CREATE
                , StandardWatchEventKinds.ENTRY_MODIFY
                , StandardWatchEventKinds.ENTRY_DELETE);

        File file = new File(filePath);
        LinkedList<File> fList = new LinkedList<File>();
        fList.addLast(file);
        while (fList.size() > 0 ) {
            File f = fList.removeFirst();
            if(f.listFiles() == null)
                continue;
            for(File file2 : f.listFiles()){
                    if (file2.isDirectory()){//��һ��Ŀ¼
                    fList.addLast(file2);
                    //
                    Paths.get(file2.getAbsolutePath()).register(watchService 
                            , StandardWatchEventKinds.ENTRY_CREATE
                            , StandardWatchEventKinds.ENTRY_MODIFY
                            , StandardWatchEventKinds.ENTRY_DELETE);
                }
            }
        }

        while(true)
        {
            //
            WatchKey key = watchService.take();
            for (WatchEvent<?> event : key.pollEvents()) 
            {
                System.out.println(event.context() +" --> " + event.kind());
            }
            //
            boolean valid = key.reset();
            //
            if (!valid) 
            {
                break;
            }
        }
    }
}
