document.addEventListener("DOMContentLoaded", function () {
	const hamburger = document.getElementById("hamburger");
	const navMenu = document.getElementById("navMenu");
	const menuItems = document.querySelectorAll(".menu-item");

	hamburger.addEventListener("click", function () {
		navMenu.classList.toggle("show");
	});

	// 서브메뉴 토글 (모바일에서 클릭으로 여닫기)
	menuItems.forEach(function (item) {
		item.addEventListener("click", function (e) {
			// 다른 메뉴는 닫기
			menuItems.forEach(i => {
				if (i !== item) i.classList.remove("active");
			});
			item.classList.toggle("active");
		});
	});
});
