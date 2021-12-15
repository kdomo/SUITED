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

import com.google.gson.Gson;

import suited.com.dao.BasketDAO;
import suited.com.dao.MemberDAO;
import suited.com.dto.BasketDTO;
import suited.com.dto.MyBasketDTO;

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
		HashMap<String, String> loginSession = (HashMap) session.getAttribute("loginSession");
		PrintWriter out = response.getWriter();
		MemberDAO memberDAO = new MemberDAO();
		BasketDAO basketDAO = new BasketDAO();

		System.out.println("요청 url : " + cmd);

		if (cmd.equals("/tocart.cart")) {
			response.sendRedirect("/cart/cart.jsp");
		} else if (cmd.equals("/getCartProc.cart")) { // 장바구니 목록 전송
			String id = loginSession.get("id");
			ArrayList<MyBasketDTO> list = basketDAO.selectCartById(id);

			Gson gson = new Gson();
			String rs = gson.toJson(list);

			if (list != null) {
//		    	RequestDispatcher rd = request.getRequestDispatcher("/cart/cart.jsp");
//		    	request.setAttribute("list", list);
				response.getWriter().write(rs);
			} else {
				response.getWriter().write("fail");
			}
		} else if (cmd.equals("/insertCartProc.cart")) { // 장바구니 테이블에 내역 추가
			String product_code = request.getParameter("product_code");
			String id = loginSession.get("id");

			System.out.println("id : " + id);
			System.out.println("product_code : " + product_code);

			int rs = basketDAO.insert(new BasketDTO(id, product_code, 1)); // 각 제품마다 초기 수량은 1로 지정
			if (rs == 1) {
				response.getWriter().write("success");
			} else {
				response.getWriter().write("fail");
			}
		} else if (cmd.equals("/countCartProc.cart")) {
			String id = loginSession.get("id");

			String rs = Integer.toString(basketDAO.countById(id));
			if (rs != "-1") {
				response.getWriter().write(rs);
			} else {
				response.getWriter().write("fail");
			}
		} else if (cmd.equals("/getQuantity.cart")) {
			String id = loginSession.get("id");
			int quantity = Integer.parseInt(request.getParameter("quantity"));
			System.out.println("quantity : " + quantity);
			String btnId = request.getParameter("btnId");
			System.out.println("btnId : " + btnId);

			String product_code = btnId.substring(0, btnId.length() - 1);
			System.out.println(product_code);
			String modification = btnId.substring(btnId.length() - 1, btnId.length()); // !는 +로 가정
			System.out.println(modification);

			int rs = basketDAO.modQuantity(id, product_code, modification);
			if (rs == 1) {
				response.getWriter().write("success");
			} else {
				response.getWriter().write("fail");
			}
		} else if (cmd.equals("/deleteProc.cart")) {
			String id = loginSession.get("id");
			String product_code = request.getParameter("product_code");

			int rs1 = basketDAO.deleteByCode(product_code);
			String rs2 = Integer.toString(basketDAO.countById(id));
			if (rs1 == 1) {
				response.getWriter().write("success");
			} else {
				response.getWriter().write("fail");
			}
		}
	}
}
