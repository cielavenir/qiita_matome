# encoding: utf-8
require 'validators/articles_validator'
require 'validators/article_validator'
require 'validators/display_columns_validator'

module QiitaMatome
  #  QiitaMatome::Display
  module Display
    # QiitaMatome::Display::Displayer
    class Displayer
      attr_reader :title, :articles, :display_columns

      def initialize(title, articles, display_columns = [:no, :title, :create_date, :stocked])
        Validators::ArticlesValidator.validate(articles)
        Validators::ArticleValidator.validate(articles)
        display_columns_list = Array(display_columns)
        Validators::DisplayColumnsValidator.validate(display_columns_list)
        symbolized_display_columns = display_columns_list.map(&:to_sym)
        @title = title
        @articles = articles
        @display_columns = symbolized_display_columns
      end

      def display_title
        "# #{@title}"
      end
    end
  end
end
