<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div id="carouselExampleCaptions" class="carousel slide">
  <div class="carousel-indicators">
    <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
    <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="1" aria-label="Slide 2"></button>
    <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="2" aria-label="Slide 3"></button>
  </div>
  <div class="carousel-inner">
    <div class="carousel-item active">
      <img src="/resources/images/card1.PNG" class="d-block w-100" alt="..." height=700>
      
      <div class="carousel-caption d-none d-md-block">
      	<button class="btnStyle" onclick="location.href='/map'">자세히 보기</button>
      </div>
    </div>
    <div class="carousel-item">
      <img src="/resources/images/card2.png" class="d-block w-100" alt="..." height=700>
      <div class="carousel-caption d-none d-md-block">
        <h5>소중한 사람에게 전하는 지역의 맛과 마음, 보따리 상점에서 만나보세요.</h5>
        <p>정성 가득한 선물로 마음을 전하는 따뜻한 공간.</p>
      </div>
    </div>
    <div class="carousel-item">
      <img src="/resources/images/card3.png" class="d-block w-100" alt="..." height=700>
      <div class="carousel-caption d-none d-md-block">
        <h5>마을 사람들의 진솔한 이야기, 당신과 함께 나누고 싶어요.</h5>
        <p>설화:수와 함께하는 따뜻한 순간들</p>
      </div>
    </div>
  </div>
  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide="prev">
    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Previous</span>
  </button>
  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide="next">
    <span class="carousel-control-next-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Next</span>
  </button>
</div>

</body>
</html>