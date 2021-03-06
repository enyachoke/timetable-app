# encoding: utf-8

class Building < ActiveRecord::Base
  attr_accessible :address, :title, :classrooms_attributes

  belongs_to :organization

  has_many :classrooms, :dependent => :destroy, :order => 'classrooms.number ASC'

  accepts_nested_attributes_for :classrooms, allow_destroy: true

  validates_presence_of :address, :title
  validates_uniqueness_of :title, :scope => [:organization_id, :address]

  normalize_attributes :address, :title

  alias_attribute :to_s, :title
end
