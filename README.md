# Scale This

## Hello! Welcome to Scale This. This is a web application for discovering musical scales and tracking your progress.
Visit the live site [here](https://scale-this.herokuapp.com)!

Read my blog posts about [V2 here](https://medium.com/@bethmschofield/any-jqueries-on-how-to-scale-this-so-far-a6e6e0e47068) and [V1 here](https://medium.com/@bethmschofield/scaling-rails-cb26cdda7039)!

![](http://forthebadge.com/images/badges/made-with-ruby.svg)
![](http://forthebadge.com/images/badges/made-with-javascript.svg)
![](https://forthebadge.com/images/badges/built-with-love.svg)

At a minimum, users can:
  + Create an account, login and logout (including Facebook OAuth)
  + See a list of scales
  + Mark scales as 'practised' and accrue experience practising that scale
  + Add new scales (they can be public or private)
  + Edit scales they have made
  + Hear audio versions of the scales
  + See a page for each public scale and any of their own private scales
  + See a personal scale library with all the scales they have marked as known, learning or to learn in the future
  + Delete scales they have made
  + See user rankings ordered by how much practise the user has done

Future functionality may include:
  + Follow other users and share new scales in private groups
  + Search the library for scales they are interested in
  + See a tailored news feed of new scales made by users they have followed
  + Search for other users who are using the app
  + Visualise the scales in new ways
  + Randomise the scale order to generate new melody snippets for practice ideas
  + Randomise the scale order in accordance to the ascending and descending rules where applicable

## Installation instructions

To run this app on a local server:
  1. In a bash terminal of your choice run:
    + `git clone git@github.com:Gingertonic/scale-this.git` to use SSH or
    + `git clone https://github.com/Gingertonic/scale-this.git` to use HTTPS
  2. Run `cd scale-this`
  3. Run `thin start --ssl` and navigate to `https://localhost:3000`
  4. Play!
    + You can make you own account or you can use these credentials to log in as a pre-made user:
      + username: `gingertonic@test.com` / password: `password`

   - If you encounter any problems or cannot access the gingertonic test account, run these steps after step 2 above
    3. run `bundle install`
    4. Run `rake db:reset`
    5. Back to step 3 as above (run `thin start --ssl`)


## This is created for a Flatiron School Portfolio Project

# Version 2: Rails with jQuery [CURRENT]

Skills shown include:
  + AJAX
  + Javascript model prototypes
  + Custom Rails API
  + ActiveRecord and SQL
  + Ruby on Rails framework
  + OAuth authentication
  + Handlebars
  + HTML, ERB & CSS
  + DRY principles

Overview
In this assessment your goal is to expand upon the rails assessment you did previously. The goal is to add dynamic features that are possible only through jQuery and a JSON API for your app. Do not use remote: true in this application.

Requirements
1. Must render at least one index page (index resource - 'list of things') via jQuery and an Active Model Serialization JSON Backend. For example, in a blog domain with users and posts, you might display the index of the users posts on the users show page, fetching the posts via an AJAX GET request, with the backend rendering the posts in JSON format, and then appending the posts to the page.

2. Must render at least one show page (show resource - 'one specific thing') via jQuery and an Active Model Serialization JSON Backend. For example, in the blog domain, you might allow a user to sift through the posts by clicking a 'Next' button on the posts show page, with the next post being fetched and rendered via JQuery/AJAX.

3. The rails API must reveal at least one has-many relationship in the JSON that is then rendered to the page. For example if each of those posts has many comments, you could render those comments as well on that show page.

4. Must use your Rails API and a form to create a resource and render the response without a page refresh. For example, a user might be able to add a comment to a post, and the comment would be serialized, and submitted via an AJAX POST request, with the response being the new object in JSON and then appending that new comment to the DOM using JavaScript (ES6 Template Literals can help out a lot with this).

5. Must translate the JSON responses into Javascript Model Objects. The Model Objects must have at least one method on the prototype. Formatters work really well for this. Borrowing from the previous example, instead of plainly taking the JSON response of the newly created comment and appending it to the DOM, you would create a Comment prototype object and add a function to that prototype to perhaps concatenate (format) the comments authors first and last name. You would then use the object to append the comment information to the DOM.

---

# Version 1: Rails [See legacy branch]

Skills shown include:
  + MVC application models
  + ActiveRecord and SQL
  + Ruby on Rails framework
  + OAuth authentication
  + Object orientation
  + HTML, ERB & CSS
  + RESTful routing
  + DRY principles
  + TDD & BDD using Rspec and Cabypara

The requirements for this project are:
  1. Use the Ruby on Rails framework.

  2. Your models must include a has_many, a belongs_to, and a has_many :through relationship. You can include more models to fill out your domain, but there must be at least a model acting as a join table for the has_many through. Also, make sure that the join table contains at least one user submittable attribute; for example: rides with tickets or appointments with times.

  3. Your models should include reasonable validations for the simple attributes. You don't need to add every possible validation or duplicates, such as presence and a minimum length, but the models should defend against invalid data.

  4. You must include at least one class level ActiveRecord scope methods. To some extent these class scopes can be added to power a specific individual feature, such as "My Overdue Tasks" in a TODO application, scoping all tasks for the user by a datetime scope for overdue items, @user.tasks.overdue. Reports make for a good usage of class scopes, such as "Most Valuable Cart by Customer" where the code would implement a Cart.most_valuable and Cart.by_customer which could be combined as Cart.most_valuable.by_customer(@customer).

  5. Your application must provide a standard user authentication, including signup, login, logout, and passwords. You can use Devise but given the complexity of that system, you should also feel free to roll your own authentication logic.

  6. Your authentication system should allow login from some other service. Facebook, twitter, foursquare, github, etc...

  7. You must make use of a nested resource with the appropriate RESTful URLs. Additionally, your nested resource must provide a form that relates to the parent resource. Imagine an application with user profiles. You might represent a person's profile via the RESTful URL of /profiles/1, where 1 is the primary key of the profile. If the person wanted to add pictures to their profile, you could represent that as a nested resource of /profiles/1/pictures, listing all pictures belonging to profile 1. The route /profiles/1/pictures/new would allow me to upload a new picture to profile 1. Focus on making a working application first and then adding more complexity. Making a nested URL resource like '/divisions/:id/teams/new' is great. Having a complex nested resource like 'countries/:id/sports/:id/divisions/:id/teams/new' is going to make this much harder on you.

  8. Your forms should correctly display validation errors. Your fields should be enclosed within a fields_with_errors class and error messages describing the validation failures must be present within the view.

  9. Your application must be, within reason, a DRY (Do-Not-Repeat-Yourself) rails app. Logic present in your controllers should be encapsulated as methods in your models. Your views should use helper methods and partials to be as logic-less as possible. Follow patterns in the Rails Style Guide and the Ruby Style Guide.

  10. Do not use scaffolding to build your project. Your goal here is to learn. Scaffold is a way to get up and running quickly, but learning a lot is not one of the benefits of scaffolding. That’s why we do not allow the use of scaffolding for projects.



## Contributions

If you would like to suggest an improvement or new feature that would be awesome!
To do this:
  1. fork and clone this repo
  2. `cd` into the project folder and run `bundle install`
  3. run `rspec` to make sure the tests are passing for you
  4. make a new branch for your changes - try and use a relevant name `git checkout -b <your-branch-name>`
      + eg. `git checkout -b awesome-new-feature`
  5. make your changes and/or additions
  6. push your changes to your own fork
  7. submit a pull request

After submitting your pull request, I will review it as soon as I can.
It would super extra awesome if you can
  + Include tests for you new features
  + Make a relevant commit message and add a solid description with the request.

## License

The MIT License (MIT)

Copyright (c) 2018 Beth Michelle Schofield [Gingertonic]

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
