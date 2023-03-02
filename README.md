# Network
네트워크 통신(HTTP, REST API) 모듈화 테스트 저장소입니다.

|GET|DELETE|
|---|---|
|<img src="./SimulatorRecording/GET SimulatorRecording.gif" width=200>|<img src="./SimulatorRecording/DELETE SimulatorRecording.gif" width=200>|

|POST|PUT|
|---|---|
|<img src="./SimulatorRecording/POST SimulatorRecording.gif" width=200>|<img src="./SimulatorRecording/PUT SimulatorRecording.gif" width=200>|



<br></br>
## HTTP
- HTTP(Hypertext Transfer Protocol)은 인터넷에서 데이터 리소스를 주고받을 때 사용하는 프로토콜 중 하나로, 클라이언트와 서버 간의 통신 규약을 정의함.
- TCP/IP를 기반으로 동작
- 요청(request)과 응답(response) 구조. 클라이언트는 요청 메시지를 생성하여 전송하고, 서버는 요청 메시지를 처리하고 클라이언트에 응답 메시지를 전송
- 상태를 유지하지 않는(stateless) 프로토콜. 이는 클라이언트와 서버 간의, 각각의 요청과 응답이 독립적으로 이루어진다는 것으 의미함. 따라서 HTTP를 이용하여 상태를 유지해야 하는 경우에는 쿠키(cookie)나 세션(session) 등의 방법을 사용
