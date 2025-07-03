<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>수호맵 - 시군구 단위 소멸위험 지도</title>
  <script src="https://cdn.jsdelivr.net/npm/leaflet@1.9.4/dist/leaflet.js"></script>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/leaflet@1.9.4/dist/leaflet.css" />
  <style>
    #map { height: 800px; width: 100%; }
    .label-text {
      font-family: 'Comic Sans MS', cursive, sans-serif;
      font-weight: bold;
      color: #333;
      text-shadow: 1px 1px 2px white;
      font-size: 12px;
      pointer-events: none;
    }
  </style>
</head>
<body>
  <h2>전국 시군구 소멸 위험 지도</h2>
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

  // danger_class에 따른 색상 반환 함수
  function getColorByDangerClass(dangerClass) {
    switch(dangerClass) {
      case "소멸고위험 지역": return "#e03e3e";   // 빨강
      case "소멸위험진입 단계": return "#f4a261"; // 주황
      default: return "#2a9d8f";                   // 초록
    }
  }

  // 시군구 이름 → 위험등급 매핑
  const locationDangerMap = {};
  suhoList.forEach(item => {
    if (item.location) {
      locationDangerMap[item.location] = item.danger_class;
    }
  });
  console.log("시군구별 위험 등급:", locationDangerMap);

  // 지도 초기화
  var map = L.map('map').setView([36.5, 127.5], 7);
  L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png').addTo(map);

  // GeoJSON 시군구 단위 경계 불러오기
  fetch('/geojson/skorea-municipalities-geo.json')
    .then(res => {
      if (!res.ok) throw new Error('GeoJSON 파일을 불러오는데 실패했습니다.');
      return res.json();
    })
    .then(geojson => {
      L.geoJSON(geojson, {
        style: function(feature) {
          const regionName = feature.properties.NAME_2;
          const dangerClass = locationDangerMap[regionName] || "정보없음";
          return {
            fillColor: getColorByDangerClass(dangerClass),
            weight: 1,
            opacity: 1,
            color: 'black',
            fillOpacity: 0.7
          };
        },
        onEachFeature: function(feature, layer) {
          const regionName = feature.properties.NAME_2;
          const dangerClass = locationDangerMap[regionName] || "정보없음";

          // 중심 좌표로 라벨 표시
          const center = layer.getBounds().getCenter();
          const labelIcon = L.divIcon({
            className: 'label-text',
            html: regionName,
            iconSize: [100, 20],
            iconAnchor: [50, 10],
            popupAnchor: [0, -20]
          });
          L.marker(center, {icon: labelIcon, interactive: false}).addTo(map);

          // 팝업
          layer.bindPopup(regionName + "<br>위험도: " + dangerClass);
        }
      }).addTo(map);
    })
    .catch(err => {
      console.error(err);
      alert('지도 데이터를 불러오는데 실패했습니다.');
    });
</script>

</body>
</html>
