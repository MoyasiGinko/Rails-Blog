class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # Guest user (not logged in)

    if user.admin?
      can :manage, :all # Admin can manage all resources
    else
      can :read, Post # All users can read posts
      can :create, Post if user.persisted? # Logged-in users can create posts
      can :update, Post, author_id: user.id # Users can update their own posts
      can :destroy, Post, author_id: user.id # Users can delete their own posts

      can :create, Comment if user.persisted? # Logged-in users can create comments
      can :destroy, Comment, author_id: user.id # Users can delete their own comments

      can :create, Like if user.persisted? # Logged-in users can like posts
      can :destroy, Like, author_id: user.id # Users can unlike posts
    end
  end
end
