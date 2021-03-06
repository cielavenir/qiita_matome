# encoding: utf-8

module QiitaMatome
  #  QiitaMatome::Sort
  module Sort
    # QiitaMatome::Sort::Consts
    module Consts
      CREATED_AT_ASC = 'created_at_asc'.freeze
      CREATED_AT_DESC = 'created_at_desc'.freeze
      UPDATED_AT_ASC = 'updated_at_asc'.freeze
      UPDATED_AT_DESC = 'updated_at_desc'.freeze
      TITLE_ASC = 'title_asc'.freeze
      TITLE_DESC = 'title_desc'.freeze
      LIKES_COUNT_ASC = 'likes_count_asc'.freeze
      LIKES_COUNT_DESC = 'likes_count_desc'.freeze
      ALL_TYPES = [
        CREATED_AT_ASC,
        CREATED_AT_DESC,
        UPDATED_AT_ASC,
        UPDATED_AT_DESC,
        TITLE_ASC,
        TITLE_DESC,
        LIKES_COUNT_ASC,
        LIKES_COUNT_DESC,
      ]
    end
  end
end
