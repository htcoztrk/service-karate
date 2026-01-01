Feature: A101Product

  Background:
    * url 'https://sosp.a101.com.tr/api'
    * def response = karate.http('api')
    * if (response.timeTaken >= 10000) karate.abort()

  @canli_GetProduct
  Scenario: Product
    And path '/product'
    And header Authorization = 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjU0OGI4MmNkLTUyMTAtNGZhMC1hYWNiLWI0ZDZjMDU1OWNjMSIsImVtYWlsIjoiYWRtaW5AdXNlci5jb20iLCJwcmVmZXJyZWRfdXNlcm5hbWUiOiJBZG1pbiBVc2VyIiwidXVpZCI6InVuZGVmaW5lZCIsIlNwUmVnaXN0ZXIiOiIwIiwicm9sZSI6IlNZU0FETUlOIiwiZXhwIjoxNzAyMTk4OTYzLCJpc3MiOiJodHRwczovL3Nvc3AuYTEwMS5jb20udHIiLCJhdWQiOiJodHRwczovL3Nvc3AuYTEwMS5jb20udHIifQ.BNKKexskQlgkrCD8-CXDrpHbfLXdLGEHGCkiXlEn2MM'
    When method get
    Then status 200

  @canli_GetTagCheckInit
  Scenario: GetTagCheckInit
    And param storeCode = '9743'
    And path '/product/tag-check-init'
    And header Authorization = 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjNlOGQ4MjY0LTE4MGYtNDJiNi1hMjBhLTM3M2RlNjM4MWZiMSIsImVtYWlsIjoiZ21AdXNlci5jb20iLCJwcmVmZXJyZWRfdXNlcm5hbWUiOiJHTSBVc2VyIiwidXVpZCI6InVuZGVmaW5lZCIsIlNwUmVnaXN0ZXIiOiIzIiwicm9sZSI6IkdNIiwiZXhwIjoxNzAyNzA3MjU5LCJpc3MiOiJodHRwczovL3Nvc3AuYTEwMS5jb20udHIiLCJhdWQiOiJodHRwczovL3Nvc3AuYTEwMS5jb20udHIifQ.xZhxEANZbDFA9Q8_58qtMl9LIMVuSfa9PdZed7jfgXY'
    When method get
    Then print response
    And assert response.payload.updatedDate[0] != null
    Then match $response.processStatus == 'Success'
    Then status 200

  @skiptestdeneme
  Scenario: skiptestdeneme
    * karate.abort()


  @canli_PostTagCheckPrint
  Scenario: PostTagCheckPrint

    * def requestBody =
"""
{
  "terminalProducts": [
      {
      "id": 0,
      "storeCode": "F240",
      "productCode": "20000800",
      "currentDate": "2023-06-06 20:19:51.000 +0300",
      "printed": true
    }
  ]
}
  """
    And path '/product/tag-check-print'
    And header Authorization = 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjNlOGQ4MjY0LTE4MGYtNDJiNi1hMjBhLTM3M2RlNjM4MWZiMSIsImVtYWlsIjoiZ21AdXNlci5jb20iLCJwcmVmZXJyZWRfdXNlcm5hbWUiOiJHTSBVc2VyIiwidXVpZCI6InVuZGVmaW5lZCIsIlNwUmVnaXN0ZXIiOiIzIiwicm9sZSI6IkdNIiwiZXhwIjoxNzAyNzA3MjU5LCJpc3MiOiJodHRwczovL3Nvc3AuYTEwMS5jb20udHIiLCJhdWQiOiJodHRwczovL3Nvc3AuYTEwMS5jb20udHIifQ.xZhxEANZbDFA9Q8_58qtMl9LIMVuSfa9PdZed7jfgXY'
    And request requestBody
    And header content-type = 'application/json'
    When method post
    Then print response
    Then status 200


  @canli_GetProductImage
  Scenario: GetProductImage

    * def requestBody =

    """
  [
  {
  "productCode": "20000804",
  "barcode": "2060000002716"
  }
  ]
  """

    And path '/product/get-product-image'
    And header Authorization = 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjNlOGQ4MjY0LTE4MGYtNDJiNi1hMjBhLTM3M2RlNjM4MWZiMSIsImVtYWlsIjoiZ21AdXNlci5jb20iLCJwcmVmZXJyZWRfdXNlcm5hbWUiOiJHTSBVc2VyIiwidXVpZCI6InVuZGVmaW5lZCIsIlNwUmVnaXN0ZXIiOiIzIiwicm9sZSI6IkdNIiwiZXhwIjoxNzAyNzA3MjU5LCJpc3MiOiJodHRwczovL3Nvc3AuYTEwMS5jb20udHIiLCJhdWQiOiJodHRwczovL3Nvc3AuYTEwMS5jb20udHIifQ.xZhxEANZbDFA9Q8_58qtMl9LIMVuSfa9PdZed7jfgXY'
    And request requestBody
    And header content-type = 'application/json'
    When method post
    Then print response
    Then status 200


