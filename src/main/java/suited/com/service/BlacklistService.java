package suited.com.service;

import java.util.HashMap;

import suited.com.dao.BlacklistDAO;

public class BlacklistService {
	private BlacklistDAO dao = new BlacklistDAO(); //사용할 인스턴스를 만들어준다.
	
	// 1. currentPage(현재 페이지)를 받아서 현재 페이지에 띄워줄 navi의 범위를 결정하는일
		// (시작,엔드 네비를 뽑아내는 작업 + 이전버튼과 다음버튼을 띄워줄지말지를 정한다.)
		// 2. currentPage(현재 페이지)라는 요청값을 받아서 DB에서 between에 ?(range)를 체워서 실제데이터를 불러오는 작업
		// (현제 페이지를 기준으로해서 몇순위에서 몇순위까지 가져올지)
		
		// 방법
		
		// currentPage는 사용자에게 유동적으로 받는것이기때문에 변수로 받아준다.
		// 하나의 페이지에 보여질 데이터의 수 : recordCntPerPage 와 네비 범위 : naviCntPerPage 를 고정으로 정한다.	
		private int recordCntPerPage = 10;
		private int naviCntPerPage = 10;
		
		// 클라이언트가 currentPage를 컨트롤러에 요청을 보내면
		// 컨트롤러는 이 서비스한테 currentPage를 넘겨주면서 메서드를 콜 할거다.
		// currentPage와 recordCntPerPage를 사용해서 startRange와 endRange를 뽑아낸다.
		// dao를 콜해서 리스트를 뽑아낸다. 리스트를 다시 컨트롤러한테 리턴을 해준다.
		// 컨트롤러는 리스트를 응답값에 담아서 다시 jsp에 응답을해주고 jsp에서는 그 응답값을 받아서 for문을 돌려서 출력해준다. 
		
		//startRange와 endRange를 InquiryController로 보내준다.
		public HashMap<String, Integer> getRange(int currentPage) throws Exception{
			//startRange와 endRange를 뽑아낸다.
			int startRange = currentPage * recordCntPerPage - (recordCntPerPage-1);
			int endRange = currentPage * recordCntPerPage;
			HashMap<String, Integer> ranges = new HashMap<>();
			ranges.put("startRange", startRange);
			ranges.put("endRange", endRange);
			return ranges;
		}
		
		// 시작네비와 끝네비 다음 이전버튼 띄우는 작업
		// 4가지의 값을 리턴해줘야 한다.
		// startNavi와 endNavi는 int , needPrev와 needNext는 boolean형 이므로
		// map을 이욯해서 키값을 통해 값을 전송해준다.
		
		public HashMap<String, Object> getPageNavi(int currentPage) throws Exception{
			// 1. 전체 데이터가 몇개인지 뽑아내는 작업
			int recordTotalCnt = dao.countAll();
			
			// 2. 총 몇 페이지가 나올지 뽑아내는 작업
			int pageTotalCnt = 0;
			
			if(recordTotalCnt % recordCntPerPage > 0) {
				pageTotalCnt = (recordTotalCnt / recordCntPerPage) + 1;
			}else {
				pageTotalCnt = recordTotalCnt / recordCntPerPage;
			}
			
			// 3.currentPage 안전장치(음수이거나 총 페이지보다 클때 제일처음과 제일 끝으로 맞춰준다.)
			if(currentPage < 1) { 
				currentPage = 1;
			}else if(currentPage > pageTotalCnt) {
				currentPage = pageTotalCnt;
			}
			
			// 4. 시작 네비 페이지, 끝 네비 페이지 잡아주는 작업 
			int startNavi = ((currentPage -1) / naviCntPerPage) * naviCntPerPage + 1;
			int endNavi = startNavi + naviCntPerPage - 1;
					
			if(endNavi > pageTotalCnt) { // endNavi 총 페이지 수를 초과되지 않게 맞춰주기.
				endNavi = pageTotalCnt;
			}
			
			// 이전, 다음 버튼 필요 여부 셋팅
			boolean needPrev = true;
			boolean needNext = true;
			if(startNavi == 1) needPrev = false;
			if(endNavi == pageTotalCnt) needNext = false;
					
			HashMap<String, Object> settingMap = new HashMap<>();
			settingMap.put("startNavi", startNavi);
			settingMap.put("endNavi", endNavi);
			settingMap.put("needPrev", needPrev);
			settingMap.put("needNext", needNext);
			settingMap.put("currentPage", currentPage);
			return settingMap;
		}
		
}
