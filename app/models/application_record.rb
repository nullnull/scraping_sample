class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  scope :created_after, ->t { where(arel_table[:created_at].gt(t)) }
  scope :created_after_or_at, ->t { where(arel_table[:created_at].gteq(t)) }
  scope :created_before, ->t { where(arel_table[:created_at].lt(t)) }
  scope :created_before_or_at, ->t { where(arel_table[:created_at].lteq(t)) }
  scope :updated_after, ->t { where(arel_table[:updated_at].gt(t)) }
  scope :updated_after_or_at, ->t { where(arel_table[:updated_at].gteq(t)) }
  scope :updated_before, ->t { where(arel_table[:updated_at].lt(t)) }
  scope :updated_before_or_at, ->t { where(arel_table[:updated_at].lteq(t)) }

  def decorate!
    ActiveDecorator::Decorator.instance.decorate(self)
    self
  end
end
