require_relative('../../app/models/concerns/autopopulateable')

ActiveRecord::Base.include(Autopopulateable)
