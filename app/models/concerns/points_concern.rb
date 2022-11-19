module PointsConcern
  extend ActiveSupport::Concern

  REP_TYPE_VALUES = {
    "push_up" => 2,
    "air_squat" => 2,
    "bar_dip" => 2,
    "bench_dip" => 1,
    "chin_up" => 3,
    "pull_up" => 4,
    "handstand_push_up" => 6,
    "back_extension" => 2,
    "mountain_climber" => 1,
    "burpee" => 3,
    "squat" => 2,
    "leg_raise" => 2,
    "body_weight_row" => 3,
    "mile" => 5,
    "plank" => 20
  }.freeze

  def points
    REP_TYPE_VALUES[rep_type] * rep_count
  end
end
