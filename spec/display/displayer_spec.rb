# encoding: utf-8
require 'spec_helper'
require 'display/display_consts'
require 'display/displayer'
require 'models/article'
require 'models/articles'

# rubocop:disable LineLength, UnusedMethodArgument
describe QiitaMatome::Display::Displayer do
  context :new do
    cases = [
      {
        case_no: 1,
        case_title: 'valid args',
        articles: [QiitaMatome::Article.new, QiitaMatome::Article.new],
        display_columns: [:no, :title],
        expected_display_columns: [:no, :title]
      },
      {
        case_no: 2,
        case_title: 'invalid articles class "String"',
        articles: 'String',
        display_columns: [:no, :title],
        expect_error: true
      },
      {
        case_no: 3,
        case_title: 'invalid article class "String"',
        articles: [QiitaMatome::Article.new, 'String'],
        display_columns: [:no, :title],
        expect_error: true
      },
      {
        case_no: 4,
        case_title: 'invalid display_columns "invalid"',
        articles: [QiitaMatome::Article.new, QiitaMatome::Article.new],
        display_columns: 'invalid',
        expect_error: true
      },
      {
        case_no: 5,
        case_title: 'valid args(auto convert display_columns)',
        articles: [QiitaMatome::Article.new, QiitaMatome::Article.new],
        display_columns: 'title',
        expected_display_columns: [:title]
      },
      {
        case_no: 6,
        case_title: 'invalid display_columns than haven\'t to_sym method.',
        articles: [QiitaMatome::Article.new, QiitaMatome::Article.new],
        display_columns: 1,
        expect_error: true
      },
      {
        case_no: 7,
        case_title: 'valid args(updated_at)',
        articles: [QiitaMatome::Article.new, QiitaMatome::Article.new],
        display_columns: [:created_at, :updated_at],
        expected_display_columns: [:created_at, :updated_at]
      }
    ]

    cases.each do |c|
      it "|case_no=#{c[:case_no]}|case_title=#{c[:case_title]}" do
        begin
          case_before c

          # -- given --
          if c[:expect_error]
            -> { QiitaMatome::Display::Displayer.new('title', c[:articles], c[:display_columns]) }.should raise_error(ArgumentError)
            next
          end
          qdd = QiitaMatome::Display::Displayer.new('title', c[:articles], c[:display_columns])

          # -- when --
          actual_articles = qdd.articles
          actual_display_columns = qdd.display_columns

          # -- then --
          expect(actual_articles).to eq(c[:articles])
          expect(actual_display_columns).to eq(c[:expected_display_columns])
        ensure
          case_after c
        end
      end

      def case_before(c)
        # implement each case before
      end

      def case_after(c)
        # implement each case after
      end
    end
  end

  context :display_title do
    cases = [
      {
        case_no: 1,
        case_title: 'valid args',
        articles: [QiitaMatome::Article.new, QiitaMatome::Article.new],
        title: 'title1',
        expected: '# title1'
      }
    ]

    cases.each do |c|
      it "|case_no=#{c[:case_no]}|case_title=#{c[:case_title]}" do
        begin
          case_before c

          # -- given --
          qdd = QiitaMatome::Display::Displayer.new(c[:title], c[:articles])

          # -- when --
          actual = qdd.display_title

          # -- then --
          expect(actual).to eq(c[:expected])
        ensure
          case_after c
        end
      end

      def case_before(c)
        # implement each case before
      end

      def case_after(c)
        # implement each case after
      end
    end
  end

  context :table_header do
    TABLE_HEADER_ARTICLE = QiitaMatome::Article.new(
      'user' => { 'permanent_id' => 99_999, 'id' => 'tbpgr', 'profile_image_url' => '' },
      'title' => 'title1',
      'created_at' => '2014-06-18 22:37:54 +0900',
      'updated_at' => '2014-06-26 02:25:11 +0900',
      'tags' => [{ 'name' => 'Ruby', 'url_name' => 'ruby', 'icon_url' => '', 'versions' => [] }],
      'likes_count' => 2
    )

    cases = [
      {
        case_no: 1,
        case_title: 'valid args',
        articles: [TABLE_HEADER_ARTICLE, QiitaMatome::Article.new],
        display_columns: [:no, :title],
        expected: <<-EOS
|No.|タイトル|
|--:|:--|
        EOS
      },
      {
        case_no: 2,
        case_title: 'full display args',
        articles: [TABLE_HEADER_ARTICLE, QiitaMatome::Article.new],
        display_columns: [:no, :title, :created_at, :likes_count],
        expected: <<-EOS
|No.|タイトル|作成日|いいね数|
|--:|:--|:--:|--:|
        EOS
      }
    ]

    cases.each do |c|
      it "|case_no=#{c[:case_no]}|case_title=#{c[:case_title]}" do
        begin
          case_before c

          # -- given --
          qdd = QiitaMatome::Display::Displayer.new(c[:title], c[:articles], c[:display_columns])

          # -- when --
          actual = qdd.table_header

          # -- then --
          expect(actual).to eq(c[:expected])
        ensure
          case_after c
        end
      end

      def case_before(c)
        # implement each case before
      end

      def case_after(c)
        # implement each case after
      end
    end
  end

  context :display_article do
    DISPLAY_ARTICLE = QiitaMatome::Article.new(
        'id' => 'd1ed617093609ccedbee',
        'user' => { 'permanent_id' => 99_999, 'id' => 'tbpgr', 'profile_image_url' => '' },
        'title' => 'title1',
        'created_at' => '2014-06-18 22:37:54 +0900',
        'updated_at' => '2014-06-26 02:25:11 +0900',
        'tags' => [{ 'name' => 'Ruby', 'url_name' => 'ruby', 'icon_url' => '', 'versions' => [] }],
        'likes_count' => 2
      )

    cases = [
      {
        case_no: 1,
        case_title: 'valid args',
        articles: [DISPLAY_ARTICLE, QiitaMatome::Article.new],
        article: DISPLAY_ARTICLE,
        no: 1,
        display_columns: [:no, :title],
        expected: '|1|[title1](http://qiita.com/tbpgr/items/d1ed617093609ccedbee)|'
      },
      {
        case_no: 2,
        case_title: 'full display args',
        articles: [DISPLAY_ARTICLE, QiitaMatome::Article.new],
        article: DISPLAY_ARTICLE,
        no: 1,
        display_columns: [:no, :title, :created_at, :likes_count],
        expected: '|1|[title1](http://qiita.com/tbpgr/items/d1ed617093609ccedbee)|2014/06/18 22:37:54|2|'
      }
    ]

    cases.each do |c|
      it "|case_no=#{c[:case_no]}|case_title=#{c[:case_title]}" do
        begin
          case_before c

          # -- given --
          qdd = QiitaMatome::Display::Displayer.new('title', c[:articles], c[:display_columns])

          # -- when --
          actual = qdd.display_article(c[:no], c[:article])

          # -- then --
          expect(actual).to eq(c[:expected])
        ensure
          case_after c
        end
      end

      def case_before(c)
        # implement each case before
      end

      def case_after(c)
        # implement each case after
      end
    end
  end

  context :display_articles do
    DISPLAY_ARTICLES = [
      QiitaMatome::Article.new(
        'id' => 'd1ed617093609ccedbee',
        'user' => { 'permanent_id' => 99_999, 'id' => 'tbpgr', 'profile_image_url' => '' },
        'title' => 'title1',
        'created_at' => '2014-06-18 22:37:54 +0900',
        'updated_at' => '2014-06-26 02:25:11 +0900',
        'tags' => [{ 'name' => 'Ruby', 'url_name' => 'ruby', 'icon_url' => '', 'versions' => [] }],
        'likes_count' => 2
      ),
      QiitaMatome::Article.new(
        'id' => 'd1ed617093609ccedbef',
        'user' => { 'permanent_id' => 99_999, 'id' => 'tbpgr', 'profile_image_url' => '' },
        'title' => 'title2',
        'created_at' => '2014-06-18 22:37:53 +0900',
        'updated_at' => '2014-06-26 02:25:09 +0900',
        'tags' => [{ 'name' => 'Ruby', 'url_name' => 'ruby', 'icon_url' => '', 'versions' => [] }],
        'likes_count' => 3
      ),
      QiitaMatome::Article.new(
        'id' => 'd1ed617093609ccedbeg',
        'user' => { 'permanent_id' => 99_999, 'id' => 'tbpgr', 'profile_image_url' => '' },
        'title' => 'title3',
        'created_at' => '2014-06-18 22:37:52 +0900',
        'updated_at' => '2014-06-26 02:25:10 +0900',
        'tags' => [{ 'name' => 'Ruby', 'url_name' => 'ruby', 'icon_url' => '', 'versions' => [] }],
        'likes_count' => 10
      )
    ]

    cases = [
      {
        case_no: 1,
        case_title: 'valid args',
        articles: DISPLAY_ARTICLES,
        display_columns: [:no, :title],
        expected: <<-EOS
|1|[title1](http://qiita.com/tbpgr/items/d1ed617093609ccedbee)|
|2|[title2](http://qiita.com/tbpgr/items/d1ed617093609ccedbef)|
|3|[title3](http://qiita.com/tbpgr/items/d1ed617093609ccedbeg)|
        EOS
      },
      {
        case_no: 2,
        case_title: 'full display args',
        articles: DISPLAY_ARTICLES,
        display_columns: [:no, :title, :created_at, :updated_at, :likes_count],
        expected: <<-EOS
|1|[title1](http://qiita.com/tbpgr/items/d1ed617093609ccedbee)|2014/06/18 22:37:54|2014/06/26 02:25:11|2|
|2|[title2](http://qiita.com/tbpgr/items/d1ed617093609ccedbef)|2014/06/18 22:37:53|2014/06/26 02:25:09|3|
|3|[title3](http://qiita.com/tbpgr/items/d1ed617093609ccedbeg)|2014/06/18 22:37:52|2014/06/26 02:25:10|10|
        EOS
      }
    ]

    cases.each do |c|
      it "|case_no=#{c[:case_no]}|case_title=#{c[:case_title]}" do
        begin
          case_before c

          # -- given --
          qdd = QiitaMatome::Display::Displayer.new('title', c[:articles], c[:display_columns])

          # -- when --
          actual = qdd.display_articles

          # -- then --
          expect(actual).to eq(c[:expected])
        ensure
          case_after c
        end
      end

      def case_before(c)
        # implement each case before
      end

      def case_after(c)
        # implement each case after
      end
    end
  end
end
# rubocop:enable LineLength, UnusedMethodArgument
