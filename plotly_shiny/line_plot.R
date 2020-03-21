a <- list(
  showticklabels = TRUE,
  tickangle = 180
)

fig <- plot_ly(df2, x = ~date, y = ~US_tests, name = 'US Tests', type = 'scatter', mode = 'lines', line = list(color = '#000'), dash = "dash") 
fig <- fig %>% add_trace(y = ~US_confirmed_cases, name = 'Confirmed Cases', mode = 'lines', line = list(color= "#538ec0")) 
fig <- fig %>% layout(title = "Number of Confirmed Cases vs. Tested in US",
                      xaxis = a,
                      yaxis = list (title = "Cases"))
fig
