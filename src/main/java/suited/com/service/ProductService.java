package suited.com.service;

import java.util.ArrayList;
import java.util.HashMap;

import suited.com.dao.ProductDAO;
import suited.com.dto.ProductDTO;

public class ProductService {
	private ProductDAO dao = new ProductDAO();
	private int recordCntPerPage = 6; // 하나의 페이지에 보여질 데이터 수
	private int naviCntPerPage = 5; // 네비게이션 범위를 얼마로 잡아줄지
	
	public HashMap<String, Object> getPageNavi(int currentPage){
		
		try {
			int recordTotalCnt = dao.countAll();
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
			
			HashMap<String, Object> map = new HashMap<>();
			map.put("startNavi", startNavi);
			map.put("endNavi", endNavi);
			map.put("needPrev", needPrev);
			map.put("needNext", needNext);
			map.put("currentPage", currentPage);
			
			return map;
		} catch (Exception e) {
			e.printStackTrace();
		} // 데이터의 총합 수
		return null;
		
		
	}
	
	public ArrayList<ProductDTO> getProductList(int currentPage){
		int startRange = currentPage * recordCntPerPage - (recordCntPerPage-1);
		int endRange = currentPage * recordCntPerPage;
		
	
		try {
			ArrayList<ProductDTO> list = dao.getProductList(startRange, endRange);
			return list;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;

		
	}
}
