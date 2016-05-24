package org.yonyou.help.search;

public class SearchResultBean {
	private String htmlPath;
	private String htmlTitle;
	private String htmlContent;
	private String htmlParent;

	public String getHtmlPath() {
		return this.htmlPath;
	}

	public void setHtmlPath(String htmlPath) {
		this.htmlPath = htmlPath;
	}

	public String getHtmlTitle() {
		return this.htmlTitle;
	}

	public void setHtmlTitle(String htmlTitle) {
		this.htmlTitle = htmlTitle;
	}

	public String getHtmlContent() {
		return this.htmlContent;
	}

	public void setHtmlContent(String htmlContent) {
		this.htmlContent = htmlContent;
	}

	public String getHtmlParent() {
		return this.htmlParent;
	}

	public void setHtmlParent(String htmlParent) {
		this.htmlParent = htmlParent;
	}
}
