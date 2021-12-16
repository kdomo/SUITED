package suited.com.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import suited.com.dao.SurveyDAO;
import suited.com.dto.SurveyDTO;


@WebServlet("*.srv")
public class SurveyController extends HttpServlet {
   protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      actionDo(request, response);
   }
   protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      actionDo(request, response);
   }
   
   private void actionDo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      request.setCharacterEncoding("utf-8");
      HttpSession session = request.getSession();
      SurveyDAO surveyDAO = new SurveyDAO();
      
      String uri = request.getRequestURI();
      String ctxPath = request.getContextPath();
      String cmd = uri.substring(ctxPath.length());
      
      System.out.println("입력 url : " + cmd);
      
      if(cmd.equals("/toSurvey.srv")) {
         response.sendRedirect("/survey/Survey.jsp");
      }else if(cmd.equals("/surveyProc.srv")) { // 설문 제출
         try {
            String name = request.getParameter("name");
            String gender = request.getParameter("gender");
            int age = Integer.parseInt(request.getParameter("age"));
            String uncomfort1 = request.getParameter("uncomfort1");
            String uncomfort2 = request.getParameter("uncomfort2");
            String uncomfort3 = request.getParameter("uncomfort3");
            int height = Integer.parseInt(request.getParameter("height"));
            int weight = Integer.parseInt(request.getParameter("weight"));
            String exercise = request.getParameter("exercise");
            String activity = request.getParameter("activity");
            String eating_habits = request.getParameter("eating_habits");
            String favorite_food = request.getParameter("favorite_food");
            String family_disease = request.getParameter("family_disease");
            String health_checkup = request.getParameter("health_checkup");
            String supplements = request.getParameter("supplements");
            String sources = request.getParameter("sources");
            String email = request.getParameter("email");

            int heightForBmi = height / 100;
            int bmi = weight / (heightForBmi * heightForBmi);

            SurveyDTO list = new SurveyDTO(0, name, gender, age, uncomfort1, uncomfort2, uncomfort3, height,
                  weight, exercise, activity, eating_habits, favorite_food, family_disease, health_checkup,
                  supplements, sources, email, bmi);
            
            surveyDAO.insert(list);
         }catch(Exception e) {
            e.printStackTrace();
         }
         response.sendRedirect("/toSurveyResult.srv");
      }else if(cmd.equals("/toSurveyResult.srv")) {
         int seq_survey = surveyDAO.getSeq();
         System.out.println("seq_survey : " + seq_survey);
         SurveyDTO dto = surveyDAO.selectBySeq(seq_survey);
         
         RequestDispatcher rd = request.getRequestDispatcher("/survey/surveyResult.jsp");
         request.setAttribute("dto", dto);
         rd.forward(request, response);
      }else if(cmd.equals("/toSurveyList.srv")) { // 설문 목록 조회
         ArrayList<SurveyDTO> list = surveyDAO.selectAll();
         
         if(list != null) {
            RequestDispatcher rd = request.getRequestDispatcher("/survey/surveyList.jsp");
            request.setAttribute("list", list);
            rd.forward(request, response);
         }
      }else if(cmd.equals("toPayment.srv")) {
         if(session.getAttribute("loginSession") != null) { // 결제창으로
            
         }else { // 로그인 페이지로
            PrintWriter out = response.getWriter();
            out.println("<script>alert('비회원은 결제가 불가합니다. 로그인 페이지로 넘어갑니다.'); "
                           + "location.href='/member/login.jsp';</script>");
            out.flush();
         }
      }else if(cmd.equals("toMain.srv")) {
         response.sendRedirect("/test.jsp");
      }
   }
}