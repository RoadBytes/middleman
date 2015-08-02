---
title: Notes of my form_tag implementation
date: 2015-08-01 18:11 UTC
tags: tealeaf, rails, form_tag, course 3
---

Rails has form helpers to make coding the html a bit easier.  But, coming from zero knowledge, I find that I'd have to learn both the html AND the rails and it's weird juggling the two syntax.  The best was for me to put it all together is to bounce between my rails code and the output html in the browser.

Also, it was interesting how the `form_tag` helps input be accessed by the controller.  Here is a cleaned up version of my `form_tag` implementation.

~~~ ruby
= form_tag "my_queue" do
  = hidden_field_tag "queue_items[][id]", queue_item.id
  = text_field_tag "queue_items[][position]", queue_item.position, class: "form-control"
  = submit_tag "Update Instant Queue", class: "btn btn-default"
~~~

Making the provided form data available to the controller was a bit tricky, but I learned that it can be accessed through the `params` hash and there is a syntax which would order the information in a certain way.  For example, in the

`hidden_field_tag "queue_items[][id]", queue_item.id`

The data for the `queue_item.id` would be available in the `params` hash through:

`params["queue_items"][int]["id"]`

See the connection between the params and `hidden_field_tag` variable name?  In the controller, I was then able to access the queue_item information by iterating through the params["queue_item"] array of hashes and accessing the `"id"` and `"position"` keys.

~~~ ruby
params["queue_items"].each do |queue_item_data|            # see that params is storing form data as an array in this case
  queue_item = QueueItem.find_by id: queue_item_data["id"] # Here we are using ["id"] to find each queue_item from the params
  queue_item[:position] = queue_item_data["position"]      # Here the position is accessed from the form data
  queue_item.save
~~~

Another problem I had was ordering the tags amongst the table rows and other data.  Also considering we were also working with HAML the freaking tabs were a bit tricky to get right.  Even though the form_tag above was nice and ordered, here is the actual form in the view for the app.

~~~ ruby
%section.my_queue.container
  .row
    .col-sm-10.col-sm-offset-1
      %article
        %header
          %h2 My Queue
        = form_tag "my_queue" do
          %table.table
            %thead
              %tr
                %th(width="10%") List Order
                %th(width="30%") Video Title
                %th(width="10%") Play
                %th(width="20%") Rating
                %th(width="15%") Genre
                %th(width="15%") Remove

            %tbody
              - @queue_items.each do |queue_item|
                %tr
                  %td
                    = hidden_field_tag "queue_items[][id]", queue_item.id
                    = text_field_tag "queue_items[][position]", queue_item.position, class: "form-control"
                  %td
                    = link_to queue_item.video.title, video_path(queue_item.video)
                  %td
                    = button_to "Play", nil, class: "btn btn-default"
                  %td
                    = queue_item.user_rating
                  %td
                    = link_to queue_item.category.name, category_path(queue_item.category)
                  %td
                    = link_to queue_item, method: "DELETE" do
                      %i.glyphicon.glyphicon-remove
          = submit_tag "Update Instant Queue", class: "btn btn-default"
~~~

So yeah, I had a good time with forms.  It's something trying to learn all this at once, but after getting my hands dirty, at all comes together and learning/understanding sets in.  Any question or comments, feel free to comment or email me.

jason.data@roadbytes.me
