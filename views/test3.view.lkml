# The name of this view in Looker is "Test3"
view: test3 {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: public.test3 ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Id2" in Explore.

  dimension: id2 {
    type: number
    sql: ${TABLE}."id2" ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_id2 {
    type: sum
    sql: ${id2} ;;  }
  measure: average_id2 {
    type: average
    sql: ${id2} ;;  }

  dimension: name2 {
    type: string
    sql: ${TABLE}."name2" ;;
  }
  measure: count {
    type: count
  }
}
