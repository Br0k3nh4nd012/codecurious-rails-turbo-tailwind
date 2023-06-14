class Article < ApplicationRecord

  ## validations ##
  validates :title, presence: true

  ## callbacks ##
  after_commit :publish_to_frontend, on: :create
  after_commit :publish_to_frontend_on_update, on: :update
  after_commit :publish_to_frontend_on_destroy, on: :destroy

  private

  def publish_to_frontend
    broadcast_prepend_later_to 'articles_index_stream',  partial: 'articles/article', locals: { article: self }, target: "articles-list"
  end

  def publish_to_frontend_on_update
    broadcast_replace_later_to 'articles_index_stream',  partial: 'articles/article', locals: { article: self }, target: "article-#{self.id}"
  end

  def publish_to_frontend_on_destroy
    broadcast_remove_to 'articles_index_stream', target: "article-#{self.id}"
  end
end
