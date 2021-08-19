# A duration in seconds are with an unit
type Php::Duration = Variant[
  Integer[0],
  Pattern[/^\d+[smhd]?$/]
]

