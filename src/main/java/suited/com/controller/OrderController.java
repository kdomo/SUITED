package suited.com.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import suited.com.dao.OrderDAO;
import suited.com.dao.Order_productDAO;
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
		Order_productDAO order_productDAO = new Order_productDAO();
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
				}else {
					out.write("orderFail");
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if(cmd.equals("/order_productProc.order")) {
//			HashMap<String,Object> rs = new ObjectMapper().readValue();
//			Gson gson = new Gson();
//			System.out.println(request.getParameterMap());
//			HashMap<String,String[]> rs = (HashMap<String, String[]>) request.getParameterMap();
//			System.out.println(rs);
//			String[] temp = request.getParameterValues("temp");
//			System.out.println(gson.toJson(temp)); 
//			gson.toJson(temp)
			
//			for(int i=0;i<temp.length;i++) {
//				
//			}
//			String product_code = request.getParameter("product_code");
//			String quantity = request.getParameter("quantity");
			String[] product_code = request.getParameterValues("product_code");
			String[] quantity = request.getParameterValues("quantity");
			for(int i=0;i<product_code.length;i++) {
				System.out.println(product_code[i]);
				System.out.println(quantity[i]);
			}
			
//			System.out.println(temp[0]);
//				System.out.println(product_code);
//				System.out.println(quantity);
//				try {
//					int rs = order_productDAO.insert(product_code, Integer.parseInt(quantity));
//				} catch (Exception e) {
//					e.printStackTrace();
//				}
//				
//				//order_productDAO 생성해서 for문이 돌때마다 이전시퀀스의 seq.currval을 order
//			
			try {
				String order_no = order_productDAO.getseq();
				out.write(order_no);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if(cmd.equals("/orderComplete.order")) {
			HashMap<String, String> loginSession = (HashMap) session.getAttribute("loginSession");
			String id = loginSession.get("id");
			String token = request.getParameter("token");
			try {
				String order_no = order_productDAO.getseq();
				if(token.equals(order_no)) {
					ArrayList<OrderDTO> orderList = orderDAO.getOrderList(order_no,id);
//					System.out.println("오더리스트 겟1"+orderList.get(1));
					RequestDispatcher rd = request.getRequestDispatcher("/order/orderConfirm.jsp");
					request.setAttribute("orderList", orderList);
					rd.forward(request, response);
					
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		}
	}

}
