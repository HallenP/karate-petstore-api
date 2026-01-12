Feature: PetStore API - Gestión de Mascotas

  Background:
    Given url 'https://petstore.swagger.io/v2'
    And header Accept = 'application/json'
    And header Content-Type = 'application/json'

  Scenario: Añadir una nueva mascota a la tienda
    Given path 'pet'
    And request
    """
    {
      "id": 10001,
      "category": {
        "id": 1,
        "name": "dogs"
      },
      "name": "Firulais",
      "photoUrls": [
        "https://google.com/firulais.jpg"
      ],
      "tags": [
        {
          "id": 1,
          "name": "friendly"
        }
      ],
      "status": "available"
    }
    """
    When method POST
    Then status 200
    And match response.id == 10001
    And match response.name == 'Firulais'
    And match response.status == 'available'

  Scenario: Consultar la mascota por ID
    Given path 'pet', 10001
    When method GET
    Then status 200
    And match response.id == 10001
    And match response.name == 'Firulais'

  Scenario: Actualizar el nombre y estatus de la mascota a sold
    Given path 'pet'
    And request
    """
    {
      "id": 10001,
      "category": {
        "id": 1,
        "name": "dogs"
      },
      "name": "Firulais-Vendido",
      "photoUrls": [
        "https://google.com/firulais.jpg"
      ],
      "tags": [
        {
          "id": 1,
          "name": "friendly"
        }
      ],
      "status": "sold"
    }
    """
    When method PUT
    Then status 200
    And match response.name == 'Firulais-Vendido'
    And match response.status == 'sold'

  Scenario: Consultar mascotas por estatus sold
    Given path 'pet/findByStatus'
    And param status = 'sold'
    When method GET
    Then status 200
    And match response[*].status contains 'sold'

