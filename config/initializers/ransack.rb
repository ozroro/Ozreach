Ransack.configure do |config|
  config.add_predicate 'lteq_end_of_day',
                       arel_predicate: 'lteq',
                       formatter: proc {|v| v.end_of_day }

  config.add_predicate 'cont_terms',
                       arel_predicate: 'matches_all',
                       formatter: proc {|v| v.split(/[[:blank:]]+/).map {|t| "%#{t}%" } }
end
