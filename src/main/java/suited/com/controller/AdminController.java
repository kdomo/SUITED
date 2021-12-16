package suited.com.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import suited.com.dao.MemberDAO;
import suited.com.dto.MemberDTO;
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
		System.out.println("admin : " + cmd);
		if (cmd.equals("/toLogin.admin")) {
			response.sendRedirect("/admin/login.jsp");
		}else if (cmd.equals("/toAdminIndex.admin")) {
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
				response.sendRedirect("${pageContext.request.contextPath}/errorPage.jsp");
				e.printStackTrace();
			}
		} else if (cmd.equals("/logoutProc.admin"))

		{ // 로그아웃 버튼을 눌렀을때
			System.out.println("로그아웃");
			session.removeAttribute("loginSession");
			response.sendRedirect("/admin/login.jsp");
		}
	}

}
