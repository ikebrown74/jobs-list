class Category < ActiveRecord::Base
  acts_as_tree :order => "name"
  belongs_to :job

  def descendants
    children.map { |f| !f.children.empty? ? f.descendants + [f]: f }.flatten
  end

  def self.category_array
    category_hash = {}
    categories = Category.all
    categories.each do |categ|
      category_array = categ.ancestors.map {|a| a.name }.reverse
      category_array << categ.name
      # remove the leading : or All Jobs:
      category_hash[category_array.join(":").sub(/(All Jobs)?:/,"")] = categ.id
    end
    # sort converts the hash elements into 2d arrays and sorts the arrays
    category_hash.sort
  end
end
