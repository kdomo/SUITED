package suited.com.controller;

import java.io.File;
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

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import suited.com.dao.CommentDAO;
import suited.com.dao.ProductDAO;
import suited.com.dto.ProductDTO;
import suited.com.service.CommentService;
import suited.com.service.ProductService;

@WebServlet("*.pro")
public class ProductController extends HttpServlet {
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
		HttpSession session = request.getSession();
		ProductDAO dao = new ProductDAO();

		String uri = request.getRequestURI();
		String ctxPath = request.getContextPath();
		String cmd = uri.substring(ctxPath.length());

		System.out.println("요청 url : " + cmd);

		if (cmd.equals("/toProduct.pro")) { // 전체 상품 목록 이동 요청
			int currentPage = Integer.parseInt(request.getParameter("currentPage"));
			System.out.println("currentPage : " + currentPage);

			ProductService service = new ProductService();
			HashMap<String, Object> naviMap = service.getPageNavi(currentPage);
			ArrayList<ProductDTO> list = service.getProductList((int) naviMap.get("currentPage"));

			if (list != null) {
				RequestDispatcher rd = request.getRequestDispatcher("/product/product.jsp");
				request.setAttribute("naviMap", naviMap);
				request.setAttribute("list", list);
				rd.forward(request, response);
			}
		}else if (cmd.equals("/toAdminProduct.pro")) { // 전체 상품 목록 이동 요청
			int currentPage = Integer.parseInt(request.getParameter("currentPage"));
			System.out.println("currentPage : " + currentPage);

			ProductService service = new ProductService();
			HashMap<String, Object> naviMap = service.getPageNavi(currentPage);
			ArrayList<ProductDTO> list = service.getProductList((int) naviMap.get("currentPage"));

			if (list != null) {
				RequestDispatcher rd = request.getRequestDispatcher("/admin/product.jsp");
				request.setAttribute("naviMap", naviMap);
				request.setAttribute("list", list);
				rd.forward(request, response);
			}
		} else if (cmd.equals("/toAdminProduct.pro")) { // 관리자 제품관리
			int currentPage = Integer.parseInt(request.getParameter("currentPage"));
			System.out.println("currentPage : " + currentPage);

			ProductService service = new ProductService();
			HashMap<String, Object> naviMap = service.getPageNavi(currentPage);
			ArrayList<ProductDTO> list = service.getProductList((int) naviMap.get("currentPage"));

			if (list != null) {
				RequestDispatcher rd = request.getRequestDispatcher("/admin/product.jsp");
				request.setAttribute("naviMap", naviMap);
				request.setAttribute("list", list);
				rd.forward(request, response);
			}
		} else if (cmd.equals("/toRegister.pro")) { // 상품 등록 페이지 이동 요청
			response.sendRedirect("/product/register.jsp");
		} else if (cmd.equals("/registerProc.pro")) { // 상품 등록 처리 후 이동 요청
			// file 영역
			String filePath = request.getServletContext().getRealPath("product_img"); // 이미지가 실제 저장된 폴더 : product_img
			File dir = new File(filePath);
			if (!dir.exists())
				dir.mkdir();
			int fileSize = 1024 * 1024 * 10;

			try {
				MultipartRequest multi = new MultipartRequest(request, filePath, fileSize, "utf-8",
						new DefaultFileRenamePolicy());
				String product_code = multi.getParameter("product_code");
				String product_name = multi.getParameter("product_name");
				int price = Integer.parseInt(multi.getParameter("price"));
				String simple_content = multi.getParameter("simple_content");
				String main_content = multi.getParameter("main_content");
				long written_product_date = System.currentTimeMillis();
				String img_origin_name = multi.getOriginalFileName("productIMG"); // form으로부터 얻어온 이미지의 name = productIMG
				String img_system_name = multi.getFilesystemName("productIMG");

				System.out.println(product_code + " : " + product_name + " : " + price + " : " + simple_content + " : "
						+ main_content);
				System.out.println("oriName : " + img_origin_name);
				System.out.println("sysName : " + img_system_name);

				int rs = dao.insert(new ProductDTO(product_code, product_name, price, simple_content, main_content,
						written_product_date, img_origin_name, img_system_name));

				if (rs != -1)
					response.sendRedirect("/toAdminProduct.pro?currentPage=1");
			} catch (Exception e) {
				e.printStackTrace();
				response.sendRedirect("${pageContext.request.contextPath}/errorPage.jsp");
			}
		} else if (cmd.equals("/product_codeCheckPopup.pro")) { // 제품 코드 확인 팝업창 띄우기
			response.sendRedirect("/product/product_codeCheckPopup.jsp");
		} else if(cmd.equals("/product_codeCheckProc.pro")){ // 제품 코드 전송 받은 후 중복 여부 확인
			String product_codeInput = request.getParameter("product_codeInput");
			System.out.println("product_code : " + product_codeInput);
			
			
			try {
				boolean rs = dao.checkProduct_code(product_codeInput);
				RequestDispatcher rd = request.getRequestDispatcher("/product/product_codeCheckPopup.jsp");
				request.setAttribute("product_codeInput", product_codeInput);
				if(rs) { // true라면 즉 중복된다면
					request.setAttribute("rs", "unavailable");
				}else { // false 라면 즉 중복되지 않는다면
					request.setAttribute("rs", "available");
				}
				rd.forward(request, response);
			} catch (Exception e) {
				e.printStackTrace();
				response.sendRedirect("${pageContext.request.contextPath}/errorPage.jsp");
			}
		} else if (cmd.equals("/detailView.pro")) { // 제품 상세 페이지로 이동
			String product_code = request.getParameter("product_code");
			int currentPage = Integer.parseInt(request.getParameter("currentPage"));
			
			try {
				ProductDTO dto = dao.selectByCode(product_code);
				if (dto != null) {
					RequestDispatcher rd = request.getRequestDispatcher("/product/detailView.jsp");
					request.setAttribute("dto", dto);
					request.setAttribute("currentPage", currentPage);
					rd.forward(request, response);
				}
			} catch (Exception e) {
				e.printStackTrace();
				response.sendRedirect("${pageContext.request.contextPath}/errorPage.jsp");
			}
		} else if (cmd.equals("/toDetailView.pro")) { // 제품의 currentPage와 리뷰의 currentPage_cmt를 구별하여 전송
			int currentPage = Integer.parseInt(request.getParameter("currentPage"));
			int currentPage_cmt = Integer.parseInt(request.getParameter("currentPage_cmt"));
			System.out.println("currentPage : " + currentPage);
			System.out.println("currentPage_cmt : " + currentPage_cmt);
			String product_code = request.getParameter("product_code");

			CommentService service = new CommentService();
			HashMap<String, Object> naviMap_cmt = service.getPageNavi(currentPage_cmt, product_code);

			RequestDispatcher rd = request.getRequestDispatcher(
					"/detailView.pro?product_code=" + product_code + "&currentPage=" + currentPage);
			request.setAttribute("naviMap_cmt", naviMap_cmt);
			rd.forward(request, response);
		} else if (cmd.equals("/toModify.pro")) { // 상품 수정 페이지 이동 요청
			response.sendRedirect("/product/modify.jsp");
		} else if (cmd.equals("/modifyProc.pro")) { // 상품 수정 처리 후 이동
			// file 영역
			String filePath = request.getServletContext().getRealPath("product_img");
			File dir = new File(filePath);
			if (!dir.exists())
				dir.mkdir();
			int fileSize = 1024 * 1024 * 10;

			try {
				MultipartRequest multi = new MultipartRequest(request, filePath, fileSize, "utf-8",
						new DefaultFileRenamePolicy());
				String product_code = multi.getParameter("product_code");
				String product_name = multi.getParameter("product_name");
				int price = Integer.parseInt(multi.getParameter("price"));
				String simple_content = multi.getParameter("simple_content");
				String main_content = multi.getParameter("main_content");
				String img_origin_name = multi.getOriginalFileName("productIMG");
				String img_system_name = multi.getFilesystemName("productIMG");

				System.out.println(product_code + " : " + product_name + " : " + price + " : " + simple_content + " : "
						+ main_content);
				System.out.println("oriName : " + img_origin_name);
				System.out.println("sysName : " + img_system_name);

				int rs = dao.modfifyByCode(product_code, product_name, price, simple_content, main_content,
						img_origin_name, img_system_name);

				if (rs != -1)
					response.sendRedirect("/toAdminProduct.pro?currentPage=1");
			} catch (Exception e) {
				e.printStackTrace();
				response.sendRedirect("${pageContext.request.contextPath}/errorPage.jsp");
			}
		} else if (cmd.equals("/confirm.pro")) { // 수정 창에서 받은 코드의 정보를 보내줌
			String product_code = request.getParameter("product_code");
			
			try {
				ProductDTO dto = dao.selectByCode(product_code);
				System.out.println("받은 코드 : " + product_code);
				if (dto != null) {
					RequestDispatcher rd = request.getRequestDispatcher("/product/modify.jsp");
					request.setAttribute("dto", dto);
					rd.forward(request, response);
				} else {
					RequestDispatcher rd = request.getRequestDispatcher("/product/modify.jsp");
					request.setAttribute("product_code", "없음");
					rd.forward(request, response);
				}
			} catch (Exception e) {
				e.printStackTrace();
				response.sendRedirect("${pageContext.request.contextPath}/errorPage.jsp");
			}
		} else if (cmd.equals("/toDelete.pro")) { // 상품 삭제 페이지로 이동 요청
			response.sendRedirect("/deleteProc.pro?currentPage=1");
		} else if (cmd.equals("/deleteProc.pro")) { // 상품 삭제 처리 후 이동
			int currentPage = Integer.parseInt(request.getParameter("currentPage"));
			System.out.println("currentPage : " + currentPage);
			ProductService service = new ProductService();
			HashMap<String, Object> naviMap = service.getPageNavi(currentPage);
			ArrayList<ProductDTO> list = service.getProductList((int) naviMap.get("currentPage"));

			if (list != null) {
				request.setAttribute("naviMap", naviMap);
				request.setAttribute("list", list);

				String product_code = request.getParameter("product_code");
				
				try {
					ProductDTO dto = dao.selectByCode(product_code);
					if (product_code == null) {
						RequestDispatcher rd = request.getRequestDispatcher("/product/delete.jsp");
						request.setAttribute("product_code", "첫 페이지");
						rd.forward(request, response);
					} else {
						if (dto != null) {
							int rs = dao.deleteByCode(product_code);
							if (rs != -1)
								response.sendRedirect("/deleteProc.pro?currentPage=1");
						} else {
							RequestDispatcher rd = request.getRequestDispatcher("/product/delete.jsp");
							request.setAttribute("product_code", "없음");
							rd.forward(request, response);
						}
					}
				} catch (Exception e) {
					e.printStackTrace();
					response.sendRedirect("${pageContext.request.contextPath}/errorPage.jsp");
				}
				
			}
		}
	}
}
