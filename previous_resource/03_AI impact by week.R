########################################################################
##### AI impact by week #####
##### from 02_DID matching_주문 합배송 일 레벨 분석.R ##################
########################################################################
estimate <- c(model$coefficients)
LB <- c(model$coefficients - 1.96*model$cse)
UB <- c(model$coefficients + 1.96*model$cse)

Treat_plot <- data.frame(x=c(-4:5), estimate=estimate*100, lwr=LB*100, upr=UB*100) 


### plotting
name <- "AI impact on labor productivity by week"

dev.off()
xrange = c(-4:5)
yrange = c(-5,10)
ylabel = "%"
plot(estimate~x, data=Treat_plot, main=name, xlab="Weeks After AI Introduction",
     ylab=ylabel, xaxt="n", ylim=yrange, pch=16, cex=1)
arrows(x0=Treat_plot$x, y0=Treat_plot$lwr, x1=Treat_plot$x, y1=Treat_plot$upr, code=3, angle=90, length=0.1)

abline(h=0, lty=2)
axis(side = 1, at = c(-4:6), labels = F)
text(c(-4:5), -6.5, labels = c(-5:-2,0:5), pos = 1, xpd = TRUE)



###############################################################################
##### AI impact by week by proficiency level - pre & posttreatment period #####
##### from 02_DID matching_주문 합배송 일 레벨 분석.R #########################
###############################################################################
#### Weekly
estimate <- c(model$coefficients[19:45])
cse <- c(model$cse[19:45])
LB <- c(estimate - 1.96*cse)
UB <- c(estimate + 1.96*cse)

Treat_plot_week <- data.frame(x=c(rep(-5:3,3)), estimate=estimate, lwr=LB, upr=UB)

### plotting: AI impact on labor productivity by week
par(mfrow=c(1,3), ps=15)

name <- "Low-skilled"
xrange = c(-5,3)
yrange = c(-0.5,1)
ylabel = "Estimate"
#plot(estimate~x, data=Treat_plot_week[1:10,], main=name, xlab="Weeks After AI Adoption",
#     ylab=ylabel, xaxt="n", ylim=yrange, pch=16, cex=1)
plot(estimate~x, data=Treat_plot_week[1:9,], main=name, xlab="Weeks after AI adoption",
     ylab=ylabel, xaxt="n", ylim=yrange, pch=16, cex=1, family="serif")
arrows(x0=Treat_plot_week$x[1:9], y0=Treat_plot_week$lwr[1:9], x1=Treat_plot_week$x[1:9], y1=Treat_plot_week$upr[1:9], code=3, angle=90, length=0.05)
abline(h=0, lty=2)
axis(side = 1, at = c(-5:3), labels = F)
text(c(-5:3), -0.65, labels = c(-5:-2,0:4), pos = 1, xpd = TRUE, family="serif")

name <- "Medium-skilled"
xrange = c(-5,3)
yrange = c(-0.5,1)
plot(estimate~x, data=Treat_plot_week[10:18,], main=name, xlab="Weeks after AI adoption",
     ylab=ylabel,xaxt="n", ylim=yrange, pch=16, cex=1, col="blue", family="serif")
arrows(x0=Treat_plot_week$x[10:18], y0=Treat_plot_week$lwr[10:18], x1=Treat_plot_week$x[10:18], y1=Treat_plot_week$upr[10:18], 
       code=3, angle=90, length=0.05, col="blue")
abline(h=0, lty=2)
axis(side = 1, at = c(-5:3), labels = F)
text(c(-5:3), -0.65, labels = c(-5:-2,0:4), pos = 1, xpd = TRUE, family="serif")

name <- "High-skilled"
xrange = c(-5,3)
yrange = c(-0.5,1)
plot(estimate~x, data=Treat_plot_week[19:27,], main=name, xlab="Weeks after AI adoption",
     ylab=ylabel,xaxt="n", ylim=yrange, pch=16, cex=1, col="red", family="serif")
arrows(x0=Treat_plot_week$x[19:27], y0=Treat_plot_week$lwr[19:27], x1=Treat_plot_week$x[19:27], y1=Treat_plot_week$upr[19:27], 
       code=3, angle=90, length=0.05, col="red")
abline(h=0, lty=2)
axis(side = 1, at = c(-5:3), labels = F)
text(c(-5:3), -0.65, labels = c(-5:-2,0:4), pos = 1, xpd = TRUE, family="serif")

######################################################################################################
##### high-skilled only #####
par(mar=c(5,4.1,4.1,2),mfrow=c(2,2), ps=15, family="serif")
#5.1 4.1 4.1 2.1
# total stacks
estimate <- c(model$coefficients[19:45]);cse <- c(model$cse[19:45])
LB <- c(estimate - 1.96*cse);UB <- c(estimate + 1.96*cse)
Treat_plot_week <- data.frame(x=c(rep(-5:3,3)), estimate=estimate, lwr=LB, upr=UB)

plot(estimate~x, data=Treat_plot_week[19:27,], main="Total stacks", xlab="Weeks after AI adoption",
     ylab="Estimate",xaxt="n", ylim=c(-4,6), pch=16, cex=1, col="red")
arrows(x0=Treat_plot_week$x[19:27], y0=Treat_plot_week$lwr[19:27], x1=Treat_plot_week$x[19:27], y1=Treat_plot_week$upr[19:27], 
       code=3, angle=90, length=0.07, col="red")
abline(h=0, lty=2)
axis(side = 1, at = c(-5:3), labels = F)
text(c(-5:3), -5, labels = c(-5:-2,0:4), pos = 1, xpd = TRUE)

# total orders
estimate <- c(model$coefficients[19:45]);cse <- c(model$cse[19:45])
LB <- c(estimate - 1.96*cse);UB <- c(estimate + 1.96*cse)
Treat_plot_week <- data.frame(x=c(rep(-5:3,3)), estimate=estimate, lwr=LB, upr=UB)

plot(estimate~x, data=Treat_plot_week[19:27,], main="Total orders", xlab="Weeks after AI adoption",
     ylab="Estimate",xaxt="n", ylim=c(-10,15), pch=16, cex=1, col="red")
arrows(x0=Treat_plot_week$x[19:27], y0=Treat_plot_week$lwr[19:27], x1=Treat_plot_week$x[19:27], y1=Treat_plot_week$upr[19:27], 
       code=3, angle=90, length=0.07, col="red")
abline(h=0, lty=2)
axis(side = 1, at = c(-5:3), labels = F)
text(c(-5:3), -13, labels = c(-5:-2,0:4), pos = 1, xpd = TRUE)

# total fee
estimate <- c(model$coefficients[19:45]/1391.5);cse <- c(model$cse[19:45]/1391.5)
LB <- c(estimate - 1.96*cse);UB <- c(estimate + 1.96*cse)
Treat_plot_week <- data.frame(x=c(rep(-5:3,3)), estimate=estimate, lwr=LB, upr=UB)

plot(estimate~x, data=Treat_plot_week[19:27,], main="Total fee", xlab="Weeks after AI adoption",
     ylab="Estimate ($)",xaxt="n", ylim=c(-20,30), pch=16, cex=1, col="red")
arrows(x0=Treat_plot_week$x[19:27], y0=Treat_plot_week$lwr[19:27], x1=Treat_plot_week$x[19:27], y1=Treat_plot_week$upr[19:27], 
       code=3, angle=90, length=0.07, col="red")
abline(h=0, lty=2)
axis(side = 1, at = c(-5:3), labels = F)
text(c(-5:3), -25, labels = c(-5:-2,0:4), pos = 1, xpd = TRUE)

# working hours
estimate <- c(model$coefficients[19:45]);cse <- c(model$cse[19:45])
LB <- c(estimate - 1.96*cse);UB <- c(estimate + 1.96*cse)
Treat_plot_week <- data.frame(x=c(rep(-5:3,3)), estimate=estimate, lwr=LB, upr=UB)

plot(estimate~x, data=Treat_plot_week[19:27,], main="Working hours", xlab="Weeks after AI adoption",
     ylab="Estimate (hours)",xaxt="n", ylim=c(-2,3), pch=16, cex=1, col="red")
arrows(x0=Treat_plot_week$x[19:27], y0=Treat_plot_week$lwr[19:27], x1=Treat_plot_week$x[19:27], y1=Treat_plot_week$upr[19:27], 
       code=3, angle=90, length=0.07, col="red")
abline(h=0, lty=2)
axis(side = 1, at = c(-5:3), labels = F)
text(c(-5:3), -2.5, labels = c(-5:-2,0:4), pos = 1, xpd = TRUE)
