require 'active_record'

module Juixe
  module Acts 
    module Commentable 

      def self.included(base)
        base.extend ClassMethods
      end

      module ClassMethods
        def acts_as_commentable(options={})
          has_many :comments, {:as => :commentable, :dependent => :destroy}.merge(options)
          include Juixe::Acts::Commentable::InstanceMethods
          extend Juixe::Acts::Commentable::SingletonMethods
        end
      end
      
      module SingletonMethods

        def find_comments_for(obj)
          Comment.find_comments_for_commentable(self.to_s, obj.id)
        end
        
        def find_comments_by_user(user)
          Comment.where(["user_id = ? and commentable_type = ?", user.id, self.to_s]).order("created_at DESC")        end
        end
      
      module InstanceMethods

        def comments_ordered_by_submitted
          Comment.find_comments_for_commentable(self.class.name, id)
        end
        
        def add_comment(comment)
          comments << comment
        end
      end
    end
  end
end

ActiveRecord::Base.send(:include, Juixe::Acts::Commentable)