class RenameLuckyDrawResultsToDrawResults < ActiveRecord::Migration
  def change
    remove_reference :lucky_draw_results, :lucky_draw
    remove_reference :lucky_draw_results, :lucky_draw_item
    rename_table :lucky_draw_results, :draw_results

    add_reference :draw_results, :draw
    add_reference :draw_results, :draw_item
  end
end
