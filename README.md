
# Web Scraper 

A Web Scraper written in Ruby to get the details of articles in the website https://www.freethink.com/articles.


## Running Project

Clone from Github

```bash
    git clone https://github.com/Vyshnav-KS/Scraper.git
    cd Scraper
```




To deploy this project run

```bash
    bundle install
    ruby scraper.rb
```


## Features

- User can select the number of pages to scrap.
- Returns an array of list of itmes containing Title, News link, Image link, Timestamp and First paragraph of the article.
- Generates JSON file with corresponding data.



## Libraries used

- Httparty
- Nokogiri
- json



## Ruby Instalation Guide

Read the documentation <a href = "https://www.ruby-lang.org/en/documentation/installation/" >here </a>