package suited.com.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import suited.com.dao.InquiryDAO;
import suited.com.dao.ProductDAO;
import suited.com.dto.InquiryDTO;
import suited.com.dto.ProductDTO;
import suited.com.service.InquiryService;

@WebServlet("*.in")
public class InquiryController extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		actionDo(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		actionDo(request, response);
	}
	private void actionDo(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 1. 공동 설정
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		InquiryDAO dao = new InquiryDAO();
		HttpSession session = request.getSession();

		// 2. 요청 url 다듬기
		String uri = request.getRequestURI();
		String ctxPath = request.getContextPath();
		String cmd = uri.substring(ctxPath.length());

		System.out.println("요청 url : " + cmd);
//		if(cmd.equals("/toLogin.in")) {
//			String id = request.getParameter("id");// 로그인 아이디를 불러온다
//			String managerOk = request.getParameter("managerOk");// 관리자 확인값을 불러온다
//			HashMap<String,String> map = new HashMap<>();// 로그인 했을때 id정보와 관리자인지의 여부를 담아놓을곳
//			map.put("id", id);//아이디를 맵형 변수에 저장
//			map.put("managerOk", managerOk);// 관리자 여부를 맵형 변수에 저장
//			session.setAttribute("idAdmin_YN", map);// 맵형 변수를 로그인세션이라는 키값에 담아서 세션에 저장(프로젝트 전체에서 쓸수있게 해준다.) 
//			response.sendRedirect("/");
//			
//		}
		if(cmd.equals("/toInquiry.in")) { // 사용자 입장에서는 자신의 아이디에 해당하는 문의내용리스트를 보여준다. / 관리자 입장에서는 사용자가 문의했던 내용들을 전부 보여준다.
			// 여기로 오려는 요청에는 ?currentPage=1의 값이 담겨있어야 한다. 기본적으로 제일 처음 페이지를 띄워주기 위해서 1이 필요.
			// 여기로 오는 모든 요청을 currentPage라는 키값과 함께 보내진다.
			int currentPage = Integer.parseInt(request.getParameter("currentPage"));// 현재 페이지가 1부터 시작하기 때문에 문의 목록페이지로 들어가려면 1의 값을 가지고 있어야한다.
			System.out.println(currentPage);
			HashMap<String, String> inquiryMap = (HashMap)session.getAttribute("loginSession");// 로그인세션이라는 키값의 맵안의 값을 가져오기 위해 쓰인다.
			String id = inquiryMap.get("id"); // 담겨있는 로그인정보를 사용하여 id 값 불러옴
			String admin_yn = inquiryMap.get("admin_yn");// 담겨있는 로그인 정보의 관리자인지 아닌지 여부를 가져옴
			try {
				// InquiryService를 호출해서 객체를 만든다음 getInquiryList를 호출하는 작업
				InquiryService service = new InquiryService();
				HashMap<String, Integer> ranges = service.getRange(currentPage);// service에있는 getInquiryList에서 ranges의 값을 가져온다.
				if(admin_yn.equals("1")) {
					ArrayList<InquiryDTO> totalList = dao.getInquiryList(ranges); // 가져온 ranges를 사용하여 전체 리스트에서의 값을 계산하여 가져온다.
					HashMap<String, Object> settingMap = service.getPageNavi(currentPage, inquiryMap); // 페이지를 띄워주는 jsp에서 사용. 시작네비 끝네비, 버튼을 띄워주는 여부, 현재페이지도 담겨있음.
					
					if(totalList != null) {
					RequestDispatcher rd = request.getRequestDispatcher("/inquiry/inquiry.jsp");
					request.setAttribute("settingMap", settingMap);
					request.setAttribute("totalList", totalList);
					rd.forward(request, response);
				    	}
				}else if(admin_yn.equals("0")) {
					ArrayList<InquiryDTO> list = dao.selectListById(ranges, id);  // 가져온 ranges와 로그인한 사용자의 id를 사용하여 그 사용자의 게시글리스트에서의 값을 계산하여 가져온다.
					HashMap<String, Object> settingMap = service.getPageNavi(currentPage, inquiryMap); // 페이지를 띄워주는 jsp에서 사용. 시작네비 끝네비, 버튼을 띄워주는 여부, 현재페이지도 담겨있음.
					if(list != null) {
						RequestDispatcher rd = request.getRequestDispatcher("/inquiry/inquiry.jsp");
						request.setAttribute("settingMap", settingMap);
						request.setAttribute("list", list);
						rd.forward(request, response);
					    }
				}
			}catch(Exception e) {
				e.printStackTrace();
				response.sendRedirect("/errorPage.jsp");
			}
		}else if(cmd.equals("/toInquiryProc.in")) {// 문의 작성하는 페이지로 이동
			int currentPage = Integer.parseInt(request.getParameter("currentPage"));
			System.out.println(currentPage);
			// product_code의 이름값을 가져온다
			ProductDTO Pdto = new ProductDTO();
			try {
				ArrayList<ProductDTO> codeList = dao.getProductCode();
				System.out.println(codeList);
//				response.sendRedirect("/writeInquiry.jsp?currentPage=" + currentPage); // 문의 작성하기 jsp
				RequestDispatcher rd = request.getRequestDispatcher("/inquiry/writeInquiry.jsp");
				request.setAttribute("currentPage", currentPage);
				request.setAttribute("codeList", codeList);
				rd.forward(request, response);
			}catch(Exception e) {
				e.printStackTrace();
				response.sendRedirect("/errorPage.jsp");
			}
			
		}else if(cmd.equals("/writeProc.in")) { // 문의 작성후에 여기로 와서 저장메서드 실행
			HashMap<String, String> inquiryMap = (HashMap)session.getAttribute("loginSession");
			String id = inquiryMap.get("id"); // 담겨있는 로그인정보를 사용
			String product_code = request.getParameter("product_code");
			String title = request.getParameter("title");
			String content = request.getParameter("content");
			String answer_yn = "0";
			try{
				if(product_code == null) {
					product_code = "X";
				}
				int rs = dao.insert(new InquiryDTO(0, id, product_code, title, content, System.currentTimeMillis(), answer_yn, null));
				if(rs != -1) {
					response.sendRedirect("/toInquiry.in?currentPage=1");
				}
			}catch(Exception e) {
				e.printStackTrace();
				response.sendRedirect("/errorPage.jsp");
			}
		}else if(cmd.equals("/toDetailView.in")) {// 작성글 상세보기 페이지로 이동
			int seq_inquiry = Integer.parseInt(request.getParameter("seq_inquiry"));
			int currentPage = Integer.parseInt(request.getParameter("currentPage"));
			try{
				InquiryDTO dto = dao.selectBySeq(seq_inquiry);
				if(dto != null) {
					RequestDispatcher rd = request.getRequestDispatcher("/inquiry/detailView.jsp");// 상세보기 jsp
					request.setAttribute("dto", dto);
					System.out.println(dto);
					String answer_yn = dto.getAnswer_yn();
					request.setAttribute("answer_yn", answer_yn);
					request.setAttribute("currentPage", currentPage);
					rd.forward(request, response);
				}
			}catch(Exception e) {
				e.printStackTrace();
				response.sendRedirect("/errorPage.jsp");
			}
		}else if (cmd.equals("/sendAnswerProc.in")) {
			int currentPage = Integer.parseInt(request.getParameter("currentPage"));
			int seq_inquiry = Integer.parseInt(request.getParameter("seq_inquiry"));
			String answer = request.getParameter("answer");
			System.out.println(answer);
			
			try{
				int rs = dao.sendAnswer(seq_inquiry, answer);
				if(rs != -1) {
					response.sendRedirect("/toDetailView.in?seq_inquiry=" + seq_inquiry + "&currentPage=" + currentPage);
				}
			}catch(Exception e) {
				e.printStackTrace();
				response.sendRedirect("/errorPage.jsp");
			}
		}
	}

}
