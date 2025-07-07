package com.example.suhodan.util;

public class PageUtil {

	private int currentPage;
	private int totalCount;
	private int pageSize = 10;
	private int totalPage;
	private int start;
	private int end;

	public PageUtil(int currentPage, int totalCount) {
		this.totalCount = totalCount;
		this.pageSize = 10;
		this.totalPage = (int) Math.ceil((double) totalCount / pageSize);

		if (currentPage < 1)
			currentPage = 1;
		if (currentPage > totalPage)
			currentPage = totalPage;

		this.currentPage = currentPage;
		this.start = (currentPage - 1) * pageSize + 1;
		this.end = currentPage * pageSize;
	}

	public int getStart() {
		return start;
	}

	public int getEnd() {
		return end;
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public int getTotalPage() {
		return totalPage;
	}
}
