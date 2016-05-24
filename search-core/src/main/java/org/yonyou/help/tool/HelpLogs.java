package org.yonyou.help.tool;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;

public class HelpLogs {
	/**
	 * 创建 文件
	 * 
	 * @param pathFileName
	 * @throws IOException
	 */
	public static void createFile(String pathFileName) throws IOException {
		File file = new File(pathFileName);
		if (!file.exists())
			file.createNewFile();
		System.out.println("创建文件：" + pathFileName);
	}

	public static void writerFile(String str2) {
		writerFile("help.log", str2);
	}

	public static void writerFile(String str1, String str2) {
		try {
			createFile(str1);
			FileWriter fw = new FileWriter(str1, true);
			fw.write(str2);
			fw.flush();
			fw.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
