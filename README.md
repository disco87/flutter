## I. FLUTTER를 이용한 APP 개발
- 주제 : 냉장고의 남음 재료를 이용해 레시피 제안
- 목표 : 
    1. 웹크롤링을 이용해 레시피를 찾는 APP을 만들어 본다.
    2. FLUTTER를 통한 기본적인 APP개발 방법을 숙지하고 APP을 출시하는 흐름을 이해하기 위한 TEST APP
- 주요 구성 : 
    + Main Menu / roullet(음식 랜덤 뽑기)  / 냉장고를 털어라(재료 입력 시 레시피 추천) / Health(추천운동)

        <img src ="https://github.com/disco87/flutter/blob/master/image/menu.png" width="150">  <img src ="https://github.com/disco87/flutter/blob/master/image/roulet.png" width="150" >   <img src ="https://github.com/disco87/flutter/blob/master/image/serch.png" width="150"> <img src ="https://github.com/disco87/flutter/blob/master/image/health.png" width="150">

- 첫 개발 하면서 미흡한점 & 아쉬운 점
  + Class 내 Data와 View를 동시에 구현 추후 provider나 Bloc Pattern을 적용 필요
  + firbase의 사용 부재
  + Firbase 또는 DB의 사용 부재

- 추후 업데이트 예정
  + 리팩토링을 통한 코드 재정리
  + Firbase를 통한 데이터 저장 추가 또는 sqlit를 사용을 통한 나의 레시피 저장
  + 티처블머신을 통한 동작인식을 모델링 후 Health 기능 업데이트
