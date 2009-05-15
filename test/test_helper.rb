require 'test/unit'

require 'rubygems'
require 'activesupport'
require 'active_support/test_case'
require 'activerecord'
require 'active_record/fixtures'

dir = File.dirname(__FILE__)

ENV['RAILS_ENV'] = 'test'

require dir + '/../lib/flexifield'
require dir + '/../lib/flexifield_def'
require dir + '/../lib/flexifield_def_entry'
require dir + '/../lib/has/flexible_fields'
require dir + '/../init.rb'

#config = { 'test' => { 'adapter' => 'sqlite3', 'dbfile' => dir + '/db/has_flexible_fields.sqlite3.db' } }
config = { 'test' => { 'adapter' => 'sqlite3', 'database' => ':memory:' } }

ActiveRecord::Base.logger = Logger.new(dir + '/log/has_flexiblefields.log')
ActiveRecord::Base.configurations = config
ActiveRecord::Base.establish_connection(config['test'])

class ActiveSupport::TestCase #:nodoc:
  include ActiveRecord::TestFixtures

  self.use_transactional_fixtures = true
  self.use_instantiated_fixtures  = true
  self.fixture_path = File.dirname(__FILE__) + '/fixtures/'
end

require dir + '/fixtures/models.rb'
require dir + '/db/schema.rb' unless Post.table_exists?


