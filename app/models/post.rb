class Post < ActiveRecord::Base

  belongs_to :author
  validate :is_title_case 

  before_validation :make_title_case

  # Whenever you are modifying an attribute of the model, use before_validation. If you are doing some other action, then use before_save
#   We use before_save for actions that need to occur that aren't modifying the model itself. For example, whenever you save to the database, let's send an email to the Author alerting them that the post was just saved!

# This is a perfect before_save action. It doesn't modify the model so there is no validation weirdness, and we don't want to email the user if the Post is invalid. That would be just mean! So if you had some method called email_author_about_post you would modify your Post model to look like this:

before_save :email_author_about_post

  private

  def is_title_case
    if title.split.any?{|w|w[0].upcase != w[0]}
      errors.add(:title, "Title must be in title case")
    end
  end

  def make_title_case
    self.title = self.title.titlecase
  end

  def email_author_about_post
  end
end
