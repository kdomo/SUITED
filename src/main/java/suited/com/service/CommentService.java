package suited.com.service;

import java.util.ArrayList;
import java.util.HashMap;

import suited.com.dao.CommentDAO;
import suited.com.dto.CommentDTO;

public class CommentService {
	private CommentDAO dao = new CommentDAO();
	private int recordCntPerPage = 3; // 하나의 페이지에 보여질 데이터 수
	private int naviCntPerPage = 3; // 네비게이션 범위를 얼마로 잡아줄지
	
	// 제품 상세 페이지 내의 리뷰에서 사용되는 getPageNavi
	public HashMap<String, Object> getPageNavi(int currentPage_cmt, String product_code){
		int recordTotalCnt = dao.countByCode(product_code); // 데이터의 총합 수
		
		int pageTotalCnt = 0; // 총 몇 페이지가 나올지
		if(recordTotalCnt % recordCntPerPage > 0) {
			pageTotalCnt = (recordTotalCnt / recordCntPerPage) + 1;
		} else {
			pageTotalCnt = recordTotalCnt / recordCntPerPage;
		}
		
		if(currentPage_cmt < 1) { // currentPage 안전장치
			currentPage_cmt = 1;
		}else if(currentPage_cmt > pageTotalCnt) {
			currentPage_cmt = pageTotalCnt;
		}
		
		// 시작 네비 페이지, 끝 네비 페이지 잡아주기
		int startNavi = ((currentPage_cmt - 1) / naviCntPerPage) * naviCntPerPage + 1;
		int endNavi = startNavi + naviCntPerPage - 1;
				
		if(endNavi > pageTotalCnt) { // endNavi 총 페이지 수 초과되지 않게 맞춰주기
			endNavi = pageTotalCnt;
		}
		
		// 이전, 다음 버튼 필요 여부 셋팅
		boolean needPrev = true;
		boolean needNext = true;
		if(startNavi == 1) needPrev = false;
		if(endNavi == pageTotalCnt) needNext = false;
		
//		System.out.println("리뷰 개수 : " + recordTotalCnt);
//		System.out.println("리뷰 pageTotalCnt : " + pageTotalCnt);
//		System.out.println("리뷰 startNavi : " + startNavi);
//		System.out.println("리뷰 endNavi : " + endNavi);
//		System.out.println("리뷰 needPrev : " + needPrev);
//		System.out.println("리뷰 needNext : " + needNext);
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("startNavi", startNavi);
		map.put("endNavi", endNavi);
		map.put("needPrev", needPrev);
		map.put("needNext", needNext);
		map.put("currentPage_cmt", currentPage_cmt);
		
		return map;
	}
	
	// 제품 상세 페이지 내의 리뷰에서 사용되는 getCommentList
	public ArrayList<CommentDTO> getCommentList(int currentPage_cmt, String product_code){
		int startRange = currentPage_cmt * recordCntPerPage - (recordCntPerPage-1);
		int endRange = currentPage_cmt * recordCntPerPage;
		
		System.out.println("currentPage_cmt : " + currentPage_cmt);
		System.out.println("startRange : " + startRange);
		System.out.println("endRange : " + endRange);
		ArrayList<CommentDTO> list = dao.getCommentList(startRange, endRange, product_code);
		for(CommentDTO dto : list) {
			System.out.println(dto.getNickname() + " : " + dto.getContent());
		}
		return list;
	}
	
	
	// 리뷰 모아보기에서 사용되는 getPageNavi
	public HashMap<String, Object> getPageNavi2(int currentPage){
		int recordTotalCnt = dao.countAll(); // 데이터의 총합 수
		
		int pageTotalCnt = 0; // 총 몇 페이지가 나올지
		if(recordTotalCnt % recordCntPerPage > 0) {
			pageTotalCnt = (recordTotalCnt / recordCntPerPage) + 1;
		} else {
			pageTotalCnt = recordTotalCnt / recordCntPerPage;
		}
		
		if(currentPage < 1) { // currentPage 안전장치
			currentPage = 1;
		}else if(currentPage > pageTotalCnt) {
			currentPage = pageTotalCnt;
		}
		
		// 시작 네비 페이지, 끝 네비 페이지 잡아주기
		int startNavi = ((currentPage - 1) / naviCntPerPage) * naviCntPerPage + 1;
		int endNavi = startNavi + naviCntPerPage - 1;
				
		if(endNavi > pageTotalCnt) { // endNavi 총 페이지 수 초과되지 않게 맞춰주기
			endNavi = pageTotalCnt;
		}
		
		// 이전, 다음 버튼 필요 여부 셋팅
		boolean needPrev = true;
		boolean needNext = true;
		if(startNavi == 1) needPrev = false;
		if(endNavi == pageTotalCnt) needNext = false;
		
//		System.out.println("리뷰 개수 : " + recordTotalCnt);
//		System.out.println("리뷰 pageTotalCnt : " + pageTotalCnt);
//		System.out.println("리뷰 startNavi : " + startNavi);
//		System.out.println("리뷰 endNavi : " + endNavi);
//		System.out.println("리뷰 needPrev : " + needPrev);
//		System.out.println("리뷰 needNext : " + needNext);
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("startNavi", startNavi);
		map.put("endNavi", endNavi);
		map.put("needPrev", needPrev);
		map.put("needNext", needNext);
		map.put("currentPage", currentPage);
		
		return map;
	}
	
	// 리뷰 모아보기에서 사용되는 getCommentList
	public ArrayList<CommentDTO> getCommentList2(int currentPage){
		int startRange = currentPage * recordCntPerPage - (recordCntPerPage-1);
		int endRange = currentPage * recordCntPerPage;
		
		System.out.println("currentPage : " + currentPage);
		System.out.println("startRange : " + startRange);
		System.out.println("endRange : " + endRange);
		ArrayList<CommentDTO> list = dao.getCommentList2(startRange, endRange);
//		for(CommentDTO dto : list) {
//			System.out.println(dto.getNickname() + " : " + dto.getContent());
//		}
		return list;
	}
}
