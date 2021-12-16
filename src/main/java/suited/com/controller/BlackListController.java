package suited.com.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import suited.com.dao.BlacklistDAO;
import suited.com.dto.BlacklistDTO;
import suited.com.service.BlacklistService;

@WebServlet("*.bl")
public class BlackListController extends HttpServlet {
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
		BlacklistDAO dao = new BlacklistDAO();
		HttpSession session = request.getSession();

		// 2. 요청 url 다듬기
		String uri = request.getRequestURI();
		String ctxPath = request.getContextPath();
		String cmd = uri.substring(ctxPath.length());

		System.out.println("요청 url : " + cmd);
		if(cmd.equals("/toBlacklist.bl")) { //블랙리스트 관리페이지로 이동한다.(총 블랙리스트 list를 가지고이동)
			int currentPage = Integer.parseInt(request.getParameter("currentPage"));//현재 페이지가 1부터 시작하기 때문에 여기로오는 요청에는 키값에 currentPage=1이 있어야한다.
			try {
				// blacklistService를 호출해서 객체를 만든다음 getblackList를 호출하는 작업
				BlacklistService service = new BlacklistService();
				HashMap<String, Integer> ranges = service.getRange(currentPage);// service에있는 getBlackList에서 ranges의 값을 가져온다.
				ArrayList<BlacklistDTO> list = dao.getBlackList(ranges);// 가져온 ranges를 사용하여 전체 리스트에서의 (*~*)까지의 값을 계산하여 가져온다.
				HashMap<String, Object> settingMap = service.getPageNavi(currentPage); // 페이지를 띄워주는 jsp에서 사용. 시작네비 끝네비, 버튼을 띄워주는 여부, 현재페이지도 담겨있음.
				
				if(list != null) {
					RequestDispatcher rd = request.getRequestDispatcher("/blacklist/blacklist.jsp");
					request.setAttribute("settingMap", settingMap);
					request.setAttribute("list", list);
					rd.forward(request, response);
				}
			
			}catch(Exception e) {
				e.printStackTrace();
				response.sendRedirect("${pageContext.request.contextPath}/errorPage.jsp");
			}
		}else if(cmd.equals("/searchId.bl")) {
			String id = request.getParameter("idInput");
			try {
				String name = dao.getNameSelectById(id);
				if(name == null) {
					PrintWriter out = response.getWriter();
					out.write("fail");
				}else {
					PrintWriter out = response.getWriter();
					out.write(name);
				}
				
			}catch(Exception e) {
				e.printStackTrace();
				response.sendRedirect("${pageContext.request.contextPath}/errorPage.jsp");
			}
		}else if(cmd.equals("/updateList.bl")) {
			String id = request.getParameter("id");
			String name = request.getParameter("name");
			String reason = request.getParameter("reason");
			System.out.println(id + name + reason);
			try {
				int rs = dao.insert(new BlacklistDTO(id, name, System.currentTimeMillis(), reason));
				if(rs != -1) {
					response.getWriter().write("success");
				}else {
					response.getWriter().write("fail");
				}
			}catch(Exception e) {
				e.printStackTrace();
				response.sendRedirect("${pageContext.request.contextPath}/errorPage.jsp");
			}
		}else if(cmd.equals("/plusBlacklist.bl")) {
			String id = request.getParameter("id");
			int currentPage = Integer.parseInt(request.getParameter("currentPage"));
			
			try {
				BlacklistService service = new BlacklistService();
				HashMap<String, Integer> ranges = service.getRange(currentPage);
				ArrayList<BlacklistDTO> list = dao.getBlackList(ranges);
				HashMap<String, Object> settingMap = service.getPageNavi(currentPage);
//				settingMap.put("list", list);
				Gson gson = new Gson();
				String blacklist = gson.toJson(list);
//				String setMap = gson.toJson(settingMap);
//				System.out.println(blacklist);
				response.getWriter().write(blacklist);
//				response.getWriter().write(setMap);
				
//					BlacklistDTO dto = dao.selectByThisId(id);
//					Gson gson = new Gson();
//					String plusDto = gson.toJson(dto);
//					System.out.println(plusDto);
//					response.getWriter().write(plusDto);
			}catch(Exception e) {
				e.printStackTrace();
				response.sendRedirect("${pageContext.request.contextPath}/errorPage.jsp");
			}	
		}else if(cmd.equals("/searchIdName.bl")) {//아이디로 찾기
			String id = request.getParameter("searchIdName");
			System.out.println(id);
			try{
				ArrayList<BlacklistDTO> list = dao.getByIdList(id);
				Gson gson = new Gson();
				String blacklist = gson.toJson(list);
				response.getWriter().write(blacklist);
			}catch(Exception e) {
				e.printStackTrace();
				response.sendRedirect("${pageContext.request.contextPath}/errorPage.jsp");
			}
			
			
		}else if(cmd.equals("/deleteById.bl")) {
			int rs = 0;
			String [] checklist = request.getParameterValues("solchecks");
			System.out.println(Arrays.toString(checklist));
			try {
				for(int i = 0; i < checklist.length; i++) {
					rs = dao.deleteById(checklist[i]);
				}
				System.out.println(rs);
				if(rs != -1) {
						response.getWriter().write("success");
					}else {
						response.getWriter().write("fail");
					}
			}catch(Exception e) {
				e.printStackTrace();
				response.sendRedirect("${pageContext.request.contextPath}/errorPage.jsp");
			}
			
		}
	}
}
