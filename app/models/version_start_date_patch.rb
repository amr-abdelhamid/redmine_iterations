require 'version'

module VersionStartDatePatch
  def self.included(base) 
    base.send(:include, StartDateMethod)

    base.class_eval do
      safe_attributes     'start_date'
      validates :start_date, :date => true

      alias_method_chain :start_date, :from_db
    end
  end

  module StartDateMethod
    def start_date_with_from_db
      self[:start_date]
    end
  end
end