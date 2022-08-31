# API Endpoints and Their Output
### [Back to Readme](./README.md)
____
[All Merchants](#all-merchants)  
[Single Merchant](#single-merchant)  
[Merchant Items](#merchant-items)  
[Search Merchants](#search-merchants)  
[All Items](#all-items)  
[Single Item](#single-item)  
[Item Merchant](#item-merchant)  
[Search Items](#search-items)  
___
### Notes:
- All endpoints return JSON data
- Search parameters are case insensitive
- When searching items unit_price, the search parameter must be a string
___
## All Merchants:
```
http://localhost:3000/api/v1/merchants
```
Output:
```
{
    "data": [
        {
            "id": "1",
            "type": "merchant",
            "attributes": {
                "name": "Schroeder-Jerde"
            }
        },
        {
            "id": "2",
            "type": "merchant",
            "attributes": {
                "name": "Klein, Rempel and Jones"
            }
        }]
}
```
[to top](#api-endpoints-and-their-output)
___

## Single Merchant:
```
http://localhost:3000/api/v1/merchants/:id
```
Output:
```
{
    "data": {
        "id": "1",
        "type": "merchant",
        "attributes": {
            "name": "Schroeder-Jerde"
        }
    }
}
```
[to top](#api-endpoints-and-their-output)
___

## Merchant Items:
```
http://localhost:3000/api/v1/merchants/:id/items
```
Output:
```
{
    "data": [
        {
            "id": "1",
            "type": "item",
            "attributes": {
                "name": "Item Qui Esse",
                "description": "Nihil autem sit odio inventore deleniti. Maiores eos cumque distinctio laborum qui. Aut est omnis doloremque. Est doloremque quia. Voluptatem dolorum ut voluptatem quia voluptatem.",
                "unit_price": "751.07"
            }
        },
        {
            "id": "2",
            "type": "item",
            "attributes": {
                "name": "Item Autem Minima",
                "description": "Cumque consequatur ad. Autem doloribus doloremque doloremque. Qui voluptatem ut. Quia voluptatem ut. Quia voluptatem ut. Quia voluptatem ut.",
                "unit_price": "670.76"
            }
        }]
}
```
[to top](#api-endpoints-and-their-output)
___

## Search Merchants:

## Find a single merchant by name:
```
http://localhost:3000/api/v1/merchants/find?name=NAME
```
Output:
```
{
    "data": {
        "id": "1",
        "type": "merchant",
        "attributes": {
            "name": "Schroeder-Jerde"
        }
    }
}
```
[to top](#api-endpoints-and-their-output)
___

## Find a single merchant by id:
```
http://localhost:3000/api/v1/merchants/find?id=ID
```
Output:
```
{
    "data": {
        "id": "1",
        "type": "merchant",
        "attributes": {
            "name": "Schroeder-Jerde"
        }
    }
}
```
[to top](#api-endpoints-and-their-output)
___

## Find all merchants by name:
```
http://localhost:3000/api/v1/merchants/find_all?name=NAME
```
Output:
```
{
    "data": [
        {
            "id": "1",
            "type": "merchant",
            "attributes": {
                "name": "Schroeder-Jerde"
            }
        },
        {
            "id": "2",
            "type": "merchant",
            "attributes": {
                "name": "Klein, Rempel and Jones"
            }
        }]
}
```
[to top](#api-endpoints-and-their-output)
___

## Find all merchants by id:
```
http://localhost:3000/api/v1/merchants/find_all?id=ID
```
Output:
```
{
    "data": [
        {
            "id": "1",
            "type": "merchant",
            "attributes": {
                "name": "Schroeder-Jerde"
            }
        },
        {
            "id": "2",
            "type": "merchant",
            "attributes": {
                "name": "Klein, Rempel and Jones"
            }
        }]
}
```
[to top](#api-endpoints-and-their-output)
___

## All Items:
```
http://localhost:3000/api/v1/items
```
Output:
```
{
    "data": [
        {
            "id": "1",
            "type": "item",
            "attributes": {
                "name": "Item Qui Esse",
                "description": "Nihil autem sit odio inventore deleniti. Maiores eos cumque distinctio laborum qui. Aut est omnis doloremque. Est doloremque quia. Voluptatem dolorum ut voluptatem quia voluptatem.",
                "unit_price": "751.07"
            }
        },
        {
            "id": "2",
            "type": "item",
            "attributes": {
                "name": "Item Autem Minima",
                "description": "Cumque consequatur ad. Autem doloribus doloremque doloremque. Qui voluptatem ut. Quia voluptatem ut. Quia voluptatem ut. Quia voluptatem ut.",
                "unit_price": "670.76"
            }
        }]
}
```
[to top](#api-endpoints-and-their-output)
___

## Single Item:
```
http://localhost:3000/api/v1/items/:id
```
```
{
    "data": {
        "id": "1",
        "type": "item",
        "attributes": {
            "name": "Item Qui Esse",
            "description": "Nihil autem sit odio inventore deleniti. Maiores eos cumque distinctio laborum qui. Aut est omnis doloremque. Est doloremque quia. Voluptatem dolorum ut voluptatem quia voluptatem.",
            "unit_price": "751.07"
        }
    }
}
```
[to top](#api-endpoints-and-their-output)
___

## Item Merchant:
```
http://localhost:3000/api/v1/items/:id/merchant
```
Output:
```
{
    "data": {
        "id": "1",
        "type": "merchant",
        "attributes": {
            "name": "Schroeder-Jerde"
        }
    }
}
```
[to top](#api-endpoints-and-their-output)
___

## Search Items:

## Find a single item by name:
```
http://localhost:3000/api/v1/items/find?name=NAME
```
Output:
```
{
    "data": {
        "id": "1",
        "type": "item",
        "attributes": {
            "name": "Item Qui Esse",
            "description": "Nihil autem sit odio inventore deleniti. Maiores eos cumque distinctio laborum qui. Aut est omnis doloremque. Est doloremque quia. Voluptatem dolorum ut voluptatem quia voluptatem.",
            "unit_price": "751.07"
        }
    }
}
```
[to top](#api-endpoints-and-their-output)
___

## Find a single item by id:
```
http://localhost:3000/api/v1/items/find?id=ID
```
Output:
```
{
    "data": {
        "id": "1",
        "type": "item",
        "attributes": {
            "name": "Item Qui Esse",
            "description": "Nihil autem sit odio inventore deleniti. Maiores eos cumque distinctio laborum qui. Aut est omnis doloremque. Est doloremque quia. Voluptatem dolorum ut voluptatem quia voluptatem.",
            "unit_price": "751.07"
        }
    }
}
```
[to top](#api-endpoints-and-their-output)
___

## Find a single item by description:
```
http://localhost:3000/api/v1/items/find?description=DESCRIPTION
```
Output:
```
{
    "data": {
        "id": "1",
        "type": "item",
        "attributes": {
            "name": "Item Qui Esse",
            "description": "Nihil autem sit odio inventore deleniti. Maiores eos cumque distinctio laborum qui. Aut est omnis doloremque. Est doloremque quia. Voluptatem dolorum ut voluptatem quia voluptatem.",
            "unit_price": "751.07"
        }
    }
}
```
[to top](#api-endpoints-and-their-output)
___

## Find a single item by unit price:
```
http://localhost:3000/api/v1/items/find?unit_price=UNIT_PRICE
```
Output:
```
{
    "data": {
        "id": "1",
        "type": "item",
        "attributes": {
            "name": "Item Qui Esse",
            "description": "Nihil autem sit odio inventore deleniti. Maiores eos cumque distinctio laborum qui. Aut est omnis doloremque. Est doloremque quia. Voluptatem dolorum ut voluptatem quia voluptatem.",
            "unit_price": "751.07"
        }
    }
}
```
[to top](#api-endpoints-and-their-output)
___

## Find a single item by merchant id:
```
http://localhost:3000/api/v1/items/find?merchant_id=MERCHANT_ID
```
Output:
```
{
    "data": {
        "id": "1",
        "type": "item",
        "attributes": {
            "name": "Item Qui Esse",
            "description": "Nihil autem sit odio inventore deleniti. Maiores eos cumque distinctio laborum qui. Aut est omnis doloremque. Est doloremque quia. Voluptatem dolorum ut voluptatem quia voluptatem.",
            "unit_price": "751.07"
        }
    }
}
```
[to top](#api-endpoints-and-their-output)
___

## Find all items by name:
```
http://localhost:3000/api/v1/items/find_all?name=NAME
```
Output:
```
{
    "data": [
        {
            "id": "1",
            "type": "item",
            "attributes": {
                "name": "Item Qui Esse",
                "description": "Nihil autem sit odio inventore deleniti. Maiores eos cumque distinctio laborum qui. Aut est omnis doloremque. Est doloremque quia. Voluptatem dolorum ut voluptatem quia voluptatem.",
                "unit_price": "751.07"
            }
        },
        {
            "id": "2",
            "type": "item",
            "attributes": {
                "name": "Item Autem Minima",
                "description": "Cumque consequatur ad. Autem doloribus doloremque doloremque. Qui voluptatem ut. Quia voluptatem ut. Quia voluptatem ut. Quia voluptatem ut.",
                "unit_price": "670.76"
            }
        }]
}
```
[to top](#api-endpoints-and-their-output)
___

## Find all items by id:
```
http://localhost:3000/api/v1/items/find_all?id=ID
```
Output:
```
{
    "data": [
        {
            "id": "1",
            "type": "item",
            "attributes": {
                "name": "Item Qui Esse",
                "description": "Nihil autem sit odio inventore deleniti. Maiores eos cumque distinctio laborum qui. Aut est omnis doloremque. Est doloremque quia. Voluptatem dolorum ut voluptatem quia voluptatem.",
                "unit_price": "751.07"
            }
        },
        {
            "id": "2",
            "type": "item",
            "attributes": {
                "name": "Item Autem Minima",
                "description": "Cumque consequatur ad. Autem doloribus doloremque doloremque. Qui voluptatem ut. Quia voluptatem ut. Quia voluptatem ut. Quia voluptatem ut.",
                "unit_price": "670.76"
            }
        }]
}
```
[to top](#api-endpoints-and-their-output)
___

## Find all items by description:
```
http://localhost:3000/api/v1/items/find_all?description=DESCRIPTION
```
Output:
```
{
    "data": [
        {
            "id": "1",
            "type": "item",
            "attributes": {
                "name": "Item Qui Esse",
                "description": "Nihil autem sit odio inventore deleniti. Maiores eos cumque distinctio laborum qui. Aut est omnis doloremque. Est doloremque quia. Voluptatem dolorum ut voluptatem quia voluptatem.",
                "unit_price": "751.07"
            }
        },
        {
            "id": "2",
            "type": "item",
            "attributes": {
                "name": "Item Autem Minima",
                "description": "Cumque consequatur ad. Autem doloribus doloremque doloremque. Qui voluptatem ut. Quia voluptatem ut. Quia voluptatem ut. Quia voluptatem ut.",
                "unit_price": "670.76"
            }
        }]
}
```
[to top](#api-endpoints-and-their-output)
___

## Find all items under a certain unit price:
```
http://localhost:3000/api/v1/items/find_all?unit_price_max=UNIT_PRICE
```
Output:
```
{
    "data": [
        {
            "id": "1",
            "type": "item",
            "attributes": {
                "name": "Item Qui Esse",
                "description": "Nihil autem sit odio inventore deleniti. Maiores eos cumque distinctio laborum qui. Aut est omnis doloremque. Est doloremque quia. Voluptatem dolorum ut voluptatem quia voluptatem.",
                "unit_price": "751.07"
            }
        },
        {
            "id": "2",
            "type": "item",
            "attributes": {
                "name": "Item Autem Minima",
                "description": "Cumque consequatur ad. Autem doloribus doloremque doloremque. Qui voluptatem ut. Quia voluptatem ut. Quia voluptatem ut. Quia voluptatem ut.",
                "unit_price": "670.76"
            }
        }]
}
```
[to top](#api-endpoints-and-their-output)
___

## Find all items over a certain unit price:
```
http://localhost:3000/api/v1/items/find_all?unit_price_min=UNIT_PRICE
```
Output:
```
{
    "data": [
        {
            "id": "1",
            "type": "item",
            "attributes": {
                "name": "Item Qui Esse",
                "description": "Nihil autem sit odio inventore deleniti. Maiores eos cumque distinctio laborum qui. Aut est omnis doloremque. Est doloremque quia. Voluptatem dolorum ut voluptatem quia voluptatem.",
                "unit_price": "751.07"
            }
        },
        {
            "id": "2",
            "type": "item",
            "attributes": {
                "name": "Item Autem Minima",
                "description": "Cumque consequatur ad. Autem doloribus doloremque doloremque. Qui voluptatem ut. Quia voluptatem ut. Quia voluptatem ut. Quia voluptatem ut.",
                "unit_price": "670.76"
            }
        }]
}
```
[to top](#api-endpoints-and-their-output)
