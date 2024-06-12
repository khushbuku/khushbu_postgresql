# The name of this view in Looker is "Nicer But Slower Film List"
view: nicer_but_slower_film_list {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: public.nicer_but_slower_film_list ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Actors" in Explore.

  dimension: actors {
    type: string
    sql: ${TABLE}."actors" ;;
  }

  dimension: category {
    type: string
    sql: ${TABLE}."category" ;;
  }

  dimension: description {
    type: string
    sql: ${TABLE}."description" ;;
  }

  dimension: fid {
    type: number
    value_format_name: id
    sql: ${TABLE}."fid" ;;
  }

  dimension: length {
    type: number
    sql: ${TABLE}."length" ;;
  }

  dimension: price {
    type: number
    sql: ${TABLE}."price" ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_price {
    type: sum
    sql: ${price} ;;  }
  measure: average_price {
    type: average
    sql: ${price} ;;  }

  dimension: rating {
    type: string
    sql: ${TABLE}."rating" ;;
  }

  dimension: title {
    type: string
    sql: ${TABLE}."title" ;;
  }
  measure: count {
    type: count
  }
}
