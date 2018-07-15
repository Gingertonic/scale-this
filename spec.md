# Specifications for the Rails Assessment

Specs:
- [x] Using Ruby on Rails for the project
- [x] Include at least one has_many relationship (x has_many y e.g. User has_many Recipes)
    Musician has_many Practises
    Scale has_many Practises
- [x] Include at least one belongs_to relationship (x belongs_to y e.g. Post belongs_to User)
    Practise belongs_to Musician
    Practise belongs_to Scale
- [x] Include at least one has_many through relationship (x has_many y through z e.g. Recipe has_many Items through Ingredients)
    Musician has many Scales through Practises
    Scales has many Musicians through Practises
- [x] The "through" part of the has_many through includes at least one user submittable attribute (attribute_name e.g. ingredients.quantity)
    eg scale.pattern
- [x] Include reasonable validations for simple model objects (list of model objects with validations e.g. User, Recipe, Ingredient, Item)
    Musician, Scale and Note have AR validations
    Practise has alternative validation
- [x] Include a class level ActiveRecord scope method (model object & class method name and URL to see the working feature e.g. User.most_recipes URL: /users/most_recipes)
    Musician has self.order_by which, depending on argument, uses:
      where.not(name: 'Admin').order("LOWER(name)")
      joins(:practises).group(:musician_id).order("sum(experience) desc")
  OR  joins(:practises).group(:musician_id).order("practises.updated_at desc")
  all viewable from /musicians/rankings

- [x] Include signup (how e.g. Devise)
    Local sign up with has_secure_password, bcrypt and custom methods
- [x] Include login (how e.g. Devise)
    Local login with has_secure_password, bcrypt and custom methods
- [x] Include logout (how e.g. Devise)
    Local logout with custom method
- [x] Include third party signup/login (how e.g. Devise/OmniAuth)
    3rd party signup/login via Facebook with omniauth & omniauth-facebook
- [x] Include nested resource show or index (URL e.g. users/2/recipes)
    eg: /:musician-slug shows a list off all their practised scales
- [x] Include nested resource "new" form (URL e.g. recipes/1/ingredients)
    /scales/:scale-slug shows a 'practised!' form which creates a new practises (or updates an existing practise where applicable)
- [x] Include form display of validation errors (form URL e.g. /recipes/new)
    validation errors shown on /musicians/new, /scales/new and /scales/:scale-slug/edit

Confirm:
- [x] The application is pretty DRY
- [x] Limited logic in controllers
- [x] Views use helper methods if appropriate
- [x] Views use partials if appropriate
