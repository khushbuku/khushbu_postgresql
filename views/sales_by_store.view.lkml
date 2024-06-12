# The name of this view in Looker is "Sales By Store"
view: sales_by_store {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: public.sales_by_store ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Manager" in Explore.

  dimension: manager {
    type: string
    sql: ${TABLE}."manager" ;;
  }

  dimension: store {
    type: string
    sql: ${TABLE}."store" ;;
  }

  dimension: total_sales {
    type: number
    sql: ${TABLE}."total_sales" ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_total_sales {
    type: sum
    sql: ${total_sales} ;;  }
  measure: average_total_sales {
    type: average
    sql: ${total_sales} ;;  }
  measure: count {
    type: count
  }
}
