Feature: Denemechange

  Background:
    * url 'https://sosp.a101.com.tr/api'
    * def response = karate.http('api')
    * if (response.timeTaken >= 10000) karate.abort()

  @deneme_canli_Login
  Scenario: DenemeLogin

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
