package suited.com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;

import org.apache.tomcat.dbcp.dbcp2.BasicDataSource;

import suited.com.dto.SurveyDTO;

public class SurveyDAO {
	private BasicDataSource bds;

	public SurveyDAO() {
		try {
			Context iCtx = new InitialContext();
			Context envCtx = (Context) iCtx.lookup("java:comp/env");
			bds = (BasicDataSource) envCtx.lookup("jdbc/bds");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public Connection getConnection() throws Exception {
		return bds.getConnection();
	}
   
   public int countAll() {
      String sql = "select count(*) from tbl_survey";
      
      try(Connection conn = this.getConnection();
         PreparedStatement pstmt = conn.prepareStatement(sql);) {
         
         ResultSet rs = pstmt.executeQuery();
         
         if(rs.next()) {
            return rs.getInt(1);
         }
      }catch(Exception e) {
         e.printStackTrace();
      }
      return -1;
   }
   
   // 설문 제출
   public int insert(SurveyDTO dto) {
      String sql = "insert into tbl_survey values(seq_survey.nextval, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
      
      try(Connection con = this.getConnection();
         PreparedStatement pstmt = con.prepareStatement(sql);){
         
         pstmt.setString(1, dto.getName());
         pstmt.setString(2, dto.getGender());
         pstmt.setInt(3, dto.getAge());
         pstmt.setString(4, dto.getUncomfort1());
         pstmt.setString(5, dto.getUncomfort2());
         pstmt.setString(6, dto.getUncomfort3());
         pstmt.setInt(7, dto.getHeight());
         pstmt.setInt(8, dto.getWeight());
         pstmt.setString(9, dto.getExercise());
         pstmt.setString(10, dto.getActivity());
         pstmt.setString(11, dto.getEating_habits());
         pstmt.setString(12, dto.getFavorite_food());
         pstmt.setString(13, dto.getFamily_disease());
         pstmt.setString(14, dto.getHealth_checkup());
         pstmt.setString(15, dto.getSupplements());
         pstmt.setString(16, dto.getSources());
         pstmt.setString(17, dto.getEmail());
         pstmt.setInt(18, dto.getBMI());
         
         int rs = pstmt.executeUpdate();
         if(rs != -1) return rs;         
      }catch(Exception e) {
         e.printStackTrace();
      }
      return -1;
   }
   
   // 설문 조회
   public ArrayList<SurveyDTO> selectAll() {
      String sql = "select * from tbl_survey";
      
      try(Connection con = this.getConnection();
         PreparedStatement pstmt = con.prepareStatement(sql);) {
         
         ResultSet rs = pstmt.executeQuery();
         
         ArrayList<SurveyDTO> list = new ArrayList<>();
         
         while(rs.next()) {
            int seq_survey = rs.getInt("seq_survey");
            String name = rs.getString("name");
            String gender = rs.getString("gender");
            int age = rs.getInt("age");
            String uncomfort1 = rs.getString("uncomfort1");
            String uncomfort2 = rs.getString("uncomfort2");
            String uncomfort3 = rs.getString("uncomfort3");
            int height = rs.getInt("height");
            int weight = rs.getInt("weight");
            String exercise = rs.getString("exercise");
            String activity = rs.getString("activity");
            String eating_habits = rs.getString("eating_habits");
            String favorite_food = rs.getString("favorite_food");
            String family_disease = rs.getString("family_disease");
            String health_checkup = rs.getString("health_checkup");
            String supplements = rs.getString("supplements");
            String sources = rs.getString("sources");
            String email = rs.getString("email");
            int bmi = rs.getInt("bmi");
            list.add(new SurveyDTO(seq_survey, name, gender, age, uncomfort1, 
                  uncomfort2, uncomfort3, height, weight, exercise, activity, 
                  eating_habits, favorite_food, family_disease, health_checkup, 
                  supplements, sources, email, bmi));
         }
         return list;
      }catch(Exception e) {
         e.printStackTrace();
      }
      return null;
   }
   
   public int getSeq() {
      String sql = "select seq_survey.currval from dual";
      
      try(Connection con = this.getConnection();
         PreparedStatement pstmt = con.prepareStatement(sql);){
         ResultSet rs = pstmt.executeQuery();
         
         while(rs.next()) {
            int seq_survey = rs.getInt("currval");
            return seq_survey;
         }
      } catch(Exception e) {
         e.printStackTrace();
      }
      return -1;
   }
   
   public SurveyDTO selectBySeq(int seq_survey) {
      String sql = "select * from tbl_survey where seq_survey = ?";
      
      try(Connection con = this.getConnection();
         PreparedStatement pstmt = con.prepareStatement(sql);) {
         pstmt.setInt(1, seq_survey);
         ResultSet rs = pstmt.executeQuery();
         
         SurveyDTO dto = new SurveyDTO();
         if(rs.next()) {
            dto.setSeq_survey(rs.getInt("seq_survey"));
            dto.setName(rs.getString("name"));
            dto.setGender(rs.getString("gender"));
            dto.setAge(rs.getInt("age"));
            dto.setUncomfort1(rs.getString("uncomfort1"));
            dto.setUncomfort2(rs.getString("uncomfort2"));
            dto.setUncomfort3(rs.getString("uncomfort3"));
            dto.setHeight(rs.getInt("height"));
            dto.setWeight(rs.getInt("weight"));
            dto.setExercise(rs.getString("exercise"));
            dto.setActivity(rs.getString("activity"));
            dto.setEating_habits(rs.getString("eating_habits"));
            dto.setFavorite_food(rs.getString("favorite_food"));
            dto.setFamily_disease(rs.getString("family_disease"));
            dto.setHealth_checkup(rs.getString("health_checkup"));
            dto.setSupplements(rs.getString("supplements"));
            dto.setSources(rs.getString("sources"));
            dto.setEmail(rs.getString("email"));
            dto.setBMI(rs.getInt("bmi"));
            return dto;
         }
      } catch (Exception e) {
         e.printStackTrace();
      }
      return null;
   }
}