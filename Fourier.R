library(fpp2)

p1 <- autoplot(calls) +
  ylab("Call volume") + xlab("Weeks") +
  scale_x_continuous(breaks=seq(1,33,by=2))
p2 <- autoplot(window(calls, end=4)) +
  ylab("Call volume") + xlab("Weeks") +
  scale_x_continuous(minor_breaks = seq(1,4,by=0.2))
gridExtra::grid.arrange(p1,p2)

calls %>% mstl() %>%
  autoplot() + xlab("Week")

calls %>%  stlf() %>%
  autoplot() + xlab("Week")

# fourier(calls, K = c(10,1))
fit <- auto.arima(calls, seasonal=FALSE, lambda=0,
                  xreg=fourier(calls, K=c(10,10)))
fit %>%
  forecast(xreg=fourier(calls, K=c(10,10), h=2*169)) %>%
  autoplot(include=5*169) +
  ylab("Call volume") + xlab("Weeks")
