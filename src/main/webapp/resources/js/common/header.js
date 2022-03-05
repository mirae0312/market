
// 이벤트 배너 닫기
let closeBn = document.querySelector('.close-bn-icon');
let eventBn = document.querySelector('.join-event-bn');

closeBn.onclick = (() => {
  eventBn.classList.add('close-bn');
});

// 고객센터, location show 토글
let serviceTab = document.querySelector('.service-tab');
let serviceTabSub = document.querySelector('.service-tab-sub');
let memberTab = document.querySelector('.member-tab');
let memberTabSub = document.querySelector('.member-tab-sub');
let locationIcon = document.querySelector('.location-icon');
let locationAlert = document.querySelector('.location-alert');

serviceTab.onclick = (() => {
  serviceTabSub.classList.toggle('show');
});

memberTab.onclick = (() => {
  memberTabSub.classList.toggle('show');
});

locationIcon.onclick = (() => {
  locationAlert.classList.toggle('show');
});

//로고 클릭시 메인
document.querySelector('.mainLogo').onclick = (() => {
  location.href = '';
})

//검색어 미입력시 전송 막음
const searchFrm = document.searchFrm;
searchFrm.addEventListener('submit', ((e) => {
  if(document.getElementById('searchInput').value == '') {
    e.preventDefault();
  }
}));
  