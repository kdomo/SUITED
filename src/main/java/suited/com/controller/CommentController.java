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

import com.google.gson.Gson;

import suited.com.dao.CommentDAO;
import suited.com.dto.CommentDTO;
import suited.com.service.CommentService;

@WebServlet("*.co")
public class CommentController extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		actionDo(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		actionDo(request, response);
	}

	public void actionDo(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		CommentDAO dao = new CommentDAO();

		String url = request.getRequestURI();
		String ctxPath = request.getContextPath();
		String cmd = url.substring(ctxPath.length());

		System.out.println("요청 url : " + cmd);

		if (cmd.equals("/insertProc.co")) {
			String product_code = request.getParameter("product_code");
			String comment = request.getParameter("comment");

			HashMap<String, String> loginSession = (HashMap) session.getAttribute("loginSession");
			String nickname = loginSession.get("nickname");
			String id = loginSession.get("id");
			long sysdate = System.currentTimeMillis();
			try {
				int rs = dao.insert(new CommentDTO(0, nickname, comment, sysdate, product_code, id));
				if (rs == 1) {
					response.getWriter().write("success");
				} else {
					response.getWriter().write("fail");
				}
			} catch (Exception e) {
				e.printStackTrace();
				response.sendRedirect("${pageContext.request.contextPath}/errorPage.jsp");
			}
			
		} else if (cmd.equals("/getCommentProc.co")) {
			int currentPage_cmt = Integer.parseInt(request.getParameter("currentPage_cmt"));
			String product_code = request.getParameter("product_code");
			System.out.println("product_code : " + product_code);

			CommentService service = new CommentService();
			HashMap<String, Object> naviMap_cmt = service.getPageNavi(currentPage_cmt, product_code);
			ArrayList<CommentDTO> list = service.getCommentList((int) naviMap_cmt.get("currentPage_cmt"), product_code);

			Gson gson = new Gson();
			String rs = gson.toJson(list);
			if (list != null) {
				request.setAttribute("naviMap_cmt", naviMap_cmt);
				response.getWriter().write(rs);
			} else {
				response.getWriter().write("fail");
			}
		} else if (cmd.equals("/deleteProc.co")) {
			int seq_review = Integer.parseInt(request.getParameter("seq_review"));
			System.out.println("삭제할 seq_review : " + seq_review);

			
			try {
				int rs = dao.deleteBySeq(seq_review);
				if (rs == 1) {
					response.getWriter().write("success");
				} else {
					response.getWriter().write("fail");
				}
			} catch (Exception e) {
				e.printStackTrace();
				response.sendRedirect("${pageContext.request.contextPath}/errorPage.jsp");
			}
			
		} else if(cmd.equals("/deleteByManager.co")){
			int seq_review = Integer.parseInt(request.getParameter("seq_review"));
			System.out.println("삭제할 seq_review : " + seq_review);
			try {
				int rs = dao.deleteBySeq(seq_review);
				if(rs != -1) response.sendRedirect("/toAllReview.co");
			} catch (Exception e) {
				e.printStackTrace();
				response.sendRedirect("${pageContext.request.contextPath}/errorPage.jsp");
			}
		} else if (cmd.equals("/toAllReview.co")) { // 모든 리뷰모아보기 페이질로 이동
			response.sendRedirect("/allReviewProc.co?currentPage=1");
		} else if (cmd.equals("/allReviewProc.co")) { // 모든 리뷰 내역 전송
			int currentPage = Integer.parseInt(request.getParameter("currentPage"));
			System.out.println("currentPage : " + currentPage);
			
			CommentService service = new CommentService();
			HashMap<String, Object> naviMap = service.getPageNavi2(currentPage);
			ArrayList<CommentDTO> list = service.getCommentList2((int) naviMap.get("currentPage"));
			
			if(list != null) {
				RequestDispatcher rd = request.getRequestDispatcher("/comment/allReview.jsp");
				request.setAttribute("naviMap", naviMap);
				request.setAttribute("list", list);
				rd.forward(request, response);
			}
			
		}
	}
}
