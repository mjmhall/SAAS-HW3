# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create!(movie)
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database her
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  movie_list = page.find_by_id("movies").text
  movie_list =~ Regexp.new("^.*?(" + e1 + ").*?(" + e2 + ").*$")	
  $1.should == e1 
  $2.should == e2
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_list.split.each {|rating| uncheck ? uncheck("ratings_" + rating) : check("ratings_" + rating )}     
end

Then /I should see all the movies/ do
  # Make sure that all the movies in the app are visible in the table
  rows = page.find_by_id("movies").all('tr').count 
  rows.should == 11
    
end

When 'I press refresh' do
  click_button("ratings_submit")
end

When 'I debug' do
  pry
end
