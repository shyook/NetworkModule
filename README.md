# iOS Alamofire를 이용한 Network Module


iOS Alamofire 라이브러리를 이용한 Network Module 설계 입니다.

API 추가가 쉽고 변경이 용이하며 API추가나 변경에 따른 다른 API들에 영향을 주지 않는 방향으로 설계


## 개발 환경


- 개발 툴 : Xcode 12.4
- SDK 버전 :
 > + Swift Language Version 5
 > + Deployment Info iOS 12.0
 
 
## 주요 내용


- Codable Protocol을 이용한 Josn 파싱.
- Post Method를 이용한 데이터 전송.
- Get Method를 이용한 데이터 획득.
- 공통 모듈을 이용한 에러 처리.
