# README

Dynamic REST and GraphQL API's with full documentation based on Rails models

DONE:

* Dynamically generate REST API
* Dynamically generate GraphQL API (queries)
* Create serializers and use for GQL object type definitions and REST API responses
* Add example of Dynamic OpenAPI docs for REST API
* Dynamic GQL mutations
* Skip certain actions for a given model

FOLLOW UPS:

* By default, do not require a separate serializer. Just use model attribute_names and provide a way to limit seralizable attributes
* More robust way to define permitted_params and args for mutations
* Customization / overriding defaults
* Handle nested objects (like /posts/:id/comments)
* Dynamic GQL schema based on user permissions
* Generate API Clients
* Generate Postman requests (or export OpenAPI to postman)
* Create pattern for enums (model attrs and GQL types)
