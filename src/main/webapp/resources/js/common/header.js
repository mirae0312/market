
// 이벤트 배너 닫기
let closeBn = document.querySelector('.close-bn-icon');
let eventBn = document.querySelector('.join-event-bn');

closeBn.onclick = (() => {
  eventBn.classList.add('close-bn');
});


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
let largeCategory = ['채소', '과일·견과·쌀', '수산·해산·건어물', '정육·계란',
					'국·반찬·메인요리', '샐러드·반찬식', '면·양념·오일', '생수·음료·우유·커피',
					'간식·과자·떡', '베이커리·치즈·델리'];
//서브카테고리
let smallCategory = {
	a : ['친환경', '고구마·감자·당근', '시금치·쌈채소·나물', '브로콜리·파프리카·양배추',
					'양파·대파·마늘·배추', '오이·호박·고추', '냉동·이색·간편채소', '콩나물·버섯'],
	b : ['친환경', '제철과일', '국산과일', '수입과일', '간편과일', '냉동·건과일', '견과류', '쌀·잡곡'],
	c : ['제철수산', '생선류', '굴비·반건류', '오징어·낙지·문어', '새우·게·랍스터',
						'해산물·조개류', '수산가공품', '김·미역·해조류', '건어물·다시팩'],
	d : ['국내산 소고기', '수입산 소고기', '돼지고기', '계란류', '닭·오리고기', '양념육·돈까스', '양고기'],
	e : ['국·탕·찌개', '밀키트·메인요리', '밑반찬','김치·젓갈·장류', '두부·어묵·부침개', '베이컨·햄·통조림'],
	f : ['샐러드·닭가슴살', '도시락·밥류', '파스타·면류', '떡볶이·튀김·순대', '피자·핫도그·만두',
						'폭립·떡갈비·안주', '죽·스프·카레', '선식·시리얼'],	
	g : ['파스타·면류', '식초·소스·드레싱', '양념·액젓·장류', '식용유·참기름·오일', '소금·설탕·향신료', '밀가루·가루·믹스'],
	h : ['생수·탄산수', '음료·주스', '우유·두유·요거트', '커피', '차'],
	i : ['과자·스낵·쿠키', '초콜릿·젤리·캔디', '떡·한과', '아이스크림'],
	j : ['식빵·빵류', '잼·버터·스프레드', '케이크·파이·디저트', '치즈', '델리', '올리브·피클']
};					

let allCategory = document.querySelector('.product-category-list-all');
let largeCategoryList = document.querySelector('.large-category-list');

allCategory.addEventListener('mouseover', function(){
	largeCategoryList.innerHTML='';
	const div = document.createElement('div');
	div.classList.add(`small-category-list`);
	const ul = document.createElement('ul');
	ul.classList.add(`largeCategory-ul`);
	largeCategory.forEach((i, e) => {
		const li = document.createElement('li');
		li.classList.add(`largeCategory`);
		li.setAttribute('data-value', `${String.fromCharCode(e+65)}`)
		let categoryName = document.createTextNode(`${i}`);
		li.append(categoryName);
		ul.appendChild(li);
	});
	largeCategoryList.append(ul);
	largeCategoryList.append(div);
	
	let larCa = document.querySelectorAll('.largeCategory');
	let smallCategoryList = document.querySelector('.small-category-list');
	largeCategoryList.addEventListener('mouseover', function(e) {
		smallCategoryList.innerHTML='';
		smallCategoryList.classList.add('onView');
		e.stopImmediatePropagation();
		const smallUl = document.createElement('ul');
		smallUl.classList.add(`smallCategory-ul`);
		for(let key in smallCategory) {
			if(e.target.dataset.value == key.toUpperCase()) {
				smallCategoryList.setAttribute('data-value', key.toUpperCase());
				smallCategory[key].forEach((i) => {
				const li = document.createElement('li');
				li.classList.add(`smallCategory`);
					let smallCategoryName = document.createTextNode(`${i}`)
					li.append(smallCategoryName);
					smallUl.appendChild(li);
				});
				smallCategoryList.append(smallUl);
				console.log(smallUl);
			};			
		};
	});
});

