# The name of this view in Looker is "City"
view: city {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: public.city ;;
  drill_fields: [city_id]

  # This primary key is the unique key for this table in the underlying database.
  # You need to define a primary key in a view in order to join to other views.

  dimension: city_id {
    primary_key: yes
    type: number
    sql: ${TABLE}."city_id" ;;
  }
    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "City" in Explore.

  dimension: city {
    type: string
    sql: ${TABLE}."city" ;;
  }

  dimension: country_id {
    type: number
    # hidden: yes
    sql: ${TABLE}."country_id" ;;
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
    drill_fields: [city_id, country.country_id, country.country_name, address.count]
  }
}
