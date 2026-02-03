Feature: Fetching all products

  Scenario: Fetching all the products by using http GET request
    Given product "Mac Book" exist with the price 50000
    When user fetches all the product
    Then response should contain the product "Mac Book"