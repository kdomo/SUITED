package suited.com.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Properties;
import java.util.Random;

import javax.mail.Address;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import suited.com.dao.CertifiedDAO;
import suited.com.dao.MemberDAO;
import suited.com.dto.CertifiedDTO;
import suited.com.dto.CommentDTO;
import suited.com.dto.MemberDTO;
import suited.com.service.CommentService;
import suited.com.utils.EncryptionUtils;
import suited.com.utils.Gmail;

/**
 * Servlet implementation class MemberController
 */
@WebServlet("*.mem")
public class MemberController extends HttpServlet {

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
		String uri = request.getRequestURI();
		String ctxPath = request.getContextPath();
		String cmd = uri.substring(ctxPath.length());
		HttpSession session = request.getSession();
		MemberDAO memberDAO = new MemberDAO();
		CertifiedDAO certifiedDAO = new CertifiedDAO();
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		System.out.println(cmd);

		if (cmd.equals("/toLogin.mem")) {
			response.sendRedirect("/member/login.jsp");
		} else if (cmd.equals("/loginProc.mem")) { // ???????????????????????? ?????????????????? ????????????
			String id = request.getParameter("id");
			String password = EncryptionUtils.getSHA256(request.getParameter("password"));
			try {
				boolean rs = memberDAO.login(id, password);
				if (rs) {// ????????? ?????? ???
					System.out.println(memberDAO.adminConfirm(id));
					if(memberDAO.adminConfirm(id)) { // ??????????????? ?????????
						out.write("admin");
					}else { 						// ???????????? ????????????
						try {
							String getChecked = certifiedDAO.getChecked(id); // ???????????? ???????????? ??????????????? ??????
							if (getChecked.equals("1")) { // ???????????????
								MemberDTO dto = memberDAO.selectById(id);
								HashMap<String, String> map = new HashMap<String, String>();
								map.put("id", id);
								map.put("password", dto.getPassword());
								map.put("nickname", dto.getNickname());
								map.put("name", dto.getName());
								map.put("gender", dto.getGender());
								map.put("age", Integer.toString(dto.getAge()));
								map.put("address", dto.getAddress());
								map.put("phone", dto.getPhone());
								map.put("kakao_login", dto.getKakao_login());
								map.put("withdrawal_yn", dto.getWithdrawal_yn());
								map.put("admin_yn", dto.getAdmin_yn());
								System.out.println("????????? ??????");
								session.setAttribute("loginSession", map);
								out.write("loginSuccess");
							} else { // ?????? ????????? ???????????? ????????????
								out.write("emailFail");
							}
						} catch (Exception e) {
							e.printStackTrace();
							response.sendRedirect("/errorPage.jsp");
						}
					}
				} else {
					out.write("loginFail");
				}
			} catch (Exception e) {
				e.printStackTrace();
				response.sendRedirect("/errorPage.jsp");
			}

		}else if (cmd.equals("/kakaologinProc.mem")) { // ???????????????????????? ?????????????????? ????????????
			String id = request.getParameter("id");
			String kakao_value = request.getParameter("kakao_value");
			try {
				boolean rs = memberDAO.kakaoLogin(kakao_value);
				if (rs) {// ????????? ?????? ???
					try {
							MemberDTO dto = memberDAO.selectByKakaoValue(kakao_value);
							HashMap<String, String> map = new HashMap<String, String>();
							map.put("id", dto.getId());
							map.put("password", dto.getPassword());
							map.put("nickname", dto.getNickname());
							map.put("name", dto.getName());
							map.put("gender", dto.getGender());
							map.put("age", Integer.toString(dto.getAge()));
							map.put("address", dto.getAddress());
							map.put("phone", dto.getPhone());
							map.put("kakao_login", dto.getKakao_login());
							map.put("withdrawal_yn", dto.getWithdrawal_yn());
							map.put("admin_yn", dto.getAdmin_yn());
							System.out.println("????????? ??????");
							session.setAttribute("loginSession", map);
							response.sendRedirect("/");
					} catch (Exception e) {
						e.printStackTrace();
						response.sendRedirect("/errorPage.jsp");
					}
				} else {
					out.write("loginFail");
				}
			} catch (Exception e) {
				e.printStackTrace();
				response.sendRedirect("/errorPage.jsp");
			}

		} else if (cmd.equals("/logoutProc.mem")) { // ???????????? ????????? ????????????
			System.out.println("????????????");
			session.removeAttribute("loginSession");
			response.sendRedirect("/member/login.jsp");
		} else if (cmd.equals("/toSignup.mem")) {
			String kakao_value = request.getParameter("kakao_value");
			if (request.getParameter("kakao_value") != "0") {
				System.out.println(kakao_value);
				try {
					String id = memberDAO.getKakaoMember(kakao_value); //?????? ????????? ???????????? ??????
					if (id != null) { //????????? ???????????????
						RequestDispatcher rd = request.getRequestDispatcher("/kakaologinProc.mem");
						request.setAttribute("id", id);
						request.setAttribute("kakao_value", kakao_value);
						rd.forward(request, response);
					} else { //????????? ???????????? ?????????
						RequestDispatcher rd = request.getRequestDispatcher("/member/signup.jsp");
						if (request.getParameter("kakao_id") != null) {
							String kakao_id = request.getParameter("kakao_id");
							request.setAttribute("kakao_id", kakao_id);
						}
						if (request.getParameter("gender") != null) {
							String gender = request.getParameter("gender");
							request.setAttribute("gender", gender);
						}
						request.setAttribute("kakao_value", kakao_value);
						rd.forward(request, response);
					}
				} catch (Exception e) {
					e.printStackTrace();
					response.sendRedirect("/errorPage.jsp");
				}

			}else {
				response.sendRedirect("/member/signup.jsp");
			}
		} else if (cmd.equals("/idCheckProc.mem")) {
			String value = request.getParameter("value");
			boolean rs;
			try {
				rs = memberDAO.idCheck(value);
				if (!rs) {
					out.write("idCheckSuccess");
				} else {
					out.write("idCheckFail");
				}
			} catch (Exception e) {
				e.printStackTrace();
				response.sendRedirect("/errorPage.jsp");
			}
		} else if (cmd.equals("/nicknameCheckProc.mem")) {
			String value = request.getParameter("value");
			System.out.println(value);
			boolean rs;
			try {
				rs = memberDAO.nicknameCheck(value);
				if (!rs) {
					out.write("nicknameCheckSuccess");
				} else {
					out.write("nicknameCheckFail");
				}
			} catch (Exception e) {
				e.printStackTrace();
				response.sendRedirect("/errorPage.jsp");
			}
		} else if (cmd.equals("/signupProc.mem")) { // ?????????????????? ????????? ????????????
			String id = request.getParameter("id");
			String kakao_value = request.getParameter("kakao_value");
			String password = EncryptionUtils.getSHA256(request.getParameter("password"));
			String nickname = request.getParameter("nickname");
			String name = request.getParameter("name");
			String gender = request.getParameter("gender");
			int age = Integer.parseInt(request.getParameter("age"));
			String address = request.getParameter("address");
			String phone = request.getParameter("phone");
			System.out.println(id + " : " + password + " : " + nickname + " : " + name + " : " + gender + " : " + age
					+ " : " + address + " : " + phone + " : ");

			try {
				int rs = memberDAO.insert(new MemberDTO(id, password, nickname, name, gender, age, address, phone,
						kakao_value, System.currentTimeMillis(), "0", "0"));
				if (rs != -1) {
					System.out.println("insert ??????");
					if (kakao_value.equals("0")) {
						int cfRs = certifiedDAO.insert(new CertifiedDTO(id, EncryptionUtils.getSHA256(id), "0"));
						if (cfRs != -1) {
							System.out.println("???????????? ??????");
							RequestDispatcher rd = request.getRequestDispatcher("/sendEmail.mem");
							request.setAttribute("id", id);
							request.setAttribute("name", "name");
							request.setAttribute("rs", "signSuccess");
							rd.forward(request, response);
						}
					} else {
						RequestDispatcher rd = request.getRequestDispatcher("/kakaologinProc.mem");
						request.setAttribute("id", id);
						request.setAttribute("kakao_value", kakao_value);
						rd.forward(request, response);
					}
				}
			} catch (Exception e) {
				RequestDispatcher rd = request.getRequestDispatcher("/member/login.jsp");
				request.setAttribute("rs", "signFail");
				rd.forward(request, response);
				e.printStackTrace();
				response.sendRedirect("/errorPage.jsp");
			}

		} else if (cmd.equals("/sendEmail.mem")) {
			String rs = request.getParameter("rs");
			String id = request.getParameter("id");
			String name = request.getParameter("name");
			String idHash = EncryptionUtils.getSHA256(id);

			String host = "http://3.37.55.164:8080/"; //aws
			
//			String host = "www.localhost:8080/";

			String from = "khsuited@gmail.com";

			String to = id;

			String subject = "?????? ????????? SUITED ????????? ??????";
			String content = "<p style=\"text-align: center;\"><font color=\"#000000\" face=\"Nanum Gothic\"><span style=\"font-size: 48px;\"><b>SUITED</b></span></font></p>"
					+ "<br><center>" + name + "??? " + " ???????????????.<br>" + "?????? ????????? SUITED ??????????????? ??????????????????.<br>"
					+ "????????? ???????????? ????????? ?????? ????????? ????????? ?????? ????????????.<br>" + "<br>" + "<a href='" + host + "emailCheckProc.mem?code="
					+ idHash + "&id=" + id + "'>" + "<img src="
					+ "'https://i.esdrop.com/d/JPuqbjQkES.jpg' alt='????????? ????????????' width='156' heigh='24'></a><br>"
					+ "<br><br>?????? ?????? ????????? ???????????? ???????????????<br>" + "??? ????????? ????????? ????????? ????????????.<br>" + "???????????? ????????? ???????????? ?????? ????????? ???????????????.<br>"
					+ "<br>???????????????." + "<br>-SUITED ?????????-<br>cs@suited.com<br><br></center>";

			Properties p = new Properties();
			p.put("mail.smtp.user", from);
			p.put("mail.smtp.starttls.enable", "true");
			p.put("mail.smtp.host", "smtp.gmail.com");
			p.put("mail.smtp.auth", "true");
			p.put("mail.smtp.port", "465");
			p.put("mail.smtp.ssl.enable", "true");
			p.put("mail.smtp.ssl.protocols", "TLSv1.2");
			try {
				Authenticator auth = new Gmail();
				Session ses = Session.getInstance(p, auth);
				ses.setDebug(true);
				MimeMessage msg = new MimeMessage(ses);
				msg.setSubject(subject, "UTF-8");
				Address fromAddr = new InternetAddress(from);
				msg.setFrom(fromAddr);
				Address toAddr = new InternetAddress(to);
				msg.addRecipient(Message.RecipientType.TO, toAddr);
				msg.setContent(content, "text/html;charset=UTF-8");
				Transport.send(msg);
				RequestDispatcher rd = request.getRequestDispatcher("/member/login.jsp");
				request.setAttribute("rs", "signSuccess");
				rd.forward(request, response);
			} catch (Exception e) {
				e.printStackTrace();
				response.sendRedirect("/errorPage.jsp");
			}
		} else if (cmd.equals("/emailCheckProc.mem")) { // ???????????? ??????????????? ????????? ????????????
			String code = request.getParameter("code");
			String id = request.getParameter("id");
			try {
				if (certifiedDAO.getIdHashById(id).equals(code)) { // ????????? ?????? ??????
					int rs = certifiedDAO.setChecked(id); // certified idHashChecked "1"??? ??????
					if (rs != -1) {
						RequestDispatcher rd = request.getRequestDispatcher("/member/login.jsp");
						request.setAttribute("rs", "emailSuccess");
						rd.forward(request, response);
					}
				} else { // ????????? ?????? ??????
					RequestDispatcher rd = request.getRequestDispatcher("/member/login.jsp");
					request.setAttribute("rs", "emailFail");
					rd.forward(request, response);
				}
			} catch (Exception e) {
				e.printStackTrace();
				response.sendRedirect("/errorPage.jsp");
			}
			System.out.println(code);
		} else if(cmd.equals("/toMypageConfirm.mem")) {
			response.sendRedirect("/member/mypageConfirm.jsp");
		} else if(cmd.equals("/toMypage.mem")) {
			int currentPage = Integer.parseInt(request.getParameter("currentPage"));
			String token = request.getParameter("token");
			String page = request.getParameter("page");
			System.out.println(token + " : " + page);
//			RequestDispatcher rd = request.getRequestDispatcher("/member/mypage.jsp");
			request.setAttribute("token", token);
			request.setAttribute("page", page);
//			rd.forward(request, response);
			
//			int currentPage = Integer.parseInt(request.getParameter("currentPage"));
//			System.out.println("currentPage : " + currentPage);
//			
			CommentService service = new CommentService();
			HashMap<String, Object> naviMap = service.getPageNavi2(currentPage);
			ArrayList<CommentDTO> list = service.getCommentList2((int) naviMap.get("currentPage"));
//			
			if(list != null) {
				RequestDispatcher rd = request.getRequestDispatcher("/member/mypage.jsp");
				request.setAttribute("naviMap", naviMap);
				request.setAttribute("list", list);
				rd.forward(request, response);
			}
			
			
		} else if(cmd.equals("/passwordConfirm.mem")) {
			HashMap<String, String> loginSession = (HashMap)session.getAttribute("loginSession");
			String id = loginSession.get("id");
			String password = EncryptionUtils.getSHA256(request.getParameter("passwordConfirm"));
			System.out.println(id + " : " + password);
			try {
				boolean rs = memberDAO.login(id, password);
				if (rs) {// ????????? ?????? ???
						out.write("ConfirmSuccess");
				}else {
					out.write("ConfirmFail");
				}
			}catch (Exception e) {
				e.printStackTrace();
				response.sendRedirect("/errorPage.jsp");
			}
		} else if(cmd.equals("/updateProc.mem")) {
			HashMap<String, String> loginSession = (HashMap)session.getAttribute("loginSession");
			String id = loginSession.get("id");
			String password = request.getParameter("password");
			String nickname = request.getParameter("nickname");
			String address = request.getParameter("address");
			String phone = request.getParameter("phoneDnone");
			
			try {
				int rs = memberDAO.updateById(id,password,nickname,address,phone);
				if(rs != -1) {
					out.write("updateSuccess");
				}else {
					out.write("updateFail");
				}
			} catch (Exception e) {
				e.printStackTrace();
				response.sendRedirect("/errorPage.jsp");
			}
		} else if(cmd.equals("/getHashPw.mem")) {
			String password = request.getParameter("password");
			password = EncryptionUtils.getSHA256(password);
			out.write(password);
		}
	}
}
