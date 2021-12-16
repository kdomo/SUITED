package suited.com.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import suited.com.dao.MemberDAO;
import suited.com.dao.OrderDAO;
import suited.com.dao.SurveyDAO;
import suited.com.dto.CommentDTO;
import suited.com.dto.MemberDTO;
import suited.com.dto.OrderDTO;
import suited.com.dto.SurveyDTO;
import suited.com.service.CommentService;
import suited.com.utils.EncryptionUtils;

@WebServlet("*.admin")
public class AdminController extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		actionDo(request, response);

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		actionDo(request, response);
	}

	private void actionDo(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		String uri = request.getRequestURI();
		String ctxPath = request.getContextPath();
		String cmd = uri.substring(ctxPath.length());
		HttpSession session = request.getSession();
		PrintWriter out = response.getWriter();
		MemberDAO memberDAO = new MemberDAO();
		SurveyDAO surveyDAO = new SurveyDAO();
		OrderDAO orderDAO = new OrderDAO();
		System.out.println("admin : " + cmd);
		if (cmd.equals("/toLogin.admin")) {
			response.sendRedirect("/admin/login.jsp");
		} else if (cmd.equals("/toAdminIndex.admin")) {
			response.sendRedirect("/admin/index.jsp");
		} else if (cmd.equals("/loginProc.admin")) { // 로그인페이지에서 로그인버튼을 눌렀을때
			String id = request.getParameter("id");
			String password = EncryptionUtils.getSHA256(request.getParameter("password"));
			try {
				boolean rs = memberDAO.adminConfirm(id); // 관리자인지 아닌지 확인
				if (rs) {// 관리자 라면
					if (memberDAO.login(id, password)) { // 로그인
						MemberDTO dto = memberDAO.selectById(id);
						HashMap<String, String> map = new HashMap<String, String>();
						map.put("id", id);
						map.put("nickname", dto.getNickname());
						map.put("name", dto.getName());
						map.put("gender", dto.getGender());
						map.put("age", Integer.toString(dto.getAge()));
						map.put("address", dto.getAddress());
						map.put("phone", dto.getPhone());
						map.put("kakao_login", dto.getKakao_login());
						map.put("withdrawal_yn", dto.getWithdrawal_yn());
						map.put("admin_yn", dto.getAdmin_yn());
						System.out.println("로그인 성공");
						session.setAttribute("loginSession", map);
						out.write("loginSuccess");
					} else { // 아직 인증이 완료되지 않았다면
						out.write("loginFail");
					}
				} else { // 관리자가 아니라면
					out.write("notAdmin");
				}
			} catch (Exception e) {
				response.sendRedirect("/errorPage.jsp");
				e.printStackTrace();
			}
		} else if (cmd.equals("/logoutProc.admin")) { // 로그아웃 버튼을 눌렀을때
			System.out.println("로그아웃");
			session.removeAttribute("loginSession");
			response.sendRedirect("/admin/login.jsp");
		} else if (cmd.equals("/toMemberList.admin")) {
			ArrayList<MemberDTO> list = memberDAO.selectAll();

			if (list != null) {
				RequestDispatcher rd = request.getRequestDispatcher("/admin/memberList.jsp");
				request.setAttribute("list", list);
				rd.forward(request, response);
			}
		} else if (cmd.equals("/toAllReview.admin")) { // 모든 리뷰모아보기 페이지로 이동
			response.sendRedirect("/allReviewProc.admin?currentPage=1");
		} else if (cmd.equals("/allReviewProc.admin")) { // 모든 리뷰 내역 전송
			int currentPage = Integer.parseInt(request.getParameter("currentPage"));
			System.out.println("currentPage : " + currentPage);

			CommentService service = new CommentService();
			HashMap<String, Object> naviMap = service.getPageNavi2(currentPage);
			ArrayList<CommentDTO> list = service.getCommentList2((int) naviMap.get("currentPage"));

			if (list != null) {
				RequestDispatcher rd = request.getRequestDispatcher("/admin/allReview.jsp");
				request.setAttribute("naviMap", naviMap);
				request.setAttribute("list", list);
				rd.forward(request, response);
			}
		} else if (cmd.equals("/toOrderList.admin")) {
			HashMap<String, String> loginSession = (HashMap) session.getAttribute("loginSession");
			String id = loginSession.get("id");
			String admin_yn = memberDAO.isAdmin(id);
			if (admin_yn.equals("1")) {
				try {
					ArrayList<OrderDTO> list = orderDAO.selectAll();
					if (list != null) {
						RequestDispatcher rd = request.getRequestDispatcher("/admin/orderList.jsp");
						request.setAttribute("list", list);
						rd.forward(request, response);
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
			} else {
				try {
					OrderDTO list = orderDAO.selectById(id);
					if (list != null) {
						RequestDispatcher rd = request.getRequestDispatcher("/admin/orderList.jsp");
						request.setAttribute("list", list);
						rd.forward(request, response);
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		} else if(cmd.equals("/toSurveyList.admin")) { // 설문 목록 조회
			try {
				ArrayList<SurveyDTO> list = surveyDAO.selectAll();
				if(list != null) {
		            RequestDispatcher rd = request.getRequestDispatcher("/admin/surveyList.jsp");
		            request.setAttribute("list", list);
		            rd.forward(request, response);
		         }
			} catch (Exception e) {
				e.printStackTrace();
			}
	      }
	}

}
