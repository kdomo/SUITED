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

import suited.com.dao.OrderDAO;
import suited.com.dto.OrderDTO;

/**
 * Servlet implementation class OrderController
 */
@WebServlet("*.order")
public class OrderController extends HttpServlet {
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
		OrderDAO orderDAO = new OrderDAO();
		System.out.println(cmd);

		if (cmd.equals("/toOrder.order")) {
			response.sendRedirect("/order/order.jsp");
		} else if(cmd.equals("/orderProc.order")) {
			HashMap<String, String> loginSession = (HashMap) session.getAttribute("loginSession");
			// 장바구니에 있던 상품내역들 받아오기
			// 주문 총액 받아오기
			String id = loginSession.get("id");
			int order_amount =  Integer.parseInt(request.getParameter("order_amount"));
			String order_address = loginSession.get("address");
			String phone = loginSession.get("phone");
			String name = loginSession.get("name");
			String order_messege = request.getParameter("order_messege");
			String delivery_message = request.getParameter("delivery_message");
			try {
				int rs = orderDAO.insert(new OrderDTO(id,System.currentTimeMillis(),order_amount,"신규",order_address,phone,name,order_messege,delivery_message));
				if(rs != -1) {
					out.write("orderSuccess");
					
					//
				}else {
					out.write("orderFail");
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			
			
			
		}
	}

}
