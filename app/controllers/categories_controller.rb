class CategoriesController < ApplicationController
  def index
    render json: Category.pluck(:name) # tagifyを導入したので、カテゴリーデータをJSONで渡す。
  end
end
