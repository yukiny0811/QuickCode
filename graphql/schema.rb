require 'graphql'
require './graphql/query.rb'

class TestDBSchema < GraphQL::Schema 
  query QueryType
end