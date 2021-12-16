package suited.com.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;

import com.google.gson.Gson;

import suited.com.dao.MemberDAO;
import suited.com.dao.OrderDAO;
import suited.com.dao.OrderJoinDAO;
import suited.com.dao.Order_productDAO;
import suited.com.dao.PaymentDAO;
import suited.com.dto.BasketDTO;
import suited.com.dto.OrderDTO;
import suited.com.dto.OrderJoinDTO;
import suited.com.dto.PaymentDTO;

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
		Order_productDAO order_productDAO = new Order_productDAO();
		OrderJoinDAO orderJoinDAO = new OrderJoinDAO();
		PaymentDAO paymentDAO = new PaymentDAO();
		MemberDAO memberDAO = new MemberDAO();
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
			String order_message = request.getParameter("order_message");
			String delivery_message = request.getParameter("delivery_message");
			try {
				int rs = orderDAO.insert(new OrderDTO(id,System.currentTimeMillis(),order_amount,"신규",order_address,phone,name,order_message,delivery_message));
				if(rs != -1) {
					out.write("orderSuccess");
				}else {
					out.write("orderFail");
				}
			} catch (Exception e) {
				e.printStackTrace();
				response.sendRedirect("${pageContext.request.contextPath}/errorPage.jsp");
			}
		} else if(cmd.equals("/order_productProc.order")) {
//			-
//			Gson gson = new Gson();
//			BasketDTO[] dto = gson.fromJson(request.getParameter("data"), BasketDTO[].class);
//			System.out.println(dto[0].getProduct_code());
//			for(int i=0;i<dto.length;i++) {
//				System.out.println(dto[i].getProduct_code());
//				System.out.println(dto[i].getQuantity());
//			}
//			-
		
			
//			-
			JSONArray arr = new JSONArray();
			arr = new JSONArray(request.getParameter("data"));
			for(int i=0;i<arr.length();i++) {
				String product_code = (String)arr.getJSONObject(i).get("product_code");
				int quantity = (int)arr.getJSONObject(i).get("quantity");
				System.out.println("product_code : " + product_code);
				System.out.println("quantity : " + quantity);
				try {
					int rs = order_productDAO.insert(product_code, quantity);
				} catch (Exception e) {
					e.printStackTrace();
					response.sendRedirect("${pageContext.request.contextPath}/errorPage.jsp");
				}
			}
			try {
				String order_no = order_productDAO.getseq();
				System.out.println("order_no" + order_no);
				out.write(order_no);
			} catch (Exception e) {
				e.printStackTrace();
				response.sendRedirect("${pageContext.request.contextPath}/errorPage.jsp");
			}
				
			
		} else if(cmd.equals("/orderComplete.order")) {
			HashMap<String, String> loginSession = (HashMap) session.getAttribute("loginSession");
			String id = loginSession.get("id");
			String token = request.getParameter("token");
			try {
				String order_no = order_productDAO.getseq();
				if(token.equals(order_no)) {
					ArrayList<OrderJoinDTO> orderJoinList = orderJoinDAO.getOrderList(order_no,id);
					RequestDispatcher rd = request.getRequestDispatcher("/order/orderConfirm.jsp");
					request.setAttribute("orderJoinList", orderJoinList);
					rd.forward(request, response);
				}
			} catch (Exception e) {
				e.printStackTrace();
				response.sendRedirect("${pageContext.request.contextPath}/errorPage.jsp");
			}
			
		} else if(cmd.equals("/payProc.order")) {
			
			String order_id = request.getParameter("order_id");
			int pay_price = Integer.parseInt(request.getParameter("pay_price"));
			String pg = request.getParameter("pg");
			String method = request.getParameter("method");
			String card_name = request.getParameter("card_name");
			String card_code = request.getParameter("card_code");
			String purchased_at = request.getParameter("purchased_at");
			
			System.out.println("order_id : " + order_id);
			System.out.println("pay_price : " + pay_price);
			System.out.println("pg : " + pg);
			System.out.println("method : " + method);
			System.out.println("card_name : " + card_name);
			System.out.println("card_code : " + card_code);
			System.out.println("purchased_at : " + purchased_at);
			try {
				int rs = paymentDAO.insert(new PaymentDTO(order_id, pay_price, pg, method, card_name, card_code, purchased_at));
				int seq = paymentDAO.getseq();
				if(rs != -1) {
					int payRs = orderDAO.pay(seq,order_id);
					if(payRs != -1) {
						out.write("paySuccess");
					}else {
						out.write("payFail");
					}
				}else {
					out.write("payFail");
				}
			} catch (Exception e) {
				e.printStackTrace();
				response.sendRedirect("${pageContext.request.contextPath}/errorPage.jsp");
			}
		} else if(cmd.equals("/toPayResult.order")) {
			String Result = request.getParameter("Result");
			if(Result.equals("paySuccess")) {
				RequestDispatcher rd = request.getRequestDispatcher("/order/orderResult.jsp");
				request.setAttribute("Result", "paySuccess");
				rd.forward(request, response);
			}else if(Result.equals("payFail")) {
				RequestDispatcher rd = request.getRequestDispatcher("/order/orderResult.jsp");
				request.setAttribute("Result", "payFail");
				rd.forward(request, response);
			}
		} else if(cmd.equals("/toOrderList.order")) {
	         HashMap<String, String> loginSession = (HashMap) session.getAttribute("loginSession");
	         String id = loginSession.get("id");
	         String admin_yn = memberDAO.isAdmin(id);
	         if(admin_yn.equals("1")) {
	            ArrayList<OrderDTO> list = orderDAO.selectAll();
	            if(list != null) {
	               RequestDispatcher rd = request.getRequestDispatcher("/order/orderList.jsp");
	               request.setAttribute("list", list);
	               rd.forward(request, response);
	            }
	         }else {
	            OrderDTO list = orderDAO.selectById("");
	            if(list != null) {
	               RequestDispatcher rd = request.getRequestDispatcher("/order/orderList.jsp");
	               request.setAttribute("list", list);
	               rd.forward(request, response);
	            }
	         }
	      }
	}

}
