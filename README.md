#2022-06-21 업데이트
- designate/output.tf 업데이트
    - designate/main.tf에서 선언한 module의 전체 리소스를 output으로 출력할 경우, 어떠한 값을 어떤 방식으로 가져오는지
      테스트를 위한 목적으로 해당 파일 업데이트

- .gitignore 업데이트
    - git 커맨드 수행 시, 코드 폴더 중 원격 저장소에 업로드 되지 말아야 할 리소스 및 디렉토리에 대한 부분을 예외처리
      파일 및 폴더에 대해 처리가 가능하며, terraform default 모듈 및 각종 파일에 대해 예외 처리 진행. 자세한 부분은 .gitignore 참조


#2022-06-21 업데이트
- 매니저님 전달 주신 리소스를 module로 하여 아래의 리소스를 생성

    - locals.tf
    - data.tf
    - provider.tf
    - terraform.tf
    - main.tf
    - variables.tf
    - output.tf
    - terraform.tfvars

- 위의 파일들은 designate 폴더에 속하는 내용으로, 실 사용은 module 본체가 있어야 같이 연동을 통해 사용가능

