# libraries
require 'nokogiri'
require 'httparty'
require 'json'

# function to scrap the website
def scraper

    # HTTParty gets the unparsed data and Nokogiri parses the data
    # article_array is created to store the data
    # article_list gives the parsed data of articles
    url = "https://www.freethink.com/articles"
    unparsed_page = HTTParty.get(url)
    parsed_page = Nokogiri::HTML(unparsed_page.body)
    article_array = Array.new
    article_list = parsed_page.css('div.loop-item')

    # total_pages: total number of paginations in the website(converts the string value to integer)
    # per_page: number of articles in each page
    page = 1;
    per_page = article_list.count
    total_pages = parsed_page.css('a.page-numbers').children[2].text.to_i
    total_articles = total_pages* per_page

    # Takes input from user to get the number of pages they want to scrap 
    puts "Time taken to scrap one page: 10 - 20 sec"
    puts "Total number of pages: #{total_pages}"
    print "Enter page limit: "
    page_limit = gets.chomp.to_i

     
    # navigates to each page 
    while page <= page_limit

        puts "Collecting details of page #{page} out of #{total_pages}...."
        
        # parsing of each pages 
        pagination_url = "https://www.freethink.com/articles?paging=#{page}"
        pagination_unparsed_page = HTTParty.get(pagination_url)
        pagination_parsed_page = Nokogiri::HTML(pagination_unparsed_page.body)
        article_list = pagination_parsed_page.css('div.loop-item')

        article_list.each do |articles|

            # To get first paragraph and timestamp of the article 
            detailed_unparsed_page = HTTParty.get(articles.css('a')[0].attributes["href"].value)
            detailed_parsed_page = Nokogiri::HTML(detailed_unparsed_page.body)
            time_stamp = detailed_parsed_page.css('time')[0].attributes["datetime"].value
            paragraph = detailed_parsed_page.css('p')[0].text

            #list items
            article = {
                title: articles.css('a.loop-item__title')[0].children.text,
                image_link: articles.css('img')[0].attributes["src"].value,
                news_page_link: articles.css('a')[0].attributes["href"].value,
                time_stamp: time_stamp,
                text: paragraph
            }
            article_array << article
        end

        puts "#{per_page*page}/#{total_articles} list of items collected."
        puts " "
        page +=1

    end

    json_file = JSON.pretty_generate(article_array) # Converts to JSON format
    File.open("data.json", 'w') { |file| file.write(json_file) } # Saves the data to a JSON file

    print json_file
    
end

scraper