require 'test/unit'

require 'rubygems'
require 'activesupport'
require 'active_support/test_case'
require 'activerecord'
require 'active_record/fixtures'

dir = File.dirname(__FILE__)

ENV['RAILS_ENV'] = 'test'

['/..','/../app/models','/fixtures','/db'].each do |lp|
  $LOAD_PATH << File.expand_path( File.dirname(__FILE__) + lp )
end

require 'has/flexible_fields'
require 'init'

#config = { 'test' => { 'adapter' => 'sqlite3', 'dbfile' => dir + '/db/has_flexible_fields.sqlite3.db' } }
config = { 'test' => { 'adapter' => 'sqlite3', 'database' => ':memory:' } }

ActiveRecord::Base.logger = Logger.new(dir + '/log/has_flexiblefields.log')
ActiveRecord::Base.configurations = config
ActiveRecord::Base.establish_connection(config['test'])

require 'flexifield'
require 'flexifield_def'
require 'flexifield_def_entry'

class ActiveSupport::TestCase #:nodoc:
  include ActiveRecord::TestFixtures

  self.use_transactional_fixtures = true
  self.use_instantiated_fixtures  = true
  self.fixture_path = File.dirname(__FILE__) + '/fixtures/'
end

require 'models.rb'
require 'schema.rb' unless Post.table_exists?
Post.create_ff_tables!

