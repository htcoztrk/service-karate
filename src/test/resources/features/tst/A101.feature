Feature: A101

  Background:
    * url 'https://sosp.a101.com.tr/api'
    * def response = karate.http('api')
    * if (response.timeTaken >= 10000) karate.abort()

  @canli_Login
  Scenario: Login

    * print "Login basliyor....."

    * def requestBody =
    """
{
  "phone": "5999999907",
  "tcLastFour": "0000"
}
  """

    And request requestBody
    And header content-type = 'application/json'
    And path '/auth/login'
    When method post
    Then print response
    And assert response.payload.sendOtp !=null
    Then status 200
    * print "Login bitiyor....."

  @canli_Login_otp
  Scenario: Login_otp
    * print  'Otp basliyor..'
    * def sleep =
      """
      function(seconds){
        for(i = 0; i <= seconds; i++)
        {
          java.lang.Thread.sleep(1*2000);
          karate.log(i);
        }
      }
      """
    * call sleep 20
    * def requestBody =
    """
{
  "otpCode": "101101",
  "phone": "5999999907"
}
  """
    And request requestBody
    And header content-type = 'application/json'
    And path '/Auth/otp-verify'
    When method post
    Then print response
    And assert response.payload.access_token !=null
    Then status 200

  @canli_Store
  Scenario: Store
    And path '/store'
    And header Authorization = 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjU0OGI4MmNkLTUyMTAtNGZhMC1hYWNiLWI0ZDZjMDU1OWNjMSIsImVtYWlsIjoiYWRtaW5AdXNlci5jb20iLCJwcmVmZXJyZWRfdXNlcm5hbWUiOiJBZG1pbiBVc2VyIiwidXVpZCI6InVuZGVmaW5lZCIsIlNwUmVnaXN0ZXIiOiIwIiwicm9sZSI6IlNZU0FETUlOIiwiZXhwIjoxNzAyMTk4OTYzLCJpc3MiOiJodHRwczovL3Nvc3AuYTEwMS5jb20udHIiLCJhdWQiOiJodHRwczovL3Nvc3AuYTEwMS5jb20udHIifQ.BNKKexskQlgkrCD8-CXDrpHbfLXdLGEHGCkiXlEn2MM'
    When method get
    Then print response
    And assert response.payload.items[0].id !=null
    And assert response.payload.items[0].code !=null
    And assert response.payload.items[0].name !=null
    And assert response.payload.items[0].regionCode !=null
    Then match $response.payload.pageIndex == 1
    Then status 200

  @canli_Getmystores
  Scenario: Getmystores
    And param page = '2'
    And param limit = '20'
    And path '/store/get-my-stores'
    And header Authorization = 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjUwMmFmZGJiLTk0ZmEtNGFlMi1hMGVjLWRhODNmOGMyMzFjYiIsImVtYWlsIjoic2Vya2FuLnNvbm1lekBhMTAxLmNvbS50ciIsInByZWZlcnJlZF91c2VybmFtZSI6IlNFUktBTiBTw5ZOTUVaIiwidXVpZCI6InVuZGVmaW5lZCIsIlNwUmVnaXN0ZXIiOiIyNzk1MzQiLCJyb2xlIjoiU00iLCJleHAiOjE3MDE3Nzk2NzYsImlzcyI6Imh0dHBzOi8vc29zcC5hMTAxLmNvbS50ciIsImF1ZCI6Imh0dHBzOi8vc29zcC5hMTAxLmNvbS50ciJ9.7v3pLMXtJ4Cj1gv3OffR1wIsrTiYVXRJ4y-XfazHr3g'
    When method get
    Then print response
    And assert response.payload.items[0].id !=null
    Then match $response.payload.pageIndex == 2
    Then status 200


  @canli_Getauditformystores
  Scenario: Getauditformystores
    And param page = '1'
    And param limit = '20'
    And path '/audit/get-audit-for-my-stores'
    And header Authorization = 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Ijg0NmFkMTk3LTJmMDEtNGMwYy1hZjYyLTRlMDdlZTdmZDg2NiIsImVtYWlsIjoiYWhtZXQuYWthcmNlc21lQGExMDEuY29tLnRyIiwicHJlZmVycmVkX3VzZXJuYW1lIjoiQUhNRVQgQUtBUsOHRcWeTUUiLCJ1dWlkIjoiYTdjYmJlMTMtODNmZi00YjQ0LWIwMDgtODg0NmFjY2YzYWQ0IiwiU3BSZWdpc3RlciI6IjEzNCIsInJvbGUiOiJHTSIsImV4cCI6MTcwMjEyMDIxNCwiaXNzIjoiaHR0cHM6Ly9zb3NwLmExMDEuY29tLnRyIiwiYXVkIjoiaHR0cHM6Ly9zb3NwLmExMDEuY29tLnRyIn0.BL8UouDXQYtIKh-lp3_55BfOypkMqfjzMZPcFcX7Vj8'
    When method get
    Then print response
    And assert response.payload.items[0].storeName !=null
    Then match $response.payload.pageIndex == 1
    Then status 200

  @canli_Getauditbystorecode
  Scenario: Getauditbystorecode
    And param page = '1'
    And param limit = '20'
    And path '/audit/get-audit-by-store-code/F240'
    And header Authorization = 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Ijg0NmFkMTk3LTJmMDEtNGMwYy1hZjYyLTRlMDdlZTdmZDg2NiIsImVtYWlsIjoiYWhtZXQuYWthcmNlc21lQGExMDEuY29tLnRyIiwicHJlZmVycmVkX3VzZXJuYW1lIjoiQUhNRVQgQUtBUsOHRcWeTUUiLCJ1dWlkIjoiYTdjYmJlMTMtODNmZi00YjQ0LWIwMDgtODg0NmFjY2YzYWQ0IiwiU3BSZWdpc3RlciI6IjEzNCIsInJvbGUiOiJHTSIsImV4cCI6MTcwMjEyMDIxNCwiaXNzIjoiaHR0cHM6Ly9zb3NwLmExMDEuY29tLnRyIiwiYXVkIjoiaHR0cHM6Ly9zb3NwLmExMDEuY29tLnRyIn0.BL8UouDXQYtIKh-lp3_55BfOypkMqfjzMZPcFcX7Vj8'
    When method get
    Then print response
    And assert response.payload.items[0].id !=null
    And assert response.payload.items[0].auditDate !=null
    And assert response.payload.items[0].score !=null
    Then match $response.payload.pageIndex == 1
    Then status 200


  @canli_Mediaapidowloadzip
  Scenario: Mediaapidowloadzip
    And param download = 'true'
    And path '/media-api/pbzip/20231009/F240.zip'
    And header Authorization = 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjUxOWNjNjZlLWMxZjUtNDFlYS04NmNlLTk5MzFiY2MxMjRlZCIsImVtYWlsIjoiMTY3OUBhMTAxLmNvbS50ciIsInByZWZlcnJlZF91c2VybmFtZSI6IkFZxZ5FTlVSIFRVUkFOQ0kiLCJ1dWlkIjoidW5kZWZpbmVkIiwiU3BSZWdpc3RlciI6IjQ5MzY2NSIsInJvbGUiOiJNUCIsImV4cCI6MTcwMjIxNTI0NCwiaXNzIjoiaHR0cHM6Ly9zb3NwLmExMDEuY29tLnRyIiwiYXVkIjoiaHR0cHM6Ly9zb3NwLmExMDEuY29tLnRyIn0.nl4jwosn0-EET_PerXKaweShBO0-yl6nV6gejUtkvzc'
    When method get
    Then print response
    Then status 200

  @canli_MediaapidowloadGeneralzip
  Scenario: MediaapidowloadGeneralzip
    And param download = 'true'
    And path '/media-api/pbzip/20231009/general.zip'
    And header Authorization = 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjUxOWNjNjZlLWMxZjUtNDFlYS04NmNlLTk5MzFiY2MxMjRlZCIsImVtYWlsIjoiMTY3OUBhMTAxLmNvbS50ciIsInByZWZlcnJlZF91c2VybmFtZSI6IkFZxZ5FTlVSIFRVUkFOQ0kiLCJ1dWlkIjoidW5kZWZpbmVkIiwiU3BSZWdpc3RlciI6IjQ5MzY2NSIsInJvbGUiOiJNUCIsImV4cCI6MTcwMjIxNTI0NCwiaXNzIjoiaHR0cHM6Ly9zb3NwLmExMDEuY29tLnRyIiwiYXVkIjoiaHR0cHM6Ly9zb3NwLmExMDEuY29tLnRyIn0.nl4jwosn0-EET_PerXKaweShBO0-yl6nV6gejUtkvzc'
    When method get
    Then print response
    Then status 200

  @canli_AuditQuestions
  Scenario: AuditQuestions
    And path '/audit/get-audit-questions/108106'
    And header Authorization = 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImM1ZGE5YzgwLTFkY2UtNDE3Yi1hMzMyLTk4NGI0YjI5NmMwMSIsImVtYWlsIjoiY2VvQHVzZXIuY29tIiwicHJlZmVycmVkX3VzZXJuYW1lIjoiVGVzdCBLdWxsYW7EsWPEsSBVc2VyIiwidXVpZCI6IjI0MDQzYWJhLTZiN2UtNDhjNC04ZWJiLWJjNzBmNDQ1Mzg3YyIsIlNwUmVnaXN0ZXIiOiIxIiwicm9sZSI6IkNFTyIsImV4cCI6MTcxMDkxOTc5MSwiaXNzIjoiaHR0cHM6Ly9zb3NwLmExMDEuY29tLnRyIiwiYXVkIjoiaHR0cHM6Ly9zb3NwLmExMDEuY29tLnRyIn0.taywsLw-d_NV4b6O5PqxQnSgSgjXH8IzbIxzSZdWQAQ'
    When method get
    Then print response
    Then match $response.payload.answeringUser == 'CEO'
    Then match $response.payload.questionItems[1] !=null
    And assert response.payload.questionItems[1].name !=null
    And assert response.payload.questionItems[1].questionId !=null
    And assert response.payload.questionItems[1].order !=null
    And assert response.payload.questionItems[1].questionAnswerTypeId !=null
    Then match $response.payload.questionItems[2] !=null
    Then match $response.payload.questionItems[5] !=null
    And assert response.payload.questionItems[5].name !=null
    And assert response.payload.questionItems[5].questionId !=null
    Then status 200
