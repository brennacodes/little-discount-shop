# Little Discount Shop

Little Discount Shop is a fictitious e-commerce platform where merchants and admins can track sales, manage inventory, and fulfill customer invoices. This project was created in two parts over the course of two weeks. 

[**Click here to view the deployed application**](https://little-discount-shop.herokuapp.com/) **Note:** You may need to wait a minute for the server to spin up and display the page. :) 

## Table of Contents
  [Goals](#goals)  
  [Full Project Requirements](#project-requirements)  
  [Database Schema](#database-schema)  
  [Screenshots](#application-screenshots)  
  [Tech Stach](#tech-stack)  
  
## Goals

- [x] Use MVC to organize code effectively
- [x] Follow REST principles 
- [x] Use TDD to help develop clean, maintainable code
- [x] Design a normalized database schema and defining model relationships
- [x] Write migrations to create tables and relationships between tables
- [x] Implement CRUD functionality for a resource using forms (form_tag or form_with), buttons, and links
- [x] Utilize advanced routing techniques including namespacing
- [x] Utilize advanced active record techniques to perform complex database queries
- [x] Use ActiveRecord methods to join multiple tables of data, make calculations, and group data based on one or more attributes
- [x] Write model tests that fully cover the data logic of the application
- [x] Write feature tests that fully cover the functionality of the application
- [x] Consume a public API while utilizing POROs as a way to apply OOP principles to organize code

## Little Discount Shop API
This project also integrates a RESTful API for the following resources:
- Items
  - return all items
  - return a single item
  - return the merchant for a specific item

- Merchants
  - return all merchants
  - return a single merchant
  - return all items for a specific merchant

### [Click Here for API Endpoints & Data Output](./project/api_endpoints.md)

## Project Requirements

[**Click Here to View Part 1 of the Project Requirements**](./project/README_pt1.md)  
[**Click Here to View Part 2 of the Project Requirements**](./project/README_pt2.md)

## Database Schema
<img src="https://github.com/brennacodes/little-discount-shop/blob/main/project/img/bulk_discounts_schema.png">

## Application Screenshots

| <b>Documentation page for the Little Discount Shop API.</b>|
|:--:|
| <img src="https://github.com/brennacodes/little-discount-shop/blob/main/project/img/Screen Shot 2022-08-30 at 9.26.46 PM.png"> |

| <b>Admin Merchants Index Page: View top-selling merchants, enable or disable merchants in the system.</b>|
|:--:|
| <img src="https://github.com/brennacodes/little-discount-shop/blob/main/project/img/Screen Shot 2022-08-10 at 3.50.59 PM.png"> |

| <b>Merchants Discounts Page: View and manage existing discounts, view upcoming holidays, create a discount for that holiday.</b>|
|:--:|
| <img src="https://github.com/brennacodes/little-discount-shop/blob/main/project/img/Screen Shot 2022-08-10 at 3.53.26 PM.png"> |

| <b>Merchants Invoice Show Page: View an invoice, its data including revenue, and all items on that invoice. </b>|
|:--:|
| <img src="https://github.com/brennacodes/little-discount-shop/blob/main/project/img/Screen Shot 2022-08-10 at 7.20.10 PM.png"> |

| <b>Merchants Items Index Page: View all of a merchant's items, including top-selling items, and items that are ready to ship. </b> |
|:--:|
| <img src="https://github.com/brennacodes/little-discount-shop/blob/main/project/img/Screen Shot 2022-08-10 at 7.21.45 PM.png"> |

| <b>Merchant's Enabled and Disabled Items: click to quickly enable or disable items. Pagination helps break up long lists.</b>|
|:--:|
| <img src="https://github.com/brennacodes/little-discount-shop/blob/main/project/img/Screen Shot 2022-08-10 at 7.32.43 PM.png"> |

## Tech Stack

  ### Language & Framework:  
  <p>
  <img src="https://img.shields.io/badge/ruby-CC342D.svg?&style=for-the-badge&logo=ruby&logoColor=white" />
  <img src="https://img.shields.io/badge/SQL-4169E1.svg?style=for-the-badge&logo=SQL&logoColor=white" />
  <img src="https://img.shields.io/badge/ActiveRecord-CC0000.svg?&style=for-the-badge&logo=rubyonrails&logoColor=white" />
  <img src="https://img.shields.io/badge/ruby%20on%20rails-b81818.svg?&style=for-the-badge&logo=rubyonrails&logoColor=white" />
  </p>

  ### Tools:  
  <p>
  <img src="https://img.shields.io/badge/git-F05032.svg?&style=for-the-badge&logo=git&logoColor=white" />
  <img alt="GitHub" src="https://img.shields.io/badge/github-%23121011.svg?style=for-the-badge&logo=github&logoColor=white"/>
  <img alt="Heroku" src="https://img.shields.io/badge/heroku-%23430098.svg?style=for-the-badge&logo=heroku&logoColor=white"/>
  <img src="https://img.shields.io/badge/vscode-007ACC.svg?&style=for-the-badge&logo=visualstudiocode&logoColor=white" />
  </p>

  ### Database:  
  <p>
  <img src="https://img.shields.io/badge/PostgreSQL-4169E1.svg?&style=for-the-badge&logo=postgresql&logoColor=white" />
  <img src="https://img.shields.io/badge/postico-4169E1.svg?&style=for-the-badge&logo=Postico&logoColor=white" />
  </p>

  ### Styling:  
  <p>
  <img src="https://img.shields.io/badge/bootstrap-7952B3.svg?&style=for-the-badge&logo=bootstrap&logoColor=white" />
  <img src="https://img.shields.io/badge/pagy-E9573F.svg?&style=for-the-badge&logo=rubygems&logoColor=white" />
  </p>

  ### Testing:  
  <p>
  <img src="https://img.shields.io/badge/rspec-E9573F.svg?&style=for-the-badge&logo=rubygems&logoColor=white" />
  <img src="https://img.shields.io/badge/launchy-E9573F.svg?&style=for-the-badge&logo=rubygems&logoColor=white" />
  <img src="https://img.shields.io/badge/orderly-E9573F.svg?&style=for-the-badge&logo=rubygems&logoColor=white" />
  <img src="https://img.shields.io/badge/pry-E9573F.svg?&style=for-the-badge&logo=rubygems&logoColor=white" />
  <img src="https://img.shields.io/badge/capybara-E9573F.svg?&style=for-the-badge&logo=rubygems&logoColor=white" /><br>
  <img src="https://img.shields.io/badge/shoulda--matchers-E9573F.svg?&style=for-the-badge&logo=rubygems&logoColor=white" />
  <img src="https://img.shields.io/badge/simplecov-E9573F.svg?&style=for-the-badge&logo=rubygems&logoColor=white" />
  <img src="https://img.shields.io/badge/faker-E9573F.svg?&style=for-the-badge&logo=rubygems&logoColor=white" />
  <img src="https://img.shields.io/badge/factorybot-E9573F.svg?&style=for-the-badge&logo=rubygems&logoColor=white" />
  </p>

  ### Public Holiday API:  
  <img src="https://img.shields.io/badge/Nager.Date-E9573F.svg?&style=for-the-badge&logo=nager&logoColor=white" />

