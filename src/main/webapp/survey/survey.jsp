<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%-- JSTL CDN --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나에게 딱 맞는 SUITED</title>
<link
   href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
   rel="stylesheet"
   integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
   crossorigin="anonymous">
<!-- 부트스트랩 CDN -->

<script src="https://code.jquery.com/jquery-3.6.0.js"
   integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
   crossorigin="anonymous"></script>
<!-- jquery CDN-->
<script
   src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
   integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
   crossorigin="anonymous"></script>
<style>
@import
   url('https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap');
</style>
<!-- 배달의민족 도현 글꼴 -->

<style>
* {
   box-sizing: border-box;
   font-family: 'Do Hyeon', sans-serif;
}

html {
   width: 100vw;
   height: 100%;
}

body {
   width: 1024pw;
   height: 100%;
}

a {
   text-decoration: none;
   color: black;
}

/* Navi 영역*/
.navber {
   width: 82.6vw;
   margin: auto;
   padding-top: 30px;
   padding-bottom: 30px;
   background-color: white;
   position: fixed;
   left: 50%;
   transform: translateX(-50%);
   z-index: 1;
}

.nav-items {
   margin: auto;
   width: 100%;
}

.nav-items>div {
   padding: 0px 10px;
}

a:hover {
   text-decoration: none;
   color: green;
   border-bottom: 2px solid green;
}

.navi-logo {
   text-align: left;
}

.navi-menu {
   text-align: center;
}

.navi-cart {
   text-align: right;
}

.navi-onButtons {
   padding-top: 92px;
   margin: auto;
   width: 82.6vw;
   height: 0;
   display: none;
}

.navi-onButtons>div {
   padding: 10px 0px;
   text-align: center;
}
.badge{
height:16px;
line-height:8px;
}

/* main 영역 */
.main {
   padding-top: 112px;
   width: 82.6vw;
   margin: auto;
}

/* footer 영역 */
.footer {
   margin: auto;
   width: 82.6vw;
}

.footer-top {
   margin: auto;
   width: 82.6vw;
}

.footer-top>ul {
   padding: 20px 0px;
   margin: 0px;
   border-bottom: 2px solid gray;
}

.footer-top>ul>li {
   list-style: none;
   float: left;
   margin-right: 10px;
}

.footer-body {
   margin: auto;
   width: 82.6vw;
   border-bottom: 2px solid gray;
   padding-bottom: 20px;
}

.footer-body-left {
   margin-top: 20px;
   padding: 0px;
}

.footer-body-left>p {
   padding: 0px;
   margin: 0px;
}

.footer-body-right {
   margin-top: 20px;
   padding: 0px;
}

.footer-body-right>p {
   padding: 0px;
   margin: 0px;
}
#carouselExampleControlsNoTouching {
   width: 500px;
   height: 500px;
   margin: auto;
   background-color: gray;
}
</style>
</head>
<body>
   <nav class="navber">
      <div class="row nav-items d-flex justify-content-center">
         <div class="col-2 col-xl-2 navi-logo">
            <a href="${pageContext.request.contextPath }/"><img
               src="../imgs/logo.png" width="80px"></a>
         </div>
         <c:choose>
            <c:when test="${empty loginSession}">
            <div class="col-xl-3 col-5 navi-menu"></div>
            </c:when>
            <c:when test="${!empty loginSession}">
               <div class="col-xl-2 col-5 navi-menu"></div>
            </c:when>
         </c:choose>
         <div class="col-xl-1 d-none d-xl-block navi-menu">
            <a href="${pageContext.request.contextPath}/toSurvey.srv">영양제추천</a>
         </div>
         <div class="col-xl-1 d-none d-xl-block navi-menu">
            <a href="${pageContext.request.contextPath }/toProduct.pro?currentPage=1">제품보기</a>
         </div>
         <div class="col-xl-1 d-none d-xl-block navi-menu">
            <a href="${pageContext.request.contextPath}/toAllReview.co">고객리뷰</a>
         </div>
         <div class="col-xl-1 d-none d-xl-block navi-menu">
            <a href="#">스토리</a>
         </div>
         <div class="col-xl-1 d-none d-xl-block navi-menu">
            <a href="${pageContext.request.contextPath}/toInquiry.in?currentPage=1">고객센터</a>
         </div>
         <c:choose>
            <c:when test="${empty loginSession}">
            </c:when>
            <c:when test="${!empty loginSession}">
               <div class="col-xl-1 d-none d-xl-block navi-menu">
                  <a href="${pageContext.request.contextPath }/toMypageConfirm.mem">${loginSession.nickname} 님</a>
               </div>
            </c:when>
         </c:choose>

         <c:choose>
            <c:when test="${empty loginSession}">
               <div class="col-xl-1 d-none d-xl-block navi-menu">
                  <a href="${pageContext.request.contextPath }/toLogin.mem">로그인</a>
               </div>
            </c:when>
            <c:when test="${!empty loginSession}">
               <div class="col-xl-1 d-none d-xl-block navi-menu">
                  <a href="${pageContext.request.contextPath }/logoutProc.mem">로그아웃</a>
               </div>
            </c:when>
         </c:choose>
         <div class="col-xl-1 col-3 navi-cart">
            <a href="${pageContext.request.contextPath}/tocart.cart">cart <span id="cartCount" class="badge bg-dark rounded-pill"></span></a>
         </div>
         <div class="col-xl-0 col-2 d-xl-none navi-menu">
            <a id="btn_navi_menu"><img src="../imgs/menu.png" width="20px"
               height="24px"></a>
         </div>
      </div>
   </nav>
   <div class="row navi-onButtons">
      <div class="col-12">
         <a href="${pageContext.request.contextPath}/toSurvey.srv">영양제추천</a>
      </div>
      <div class="col-12">
         <a href="${pageContext.request.contextPath }/toProduct.pro?currentPage=1">제품보기</a>
      </div>
      <div class="col-12">
         <a href="${pageContext.request.contextPath}/toAllReview.co">고객리뷰</a>
      </div>
      <div class="col-12">
         <a href="${pageContext.request.contextPath}/toInquiry.in?currentPage=1">고객센터</a>
      </div>
      <c:choose>
         <c:when test="${empty loginSession}">
         </c:when>
         <c:when test="${!empty loginSession}">
            <div class="col-12">
         <a href="${pageContext.request.contextPath }/toMypageConfirm.mem">${loginSession.nickname} 님</a>
      </div>
         </c:when>
      </c:choose>
      
      <c:choose>
         <c:when test="${empty loginSession}">
            <div class="col-12">
               <a href="${pageContext.request.contextPath }/toLogin.mem">로그인</a>
            </div>
         </c:when>
         <c:when test="${!empty loginSession}">
            <div class="col-12">
               <a href="${pageContext.request.contextPath }/logoutProc.mem">로그아웃</a>
            </div>
         </c:when>
      </c:choose>
      <div class="col-12">
         <a href="${pageContext.request.contextPath}/toInquiry.in?currentPage=1">고객센터</a>
      </div>
   </div>

   <div class="main">
      <form action="${pageContext.request.contextPath}/surveyProc.srv"
         method="post" id="surveyForm" name="surveyForm">
         <div id="carouselExampleControlsNoTouching" class="carousel slide"
            data-bs-touch="false" data-bs-interval="false">
            <div class="carousel-inner">
               <div class="carousel-item active">
                  <h2>1.고객님의 이름을 알려주세요.</h2>
                  <input type="text" class="survey" id="name" name="name">
               </div>
               <div class="carousel-item">
                  <h2>2.고객님의 성별을 알려주세요.</h2>
                  <input type="radio" id="gender" name="gender" value="여" checked>여성<br>
                  <input type="radio" id="gender" name="gender" value="남">남성
               </div>
               <div class="carousel-item">
                  <h2>3.고객님의 나이를 알려주세요.</h2>
                  <input type="text" class="survey" id="age" name="age">세
               </div>
               <div class="carousel-item">
                  <h2>4-1.다음 중 해당하는 사항을 골라주세요.</h2>
                  <input type="radio" id="uncomfort1" name="uncomfort1" value="오메가3"
                     checked>상처가 생기면 잘 아물지 않아요.<br> <input type="radio"
                     id="uncomfort1" name="uncomfort1" value="오메가3">손끝 또는 발끝이
                  자주 저려요.<br> <input type="radio" id="uncomfort1"
                     name="uncomfort1" value="오메가3">충치가 생기고 잇몸이 자주 붓고 피가 나요.<br>
                  <input type="radio" id="uncomfort1" name="uncomfort1" value="null">해당사항이
                  없어요.
               </div>
               <div class="carousel-item">
                  <h2>4-2.다음 중 해당하는 사항을 골라주세요.</h2>
                  <input type="radio" id="uncomfort2" name="uncomfort2"
                     value="프로바이오틱스" checked>복통이나 속쓰림이 자주 발생해요.<br> <input
                     type="radio" id="uncomfort2" name="uncomfort2" value="프로바이오틱스">변비가
                  있어요.<br> <input type="radio" id="uncomfort2" name="uncomfort2"
                     value="프로바이오틱스">설사와 같은 묽은 변을 자주 보는 편이에요.<br> <input
                     type="radio" id="uncomfort2" name="uncomfort2" value="프로바이오틱스">술을
                  마실 때 얼굴이나 몸이 붉어지고 소화가 안돼요.<br> <input type="radio"
                     id="uncomfort2" name="uncomfort2" value="null">해당사항이 없어요.
               </div>
               <div class="carousel-item">
                  <h2>4-3.다음 중 해당하는 사항을 골라주세요.</h2>
                  <input type="radio" id="uncomfort3" name="uncomfort3"
                     value="히알루론산 스피루리나" checked>피부가 건조하여 벗겨지거나 머리에 비듬이 많이 생겨요.<br>
                  <input type="radio" id="uncomfort3" name="uncomfort3"
                     value="히알루론산 스피루리나">여드름이 많아 걱정이에요.<br> <input
                     type="radio" id="uncomfort3" name="uncomfort3" value="히알루론산 스피루리나">피부에
                  염증이 자주 생겨요.<br> <input type="radio" id="uncomfort3"
                     name="uncomfort3" value="히알루론산 스피루리나">입안이 헐고 입술이 자주 갈라져요.<br>
                  <input type="radio" id="uncomfort3" name="uncomfort3" value="null">해당사항이
                  없어요.
               </div>
               <div class="carousel-item">
                  <h2>5.고객님의 키를 알려주세요.</h2>
                  <input type="text" class="survey" id="height" name="height">cm
               </div>
               <div class="carousel-item">
                  <h2>6.고객님의 몸무게를 알려주세요.</h2>
                  <input type="text" class="survey" id="weight" name="weight">kg
               </div>
               <div class="carousel-item">
                  <h2>7.평소 운동을 얼마나 자주 하시나요?</h2>
                  <input type="radio" id="exercise" name="exercise" value="null"
                     checked>주 4회 이상 해요.<br> <input type="radio"
                     id="exercise" name="exercise" value="홍삼 옥타코사놀">주 2-3회 정도
                  해요.<br> <input type="radio" id="exercise" name="exercise"
                     value="홍삼 옥타코사놀">주 1회 이하로 해요.
               </div>
               <div class="carousel-item">
                  <h2>8.평소 햇빛을 받는 야외활동을 얼마나 많이 하시나요?</h2>
                  <input type="radio" id="activity" name="activity" value="null"
                     checked>하루 4시간 이상 야외활동을 해요.<br> <input type="radio"
                     id="activity" name="activity" value="비타민B">하루 1시간-4시간 사이로
                  야외활동을 해요.<br> <input type="radio" id="activity"
                     name="activity" value="비타민B">하루 1시간 이내로 야외활동을 해요.
               </div>
               <div class="carousel-item">
                  <h2>9.평소 식습관은 어떠신가요?</h2>
                  <input type="radio" id="eating_habits" name="eating_habits"
                     value="프로폴리스" checked>생선을 일주일에 3번 이상 먹어요.<br> <input
                     type="radio" id="eating_habits" name="eating_habits" value="프로폴리스">녹황색
                  채소(시금치,브로콜리 등)를 거의 매일 먹어요.<br> <input type="radio"
                     id="eating_habits" name="eating_habits" value="프로폴리스">일주일
                  동안 과일(사과 1개나 귤 3개 정도)을 4일 이상 먹어요.<br> <input type="radio"
                     id="eating_habits" name="eating_habits" value="비타민C">일주일
                  동안 4일 이상 고기(삼겹살 등 메인 요리)를 먹어요.<br> <input type="radio"
                     id="eating_habits" name="eating_habits" value="비타민C">단
                  음식(빵/과자,초콜릿,탄산음료 등)을 자주 먹어요.<br> <input type="radio"
                     id="eating_habits" name="eating_habits" value="비타민C">일주일
                  동안 식사를 5회 이상 먹지 않아요.<br> <input type="radio"
                     id="eating_habits" name="eating_habits" value="null">해당
                  사항이 없어요.
               </div>
               <div class="carousel-item">
                  <h2>10.기호 식품이 있으신가요?</h2>
                  <input type="radio" id="favorite_food" name="favorite_food"
                     value="루테인" checked>하루에 담배를 반 갑 이상 피워요.<br> <input
                     type="radio" id="favorite_food" name="favorite_food" value="루테인">하루에
                  커피를 3잔 이상 마셔요.<br> <input type="radio" id="favorite_food"
                     name="favorite_food" value="루테인">하루에 물을 2L 이하로 마셔요.<br>
                  <input type="radio" id="favorite_food" name="favorite_food"
                     value="루테인">일주일에 인스턴트 식품(라면,편의점 도시락 등)으로 3번 이상 식사를 해요.<br>
                  <input type="radio" id="favorite_food" name="favorite_food"
                     value="null">해당 사항이 없어요.
               </div>
               <div class="carousel-item">
                  <h2>11.가족이 앓고 있는 질환을 선택해주세요.</h2>
                  <input type="radio" id="family_disease" name="family_disease"
                     value="밀크씨슬" checked>간 질환<br> <input type="radio"
                     id="family_disease" name="family_disease" value="밀크씨슬">혈관
                  질환(심근경색,뇌출혈 등)<br> <input type="radio" id="family_disease"
                     name="family_disease" value="밀크씨슬">뼈/관절 질환(골다공증,골감소증 등)<br>
                  <input type="radio" id="family_disease" name="family_disease"
                     value="null">해당 사항이 없어요.
               </div>
               <div class="carousel-item">
                  <h2>12.건강검진을 언제 마지막으로 하셨나요?</h2>
                  <input type="radio" id="health_checkup" name="health_checkup"
                     value="null" checked>1년 이내에 했어요.<br> <input
                     type="radio" id="health_checkup" name="health_checkup"
                     value="null">1-2년 사이에 했어요.<br> <input type="radio"
                     id="health_checkup" name="health_checkup" value="칼슘 마그네슘 비타민D">2년
                  이상 하지 않았어요.<br> <input type="radio" id="health_checkup"
                     name="health_checkup" value="칼슘 마그네슘 비타민D">건강검진을 해본 적이
                  없어요.
               </div>
               <div class="carousel-item">
                  <h2>13.평소 영양제를 얼마나 챙겨드시나요?</h2>
                  <input type="radio" id="supplements" name="supplements"
                     value="null" checked>조금이라도 필요한 성분은 모두 섭취해요.<br> <input
                     type="radio" id="supplements" name="supplements" value="발효효소">꼭
                  필요한 성분만 섭취해요.<br> <input type="radio" id="supplements"
                     name="supplements" value="발효효소">영양제를 섭취하지 않아요.
               </div>
               <div class="carousel-item">
                  <h2>14.SUTIED를 어떻게 알게 되셨나요?</h2>
                  <input type="radio" id="sources" name="sources" value="지인 추천"
                     checked>지인 추천<br> <input type="radio" id="sources"
                     name="sources" value="인플루언서 추천">인플루언서 추천<br> <input
                     type="radio" id="sources" name="sources" value="SNS">SNS(페이스북/인스타그램
                  등)<br> <input type="radio" id="sources" name="sources"
                     value="인터넷">인터넷(블로그/기사 등)<br> <input type="radio"
                     id="sources" name="sources" value="직접 검색">직접 검색<br> <input
                     type="radio" id="sources" name="sources" value="기타">기타
               </div>
               <div class="carousel-item">
                  <h2>15.결과를 받아보기 위해 이메일을 알려주세요.</h2>
                  <input type="text" class="survey" id="email" name="email">
               </div>
               <div class="carousel-item">
                  <h2>설문이 끝났어요! 아래 버튼을 눌러 결과를 확인해보세요!</h2>
                  <input type="button" class="survey" id="btnSubmit" name="btnSubmit"
                     value="결과 확인하기">
               </div>
            </div>
            <button class="carousel-control-prev" type="button"
               data-bs-target="#carouselExampleControlsNoTouching"
               data-bs-slide="prev" id="prevBtn">
               <span class="carousel-control-prev-icon" aria-hidden="true"></span>
               <span class="visually-hidden">Previous</span>
            </button>
            <button class="carousel-control-next" type="button"
               data-bs-target="#carouselExampleControlsNoTouching"
               data-bs-slide="next" id="nextBtn" value=1>
               <span class="carousel-control-next-icon" aria-hidden="true"></span>
               <span class="visually-hidden">Next</span>
            </button>
         </div>
      </form>
   
      <script>
         console.log($(nextBtn).val());
         if ($(nextBtn).val() == 1) {
            $(prevBtn).css({
               "display" : "none"
            });
   
            $("#nextBtn").on("click", function() {
               $(nextBtn).css({"display" : "none"});
               setTimeout(function() {
                  $(nextBtn).css({"display" : "block"});
               }, 1000);
   
               let plus_val = Number($(nextBtn).val()) + 1;
               $(nextBtn).attr('value', plus_val);
               console.log($(nextBtn).val());
   
               
            });
   
            $("#prevBtn").on("click", function() {
               $(prevBtn).css({"display" : "none"});
               setTimeout(function() {
                  if ($(nextBtn).val() == 1) {
                     $(prevBtn).css({
                        "display" : "none"
                     });
                  }else{
                     $(prevBtn).css({"display" : "block"});
                  }
               }, 1000);
   
               let minus_val = Number($(nextBtn).val()) - 1;
               $(nextBtn).attr('value', minus_val);
               console.log($(nextBtn).val());
            });
         }
   
         document.getElementById("btnSubmit").addEventListener("click",
               function(e) {
                  if (document.getElementById("name").value == "") {
                     alert("이름을 입력하세요.");
                     return;
                  } else if (document.getElementById("gender").value == "") {
                     alert("성별을 선택해주세요.");
                     return;
                  } else if (document.getElementById("age").value == "") {
                     alert("나이를 입력해주세요.");
                     return;
                  } else if (document.getElementById("height").value == "") {
                     alert("신장을 입력해주세요.");
                     return;
                  } else if (document.getElementById("weight").value == "") {
                     alert("체중을 입력해주세요.");
                     return;
                  } else if (document.getElementById("email").value == "") {
                     alert("이메일을 입력해주세요.");
                     return;
                  }
   
                  document.getElementById("surveyForm").submit();
               });
      </script>
      
   </div>
   <div class="footer">
      <div class="row footer-top">
         <ul>
            <li><a href="">이용약관</a></li>
            <li><a href="">개인정보처리방침</a></li>
            <li><a href="${pageContext.request.contextPath}/toInquiry.in?currentPage=1">고객센터</a></li>
         </ul>
      </div>
      <div class="row footer-body">
         <div class="col-12 col-xl-6 footer-body-left">
            <p>SUITED | 사업자번호: 000-00-00000 | 대표: ㅇㅇㅇ</p>
            <p>개인정보취급담당자: ㅇㅇㅇ</p>
            <p>통신판매업신고: 제 2021-서울강남-00000 호</p>
            <p>유통판매업신고: 제 2021-0000000 호</p>
         </div>
         <div class="col-12 col-xl-6 footer-body-right">
            <p>고객센터</p>
            <p>고객문의: cs@suited.com | 전화: 02-0000-0000</p>
            <p>상담시간: 평일 09:00~15:30 (점심시간 12:50~13:30)</p>
            <p>제휴문의: marketing@suited.com | 전화: 02-0000-0000</p>
         </div>
      </div>
      ⓒ SUITED Inc. All Rights Reserved.
   </div>

   <script>
      $(function() {
         getCartCount();
         let onNavbar = 0; // 네비 햄버거버튼 클릭했는지 아닌지 알기위한 변수
         $('#btn_navi_menu').on('click', function() { //햄버거버튼 클릭 시
            if (onNavbar == 0) {
               $('.navi-onButtons').css({
                  "height" : "auto",
                  "display" : "block"
               }); // 세로 네비영역 열기
               onNavbar = 1;
               $('html, body').animate({
                      scrollTop : 0
                  }, 100);
                  return false;
            } else {
               $('.navi-onButtons').css({
                  "height" : "0",
                  "display" : "none"
               }); //세로 네비영역 닫기
               onNavbar = 0;
            }
         });

         $(window).resize(function() { //브라우저 크기를 조정했을때
            if (window.innerWidth > 1199) { //브라우저 크기가 1199를 넘었다면
               $('.navi-onButtons').css({
                  "height" : "0",
                  "display" : "none"
               }); //세로 네비영역 닫기
               onNavbar = 0;
            }
         });
         
         function getCartCount(){
            $.ajax({
               type : "get"
               , url : "${pageContext.request.contextPath}/countCartProc.cart"
            }).done(function(rs){
               if(rs != "fail"){
                  $('#cartCount').html(rs);
               } else {
                  alert("오류");
               }
            }).fail(function(e){
               console.log(e);
            })
         }
      });
   </script>
</body>
</html>