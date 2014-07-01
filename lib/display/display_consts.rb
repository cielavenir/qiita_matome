# encoding: utf-8

module QiitaMatome
  #  QiitaMatome::Display
  module Display
    # QiitaMatome::Display::Consts
    module Consts
      TITLE = :title.freeze
      CREATED_AT = :created_at.freeze
      UPDATED_AT = :updated_at.freeze
      STOCKED = :stock_count.freeze
      NO = :no.freeze

      ALIGN_RIGHT = :right
      ALIGN_LEFT = :left
      ALIGN_CENTER = :center

      COLUMNS = [TITLE, CREATED_AT, UPDATED_AT, STOCKED, NO]
      COLUMNS_ALIGN_MAP = {
        TITLE => ALIGN_LEFT,
        CREATED_AT => ALIGN_CENTER,
        UPDATED_AT => ALIGN_CENTER,
        STOCKED => ALIGN_RIGHT,
        NO => ALIGN_RIGHT
      }
      COLUMNS_TITLE_MAP = {
        TITLE => 'タイトル',
        CREATED_AT => '作成日',
        UPDATED_AT => '更新日',
        STOCKED => 'ストック数',
        NO => 'No.'
      }
    end
  end
end
