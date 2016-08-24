rut-chileno
===========

ruby gem to validate and format chilean R.U.T.

install as ruby gem
```
	$ gem install chilean_rut
```
or add to Gemfile in Ruby on Rails
```ruby
	gem 'chilean_rut'
```
then
```
	$ bundle install
```

One example use could be in a validator class
```ruby
class RUTValidator < ActiveModel::Validator
  require 'chilean_rut'
  def validate(record)
    unless RUT::validate(record.rut)
      record.errors[:rut] << I18n.t(:invalid_rut)
    end
  end
end
```
which is then referenced from a model
```ruby
class Person < ActiveRecord::Base
  validates_with RUTValidator
end
```
class functions
```ruby
require 'chilean_rut'

rut = '55.555.555-5'
puts RUT::validate(rut) ? 'VALIDO' : 'NO VALIDO' # VALIDO
puts RUT::format(rut) # 55.555.555-5
puts RUT::remove_format(rut) # 555555555
puts RUT::remove_points(rut) # 55555555-5
puts RUT::remove_hyphens(rut) # 55.555.5555
```

----------------------------------------

based on jQuery library by Joaquin Nuñez

http://joaquinnunez.cl/jQueryRutPlugin/
