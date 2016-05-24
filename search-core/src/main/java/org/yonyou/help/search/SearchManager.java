package org.yonyou.help.search;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.yonyou.help.index.IndexManager;
import org.yonyou.help.tool.HelpLogs;

import org.apache.lucene.analysis.Analyzer;
import org.apache.lucene.document.Document;
import org.apache.lucene.search.IndexSearcher;
import org.apache.lucene.search.Query;
import org.apache.lucene.search.ScoreDoc;
import org.apache.lucene.search.TopDocs;
import org.apache.lucene.search.highlight.Highlighter;
import org.apache.lucene.search.highlight.InvalidTokenOffsetsException;
import org.apache.lucene.search.highlight.QueryScorer;
import org.apache.lucene.search.highlight.SimpleHTMLFormatter;
import org.apache.lucene.store.FSDirectory;
import org.wltea.analyzer.lucene.IKAnalyzer;
import org.wltea.analyzer.lucene.IKQueryParser;
import org.wltea.analyzer.lucene.IKSimilarity;

public class SearchManager {
	private String searchWord;
	private IndexManager indexManager;
	private Analyzer analyzer;
	private String prefixHTML = "<font color='red'>";
	private String suffixHTML = "</font>";

	public SearchManager(String searchWord, String langcode) {
		this.searchWord = searchWord;
		this.indexManager = new IndexManager(langcode);
		this.analyzer = new IKAnalyzer();
	}

	public List search(int start) {
		List searchResult = new ArrayList();
		//创建索引
		if (!this.indexManager.ifIndexExist()) {
			try {
				if (!this.indexManager.createIndex())
					return searchResult;
			} catch (IOException e) {
				e.printStackTrace();
				HelpLogs.writerFile("\n search()==" + e.getMessage());
				return searchResult;
			}
		}

		//打开索引文件
		IndexSearcher searcher = null;
		try {
			searcher = new IndexSearcher(FSDirectory.open(new File(this.indexManager.getIndexDir())));
		} catch (IOException ioe) {
			ioe.printStackTrace();
			HelpLogs.writerFile("IndexSearcher()==" + ioe.getMessage());

		}

		searcher.setSimilarity(new IKSimilarity());

		Query query = null;
		try {
			String[] fields = { "title", "content" };
			query = IKQueryParser.parseMultiField(fields, this.searchWord);
		} catch (IOException e) {
			e.printStackTrace();
			HelpLogs.writerFile("IKQueryParser.parseMultiField()==" + e.getMessage());
		}
		if ((query != null) && (searcher != null)) {
			try {
				int hitsPerPage = 10;
				TopDocs results = searcher.search(query, 10000);
				ScoreDoc[] hits = results.scoreDocs;
				if(hits == null || hits.length<=0 ) return searchResult;
				int i = start;
				do {
					Document doc = searcher.doc(hits[i].doc);
					SearchResultBean resultBean = new SearchResultBean();
					resultBean.setHtmlPath(doc.get("path"));

					SimpleHTMLFormatter simpleHTMLFormatter = new SimpleHTMLFormatter(this.prefixHTML, this.suffixHTML);
					Highlighter highlighter = new Highlighter(simpleHTMLFormatter, new QueryScorer(query));

					String highLightText = highlighter.getBestFragment(this.analyzer, "title", doc.get("title"));
					if (highLightText == null)
						highLightText = doc.get("title");
					resultBean.setHtmlTitle(highLightText);

					highLightText = highlighter.getBestFragment(this.analyzer, "content", doc.get("content"));
					resultBean.setHtmlContent(highLightText);
					resultBean.setHtmlParent(doc.get("parent"));
					searchResult.add(resultBean);

					i++;
					if (i >= start + hitsPerPage)
						break;
				} while (i < hits.length);
			} catch (IOException e) {
				e.printStackTrace();
				HelpLogs.writerFile("searcher.doc==" + e.getMessage());
			} catch (InvalidTokenOffsetsException invEx) {
				invEx.printStackTrace();
				HelpLogs.writerFile("searcher.doc==" + invEx.getMessage());
			}
		}
		return searchResult;
	}

	public int getTotal() {
		int total = 0;
		if (!this.indexManager.ifIndexExist()) {
			try {
				if (!this.indexManager.createIndex())
					return total;
			} catch (IOException e) {
				e.printStackTrace();
				HelpLogs.writerFile("searcher.doc==" + e.getMessage());
				return total;
			}
		}

		IndexSearcher searcher = null;
		try {
			searcher = new IndexSearcher(FSDirectory.open(new File(this.indexManager.getIndexDir())));
		} catch (IOException ioe) {
			ioe.printStackTrace();
			HelpLogs.writerFile("FSDirectory.open==" + ioe.getMessage());
		}

		Query query = null;
		try {
			String[] fields = { "title", "content" };
			query = IKQueryParser.parseMultiField(fields, this.searchWord);
		} catch (IOException e) {
			e.printStackTrace();
			HelpLogs.writerFile("FSDirectory.open==" + e.getMessage());
		}
		if ((query != null) && (searcher != null)) {
			try {
				TopDocs results = searcher.search(query, 10000);
				ScoreDoc[] hits = results.scoreDocs;
				total = hits.length;
			} catch (IOException ioEx) {
				ioEx.printStackTrace();
				HelpLogs.writerFile("FSDirectory.open==" + ioEx.getMessage());
			}
		}
		return total;
	}
}
