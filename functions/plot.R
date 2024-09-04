#' Plot a timeseries
#' 
#' @param x table of account data
#' @return a ggplot object
plot_timeseries = function(x = read_downeast(), var = Quantity){
  
  x = dplyr::arrange(x, Account, Date)
  
  ggplot2::ggplot(data = x, 
                  mapping = aes(x = Date, y = {{ var }})) + 
    labs(title = "Oil Consumption") + 
    geom_point() + 
    geom_smooth(method = "loess", formula = "y~x") + 
    facet_wrap(~Account)
}

plot_monthly = function(x = read_downeast(), var = Quantity){
  
  x = dplyr::arrange(x, Account, Date) |>
    dplyr::mutate(Month = factor(Month, levels = month.abb))
 
  ggplot2::ggplot(data = x, 
                  mapping = aes(x = Month, y = {{ var }})) + 
    geom_boxplot() +
    facet_wrap(~Account)
}
  
  