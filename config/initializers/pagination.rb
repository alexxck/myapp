# frozen_string_literal: true

# These two are needed to make will_paginate work with AA.
Kaminari.configure do |config|
  config.page_method_name = :per_page_kaminari
end

require 'will_paginate/active_record'
module WillPaginate
  module ActiveRecord
    module RelationMethods
      alias total_count count
    end
  end
end