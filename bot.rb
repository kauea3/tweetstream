require "rubygems"
require "tweetstream"
require "em-http-request"
require "simple_oauth"
require "json"
require "uri"

# config oauth
OAUTH = {
 :consumer_key => "EDIT_HERE",
 :consumer_secret => "EDIT_HERE",
 :token => "EDIT_HERE",
 :token_secret => "EDIT_HERE"
}
ACCOUNT_ID = OAUTH[:token].split("-").first.to_i

TweetStream.configure do |config|
 config.consumer_key       = OAUTH[:consumer_key]
 config.consumer_secret    = OAUTH[:consumer_secret]
 config.oauth_token        = OAUTH[:token]
 config.oauth_token_secret = OAUTH[:token_secret]
 config.auth_method = :oauth
 
  @client  = TweetStream::Client.new

  puts "[STARTING] bot..."
  @client.userstream() do |status| 
  # Cada status recebido pelo User Stream será manipulado dentro desse bloco
    puts status.text  # print do texto do tweet
   
   @client  = TweetStream::Client.new

puts "[STARTING] bot..."
@client.userstream() do |status| 

if !status.retweet? && 
   status.in_reply_to_user_id? && status.in_reply_to_user_id == ACCOUNT_ID &&
   status.text[-1] == "?"

     tweet = {
       "status" => "@#{status.user.screen_name} " + %w(Sim Não Talvez).sample,
       "in_reply_to_status_id" => status.id.to_s
     }

     # Aqui vai o código que posta a resposta no twitter (apresentado abaixo)
 end
end
@client  = TweetStream::Client.new

puts "[STARTING] bot..."
@client.userstream() do |status| 

if !status.retweet? && 
   status.in_reply_to_user_id? && status.in_reply_to_user_id == ACCOUNT_ID &&
   status.text[-1] == "agua"

     tweet = {
       "status" => "@#{status.user.screen_name} " + %w(Beba Agua).sample,
       "in_reply_to_status_id" => status.id.to_s
     }

     twurl = URI.parse("https://api.twitter.com/1.1/statuses/update.json")
     authorization = SimpleOAuth::Header.new(:post, twurl.to_s, tweet, OAUTH)

     http = EventMachine::HttpRequest.new(twurl.to_s).post({
       :head => {"Authorization" => authorization},
       :body => tweet
     })
     http.errback {
       puts "[CONN_ERROR] errback"
     }
     http.callback {
       if http.response_header.status.to_i == 200
         puts "[HTTP_OK] #{http.response_header.status}"
       else
         puts "[HTTP_ERROR] #{http.response_header.status}"
       end
     }

 end
end
end
