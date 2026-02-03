Feature: Update product
  Scenario: User updates existing product by hitting http Patch request
    Given product "Mac Book" of price 50000 exists
    When user updates price of "Mac Book" to 100000
    Then product "Mac Book" should have price 100000