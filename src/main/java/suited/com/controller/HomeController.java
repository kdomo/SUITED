package suited.com.controller;

import java.io.IOException;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import suited.com.dao.MemberDAO;



@WebServlet("/home")
public class HomeController extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		MemberDAO memberDAO = new MemberDAO();
		if(session.getAttribute("loginSession") != null) {
			HashMap<String,String> map = (HashMap) session.getAttribute("loginSession");
			String id = map.get("id");
			boolean rs;
			try {
				rs = memberDAO.adminConfirm(id);
				if(rs) {
					response.sendRedirect("/admin/index.jsp");
				}else {
					response.sendRedirect("/index.jsp");
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else {
			response.sendRedirect("/index.jsp");
		}
		
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
	
}
