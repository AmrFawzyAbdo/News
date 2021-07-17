# News
Getting latest news, and the user is able to search among news and, can go through it's details, with the ability of checking internet connection state.


## Installation
TODO: install Alamofire and, Kingfisher pods.
TODO: Get your APIKEY from: https://newsapi.org/account.


## Screenshots

https://i.postimg.cc/xT5Wt5N0/Screen-Shot-2021-07-17-at-4-44-55-AM.png,
https://i.postimg.cc/j2Xk3q58/Screen-Shot-2021-07-17-at-4-45-12-AM.png,
https://i.postimg.cc/3N7cZ0K4/Screen-Shot-2021-07-17-at-4-45-22-AM.png,
https://i.postimg.cc/xCLZH3SV/Screen-Shot-2021-07-17-at-4-45-27-AM.png


## Usage
- User can get all new before search.
- Search with title and press searc icon. (If there is no result you will get a toast message)
- Pull down tableView to refresh news feed.
- Navigate to any of news to go through it's details.
- User can get the image fullscreen.
- User can scroll among details.
- There is a button that direct you to a web view with more details.
- There is a check for internet connection.

## Note
- If there is no image it will be replaced with "newsImage".
- If there is no data according to search, Toast message will notify the user

## Feedback
- My account give me access to get only five pages (PAGINATION), I can't get more until upgrade my account to a paid plan.


## API Reference

#### Get all items

```http
  GET https://newsapi.org/v2/everything?q=tesla&sortBy=publishedAt&apiKey=&page=
```

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `api_key` | `string` | **Required**. Your API key |

#### Get item

```http
  GET https://newsapi.org/v2/everything?qInTitle=tesla&sortBy=publishedAt&apiKey=&page=
```

| Parameter | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `api_key`      | `string` | **Required**. Your API key 
| `qInTitle`      | `string` | **Required**. Tilte to search

  
