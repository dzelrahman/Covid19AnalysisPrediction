# Confirm Forecast w/o China

m_world <- prophet(temp_prophet_ex_china)

future_world <- make_future_dataframe(m_world, periods = 30)
tail(future_world)

forecast_world <- predict(m_world, future_world)
forecast_world %>% 
  select(ds, yhat, yhat_lower, yhat_upper) %>%
  tail()

forecasted_conf_world <- forecast_world %>%
  arrange(desc(ds)) %>%
  slice(1) %>%
  pull(yhat) %>%
  round()
forecasted_conf_world

forecast_p_world <- plot(m_world, forecast_world) + 
  labs(x = "", 
       y = "confirmed case", 
       title = "Projected Confirmed", 
       subtitle = "To Next Month") + bbc_style()

forecast_p_world



# ggsave("forecasted_conf.png", forecast_p, width = 10, height = 5)

finalise_plot(plot_name = forecast_p_world,
              source = "Source: John Hopkins University",
              save_filepath = "forecasted_conf_world.png",
              width_pixels = 640,
              height_pixels = 550)