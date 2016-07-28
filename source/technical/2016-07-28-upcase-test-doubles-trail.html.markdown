---
title: "Upcase: Test Doubles trail"
date: 2016-07-28 22:03 UTC
tags: course notes, upcase, testing
---

# Learning about Testing with Stubs and Mocks and Spies

These are notes from UpCase's course "Test Doubles"

https://thoughtbot.com/upcase/test-doubles

# Simple Stub

## Create a Stub with Rspec `double`

`all_posts = double('descriptive statement')`

> This creates an object that stands in for an actual object like an ActiveRecord DB Query for example;
> it's like a stunt double for your actual object. Using the double method is very similar to calling Object.new, but tests that use doubles will fail with much clearer error messages. The "descriptive statement" string above is simply a name which will be used in test failure messages.

## Control behavior with `allow`

`allow(Posts).to receive(:all).and_return(all_posts)`

Combined with `allow`, you can prevent the test from actually hitting the database or model

# Notes from my implementation
~~~
require "spec_helper"
require "dashboard"

describe Dashboard do
  describe "#posts" do
    it "returns posts created today" do
      posts        = double('all posts')
      todays_posts = double('today\s posts')

      allow(Post).to receive(:all).and_return(posts)
      allow(posts).to receive(:today).and_return(todays_posts)
      allow(todays_posts).to receive(:map).and_return(%w(first_today last_today))

      dashboard = Dashboard.new(posts: Post.all)
      # Post.all.today
      # When is it run?  I think it's lazy loaded, but run when @posts is initialized OR is it run at today
      # Well lets run the code
      # the other issue is knowing what code to stub

      result = dashboard.todays_posts

      expect(result.map(&:title)).to match_array(%w(first_today last_today))
    end
  end

  around do |example|
    Timecop.freeze { example.run }
  end
end
~~~

# Stubs with constrant

## this adds another method `.with()` to `receive(:method)` that allows us to check if a method is received with arguments

`allow(all_posts).to receive(:visible_to).with(user).and_return(visible_posts)`

# Here is a diff of my first attempt at the assignment

~~~
describe Dashboard do
   describe "#posts" do
     it "returns posts visible to the current user" do
-      user = create(:user)
-      other_user = create(:user)
-      create :post, user: other_user, published: true, title: "published_one"
-      create :post, user: other_user, published: true, title: "published_two"
-      create :post, user: other_user, published: false, title: "unpublished"
-      create :post, user: user, published: false, title: "visible_one"
-      create :post, user: user, published: false, title: "visible_two"
-      dashboard = Dashboard.new(posts: Post.all, user: user)
+      create(:user) # other user
+      user          = create(:user)
+      all_posts     = double("all posts")
+      visible_posts = double("visible posts")
+      allow(Post).to receive(:all).and_return(all_posts)
+      allow(all_posts).to receive(:visible_to).with(user).and_return(visible_posts)
 
-      result = dashboard.posts
+      dashboard = Dashboard.new(posts: Post.all, user: user)
+      result    = dashboard.posts
 
-      expect(result.map(&:title)).to match_array(%w(
-        published_one
-        published_two
-        visible_one
-        visible_two
-      ))
+      expect(result).to eq visible_posts
     end
   end
 end
~~~

I wonder if `Post.all` needs to be stubbed.

# Setting Expectations with Mocks

This allows us to test if a model received a method.

`allow(Post).to receive(:all)` stubs out the behavior of `Post`.

`expect(Post).to receive(:all)`

  * stubs out the behavior of `Post`
  * AND tests that `Post` receives the `all` method

# My implementation

~~~
 describe Signup do
   describe "#save" do
     it "creates an account with one user" do
+      account = double("Account instance")
+      expect(Account).to receive("create!").
+        with(name: "Example").and_return(account)
+      expect(User).to receive("create!").
+        with(account: account, email: "user@example.com")
+
       signup = Signup.new(email: "user@example.com", account_name: "Example")
 
       result = signup.save
 
-      expect(Account.count).to eq(1)
-      expect(Account.last.name).to eq("Example")
-      expect(User.count).to eq(1)
-      expect(User.last.email).to eq("user@example.com")
-      expect(User.last.account).to eq(Account.last)
       expect(result).to be(true)
     end
   end
 
   describe "#user" do
     it "returns the user created by #save" do
+      saved_user = double("saved user")
+      allow(User).to receive("create!").and_return(saved_user)
       signup = Signup.new(email: "user@example.com", account_name: "Example")
       signup.save
 
       result = signup.user
 
-      expect(result.email).to eq("user@example.com")
-      expect(result.account.name).to eq("Example")
+      expect(result).to eq(saved_user)
     end
   end
 end
~~~

No need to touch the database

# Verifying Expectations with Spies

* Allows us to break up test into nice parts:
  * Setup
  * Exercise
  * Verification

# Example

these two implementations are the same behavior with spies having better grouping

  * Mock example

~~~
describe PostsController  do
  describe "#edit" do
    it "redirects to the created post when published" do
      # Setup
      post = create(:post)
      allow(post).to received(:published?).and_return(true)
      attributes = { "title" => "example" }

      # Setup? Verification? Both?
      expect(Post).to receive(:create).with(attributes).and_return(post)

      # Exercise
      post :create, post: attributes

      # Verification
      expect(response).to redirect_to(post_url(post))
    end
  end
end
~~~

  * Spy example

~~~
describe PostsController  do
  describe "#edit" do
    it "redirects to the created post when published" do
      # Setup
      post = create(:post)
      allow(post).to receive(:published?).and_return(true)
      allow(Post).to receive(:create).and_return(post)
      attributes = { "title" => "example" }

      # Exercise
      post :create, post: attributes

      # Verification
      expect(Post).to have_received(:create).with(attributes)
      expect(response).to redirect_to(post_url(post))
    end
  end
end
~~~

# More closely:

~~~
  # Here is a mock
  expect(Post).to receive(:create).with(attributes).and_return(post)

  # Here is an equivalent spy
  allow(Post).to receive(:create).with(attributes).and_return(post)
  expect(Post).to have_received(:create).with(attributes)
~~~

# Testing Flexible Interactions with Fakes

Here we just actually implement a plain old Ruby object!

# An awkward example

~~~
describe SearchForm  do
  describe "#results" do
    it "builds a search and returns its results" do
      search = double("search")
      results = double("results")
      allow(Search).to receive(:new).and_return(search)
      allow(search).to receive(:author_word).and_return(search)
      allow(search).to receive(:title_word).and_return(search)
      # the order must have `:to_a` last!
      allow(search).to receive(:to_a).and_return(results)
      form = SearchForm.new(title: "one two", author: "Billy Idol")

      expect(form.results).to eq(results)
      expect(search).to have_received(:author_word).with("Billy")
      expect(search).to have_received(:author_word).with("Idol")
      expect(search).to have_received(:title_word).with("one")
      expect(search).to have_received(:title_word).with("two")
    end
  end
end
~~~

# Using a fake

~~~
describe SearchForm  do
  describe "#results" do
    it "builds a search and returns its results" do
      search = FakeSearch.new
      allow(Search).to receive(:new).and_return(search)
      form = SearchForm.new(title: "one two", author: "Billy Idol")

      expect(form.results.criteria).to eq(
        author_words: %w(Billy Idol),
        title_words: %w(one two)
      )
    end
  end
end
~~~

# But this `FakeSearch` must be implemented

~~~
class FakeSearch
  def initialize(criteria = nil)
    @criteria = criteria || {
      author_words: [],
      title_words: []
    }
  end

  def author_word(word)
    new_words = @criteria[:author_words] + [word]
    self.class.new(@criteria.merge(author_words: new_words))
  end

  def title_word(word)
    new_words = @criteria[:title_words] + [word]
    self.class.new(@criteria.merge(title_words: new_words))
  end

  def results
    Results.new(@criteria)
  end

  class Results
    attr_reader :criteria

    def initialize(criteria)
      @criteria = criteria
    end
  end
end
~~~

# Some question and answers I have

* Q: How does the fake replace spies?

~~~
expect(search).to have_received(:author_word).with("Billy")
expect(search).to have_received(:author_word).with("Idol")
expect(search).to have_received(:title_word).with("one")
expect(search).to have_received(:title_word).with("two")
~~~

* A: By testing side effects.
  * if `search` didn't receive the following methods, this wouldn't pass.

~~~
expect(form.results.criteria).to eq(
  author_words: %w(Billy Idol),
  title_words: %w(one two)
)
~~~

# My implementation

For this assignment, we were meant to implement a `logger` that made note of exceptions that were raised when a method was called.

I just made this class:

~~~
class FakeLogger
  attr_reader :info_message, :error_message
  def info(message)
    @info_message = message
  end

  def error(message)
    @error_message = message
  end
end
~~~

* It can tell if there's been an error or not.
* It can return the error that was logged.

# The featured solution

~~~
class FakeLogger
  attr_reader :info_message, :error_message
  def info(message)
    @message = {
      info: [],
      data: [],
      error: [],
      fatal: []
    }
  end

  def data(message)
    @message[:data] << message
  end

  ... # other parts omitted
end
~~~

# Verifying Mailers with Test Doubles

Putting it all together

# Objectives:

* test `Signup#save`'s interaction with `SignupMailer#signup`
* test this same method to log a message

# `SignupMailer#signup`

Here, I just needed to test that `SignupMailer` received the `signup(account: account, user: user)` when `Signup#save` was called.

This was straight forward and there weren't many side effects to test for.

# `Log.message[:info]`

After testing `Signup#save` sends a message to `SignupMailer`, we were asked to practice TDD and implement a log to the server with an info message.  It was interesting because there was no Logger object to work with.  But, I make a `FakeLogger` fake in the end to make sure that the `Signup#save` object some how logs a sent email.

Still, one interesting thing was I was open to implementing the message anyway I wanted since there was no preexisting `Logger`.  I created an object with a `messages` method that returned a hash.  `{ info: [] }`.  This may have made more sense if were logging errors and stuff too, but that's what I saw in in the lesson so I had at it.

# Conclusion

I really enjoyed the lesson and learned about stubs, mocks, spies, and fakes. This will come in handy for TDD I'm working on in the future.

* Stubs: stand in objects for betting isolating and error messages.
* Mocks: stand in 'method' calls with evaluation
* Spies: separated out Mock to allow for organizing setup and evaluation
* Fakes: plain old ruby objects that can be tested for values.

