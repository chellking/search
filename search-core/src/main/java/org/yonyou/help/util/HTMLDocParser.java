package org.yonyou.help.util;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.io.UnsupportedEncodingException;
import org.apache.lucene.demo.html.HTMLParser;

public class HTMLDocParser {
	private String htmlPath;
	private String htmlParent;
	private HTMLParser htmlParser;

	public HTMLDocParser(String htmlPath) {
		this.htmlPath = htmlPath;
		initHtmlParser();
	}

	private void initHtmlParser() {
		InputStream inputStream = null;
		try {
			inputStream = new FileInputStream(this.htmlPath);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}
		if (inputStream != null)
			try {
				this.htmlParser = new HTMLParser(new InputStreamReader(inputStream, "UTF-8"));
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
	}

	public String getTitle() {
		if (this.htmlParser != null) {
			try {
				return this.htmlParser.getTitle();
			} catch (IOException e) {
				e.printStackTrace();
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
		return "";
	}

	public Reader getContent() {
		if (this.htmlParser != null) {
			try {
				return this.htmlParser.getReader();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return null;
	}

	public String getPath() {
		return this.htmlPath;
	}

	public String getParent() {
		return this.htmlParent;
	}
}
