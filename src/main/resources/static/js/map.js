  // 영어 지명 → 한글 지명 매핑 객체
  const regionMap = {
    "Gapyeong": "가평군","Gangneung": "강릉시","Gangjin": "강진군","Ganghwa": "강화군","Geochang": "거창군","Gyeongju": "경주시","Goryeong": "고령군","Goseong": "고성군","Gochang": "고창군","Goheung": "고흥군","Gokseong": "곡성군","Gongju": "공주시","Goesan": "괴산군","Gurye": "구례군","Gunsan": "군산시","Gunwi": "군위군","Geumsan": "금산군","Geumjeong": "금정구","Gimje": "김제시","Gimcheon": "김천시","Naju": "나주시","Namwon": "남원시","Namhae": "남해군","Nonsan": "논산시","Danyang": "단양군","Damyang": "담양군","Dangjin": "당진시","Dong": "동구","Dongducheon": "동두천시","Dongnae": "동래구","Donghae": "동해시","Mokpo": "목포시","Muan": "무안군","Muju": "무주군","Mungyeong": "문경시","Miryang": "밀양시","Boryeong": "보령시","Boseong": "보성군","Boeun": "보은군","Bonghwa": "봉화군","Buan": "부안군","Buyeo": "부여군","Buk": "북구","Sasang": "사상구","Sacheon": "사천시","Saha": "사하구","Sancheong": "산청군","Samcheok": "삼척시","Sangju": "상주시","Seo": "서구","Seosan": "서산시","Seocheon": "서천군","Seongju": "성주군","Sokcho": "속초시","Sunchang": "순창군","Sinan": "신안군","Andong": "안동시","Yanggu": "양구군","Yangyang": "양양군","Yangpyeong": "양평군","Yeosu": "여수시","Yeoju": "여주시","Yeoncheon": "연천군","Yeonggwang": "영광군","Yeongdeok": "영덕군","Yeongdo": "영도구","Yeongdong": "영동군","Yeongam": "영암군","Yeongyang": "영양군","Yeongwol": "영월군","Yeongju": "영주시","Yeongcheon": "영천시","Yesan": "예산군","Yecheon": "예천군","Okcheon": "옥천군","Ongjin": "옹진군","Wando": "완도군","Wanju": "완주군","Ulleung": "울릉군","Ulju": "울주군","Uljin": "울진군","Eumseong": "음성군","Uiryeong": "의령군","Uiseong": "의성군","Iksan": "익산시","Inje": "인제군","Imsil": "임실군","Jangseong": "장성군","Jangsu": "장수군","Jangheung": "장흥군","Jeongseon": "정선군","Jeongeup": "정읍시","Jecheon": "제천시","Jung": "중구","Jeungpyeong": "증평군","Jindo": "진도군","Jinan": "진안군","Changnyeong": "창녕군","Cheorwon": "철원군","Cheongdo": "청도군","Cheongsong": "청송군","Cheongyang": "청양군","Chungju": "충주시","Chilgok": "칠곡군","Taebaek": "태백시","Taean": "태안군","Tongyeong": "통영시","Pyeongchang": "평창군","Pocheon": "포천시","Pohang": "포항시","Hadong": "하동군","Haman": "함안군","Hamyang": "함양군","Hampyeong": "함평군","Hapcheon": "합천군","Haenam": "해남군","Haeundae": "해운대구","Hongseong": "홍성군","Hongcheon": "홍천군", "Hwasun": "화순군","Hwacheon": "화천군","Hoengseong": "횡성군"
  };
  
	//설화 데이터가 있는 지역명 배열
  const legendRegions = ["횡성군", "정선군", "영월군", "양양군", "평창군", "가평군", "진안군", "정읍시", "서천군", "장성군", "고흥군", "청도군", "부여군", "밀양시", "포천시", "거창군", "남해군", "울릉군", "충주시", "괴산군", "영월군"];

  // danger_class에 따른 색상 반환 함수
  function getColorByDangerClass(dangerClass) {
    switch(dangerClass) {
      case "소멸고위험 지역": return "#FF4500"; // Or #DC143C (Crimson), #B22222 (FireBrick)
      case "소멸위험진입 단계": return "#FF9999"; // Or #FA8072 (Salmon), #F08080 (LightCoral)
      default: return "#EFEFEC"; // 기존과 동일
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
        	  const engName = feature.properties.NAME_2;
        	  const regionName = regionMap[engName] || "";
        	  const dangerClass = locationDangerMap[regionName] || "정보없음";

        	  const center = layer.getBounds().getCenter();
        	  const isLegendRegion = legendRegions.includes(regionName); // 🔸 설화 지역인지 판별
        	  const labelClass = isLegendRegion ? 'label-text legend-highlight' : 'label-text';

        	  const labelIcon = L.divIcon({
        	    className: labelClass,
        	    html: regionName,
        	    iconSize: [100, 20],
        	    iconAnchor: [50, 10],
        	    popupAnchor: [0, -20]
        	  });
        	  L.marker(center, {icon: labelIcon, interactive: false}).addTo(map);

        	  // 설화지역일 때만 바인딩
        	  if (isLegendRegion) {
				const popupContent =
				  "<div class=\"custom-popup\" style=\"text-align: center;\">" +
				    "<h3>설화 보기</h3>" +
				    "<p>" + regionName + "을 선택하셨어요!<br><strong>" + regionName + "의 설화</strong>에 대해서 알아볼까요?</p>" +
				    "<button onclick=\"location.href='/legend/locationli?location=" + regionName + "'\">알아보기 ✔</button>" +
				  "</div>";
        	    
        	    layer.bindPopup(popupContent, {maxWidth: 300}); // 🔸 여기만 조건적으로 실행
        	  }
        	}
      }).addTo(map);
    })
    .catch(err => {
      console.error(err);
      alert('지도 데이터를 불러오는데 실패했습니다.');
    });

	L.control.seeButton({ position: 'topright' }).addTo(map);
