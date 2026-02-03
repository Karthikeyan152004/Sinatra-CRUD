Feature: Product creation validation
  Scenario: Create new product successfully
    When user creates a product with name "Tshirt-2" price 500 and availability as true
    Then product "Tshirt-2" should be stored in the system
