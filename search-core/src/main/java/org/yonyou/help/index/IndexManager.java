package org.yonyou.help.index;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.Reader;

import org.yonyou.help.util.HTMLDocParser;

import org.apache.lucene.analysis.Analyzer;
import org.apache.lucene.document.Document;
import org.apache.lucene.document.Field;
import org.apache.lucene.index.CorruptIndexException;
import org.apache.lucene.index.IndexReader;
import org.apache.lucene.index.IndexWriter;
import org.apache.lucene.index.IndexWriterConfig;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.FSDirectory;
import org.apache.lucene.util.Version;
import org.wltea.analyzer.lucene.IKAnalyzer;

public class IndexManager {
	/** 数据-文件夹 **/
	private String dataDir;
	/** 索引-文件夹 **/
	private String indexDir;

	public IndexManager(String langcode) {
		// TODO
		this.dataDir = ("F:\\nchome\\uap65_riafornc_20151019\\hotwebs\\help\\simpchn\\G0");
		this.indexDir = ("F:\\index-help\\help");
	}

	public boolean createIndex() throws IOException {
		if (ifIndexExist()) {
			return true;
		}

		//数据源
		File dataDir = new File(this.dataDir);
		if (!dataDir.exists()) {
			return false;
		}
		//目标索引
		File indexDir = new File(this.indexDir);
//		if (!indexDir.exists()) {
//			return false;
//		}
		Directory fsDirectory = FSDirectory.open(indexDir);
		
		Analyzer analyzer = new IKAnalyzer();
		IndexWriterConfig iwc = new IndexWriterConfig(Version.LUCENE_31, analyzer);
		IndexWriter indexWriter = new IndexWriter(fsDirectory, iwc);
		searchfiles(dataDir.getAbsolutePath(), indexWriter);

		indexWriter.optimize();
		indexWriter.close();
		fsDirectory.close();
		return true;
	}

	private void searchfiles(String sdir, IndexWriter indexWriter) throws CorruptIndexException, IOException {
		File dir = new File(sdir);

		if (!dir.exists()) {
			return;
		}
		File[] htmls = dir.listFiles();
		for (int i = 0; i < htmls.length; i++) {
			String htmlPath = htmls[i].getAbsolutePath();
			if (htmls[i].isDirectory()) {
				searchfiles(htmlPath, indexWriter);
			} else if ((htmlPath.endsWith(".html")) || (htmlPath.endsWith(".htm")))
				addDocument(htmlPath, indexWriter);
		}
	}

	public void addDocument(String htmlPath, IndexWriter indexWriter) {
		HTMLDocParser htmlParser = new HTMLDocParser(htmlPath);
		String path = htmlParser.getPath();
		// 获取文件父目录
		String ParentPath = new File(path).getParent();
		int i = ParentPath.lastIndexOf("\\");
		if (ParentPath.length() > i) {
			ParentPath = ParentPath.substring(i + 1, i + 3);
			if ((ParentPath.equals("si")) || (ParentPath.equals("tr")) || (ParentPath.equals("fr")) || (ParentPath.equals("en")))
				ParentPath = "";
		} else {
			ParentPath = "";
		}
		// 获取文件路径名
		path = new File(path).getName();
		// 获取html标签内容
		String title = htmlParser.getTitle();
		// 获取html内容
		Reader content = htmlParser.getContent();
		StringBuffer sb = new StringBuffer();
		BufferedReader bufReader = null;
		String str = null;
		try {
			bufReader = new BufferedReader(content);
			while ((str = bufReader.readLine()) != null) {
				sb.append(str);
			}
			bufReader.close();
			content.close();
			Document document = new Document();
			// 增加文件路径名
			document.add(new Field("path", path, Field.Store.YES, Field.Index.NO));
			// 增加html标签内容
			document.add(new Field("title", title, Field.Store.YES, Field.Index.ANALYZED_NO_NORMS));
			// 增加html内容
			document.add(new Field("content", sb.toString(), Field.Store.YES, Field.Index.ANALYZED_NO_NORMS));
			// 增加文件父目录
			document.add(new Field("parent", ParentPath, Field.Store.YES, Field.Index.ANALYZED_NO_NORMS));
			indexWriter.addDocument(document);


		} catch (IOException e) {
			e.printStackTrace();

			if (bufReader != null)
				try {
					bufReader.close();
				} catch (IOException localIOException1) {
				}
			if (content != null)
				try {
					content.close();
				} catch (IOException localIOException2) {
				}
		} finally {
			if (bufReader != null)
				try {
					bufReader.close();
				} catch (IOException localIOException3) {
				}
			if (content != null)
				try {
					content.close();
				} catch (IOException localIOException4) {
				}
		}
	}

	public boolean ifIndexExist() {
		try {
			Directory dir = FSDirectory.open(new File(getIndexDir()));
			if (IndexReader.indexExists(dir)) {
				return true;
			}
			return false;
		} catch (IOException ioEx) {
		}
		return false;
	}

	public String getDataDir() {
		return this.dataDir;
	}

	public String getIndexDir() {
		return this.indexDir;
	}
}
