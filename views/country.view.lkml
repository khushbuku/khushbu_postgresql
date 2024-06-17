# The name of this view in Looker is "Country"
view: country {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: public.country ;;
  drill_fields: [country_id]

  # This primary key is the unique key for this table in the underlying database.
  # You need to define a primary key in a view in order to join to other views.

  dimension: country_id {
    primary_key: yes
    type: number
    sql: ${TABLE}."country_id" ;;
  }

  filter: country_filter {
    type: string
    suggest_dimension: country_name
  }
    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Country Name" in Explore.

  dimension: country_name {
    type: string
    sql: ${TABLE}."country_name" ;;
  }
  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: last_update {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}."last_update" ;;
  }
  measure: count {
    type: count
    drill_fields: [country_id, country_name, city.count]
  }
}
