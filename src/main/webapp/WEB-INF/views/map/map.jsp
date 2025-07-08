<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
  <title>수호맵 - 시군구 단위 소멸위험 지도</title>
  <script src="https://cdn.jsdelivr.net/npm/leaflet@1.9.4/dist/leaflet.js"></script>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/leaflet@1.9.4/dist/leaflet.css" />
  <!-- NotoSans KR -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
  <!-- map.css -->
  <link rel="stylesheet" href="/css/map.css">
</head>
<body>
<%@ include file="../include/menu.jsp" %>
<div id="map"></div>
<script>
  <% 
    String rawJson = (String) request.getAttribute("suhoListJson");
    if (rawJson != null) {
      rawJson = rawJson.replace("\"", "\\\""); // 큰따옴표 이스케이프
  %>
  var suhoList = JSON.parse("<%= rawJson %>");
  console.log("DB 데이터:", suhoList);
  <% } else { %>
  var suhoList = [];
  console.error("DB에서 지도 데이터를 불러오지 못했습니다.");
  <% } %>
  
  L.Control.SeeButton = L.Control.extend({
	  onAdd: function(map) {
	    const container = L.DomUtil.create('div', 'leaflet-bar leaflet-control custom-see-container');
	    
	    const btn = L.DomUtil.create('button', 'see', container);
	    btn.innerHTML = '전체 설화 보기';
	    btn.onclick = function () {
	      location.href = '/legend/legend.do';
	    };

	    L.DomEvent.disableClickPropagation(btn);
	    return container;
	  },

	  onRemove: function(map) {}
	});

	L.control.seeButton = function(opts) {
	  return new L.Control.SeeButton(opts);
	};

</script>
<script src="/js/map.js"></script>
</body>
</html>
