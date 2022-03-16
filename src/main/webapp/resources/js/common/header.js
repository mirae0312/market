
// 이벤트 배너 닫기
let closeBn = document.querySelector('.close-bn-icon');
let eventBn = document.querySelector('.join-event-bn');

closeBn.onclick = (() => {
  eventBn.classList.add('close-bn');
  localStorage.setItem('bn-status', 'false');
});

//배너 상태 localStorage 저장
const storedBn = localStorage.getItem('bn-status');
console.log(storedBn);
if(storedBn !== null) {
	if(storedBn === 'false') {
		eventBn.style.display = 'none';		
	}
}

var serviceTab = document.querySelector('.service-tab');
var serviceTabSub = document.querySelector('.service-tab-sub');
var memberTab = document.querySelector('.member-tab');
var memberTabSub = document.querySelector('.member-tab-sub');
var locationIcon = document.querySelector('.location-icon');
var locationAlert = document.querySelector('.location-alert');

//호버 이벤트 함수
const showSubNav = (subNavName) => {
	subNavName.classList.add('show');
	subNavName.addEventListener('mouseleave', function() {
		subNavName.classList.remove('show');
	});
};

//고객센터 호버 이벤트
serviceTab.addEventListener('mouseover', function() {
	showSubNav(serviceTabSub);
});

//로그인해서 memberTab이 존재하는 경우에만 동작하도록
if(memberTab != null) {	
	memberTab.addEventListener('mouseover', function() {
		showSubNav(memberTabSub);
	});
};

//배송지
locationIcon.addEventListener('mouseover', function() {
	showSubNav(locationAlert);
});


//검색창 검색어 미입력시 전송 막음
const searchFrm = document.searchFrm;
searchFrm.addEventListener('submit', function(e) {
  if(document.getElementById('searchInput').value == '') {
    e.preventDefault();
  }
});


//카테고리 동적 생성
//메인카테고리
let largeCategory = [
	{"A" : '채소'}, 
	{"B" : '과일·견과·쌀'}, 
	{"C" : '수산·해산·건어물'}, 
	{"D" : '정육·계란'},
	{"E" : '국·반찬·메인요리'}, 
	{"F" : '샐러드·반찬식'}, 
	{"G" : '면·양념·오일'}, 
	{"H" : '생수·음료·우유·커피'},
	{"I" : '간식·과자·떡'},
	{"J" : '베이커리·치즈·델리'}
	];
//서브카테고리
let smallCategory = {
	"A" : {
		"01a" : '친환경', 
		"02a" : '고구마·감자·당근', 
		"03a" : '시금치·쌈채소·나물', 
		"04a" : '브로콜리·파프리카·양배추',
		"05a" : '양파·대파·마늘·배추', 
		"06a" : '오이·호박·고추', 
		"07a" : '냉동·이색·간편채소', 
		"08a" : '콩나물·버섯'},
	"B" : {
		"01b" : '친환경', 
		"02b" : '제철과일', 
		"03b" : '국산과일', 
		"04b" : '수입과일', 
		"05b" : '간편과일', 
		"06b" : '냉동·건과일', 
		"07b" : '견과류', 
		"08b" : '쌀·잡곡'},
	"C" : {
		"01c" : '제철수산', 
		"02c" : '생선류', 
		"03c" : '굴비·반건류', 
		"04c" : '오징어·낙지·문어', 
		"05c" : '새우·게·랍스터',
		"06c" : '해산물·조개류', 
		"07c" : '수산가공품', 
		"08c" : '김·미역·해조류', 
		"09c" : '건어물·다시팩'},
	"D" : {
		"01d" : '국내산 소고기', 
		"02d" : '수입산 소고기', 
		"03d" : '돼지고기', 
		"04d" : '계란류', 
		"05d" : '닭·오리고기', 
		"06d" : '양념육·돈까스', 
		"07d" : '양고기'},
	"E" : {
		"01e" : '국·탕·찌개', 
		"02e" : '밀키트·메인요리', 
		"03e" : '밑반찬',
		"04e" : '김치·젓갈·장류', 
		"05e" : '두부·어묵·부침개', 
		"06e" : '베이컨·햄·통조림'},
	"F" : {
		"01f" : '샐러드·닭가슴살', 
		"02f" : '도시락·밥류', 
		"03f" : '파스타·면류', 
		"04f" : '떡볶이·튀김·순대', 
		"05f" : '피자·핫도그·만두',
		"06f" : '폭립·떡갈비·안주', 
		"07f" : '죽·스프·카레', 
		"08f" : '선식·시리얼'},	
	"G" : {
		"01g" : '파스타·면류', 
		"02g" : '식초·소스·드레싱', 
		"03g" : '양념·액젓·장류', 
		"04g" : '식용유·참기름·오일', 
		"05g" : '소금·설탕·향신료', 
		"06g" : '밀가루·가루·믹스'},
	"H" : {
		"01h" : '생수·탄산수', 
		"02h" : '음료·주스', 
		"03h" : '우유·두유·요거트', 
		"04h" : '커피', 
		"05h" : '차'},
	"I" : {
		"01i" : '과자·스낵·쿠키', 
		"02i" : '초콜릿·젤리·캔디', 
		"03i" : '떡·한과', 
		"04i" : '아이스크림'},
	"J" : {
		"01j" : '식빵·빵류', 
		"02j" : '잼·버터·스프레드', 
		"03j" : '케이크·파이·디저트', 
		"04j" : '치즈', 
		"05j" : '델리', 
		"06j" : '올리브·피클'}
};					

//전체 카테고리 호버 이벤트
const allCategory = $('.product-category-list-all');
const largeCList = $('.large-category-list');
const largeC = $('.large-category');

/*allCategory.mouseover(function() {
	console.log(this);
	//호버했을 때 콜백 함수
		let mainCategory = `<div class="large-category-list">
								<ul>`;
		largeCategory.forEach((e) => {
			for(data in e) {	
				mainCategory += `
								<a href=${contextPath}/${data}>
									<li class="large-category">${e[data]}</li>
								</a>
								`;
			}
		});
				mainCategory += `
								</ul>
							</div>`;
		allCategory.append(mainCategory);	

		
		$(document).on('mouseleave', '.large-category', function() {
			//allCategory.children('div').remove();			
		});

});*/
