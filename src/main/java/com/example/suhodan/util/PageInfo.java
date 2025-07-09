package com.example.suhodan.util;

public class PageInfo {
    private int curPage;       // 현재 페이지
    private int listCnt;       // 전체 게시글 수
    private int pageSize;      // 한 페이지에 출력할 게시글 수
    private int blockSize = 5; // 페이지 블록에 보여줄 페이지 수

    private int totPage;       // 전체 페이지 수
    private int startIndex;    // DB 쿼리 시작 index (1-based)
    private int endIndex;      // DB 쿼리 끝 index (1-based)

    private int curBlock;      // 현재 블록
    private int totBlock;      // 전체 블록 수
    private int blockBegin;    // 블록 시작 페이지 번호
    private int blockEnd;      // 블록 끝 페이지 번호
    private int prevPage;      // 이전 블록의 마지막 페이지
    private int nextPage;      // 다음 블록의 첫 페이지

    public PageInfo(int listCnt, int curPage, int pageSize) {
        this.listCnt = listCnt;
        this.curPage = curPage;
        this.pageSize = pageSize;

        this.totPage = (int) Math.ceil((double) listCnt / pageSize);
        if (curPage < 1) this.curPage = 1;
        if (curPage > totPage) this.curPage = totPage;

        this.startIndex = (this.curPage - 1) * pageSize + 1;
        this.endIndex = startIndex + pageSize - 1;
        if (endIndex > listCnt) endIndex = listCnt;

        this.curBlock = (int) Math.ceil((double) this.curPage / blockSize);
        this.totBlock = (int) Math.ceil((double) totPage / blockSize);

        this.blockBegin = (curBlock - 1) * blockSize + 1;
        this.blockEnd = blockBegin + blockSize - 1;
        if (blockEnd > totPage) blockEnd = totPage;

        this.prevPage = (curBlock > 1) ? (blockBegin - 1) : 1;
        this.nextPage = (curBlock < totBlock) ? (blockEnd + 1) : totPage;
    }

    // Getter 메서드 (JSP에서 사용하기 위함)
    public int getCurPage() { return curPage; }
    public int getListCnt() { return listCnt; }
    public int getPageSize() { return pageSize; }
    public int getTotPage() { return totPage; }
    public int getStartIndex() { return startIndex; }
    public int getEndIndex() { return endIndex; }
    public int getCurBlock() { return curBlock; }
    public int getTotBlock() { return totBlock; }
    public int getBlockBegin() { return blockBegin; }
    public int getBlockEnd() { return blockEnd; }
    public int getPrevPage() { return prevPage; }
    public int getNextPage() { return nextPage; }
}
