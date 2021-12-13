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

@WebServlet("*.cart")
public class CartController extends HttpServlet {
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
		if (cmd.equals("/tocart.cart")) {
			response.sendRedirect("/cart/cart.jsp");
			
		}
	}
}
